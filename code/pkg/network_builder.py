import numpy as np
import pandas as pd
from time import sleep
import networkx as nx
import community
import multiprocessing as mp
import itertools
from sklearn.cluster import KMeans
from scipy.stats import hypergeom
from scipy.stats import kendalltau
from scipy import stats
from statsmodels.stats.multitest import multipletests

def string_search(string_id, score):
    species = string_id.split('.')[0]
    BASE = 'https://string-db.org/api/tsv/interactions?identifiers='
    success = False
    while not success:
        try:
            result = requests.get(BASE+string_id.split('.')[1]+'&required_score='+score+'&species='+species+'&limit=999999')
            success = True
        except:
            sleep(.25)
    urlData = result.content
    rawData = pd.read_csv(io.StringIO(result.content.decode('utf-8')), sep='\t')
    return set(zip(rawData[rawData.columns[0]], rawData[rawData.columns[1]]))

def network_builder(protein_dataset, score='400'):
    G = nx.Graph()
    to_keep = []
    for count, i in enumerate(protein_dataset.proteins):
        if not i.string_id is None:
            G.add_edges_from(string_search(i.string_id, score=score))
            to_keep.append(i.string_id)
            sleep(.1)
        if count+1 % 25 == 0:
            print('{} proteins queried, {} left'.format(count+1, len(protein_dataset.proteins)-count+1))
    G = G.subgraph(to_keep)
    to_keep = [node for node in G.nodes if G.degree(node) != 0]
    G = G.subgraph(to_keep)
    return G

def calc_dist(inp):
    x_coms = [i[inp[0][0]] for i in inp[1]]
    y_coms = [i[inp[0][1]] for i in inp[1]]
    agreement_list = [i in y_coms for i in x_coms]
    return sum(agreement_list)/len(agreement_list)

def network_cluster(G, N=1000):
    attrs_store = []
    for i in range(N):
        attrs = community.best_partition(graph=G, resolution=1.0)
        attrs_store.append(attrs)
    print('{} Clustering iterations performed'.format(N))
    avg_num_clusters = np.mean([len(set(attrs_store[i].values())) for i in range(len(attrs_store))])
    print('Avergae Number of Clusters {}'.format(avg_num_clusters))
          
    all_pairs = list(itertools.combinations(list(G.nodes), 2)) 
    inputs = list(zip(all_pairs, [attrs_store]*len(all_pairs)))

    pool = mp.Pool(processes = (mp.cpu_count() - 1))
    outputs = pool.map(calc_dist, inputs)
    pool.close()
    pool.join()
          
    d = dict(zip(all_pairs, outputs))
    d = {**d, **{(k[1],k[0]):v for k,v in d.items()}}
    df = pd.Series(d).unstack()
    df = df.fillna(1.0)
    consensus_matrix = df
          
    k = int(np.floor(avg_num_clusters))
    km = KMeans(n_clusters=k)
    km.fit(consensus_matrix.values)
    labels = [i+1 for i in km.labels_]
    attrs = dict(zip(consensus_matrix.columns, labels))
            
    nx.set_node_attributes(G,name='community', values=attrs)
    return G

def add_entries(G, dataset):
    d = dict([(i.string_id, i.entry_name) for i in dataset.proteins if i.string_id in G.nodes()])
    nx.set_node_attributes(G,name='entry_name', values=d)
    d = dict([(i.string_id, i.uniprot_id) for i in dataset.proteins if i.string_id in G.nodes()])
    nx.set_node_attributes(G,name='uniprot_id', values=d)
    return G

def construct_network(list_of_G, list_of_G_names):
    H = nx.Graph()
    for G, G_name in zip(list_of_G,list_of_G_names):
        community_d = {}
        entry_d = {}
        uniprot_d = {}
        for string_id,community,entry_name,uniprot_id in [(i[0],i[1]['community'],i[1]['entry_name'],i[1]['uniprot_id']) for i in G.nodes(data=True)]:
            try:
                community_d[community].append(string_id)
            except:
                community_d[community] = [string_id]
            try:
                entry_d[community].append(entry_name)
            except:
                entry_d[community] = [entry_name]
            try:
                uniprot_d[community].append(uniprot_id)
            except:
                uniprot_d[community] = [uniprot_id]
        for community in community_d.keys():
            H.add_node(G_name+' FC'+str(community), uniprot_ids=uniprot_d[community], entry_ids=entry_d[community] )
    for source, target in itertools.combinations(H.nodes(), 2):
        H.add_edge(source, target)
    return H.to_undirected()

def calc_prop(m, n, d, G, alpha=0.10):
    m_dataset = d[[i for i in d.keys() if i in m][0]]
    m_items = G.nodes(data=True)[m]['uniprot_ids']
    m_abd = pd.DataFrame(data=m_dataset.values, index=m_dataset.samples, columns=m_dataset.measures)[m_items].T
    n_dataset = d[[i for i in d.keys() if i in n][0]]
    n_items = G.nodes(data=True)[n]['uniprot_ids']
    n_abd = pd.DataFrame(data=n_dataset.values, index=n_dataset.samples, columns=n_dataset.measures)[n_items].T
    spear_pval = []
    for m_str in m_abd.index:
        for n_str in n_abd.index:
            r, pval = stats.spearmanr(list(m_abd.loc[m_str]), list(n_abd.loc[n_str]))
            spear_pval.append(pval)
    hyp_vec = multipletests(pvals=spear_pval, alpha=alpha, method='fdr_bh')[0]
    return np.sum(hyp_vec)/len(hyp_vec)

def spearman_proportions(G, list_of_datasets, list_of_dataset_names):
    d = dict(zip(list_of_dataset_names, list_of_datasets))
    inputs = [(m, n, d, G) for m, n in G.edges()]
    pool = mp.Pool(processes = (mp.cpu_count() - 1))
    outputs = pool.starmap(calc_prop, inputs)
    pool.close()
    pool.join()
    nx.set_edge_attributes(G,name='spearman_proportion', values=dict(zip([(i[0], i[1]) for i in inputs], outputs)))
    return G

def enrich_test(items, db):
    db_scores = {}
    M = len(set([i for j in db.values() for i in j]))
    N = len(items)
    for pathway in db.keys():
        n = len(db[pathway])
        x = len(set(items).intersection(set(db[pathway])))
        if x >= 2:
            pval = hypergeom.sf(x-1, M, n, N)
        else:
            pval=1.0
        db_scores[pathway]=pval
    return db_scores

def kendall_tau_scores(G, list_of_dbs, list_of_db_names):
    for db, db_name in zip(list_of_dbs, list_of_db_names):
        node_db_scores = {}
        node_sorted_list_d = {}
        for node in G.nodes(data=True):
            db_scores = enrich_test(node[1]['uniprot_ids'], db)
            node_sorted_list_d[node[0]] = [k for k, v in sorted(db_scores.items(), key=lambda item: item[1])]
            node_db_scores[node[0]] = db_scores
        db_scores_df = pd.DataFrame(data=node_db_scores)
        edge_kendalltau_d = {}
        for m, n in G.edges():
            m_score = list(db_scores_df[m])
            n_score = list(db_scores_df[n])
            edge_kendalltau_d[(m,n)] = kendalltau(m_score, n_score)[0]
        nx.set_edge_attributes(G,name=db_name+' Kendall Tau', values=edge_kendalltau_d)
        nx.set_node_attributes(G,name=db_name+' Sorted Enrichments', values=node_sorted_list_d)
    return G

def jaccard_score(itemsA, itemsB):
    tot = len(itemsA.union(itemsB))
    overlap = len(itemsA.intersection(itemsB))
    return overlap/tot * 100