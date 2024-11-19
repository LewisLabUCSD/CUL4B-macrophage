import pandas as pd
import numpy as np
from statsmodels.stats.multitest import multipletests
from scipy.stats import f_oneway
import itertools
import copy

def ANOVA_oneway(values, labels, measures, conditions, alpha, method):
    #print([[labels[i] for i in range(len(labels)) if condition in labels[i] and condition[0]==labels[i][0]] for condition in conditions])
    split_data = list([np.stack([values[i] for i in range(len(labels)) if condition in labels[i] and condition[0]==labels[i][0]], axis=0) for condition in conditions])
    test = f_oneway(*split_data)
    #hyp_vec = multipletests(pvals=test.pvalue, alpha=alpha, method=method)[0]
    multi_tests = multipletests(pvals=test.pvalue, alpha=alpha, method=method)
    return test, multi_tests
    #return hyp_vec

def ANOVA_filter(protein_dataset, conditions, alpha=0.10, method='fdr_bh'):
    hyp_vec = ANOVA_oneway(values=protein_dataset.values, labels=protein_dataset.samples, measures=protein_dataset.measures, conditions=conditions, alpha=alpha, method=method)
    protein_dataset_filt = copy.deepcopy(protein_dataset)
    protein_dataset_filt.values = protein_dataset.values[: , hyp_vec]
    protein_dataset_filt.measures = list(itertools.compress(protein_dataset.measures, hyp_vec))
    protein_dataset_filt.proteins = list(itertools.compress(protein_dataset.proteins, hyp_vec))
    return protein_dataset_filt