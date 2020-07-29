from src.train_prophet import TrainProphet
from definitions.prophet_definitions import TEST_DF as df
import os

if __name__ == "__main__":
    model = TrainProphet("2013-02-01")
    model.fit(df)
