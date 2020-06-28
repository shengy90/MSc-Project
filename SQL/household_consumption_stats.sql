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

stdortou,
COALESCE(tariffs.Tariff, "Normal") AS tariff_type,
CASE 
    WHEN stdortou = 'ToU' AND tariffs.Tariff = "Low" THEN 3.99
    WHEN stdortou = 'ToU' AND  tariffs.Tariff = "Normal" THEN 11.76
    WHEN stdortou = 'ToU' AND  tariffs.Tariff = "High" THEN 67.20
    ELSE 14.228 
    END AS tariff,
SAFE_CAST(kwhh AS FLOAT64) AS kwhh,
REPLACE(acorn, "ACORN-", "") AS acorn,
acorn_grouped,

MOD(ABS(FARM_FINGERPRINT(lcl_id)),100) AS sample

FROM `machine-learning-msc.low_carbon_london.household_consumption_raw_stats` raw_stats
LEFT JOIN `machine-learning-msc.low_carbon_london.dtou_tariffs` tariffs ON tariffs.TariffDateTime = raw_stats.ts



