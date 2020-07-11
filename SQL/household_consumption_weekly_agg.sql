CREATE OR REPLACE TABLE `machine-learning-msc.low_carbon_london.household_consumption_weekly_season_agg` AS 


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
	CASE
		WHEN EXTRACT(MONTH FROM ts) IN (12,1,2) THEN 'Winter'
		WHEN EXTRACT(MONTH FROM ts) IN (3,4,5) THEN 'Spring'
		WHEN EXTRACT(MONTH FROM ts) IN (6,7,8) THEN 'Summer'
		WHEN EXTRACT(MONTH FROM ts) IN (9,10,11) THEN 'Autumn'
		ELSE 'Error'
		END AS season 
	FROM `machine-learning-msc.low_carbon_london.household_consumption_stats` 
	WHERE day >= '2012-10-01' AND day < '2013-10-01'
	AND stdortou = 'Std'
	AND lcl_id IN (SELECT lcl_id FROM households WHERE num_hhourly=48)
	),


data AS (
	SELECT 
	lcl_id,
	acorn,
	acorn_grouped,
	season,
	dayofweek,
	kwhh,
	PERCENTILE_CONT(kwhh, 0.5) OVER (PARTITION BY lcl_id, season, dayofweek) AS weekly_season_median,
	PERCENTILE_CONT(kwhh, 0.25) OVER (PARTITION BY lcl_id, season, dayofweek) AS weekly_season_quartile_25,
	PERCENTILE_CONT(kwhh, 0.75) OVER (PARTITION BY lcl_id, season, dayofweek) AS weekly_season_quartile_75

	FROM raw_data
	)

SELECT 
lcl_id,
acorn_grouped,
acorn,
season,
dayofweek,
AVG(kwhh) AS weekly_season_avg,
MAX(kwhh) AS weekly_season_max,
MIN(kwhh) AS weekly_season_min,
STDDEV(kwhh) AS weekly_season_stddev,
AVG(weekly_season_median) AS weekly_season_median,
AVG(weekly_season_quartile_25) AS weekly_season_quartile_25,
AVG(weekly_season_quartile_75) AS weekly_season_quartile_75
FROM data 
GROUP BY 1,2,3,4,5


