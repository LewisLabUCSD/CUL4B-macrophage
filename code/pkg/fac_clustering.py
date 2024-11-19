import pandas as pd
import numpy as np
from sklearn.preprocessing import minmax_scale
from scipy.spatial.distance import pdist
from scipy.cluster.hierarchy import linkage

class ClusteredData:
    def __init__(self, Xs, similarity_metric, hierarchy_method):
        self.storage = {'X{}'.format(i):Xs[i] for i in range(len(Xs))}
        self.indv_dist = {}
        for i in range(len(Xs)):
            self.indv_dist['X{}'.format(i)] = minmax_scale(pdist(Xs[i].T, similarity_metric))
        self.indv_cluster = {}
        for key, value in self.indv_dist.items():
            self.indv_cluster[key] = linkage(value, method=hierarchy_method)
        self.group_dist = np.mean(list(self.indv_dist.values()), axis=0)
        self.group_cluster = linkage(self.group_dist, method=hierarchy_method)