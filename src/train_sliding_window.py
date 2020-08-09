from src.train_clusters import TrainClusters
from src.train_clusters import Normaliser
from src.train_prophet import TrainProphet

import pandas as pd
import numpy as np


def normalise_df(som_df):
    value_list = ['hh_avg']
    column_list = ['month_name', 'weekly_rank']
    normaliser = Normaliser(value_list, column_list)

    train_df = som_df.query('train_test_split=="train"')
    test_df = som_df.query('train_test_split=="test"')

    train_norm = normaliser.fit(train_df)
    test_norm = normaliser.predict(test_df)
    return train_norm, test_norm


def train_clusters(train_df, test_df):
    som = TrainClusters(cluster_type="som")
    som.fit(train_df, cluster_num=5, sigma=0.1, learning_rate=0.1)
    train_pred = som.predict(train_df)
    test_pred = som.predict(test_df)
    train_pred['train_test_split'] = 'train'
    test_pred['train_test_split'] = 'test'
    clusters = pd.concat([train_pred, test_pred])
    return clusters


def train_som(som_df):
    train_df, test_df = normalise_df(som_df)
    clusters = train_clusters(train_df, test_df)
    clusters = clusters[['lcl_id','cluster','train_test_split']]
    return clusters


def get_ts_inputs(ts_df, som_clusters):
    train = ts_df.merge(som_clusters.query(f"train_test_split=='train'"),
                        left_on='lcl_id',
                        right_on='lcl_id',
                        how='inner'
                        )
    test = ts_df.merge(som_clusters.query(f"train_test_split=='test'"),
                       left_on='lcl_id',
                       right_on='lcl_id',
                       how='inner'
                       )

    train['households_num'] = train['lcl_id'].nunique()
    test['households_num'] = test['lcl_id'].nunique()

    train = train.groupby('ds').mean().reset_index()
    test = test.groupby('ds').mean().reset_index()
    return train, test


def train_baseline(ts_df, som_clusters, eval_date):
    train_df, test_df = get_ts_inputs(ts_df, som_clusters)
    baseline_model = TrainProphet(eval_date)
    baseline_model.fit(train_df)
    baseline_model.evaluate_global_mape(train_test_split="train", df=train_df, test_period=eval_date)
    baseline_model.evaluate_global_mape(train_test_split="test", df=test_df, test_period=eval_date)
    return baseline_model


def train_som_forecasts(ts_df, som_clusters, eval_date):
    clusters = som_clusters.groupby('cluster').count().index.to_list()

    train_global_fc = pd.DataFrame()
    test_global_fc = pd.DataFrame()

    for cluster in clusters:
        cluster_df = som_clusters.query(f"cluster=={cluster}")
        train, test = get_ts_inputs(ts_df, cluster_df)

        print(f"\nTraining cluster: {cluster}. Number of train households: {train['households_num'].max()}. Number of test households: {test['households_num'].max()}.")

        model = TrainProphet(eval_date)
        model.fit(train)
        model.evaluate_global_mape(train_test_split='test', df=test, test_period=eval_date)
        model.evaluate_global_mape(train_test_split='train', df=train, test_period=eval_date)
        test_global_fc = pd.concat([test_global_fc, model.test_global])
        train_global_fc = pd.concat([train_global_fc, model.train_global])

        # train_forecast = train[['cluster', 'ds', 'y']].copy()
        # train_forecast['max_households'] = train['households_num'].max()
        # train_forecast = train_forecast.merge(model.forecast[['ds', 'yhat']], left_on='ds', right_on='ds')
        # train_forecast['y_global'] = train_forecast['y'] * train_forecast['max_households']
        # train_forecast['yhat_global'] = train_forecast['yhat'] * train_forecast['max_households']

        # train_global_fc = pd.concat([train_global_fc, train_forecast])

    return model, train_global_fc, test_global_fc


def evaluate_results(global_train, global_test):
    train = global_train.groupby('ds')[['y_global', 'yhat_global']].sum()
    test = global_test.groupby('ds')[['y_global', 'yhat_global']].sum()

    train_mape = np.round(np.mean(np.abs(train['yhat_global']/train['y_global']-1)),4)*100
    test_mape = np.round(np.mean(np.abs(test['yhat_global']/test['y_global']-1)),4)*100

    print(f"Train global MAPE: {train_mape}. Test global MAPE: {test_mape}.")
    return train_mape, test_mape