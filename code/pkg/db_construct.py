import pandas as pd
import numpy as np
import requests
import io
from time import sleep

def database_dict_builder(proteome_id, query_item, split_str):
    BASE = 'http://www.uniprot.org/uniprot/'
    payload = {'query':'reviewed:yes+AND+proteome:'+proteome_id,
               'format':'tab',
               'columns': 'id,entry_name,'+query_item}
    result = requests.get(BASE, payload)
    uniprot_query = pd.read_csv(io.StringIO(result.content.decode('utf-8')), sep='\t')
    db_pathways = set([i for j in list(uniprot_query[list(uniprot_query.columns)[2]].dropna()) for i in j.split(split_str)]) - set([''])
    db_mapping={}
    num_paths=0
    for p in db_pathways:
        temp = uniprot_query.loc[[True if p in i else False for i in uniprot_query[list(uniprot_query.columns)[2]].fillna('')]]
        db_mapping[p]=list(temp['Entry'])
        num_paths+=1
        if num_paths % 100==0:
            print('{} Pathways Processed'.format(num_paths))
    return db_mapping

def database_dict_builder_KEGG(proteome_id, query_item, split_str):
    BASE = 'http://www.uniprot.org/uniprot/'
    payload = {'query':'reviewed:yes+AND+proteome:'+proteome_id,
               'format':'tab',
               'columns': 'id,entry_name,'+query_item}
    result = requests.get(BASE, payload)
    uniprot_query = pd.read_csv(io.StringIO(result.content.decode('utf-8')), sep='\t')
    kegg_paths = []
    num_prots=0
    for index in uniprot_query.index:
        num_prots += 1
        try:
            kegg_id = uniprot_query.loc[index][list(uniprot_query.columns)[2]].split(split_str)[0]
            kegg_paths.append(kegg_search(kegg_id))
            if num_prots % 100==0:
                print('{} Proteins Processed'.format(num_prots))
        except:
            kegg_paths.append(float('nan'))
            if num_prots % 100==0:
                print('{} Proteins Processed'.format(num_prots))
    uniprot_query['temp'] = kegg_paths
    db_pathways = set([i for j in list(uniprot_query[list(uniprot_query.columns)[3]].dropna()) for i in j.split(split_str)]) - set([''])
    db_mapping={}
    num_paths=0
    for p in db_pathways:
        temp = uniprot_query.loc[[True if p in i else False for i in uniprot_query[list(uniprot_query.columns)[3]].fillna('')]]
        db_mapping[p]=list(temp['Entry'])
        num_paths+=1
        if num_paths % 100==0:
            print('{} Pathways Processed'.format(num_paths))
    return db_mapping

def kegg_search(kegg_id):
    BASE = 'http://rest.kegg.jp/link/pathway/'
    success = False
    while not success:
        try:
            result = requests.get(BASE+kegg_id)
            success = True
        except:
            sleep(.25)
    urlData = result.content
    try:
        rawData = pd.read_csv(io.StringIO(result.content.decode('utf-8')), sep='\t', header=None)
        pathways = list(rawData[1])
        return ';'.join(pathways)
    except:
        return float('nan')