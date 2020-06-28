CREATE OR REPLACE TABLE `machine-learning-msc.low_carbon_london.household_consumption_stats` AS 
SELECT 
lcl_id,
ts,
-- extract date elements
EXTRACT(YEAR FROM ts) AS year,
EXTRACT(MONTH FROM ts) AS month,
EXTRACT(DAY FROM ts) AS day,
EXTRACT(YEAR FROM ts)*100 + EXTRACT(MONTH FROM ts) AS yyyymm,
EXTRACT(YEAR FROM ts)*10000+EXTRACT(MONTH FROM ts)*100+EXTRACT(DAY from ts) AS yyyymmdd,

--extract time elements
EXTRACT(HOUR FROM ts) AS hour,
EXTRACT(MINUTE FROM ts) AS minute,

SAFE_CAST(kwhh AS FLOAT64) AS kwhh,
REPLACE(acorn, "ACORN-A", "") AS acorn,
acorn_grouped,
MOD(ABS(FARM_FINGERPRINT(lcl_id)),100) AS sample
FROM `machine-learning-msc.low_carbon_london.household_consumption_raw_stats` 
WHERE stdortou = 'Std'