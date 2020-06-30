CREATE OR REPLACE TABLE `machine-learning-msc.low_carbon_london.household_consumption_daily_stats` AS 

WITH daily_sum AS (
  SELECT 
  lcl_id,
  month,
  day,
  acorn, 
  acorn_grouped,
  sample,
  tariff,

  -- daily stats 
  SUM(kwhh) AS daily_consumption,
  STDDEV(kwhh) AS daily_consumption_stddev,
  MAX(kwhh) AS daily_consumption_max,
  MIN(kwhh) AS daily_consumption_min,
  AVG(kwhh) AS daily_consumption_avg


  FROM `machine-learning-msc.low_carbon_london.household_consumption_stats`
  GROUP BY 1,2,3,4,5,6,7
  )
  
SELECT 
*,
SUM(daily_consumption) OVER month_to_date AS month_to_date_cumulative_sum, -- cumulative month to date consumption
STDDEV(daily_consumption) OVER month_to_date AS month_to_date_cumulative_stddev, -- std deviation of month to date consumption
MAX(daily_consumption) OVER month_to_date AS month_to_date_cumulative_max, -- maximum of month to date consumption
MIN(daily_consumption) OVER month_to_date AS month_to_date_cumulative_min, -- minimum of month to date consumption
AVG(daily_consumption) OVER month_to_date AS month_to_date_cumulative_avg -- average of month to date consumption

FROM daily_sum 
WINDOW 
month_to_date AS (PARTITION BY lcl_id, month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)



