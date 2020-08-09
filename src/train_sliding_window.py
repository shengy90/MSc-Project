from train_clusters import TrainCluster
from train_clusters import Normaliser
from train_prophet import TrainProphet

class TrainSlidingWindow():
    def __init__(self):
        pass

    def _normalise_inputs(self, df):
        value_list=['hh_avg']
        column_list = ['month_name', 'weekly_rank']
        normaliser = Normaliser(value_list, column_list)

        train_df = som_df.query('train_test_split=="train"')
        test_df = som_df.query('train_test_split=="test"')
        train_norm = normaliser.fit(train_df)
        test_norm = normaliser.predict(test_df)
        return train_norm, test_norm