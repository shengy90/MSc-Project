from minisom import MiniSom
from matplotlib.gridspec import GridSpec

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt



def _pivot_df(df, value_list:list, column_list:list) ->str:
    """
    :type value_list: list
    :type column_list: list
    :param df: input data frame
    :param value_list: list of values that we want to aggregate
    :param column_list: list of columns that we want to pivot
    :return: pivoted pandas DataFrame
    """
    pivot_df = pd.pivot_table(df, values=value_list, index=['lcl_id'], columns=column_list,
                          aggfunc=np.sum)
    pivot_df.columns = [''.join(str(col)) for col in pivot_df.columns]
    return pivot_df


class Normaliser:
    def __init__(self):
        pass

    def fit(self, train_df):
        self.mean = np.mean(self.train_df, axis=0)
        self.std = np.std(self.train_df, axis=0)
        train_norm = (train_df - self.mean)/self.std
        return train_norm.values

    def predict(self, test_df):
        test_norm = (test_df - self.mean)/self.std
        return test_norm.values



class TrainClusters:
    def __init__(self, cluster_type):
        self.cluster_type = cluster_type

    @staticmethod
    def train_som(train_df, cluster_num, iter_num=100000):
        n_neurons = 1
        m_neurons = cluster_num
        som = MiniSom(n_neurons, m_neurons, train_df.shape[1],
                      sigma=1.5, learning_rate=0.5, neighborhood_function='gaussian', random_seed=0)
        som.pca_weights_init(train_df)
        som.train(train_df, iter_num, verbose=True)
        return som

    def fit(self, train_df, cluster_num, iter_num=100000):
        if self.cluster_type == 'som':
            self.cluster_model = self.train_som(train_df, cluster_num, iter_num)
        else:
            print("Lalalala")