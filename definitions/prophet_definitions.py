from pathlib import Path
import pandas as pd
import os

# Get test dataframe
path = Path(os.path.realpath(__file__))
parent_dir = str(path.parent.parent)
TEST_DF = pd.read_csv(os.path.join(parent_dir, 'bin', 'test_data.csv'))
TEST_DF['ds'] = pd.to_datetime(TEST_DF['ds'])

# Custom Holidays
CUSTOM_HOLS = pd.DataFrame({
  'holiday': 'December Year End',
  'ds': pd.to_datetime(['2012-12-20', '2012-12-21', '2012-12-22',
                        '2012-12-23', '2012-12-24', '2012-12-25',
                        '2012-12-26', '2012-12-27', '2012-12-28',
                        '2012-12-29', '2012-12-30', '2012-12-31',
                        '2013-01-01', '2013-01-02', '2013-01-03']),
  'lower_window': 0,
  'upper_window': 1,
})
