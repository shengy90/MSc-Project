CREATE OR REPLACE TABLE `machine-learning-msc.low_carbon_london.household_consumption_monthly_stats` AS 

WITH monthly_sum AS (
  SELECT 
  lcl_id,
  month,
  acorn, 
  acorn_grouped,
  sample,
  tariff,
  stdortou,

  -- daily stats 
  SUM(kwhh) AS monthly_consumption,
  STDDEV(kwhh) AS monthly_consumption_stddev,
  MAX(kwhh) AS monthly_consumption_max,
  MIN(kwhh) AS monthly_consumption_min,
  AVG(kwhh) AS monthly_consumption_avg

  FROM `machine-learning-msc.low_carbon_london.household_consumption_stats`
  GROUP BY 1,2,3,4,5,6,7
  )
  
SELECT 
*
FROM monthly_sum 


