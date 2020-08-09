CREATE OR REPLACE TABLE `machine-learning-msc.london_heathrow_hourly_weather_data.london_heathrow_hourly_weather` AS 

WITH twentytwelve AS (

	SELECT 
	SAFE_CAST(ob_time AS TIMESTAMP) AS ts,
	SAFE_CAST(wind_speed AS FLOAT64) AS wind_speed, 
	COALESCE(SAFE_CAST(prst_wx_id AS INT64),0) AS weather_flag,
	SAFE_CAST(cld_ttl_amt_id AS INT64) AS cloud_amount_flag,
	SAFE_CAST(cld_base_ht AS FLOAT64) AS cloud_base_height,
	SAFE_CAST(msl_pressure AS FLOAT64) AS mean_sea_level_pressure,
	SAFE_CAST(air_temperature AS FLOAT64) AS air_temperature,
	SAFE_CAST(dewpoint AS FLOAT64) AS dewpoint,
	SAFE_CAST(wetb_temp AS FLOAT64) web_bulb_temperature,
	SAFE_CAST(drv_hr_sun_dur AS FLOAT64) AS derived_hourly_sun_duration 

	FROM `machine-learning-msc.london_heathrow_hourly_weather_data.london_heathrow_hourly_2012` 

	WHERE ob_time != 'end data'

	),

twentythirteen AS (

	SELECT 


	SAFE_CAST(ob_time AS TIMESTAMP) AS ts,
	SAFE_CAST(wind_speed AS FLOAT64) AS wind_speed, 
	COALESCE(SAFE_CAST(prst_wx_id AS INT64),0) AS weather_flag,
	SAFE_CAST(cld_ttl_amt_id AS INT64) AS cloud_amount_flag,
	SAFE_CAST(cld_base_ht AS FLOAT64) AS cloud_base_height,
	SAFE_CAST(msl_pressure AS FLOAT64) AS mean_sea_level_pressure,
	SAFE_CAST(air_temperature AS FLOAT64) AS air_temperature,
	SAFE_CAST(dewpoint AS FLOAT64) AS dewpoint,
	SAFE_CAST(wetb_temp AS FLOAT64) web_bulb_temperature,
	SAFE_CAST(drv_hr_sun_dur AS FLOAT64) AS derived_hourly_sun_duration 

	FROM `machine-learning-msc.london_heathrow_hourly_weather_data.london_heathrow_hourly_2013` 

	WHERE ob_time != 'end data'
	),

twentyfourteen AS (

	SELECT
	SAFE_CAST(ob_time AS TIMESTAMP) AS ts,
	SAFE_CAST(wind_speed AS FLOAT64) AS wind_speed,
	COALESCE(SAFE_CAST(prst_wx_id AS INT64),0) AS weather_flag,
	SAFE_CAST(cld_ttl_amt_id AS INT64) AS cloud_amount_flag,
	SAFE_CAST(cld_base_ht AS FLOAT64) AS cloud_base_height,
	SAFE_CAST(msl_pressure AS FLOAT64) AS mean_sea_level_pressure,
	SAFE_CAST(air_temperature AS FLOAT64) AS air_temperature,
	SAFE_CAST(dewpoint AS FLOAT64) AS dewpoint,
	SAFE_CAST(wetb_temp AS FLOAT64) web_bulb_temperature,
	SAFE_CAST(drv_hr_sun_dur AS FLOAT64) AS derived_hourly_sun_duration

	FROM `machine-learning-msc.london_heathrow_hourly_weather_data.london_heathrow_hourly_2014`

	WHERE ob_time != 'end data'
	),

union_all AS (
	SELECT * FROM twentytwelve
	UNION ALL
	SELECT * FROM twentythirteen
	UNION ALL
	SELECT * FROM twentyfourteen
	)

SELECT
* EXCEPT(air_temperature),
LAST_VALUE(air_temperature IGNORE NULLS) OVER (ORDER BY ts ASC) AS air_temperature
FROM union_all

