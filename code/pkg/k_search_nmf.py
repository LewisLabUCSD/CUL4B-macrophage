import numpy as np
import pandas as pd
from scipy.cluster.hierarchy import cophenet, linkage
from sklearn.preprocessing import minmax_scale
from scipy.spatial.distance import pdist


from pkg.nmf_models import NMF_model

def cophenet_corr(Z1, Z2):
    return np.corrcoef(Z1, Z2)[0,1]

def nmf_sigs(x, k_start, k_end, trial_lower, trial_upper, trial_tol, N_iter, dist_metric, hierarchy_method):
    Z1 = x.group_cluster
    model_d = {}
    for k in range(k_start,k_end+1):
        print('k = {}'.format(k))
        num_trials = 0
        
        corr_avg = []
        corr_std = 0.0
        current_std = 0.0
        prev_std = 0.0
        std_diff = []
        
        error_avg = []
                
        while num_trials <= trial_lower or np.mean(std_diff) > trial_tol and num_trials < trial_upper:
            prev_std = current_std
            model = NMF_model(x.storage['X0'])
            model.init_wh(k=k)
            
            for j in range(N_iter):
                model.mult_update()
            
            error_avg.append(model.error())
            Z2 = linkage(minmax_scale(pdist(model.w, dist_metric)), method=hierarchy_method)
            corr = cophenet_corr(cophenet(Z1), cophenet(Z2))
            corr_avg.append(corr)
            current_std = np.std(corr_avg)
            std_diff.append(abs(prev_std - current_std))
            if len(std_diff) > trial_lower:
                std_diff = std_diff[1:]
            num_trials+=1
            try:
                model_d[k].append((corr, model.error(), model))
            except:
                model_d[k] = [(corr, model.error(), model)]
                
        print('num trials = {}'.format(num_trials))
        print('avg corr = {}'.format(np.mean(corr_avg)))
        print('avg error = {}'.format(np.mean(error_avg)))
        print()
        
    return model_d