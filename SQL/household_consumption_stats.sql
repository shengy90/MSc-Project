CREATE OR REPLACE TABLE `machine-learning-msc.low_carbon_london.household_consumption_stats` AS 
SELECT 
lcl_id,
ts,
--extract ts elements
CAST(TIMESTAMP_TRUNC(ts, YEAR) AS DATE) AS year,
CAST(TIMESTAMP_TRUNC(ts, MONTH) AS DATE) AS month,
CAST(TIMESTAMP_TRUNC(ts, DAY) AS DATE) AS day,

EXTRACT(HOUR FROM ts) AS hour,
EXTRACT(MINUTE FROM ts) AS minute,

SAFE_CAST(kwhh AS FLOAT64) AS kwhh,
REPLACE(acorn, "ACORN-A", "") AS acorn,
acorn_grouped,
MOD(ABS(FARM_FINGERPRINT(lcl_id)),100) AS sample
FROM `machine-learning-msc.low_carbon_london.household_consumption_raw_stats` 
WHERE stdortou = 'Std'