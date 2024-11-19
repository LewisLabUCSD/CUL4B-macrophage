import pandas as pd
import numpy as np
import requests
import io
from time import sleep

class ProteinDataset:
    def __init__(self, df, mapped_ids):
        self.samples = list(df.index)
        self.measures = list(df.columns)
        self.values = df.values
        self.proteins = []
        for i in range(len(self.measures)):
            self.proteins.append(Protein(dataset_id=self.measures[i], uniprot_id=mapped_ids[i]))
            if i % 100 == 0 and i != 0:
                print('Processed {} proteins'.format(i))
            sleep(.25)
        
class Protein:
    def __init__(self, dataset_id, uniprot_id):
        def uniprot_search(uniprot_id):
            BASE = 'http://www.uniprot.org/uniprot/'
            payload = {'query':'id:'+uniprot_id,
                       'format':'tab',
                       'columns': 'id,entry_name,go(biological process),go(molecular function),database(KEGG),database(Reactome),database(STRING),database(BioGRID)', 
                       'limit':'1'}
            success = False
            while not success:
                try:
                    result = requests.get(BASE, payload)
                    success = True
                except:
                    sleep(.25)
            try:
                uniprot_query = pd.read_csv(io.StringIO(result.content.decode('utf-8')), sep='\t')
                return uniprot_query
            except:
                return None
        def kegg_search(kegg_id):
            BASE = 'http://rest.kegg.jp/link/pathway/'
            result = requests.get(BASE+kegg_id)
            urlData = result.content
            try:
                rawData = pd.read_csv(io.StringIO(result.content.decode('utf-8')), sep='\t', header=None)
                pathways = list(rawData[1])
                return pathways
            except:
                return None
        self.dataset_id = dataset_id
        self.uniprot_id = uniprot_id
        uniprot_query = uniprot_search(self.uniprot_id)
        if uniprot_query is None:
            self.entry = None
            self.entry_name = None
            self.go_bp = None
            self.go_mf = None
            self.kegg_id = None
            self.kegg = None
            self.reactome = None
            self.string_id = None
            self.biogrid_id = None
        else:
            self.entry = uniprot_query.loc[0]['Entry']
            self.entry_name = uniprot_query.loc[0]['Entry name']
            try:
                self.go_bp = uniprot_query.loc[0]['Gene ontology (biological process)'].split('; ')
            except:
                self.go_bp = None
            try:
                self.go_mf = uniprot_query.loc[0]['Gene ontology (molecular function)'].split('; ')
            except:
                self.go_mf = None
            try:
                self.kegg_id = uniprot_query.loc[0]['Cross-reference (KEGG)'].split(';')[0]
                self.kegg = kegg_search(self.kegg_id)
            except:
                self.kegg_id = None
                self.kegg = None
            try:
                self.reactome = uniprot_query.loc[0]['Cross-reference (Reactome)'].split(';')[:-1]
            except:
                self.reactome = None
            try:
                self.string_id = uniprot_query.loc[0]['Cross-reference (STRING)'].split(';')[0]
            except:
                self.string_id = None
            try:
                self.biogrid_id = uniprot_query.loc[0]['Cross-reference (BioGRID)'].split(';')[0]
            except:
                self.biogrid_id = None