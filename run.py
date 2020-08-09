from src.train_sliding_window import *
from definitions.sliding_window_definitions import SOM_DUMMY, TS_DUMMY

if __name__ == "__main__":
    # dates
    START_DATE = '2012-11-01'
    END_DATE = '2013-03-01'
    EVAL_DATE = '2013-02-01'

    som_clusters = train_som(SOM_DUMMY)
    baseline_model = train_baseline(TS_DUMMY, som_clusters, EVAL_DATE)
    som_model, som_train_global, som_test_global = train_som_forecasts(TS_DUMMY, som_clusters, EVAL_DATE)
    evaluate_results(som_train_global, som_test_global)
