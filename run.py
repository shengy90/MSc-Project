from src.train_prophet import TrainProphet
from src.train_clusters import TrainClusters, Normaliser
from definitions.prophet_definitions import TEST_DF as df
from definitions.cluster_definition import CLUSTER_DUMMY_DF

if __name__ == "__main__":
    normaliser = Normaliser(value_list=['hh_avg'], column_list=['month_name','weekly_rank'])
    norm_df_train = normaliser.fit(CLUSTER_DUMMY_DF)
    norm_df_test = normaliser.fit(CLUSTER_DUMMY_DF)
    cluster = TrainClusters(cluster_type="agglo")
    cluster.fit(norm_df_train)
    pred = cluster.predict(norm_df_train)

    print(pred)