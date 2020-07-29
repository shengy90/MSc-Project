import datetime as dt
import numpy as np
from fbprophet import Prophet
from definitions.prophet_definitions import CUSTOM_HOLS


def _get_training_period(df, date_filter):
    df_out = df.query(f"ds < '{date_filter}'").copy()
    assert len(df_out) < len(df)
    assert df_out['ds'].max() < dt.datetime.strptime(date_filter, "%Y-%m-%d")
    return df_out


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

    def _make_future_df(self, df):
        future_df = self.m.make_future_dataframe(periods=1440, freq='30min')
        future_df = future_df.merge(df, left_on='ds', right_on='ds')
        return future_df


    def _evaluate_mape(self, df, forecast):
        fc_start = self.test_period
        y = df.query(f'ds>="{fc_start}"')[['ds','y']]
        pred = forecast.query(f'ds>="{fc_start}"')[['ds', 'yhat']]
        eval_df = y.merge(pred, on='ds')
        eval_df['y'] = eval_df['y'] + 0.000000000001
        eval_df['abs_err'] = np.abs((eval_df['y'] - eval_df['yhat']))
        eval_df['abs_perc'] = np.round(eval_df['abs_err']/eval_df['y']*100,4)
        return np.mean(eval_df['abs_perc'])


    def fit(self, df):
        # Get training period
        print("Getting Training Period..")
        train_df = _get_training_period(df, self.test_period)
        self.m.fit(train_df)
        # Get forecast period
        future_df = self._make_future_df(df)

        forecast = self.m.predict(future_df)
        mape = self._evaluate_mape(df, forecast)

        self.forecast = forecast
        self.mape = mape
        return forecast, mape

    def plot_forecast(self):
        plot = self.m.plot(self.forecast)
        return plot

    def plot_components(self):
        plot = self.m.plot_components(self.forecast)
        return plot