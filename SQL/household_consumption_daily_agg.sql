WITH data AS (
	SELECT 
	lcl_id,
	acorn,
	acorn_grouped,
	ts,
	hourly_rank,
	hhourly_rank,
	kwhh,
	PERCENTILE_CONT(kwhh, 0.5) OVER (PARTITION BY lcl_id, hhourly_rank) AS median,
	PERCENTILE_CONT(kwhh, 0.25) OVER (PARTITION BY lcl_id, hhourly_rank) AS quartile_25,
	PERCENTILE_CONT(kwhh, 0.75) OVER (PARTITION BY lcl_id, hhourly_rank) AS quartile_75


	FROM `machine-learning-msc.low_carbon_london.household_consumption_stats` 
	WHERE day >= '2012-10-01' AND day < '2013-10-01'
	AND stdortou = 'Std'
	)

SELECT 
lcl_id,
hhourly_rank,
AVG(kwhh) AS hh_avg,
MAX(kwhh) AS hh_max,
MIN(kwhh) AS hh_min,
STDDEV(kwhh) AS hh_stddev,
AVG(median) AS hh_median,
AVG(quartile_25) AS hh_quartile_25,
AVG(quartile_75) AS hh_quartile_75
FROM data 
GROUP BY 1,2
