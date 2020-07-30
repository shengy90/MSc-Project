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
    pivot_df = pd.pivot_table(df, values=['hh_avg'], index=['lcl_id'], columns=['month_name','weekly_rank'], aggfunc=np.sum)
    pivot_df.columns = [''.join(str(col)) for col in pivot_df.columns]
    return pivot_df


class Normaliser:
    def __init__(self, value_list, column_list):
        self.value_list = value_list
        self.column_list = column_list


    def fit(self, train_df):
        df = _pivot_df(train_df, value_list=self.value_list, column_list=self.column_list)
        mean = np.mean(df, axis=0)
        std = np.std(df, axis=0)
        train_norm = (df - mean)/std

        self.mean = mean
        self.std = std
        return train_norm


    def predict(self, test_df):
        df = _pivot_df(test_df, value_list=self.value_list, column_list=self.column_list)
        test_norm = (df - self.mean)/self.std
        return test_norm



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
        self.train_df = train_df
        self.cluster_num = cluster_num
        self.iter_num = iter_num
        if self.cluster_type == 'som':
            self.cluster_model = self.train_som(train_df, cluster_num, iter_num)
        else:
            print("Lalalala")