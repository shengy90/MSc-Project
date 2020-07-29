import datetime as dt
from fbprophet import Prophet
from definitions.prophet_definitions import CUSTOM_HOLS


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


    def _get_training_period(self, df, date_filter):
        df_out = df.query(f"ds < '{date_filter}'").copy()
        assert len(df_out) < len(df)
        assert df_out['ds'].max() < dt.datetime.strptime(date_filter, "%Y-%m-%d")
        return df_out

    def _make_future_df(self, df):
        future_df = self.m.make_future_dataframe(periods=1440, freq='30min')
        future_df = future_df.merge(df, left_on='ds', right_on='ds')
        return future_df

    def fit(self, df):
        # Get training period
        train_df = self._get_training_period(df, self.test_period)
        self.m.fit(train_df)
        # Get forecast period
        future_df = self._make_future_df(df)

        forecast = self.m.predict(future_df)
        mape = self.evaluate_mape(df)

        self.forecast = forecast
        self.mape = mape
        return forecast, mape

    def plot_forecast(self):
        plot = self.m.plot(self.forecast)
        return plot


    def plot_components(self):
        plot = self.m.plot_components(self.forecast)
        return plot