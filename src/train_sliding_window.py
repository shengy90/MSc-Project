from src.train_clusters import TrainClusters
from src.train_clusters import Normaliser
from src.train_prophet import TrainProphet

import pandas as pd
import numpy as np


def generate_query_strings(start_date, end_date):
    start_date = start_date
    end_date = end_date

    som_query_string = f"""
        WITH 
        raw_data AS (
            SELECT * FROM `machine-learning-msc.forecasting_20200719.train_set` data 
            UNION ALL 
            SELECT * FROM `machine-learning-msc.forecasting_20200719.test_set` data 
            ),
    
        stg1 AS (
            SELECT 
            data.lcl_id,
            split.train_test_split,
            FORMAT_DATETIME('%B', DATETIME(data.ts)) AS month_name,
            data.dayofweek,
            data.hhourly_rank,
            ROUND(AVG(data.kwhh),4) AS hh_avg
    
            FROM raw_data data
    
            INNER JOIN `machine-learning-msc.households.train_test_split` split 
                ON split.lcl_id = data.lcl_id 
    
            WHERE data.ts >= '{start_date}' AND data.ts < '{end_date}'
            AND split.random_state = 'original_split'
            GROUP BY 1,2,3,4,5
            )
    
        SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY lcl_id, month_name ORDER BY dayofweek ASC, hhourly_rank ASC) AS weekly_rank
        FROM stg1 
        ORDER BY lcl_id, month_name, weekly_rank, hhourly_rank
        """

    ts_query_string =f"""
        WITH all_data AS (
            SELECT * FROM `machine-learning-msc.forecasting_20200719.test_set`
            UNION ALL 
            SELECT * FROM `machine-learning-msc.forecasting_20200719.train_set`   
            )
        
        SELECT 
        data.lcl_id,
        data.ts AS ds,
        data.kwhh AS y,
        LAST_VALUE(weather.air_temperature IGNORE NULLS) OVER (PARTITION BY data.lcl_id ORDER BY data.ts ASC) AS air_temperature
        
        FROM all_data data
        LEFT JOIN `machine-learning-msc.london_heathrow_hourly_weather_data.london_heathrow_hourly_weather` weather 
          ON TIMESTAMP_TRUNC(weather.ts, HOUR) = TIMESTAMP_TRUNC(data.ts, hour)
        WHERE data.ts >= '{start_date}' AND data.ts < '{end_date}'
        ORDER BY 1,2 ASC
        """

    return som_query_string, ts_query_string

def normalise_df(som_df):
    value_list = ['hh_avg']
    column_list = ['month_name', 'weekly_rank']
     

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


def train_som_forecasts(ts_df, som_clusters, eval_date, verbose=False):
    clusters = som_clusters.groupby('cluster').count().index.to_list()

    train_global_fc = pd.DataFrame()
    test_global_fc = pd.DataFrame()

    for cluster in clusters:
        cluster_df = som_clusters.query(f"cluster=={cluster}")
        train, test = get_ts_inputs(ts_df, cluster_df)

        if verbose is True:
            print(f"\nTraining cluster: {cluster}. Number of train households: {train['households_num'].max()}. Number of test households: {test['households_num'].max()}.")

        model = TrainProphet(eval_date)
        model.fit(train)
        model.evaluate_global_mape(train_test_split='test', df=test, test_period=eval_date)
        model.evaluate_global_mape(train_test_split='train', df=train, test_period=eval_date)
        test_global_fc = pd.concat([test_global_fc, model.test_global])
        train_global_fc = pd.concat([train_global_fc, model.train_global])

    return model, train_global_fc, test_global_fc


def evaluate_results(global_train, global_test):
    train = global_train.groupby('ds')[['y_global', 'yhat_global']].sum()
    test = global_test.groupby('ds')[['y_global', 'yhat_global']].sum()

    train_mape = np.round(np.mean(np.abs(train['yhat_global']/train['y_global']-1)),4)*100
    test_mape = np.round(np.mean(np.abs(test['yhat_global']/test['y_global']-1)),4)*100

    print(f"Train global MAPE: {train_mape}. Test global MAPE: {test_mape}.")
    return train_mape, test_mape