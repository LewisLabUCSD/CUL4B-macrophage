import pandas as pd
import numpy as np

class NMF_model:
    def __init__(self, X):
        self.samples = list(X.columns)
        self.variables = list(X.index)
        self.x = X.values.T
    def init_wh(self, k):
        self.w = np.random.uniform(low=0.0, high=1.0, size=(self.x.shape[0], k))
        #self.w = np.random.rand(self.x.shape[0], k)
        self.h = np.random.uniform(low=0.0, high=self.x.max(), size=(k, self.x.shape[1]))
        #self.h = np.random.rand(k, self.x.shape[1])
    def mult_update(self):
        self.h = np.multiply(self.h, 
                             np.divide(np.matmul(self.w.T, 
                                                 self.x), 
                                       np.matmul(self.w.T, 
                                                 np.matmul(self.w, 
                                                           self.h))))
        self.w = np.multiply(self.w, 
                             np.divide(np.matmul(self.x, 
                                                 self.h.T), 
                                       np.matmul(np.matmul(self.w, 
                                                           self.h), 
                                                 self.h.T)))
        w_sums = self.w.sum(axis=1)
        self.w /= w_sums[:, np.newaxis]
        
    def error(self):
        return np.linalg.norm(np.subtract(self.x, np.matmul(self.w, self.h)), 'fro')
    
class JNMF_model:
    def __init__(self, Xs):
        self.length = len(Xs.keys())
        self.samples = {k:v.columns for k,v in Xs.items()}
        self.variables = {k:v.index for k,v in Xs.items()}
        self.xs = {k:v.values.T for k,v in Xs.items()}
    def init_wh(self, k):
        self.w = np.random.uniform(low=0.0, high=1.0, size=(len(list(self.samples.items())[0][1]), k))
        #self.w = np.random.rand(len(list(self.samples.items())[0][1]), k)
        self.h = {key:np.random.uniform(low=0.0, high=value.max() , size=(k, value.shape[1])) for key,value in self.xs.items()}
        #self.h = {key:np.random.rand(k, value.shape[1]) for key,value in self.xs.items()}
    def mult_update(self):
        numer = np.zeros(self.w.shape)
        denom = np.zeros(self.w.shape)
        for key in self.xs.keys():
            numer += np.matmul(self.xs[key], 
                               self.h[key].T)
            denom += np.matmul(np.matmul(self.w, 
                                         self.h[key]), 
                               self.h[key].T)
        self.w *= numer/denom
        w_sums = self.w.sum(axis=1)
        self.w /= w_sums[:, np.newaxis]
        
        for key in self.xs.keys():
            self.h[key] = np.multiply(self.h[key], 
                                      np.divide(np.matmul(self.w.T, 
                                                          self.xs[key]), 
                                                np.matmul(self.w.T, 
                                                          np.matmul(self.w, 
                                                                    self.h[key]))))
    def error(self):
        err = 0
        for key in self.xs.keys():
            err += np.linalg.norm(np.subtract(self.xs[key], np.matmul(self.w, self.h[key])), 'fro')
        return err