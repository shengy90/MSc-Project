CREATE OR REPLACE TABLE `machine-learning-msc.low_carbon_london.household_consumption_daily_agg` AS 


WITH 
households AS (
	SELECT 
	lcl_id,
	COUNT(DISTINCT hhourly_rank) AS num_hhourly
	FROM `machine-learning-msc.low_carbon_london.household_consumption_stats` 
	WHERE stdortou = 'Std'
	AND day >= '2012-10-01' AND day < '2013-10-01'
	GROUP BY 1 
	),

raw_data AS (
	SELECT 
	*,
	FORMAT_DATETIME("%B", DATETIME(ts)) AS month_name
	FROM `machine-learning-msc.low_carbon_london.household_consumption_stats` 
	),


data AS (
	SELECT 
	lcl_id,
	acorn,
	acorn_grouped,
	month_name,
	dayofweek,
	ts,
	hourly_rank,
	hhourly_rank,
	kwhh,
	PERCENTILE_CONT(kwhh, 0.5) OVER (PARTITION BY lcl_id, month_name, dayofweek, hhourly_rank) AS median,
	PERCENTILE_CONT(kwhh, 0.25) OVER (PARTITION BY lcl_id, month_name, dayofweek, hhourly_rank) AS quartile_25,
	PERCENTILE_CONT(kwhh, 0.75) OVER (PARTITION BY lcl_id, month_name, dayofweek, hhourly_rank) AS quartile_75

	FROM raw_data
  	)

SELECT 
lcl_id,
acorn_grouped,
acorn,
month_name,
dayofweek,
hhourly_rank,
AVG(kwhh) AS hh_avg,
MAX(kwhh) AS hh_max,
MIN(kwhh) AS hh_min,
STDDEV(kwhh) AS hh_stddev,
AVG(median) AS hh_median,
AVG(quartile_25) AS hh_quartile_25,
AVG(quartile_75) AS hh_quartile_75
FROM data 
GROUP BY 1,2,3,4,5,6

