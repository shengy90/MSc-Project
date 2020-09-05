from sklearn.decomposition import PCA
from sklearn.cluster import AgglomerativeClustering
from minisom import MiniSom

import pandas as pd
import numpy as np


def _pivot_df(df, value_list:list, column_list:list) ->str:
    """
    :type value_list: list
    :type column_list: list
    :param df: input data frame
    :param value_list: list of values that we want to aggregate
    :param column_list: list of columns that we want to pivot
    :return: pivoted pandas DataFrame
    """
    pivot_df = pd.pivot_table(df, values=value_list, index=['lcl_id'], columns=column_list, aggfunc=np.sum)
    pivot_df.columns = [''.join(str(col)) for col in pivot_df.columns]
    pivot_df.fillna(0, inplace=True)
    return pivot_df

def _generate_column_names(n_components):
    col_list = []
    for i in range(n_components):
        col_list.append(f"PC{i+1}")
    return col_list

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


    def _train_som(self, train_df, cluster_num, sigma, learning_rate, iter_num=100000):
        n_neurons = 1
        m_neurons = cluster_num
        som = MiniSom(n_neurons, m_neurons, train_df.shape[1],
                      sigma=sigma, learning_rate=learning_rate, neighborhood_function='gaussian', random_seed=0)
        som.train(train_df.values, iter_num, verbose=False)
        return som


    def _predict_som(self, df):
        som_cluster_df = pd.DataFrame(df.groupby(['lcl_id']).count().reset_index()[['lcl_id']])
        som_cluster_df['cluster'] = np.NaN

        for idx, xx in enumerate(df.values):
            som_cluster_df.loc[idx, 'cluster'] = self.cluster_model.winner(xx)[1].astype(int)

        som_cluster_df = som_cluster_df.merge(df, on='lcl_id', how='inner')

        return som_cluster_df


    def _train_pca(self, train_df):
        # n_components must be <= min(n_sample, n_dimensions) or 8, whichever smaller.
        df_shape = list(train_df.shape)
        df_shape.append(8)

        pca = PCA(n_components=np.min(df_shape))
        pca.fit(train_df.values)
        return pca


    def _predict_pca(self, df):
        principal_components = self.pca.transform(df.values)
        pca_components = pd.DataFrame(
            index = df.index,
            columns=_generate_column_names(self.pca.n_components),
            data = principal_components
            )
        return pca_components


    def _train_agglo(self, df, cluster_num):
        # number of clusters must be <= number of samples
        n_clusters = np.min([len(df), cluster_num])
        agglo = AgglomerativeClustering(n_clusters=n_clusters)
        agglo.fit(df.values)
        return agglo


    def _predict_agglo(self, df):
        agglo_predictions = df.copy()
        agglo_predictions['cluster'] = pd.Categorical(self.cluster_model.fit_predict(df.values)).astype(int)
        agglo_predictions.reset_index(inplace=True)
        return agglo_predictions


    def fit(self, train_df, iter_num=100000, **kwargs):
        cluster_num = 5 if kwargs.get('cluster_num') is None else kwargs.get('cluster_num')
        sigma =  1.5 if kwargs.get('sigma') is None else kwargs.get('sigma')
        learning_rate = 0.5 if kwargs.get('learning_rate') is None else kwargs.get('learning_rate')

        self.train_df = train_df
        self.cluster_num = cluster_num
        self.iter_num = iter_num

        if self.cluster_type == 'som':
            self.cluster_model = self._train_som(train_df, cluster_num, sigma, learning_rate, iter_num)
            self.som_topographic_error = self.cluster_model.topographic_error(train_df.values)

        elif self.cluster_type == 'agglo':
            self.pca = self._train_pca(train_df)
            pca_results = self._predict_pca(train_df)
            self.cluster_model = self._train_agglo(pca_results, cluster_num)

        else:
            raise ValueError("cluster_type must be either 'som' or 'agglo'!")

    def predict(self, df):
        if self.cluster_type == 'som':
            cluster_df = self._predict_som(df)
        else:
            cluster_df = self._predict_agglo(df)

        return cluster_df