import datetime as dt
import numpy as np
from fbprophet import Prophet
from definitions.prophet_definitions import CUSTOM_HOLS


def _get_training_period(df, date_filter):
    df_out = df.query(f"ds < '{date_filter}'").copy()
    assert len(df_out) < len(df)
    assert df_out['ds'].max() < dt.datetime.strptime(date_filter, "%Y-%m-%d")
    return df_out


def _make_future_df(m, df):
    future_df = m.make_future_dataframe(periods=1440, freq='30min')
    future_df = future_df.merge(df, left_on='ds', right_on='ds')
    return future_df


def _evaluate_mape(df, forecast, test_period):
    fc_start = test_period
    y = df.query(f'ds>="{fc_start}"')[['ds','y']]
    pred = forecast.query(f'ds>="{fc_start}"')[['ds', 'yhat']]
    eval_df = y.merge(pred, on='ds')
    eval_df['y'] = eval_df['y'] + 0.000000000001
    eval_df['abs_err'] = np.abs((eval_df['y'] - eval_df['yhat']))
    eval_df['abs_perc'] = np.round(eval_df['abs_err']/eval_df['y'],4)*100
    return np.mean(eval_df['abs_perc']), eval_df


class TrainProphet:
    def __init__(self, test_period):
        """
        :param test_period: date (YYYY-MM-DD) which data after that date will be used as forecast period.
        """
        self.holidays = CUSTOM_HOLS
        self.test_period = test_period
        self.m = Prophet(holidays=self.holidays, seasonality_mode='multiplicative', yearly_seasonality=False)
        self.m.add_country_holidays(country_name="UK")
        self.m.add_regressor('air_temperature', mode='multiplicative')


    def fit(self, df, verbose=False):
        # Fit Model
        train_df = _get_training_period(df, self.test_period)
        self.m.fit(train_df)

        # Get forecast
        future_df = _make_future_df(self.m, df)
        forecast = self.m.predict(future_df)

        # Evaluate Forecast
        mape, training_mape_df = _evaluate_mape(df, forecast, self.test_period)

        # Save forecast and training MAPE
        self.forecast = forecast
        self.training_mape = mape
        self.training_mape_df = training_mape_df

        if verbose is True:
            print(f"Training Mean Absolute Percentage Error: {self.training_mape}")
        return self


    def evaluate_global_mape(self, train_test_split, df, test_period=None, verbose=False):
        if test_period is not None:
            test_period = test_period
        else:
            test_period = self.test_period

        test_df = df.query(f"ds>='{test_period}'").copy()
        test_df['max_households'] = test_df['households_num'].max()
        test_forecast = self.m.predict(test_df[['ds','y','air_temperature']])
        test_forecast = test_forecast[['ds','yhat']]
        test_df = test_df.merge(test_forecast, left_on='ds', right_on='ds')
        # calculate global forecasts
        test_df['y_global'] = test_df['y'] * test_df['max_households']
        test_df['yhat_global'] = test_df['yhat'] * test_df['max_households']
        test_df = test_df[['cluster', 'ds', 'y', 'max_households', 'yhat', 'y_global', 'yhat_global']]

        # Save test forecast and test MAPE
        self.test_mape = np.round(np.mean(np.abs(test_df['yhat_global']/test_df['y_global'] - 1)),4) * 100

        if train_test_split == "train":
            self.train_global = test_df
        elif train_test_split == "test":
            self.test_global = test_df
        else:
            raise ValueError("train_test_split must be in ['train','test']")

        if verbose is True:
            print(f"Global {train_test_split} Mean Absolute Percentage Error: {self.test_mape}")
        return self


    def plot_forecast(self):
        plot = self.m.plot(self.forecast)
        return plot

    def plot_components(self):
        plot = self.m.plot_components(self.forecast)
        return plot