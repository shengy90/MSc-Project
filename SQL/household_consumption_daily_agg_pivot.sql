/*
Granularity of table: 1 row per lcl_id per half-hour.
Total number of columns: 12 months X 7 days of weeks X 5 metrics.
*/
CREATE OR REPLACE TABLE `machine-learning-msc.low_carbon_london.household_consumption_daily_agg_pivot` AS 



SELECT 
lcl_id,
acorn_grouped,
acorn,
hhourly_rank,

-- pivots : jan
SUM(IF(month_name='January' AND dayofweek = 1, hh_avg, NULL)) AS jan_sun_hh_avg,
SUM(IF(month_name='January' AND dayofweek = 2, hh_avg, NULL)) AS jan_mon_hh_avg,
SUM(IF(month_name='January' AND dayofweek = 3, hh_avg, NULL)) AS jan_tue_hh_avg,
SUM(IF(month_name='January' AND dayofweek = 4, hh_avg, NULL)) AS jan_wed_hh_avg,
SUM(IF(month_name='January' AND dayofweek = 5, hh_avg, NULL)) AS jan_thu_hh_avg,
SUM(IF(month_name='January' AND dayofweek = 6, hh_avg, NULL)) AS jan_fri_hh_avg,
SUM(IF(month_name='January' AND dayofweek = 7, hh_avg, NULL)) AS jan_sat_hh_avg,

-- pivots : feb
SUM(IF(month_name='February' AND dayofweek = 1, hh_avg, NULL)) AS feb_sun_hh_avg,
SUM(IF(month_name='February' AND dayofweek = 2, hh_avg, NULL)) AS feb_mon_hh_avg,
SUM(IF(month_name='February' AND dayofweek = 3, hh_avg, NULL)) AS feb_tue_hh_avg,
SUM(IF(month_name='February' AND dayofweek = 4, hh_avg, NULL)) AS feb_wed_hh_avg,
SUM(IF(month_name='February' AND dayofweek = 5, hh_avg, NULL)) AS feb_thu_hh_avg,
SUM(IF(month_name='February' AND dayofweek = 6, hh_avg, NULL)) AS feb_fri_hh_avg,
SUM(IF(month_name='February' AND dayofweek = 7, hh_avg, NULL)) AS feb_sat_hh_avg,

-- pivots : mar
SUM(IF(month_name='March' AND dayofweek = 1, hh_avg, NULL)) AS mar_sun_hh_avg,
SUM(IF(month_name='March' AND dayofweek = 2, hh_avg, NULL)) AS mar_mon_hh_avg,
SUM(IF(month_name='March' AND dayofweek = 3, hh_avg, NULL)) AS mar_tue_hh_avg,
SUM(IF(month_name='March' AND dayofweek = 4, hh_avg, NULL)) AS mar_wed_hh_avg,
SUM(IF(month_name='March' AND dayofweek = 5, hh_avg, NULL)) AS mar_thu_hh_avg,
SUM(IF(month_name='March' AND dayofweek = 6, hh_avg, NULL)) AS mar_fri_hh_avg,
SUM(IF(month_name='March' AND dayofweek = 7, hh_avg, NULL)) AS mar_sat_hh_avg,

-- pivots : apr
SUM(IF(month_name='April' AND dayofweek = 1, hh_avg, NULL)) AS apr_sun_hh_avg,
SUM(IF(month_name='April' AND dayofweek = 2, hh_avg, NULL)) AS apr_mon_hh_avg,
SUM(IF(month_name='April' AND dayofweek = 3, hh_avg, NULL)) AS apr_tue_hh_avg,
SUM(IF(month_name='April' AND dayofweek = 4, hh_avg, NULL)) AS apr_wed_hh_avg,
SUM(IF(month_name='April' AND dayofweek = 5, hh_avg, NULL)) AS apr_thu_hh_avg,
SUM(IF(month_name='April' AND dayofweek = 6, hh_avg, NULL)) AS apr_fri_hh_avg,
SUM(IF(month_name='April' AND dayofweek = 7, hh_avg, NULL)) AS apr_sat_hh_avg,

-- pivots : may
SUM(IF(month_name='May' AND dayofweek = 1, hh_avg, NULL)) AS may_sun_hh_avg,
SUM(IF(month_name='May' AND dayofweek = 2, hh_avg, NULL)) AS may_mon_hh_avg,
SUM(IF(month_name='May' AND dayofweek = 3, hh_avg, NULL)) AS may_tue_hh_avg,
SUM(IF(month_name='May' AND dayofweek = 4, hh_avg, NULL)) AS may_wed_hh_avg,
SUM(IF(month_name='May' AND dayofweek = 5, hh_avg, NULL)) AS may_thu_hh_avg,
SUM(IF(month_name='May' AND dayofweek = 6, hh_avg, NULL)) AS may_fri_hh_avg,
SUM(IF(month_name='May' AND dayofweek = 7, hh_avg, NULL)) AS may_sat_hh_avg,

-- pivots : jun
SUM(IF(month_name='June' AND dayofweek = 1, hh_avg, NULL)) AS jun_sun_hh_avg,
SUM(IF(month_name='June' AND dayofweek = 2, hh_avg, NULL)) AS jun_mon_hh_avg,
SUM(IF(month_name='June' AND dayofweek = 3, hh_avg, NULL)) AS jun_tue_hh_avg,
SUM(IF(month_name='June' AND dayofweek = 4, hh_avg, NULL)) AS jun_wed_hh_avg,
SUM(IF(month_name='June' AND dayofweek = 5, hh_avg, NULL)) AS jun_thu_hh_avg,
SUM(IF(month_name='June' AND dayofweek = 6, hh_avg, NULL)) AS jun_fri_hh_avg,
SUM(IF(month_name='June' AND dayofweek = 7, hh_avg, NULL)) AS jun_sat_hh_avg,

-- pivots : jul
SUM(IF(month_name='July' AND dayofweek = 1, hh_avg, NULL)) AS jul_sun_hh_avg,
SUM(IF(month_name='July' AND dayofweek = 2, hh_avg, NULL)) AS jul_mon_hh_avg,
SUM(IF(month_name='July' AND dayofweek = 3, hh_avg, NULL)) AS jul_tue_hh_avg,
SUM(IF(month_name='July' AND dayofweek = 4, hh_avg, NULL)) AS jul_wed_hh_avg,
SUM(IF(month_name='July' AND dayofweek = 5, hh_avg, NULL)) AS jul_thu_hh_avg,
SUM(IF(month_name='July' AND dayofweek = 6, hh_avg, NULL)) AS jul_fri_hh_avg,
SUM(IF(month_name='July' AND dayofweek = 7, hh_avg, NULL)) AS jul_sat_hh_avg,

-- pivots : aug
SUM(IF(month_name='August' AND dayofweek = 1, hh_avg, NULL)) AS aug_sun_hh_avg,
SUM(IF(month_name='August' AND dayofweek = 2, hh_avg, NULL)) AS aug_mon_hh_avg,
SUM(IF(month_name='August' AND dayofweek = 3, hh_avg, NULL)) AS aug_tue_hh_avg,
SUM(IF(month_name='August' AND dayofweek = 4, hh_avg, NULL)) AS aug_wed_hh_avg,
SUM(IF(month_name='August' AND dayofweek = 5, hh_avg, NULL)) AS aug_thu_hh_avg,
SUM(IF(month_name='August' AND dayofweek = 6, hh_avg, NULL)) AS aug_fri_hh_avg,
SUM(IF(month_name='August' AND dayofweek = 7, hh_avg, NULL)) AS aug_sat_hh_avg,

-- pivots : sep
SUM(IF(month_name='September' AND dayofweek = 1, hh_avg, NULL)) AS sep_sun_hh_avg,
SUM(IF(month_name='September' AND dayofweek = 2, hh_avg, NULL)) AS sep_mon_hh_avg,
SUM(IF(month_name='September' AND dayofweek = 3, hh_avg, NULL)) AS sep_tue_hh_avg,
SUM(IF(month_name='September' AND dayofweek = 4, hh_avg, NULL)) AS sep_wed_hh_avg,
SUM(IF(month_name='September' AND dayofweek = 5, hh_avg, NULL)) AS sep_thu_hh_avg,
SUM(IF(month_name='September' AND dayofweek = 6, hh_avg, NULL)) AS sep_fri_hh_avg,
SUM(IF(month_name='September' AND dayofweek = 7, hh_avg, NULL)) AS sep_sat_hh_avg,

-- pivots : oct
SUM(IF(month_name='October' AND dayofweek = 1, hh_avg, NULL)) AS oct_sun_hh_avg,
SUM(IF(month_name='October' AND dayofweek = 2, hh_avg, NULL)) AS oct_mon_hh_avg,
SUM(IF(month_name='October' AND dayofweek = 3, hh_avg, NULL)) AS oct_tue_hh_avg,
SUM(IF(month_name='October' AND dayofweek = 4, hh_avg, NULL)) AS oct_wed_hh_avg,
SUM(IF(month_name='October' AND dayofweek = 5, hh_avg, NULL)) AS oct_thu_hh_avg,
SUM(IF(month_name='October' AND dayofweek = 6, hh_avg, NULL)) AS oct_fri_hh_avg,
SUM(IF(month_name='October' AND dayofweek = 7, hh_avg, NULL)) AS oct_sat_hh_avg,

-- pivots : nov
SUM(IF(month_name='November' AND dayofweek = 1, hh_avg, NULL)) AS nov_sun_hh_avg,
SUM(IF(month_name='November' AND dayofweek = 2, hh_avg, NULL)) AS nov_mon_hh_avg,
SUM(IF(month_name='November' AND dayofweek = 3, hh_avg, NULL)) AS nov_tue_hh_avg,
SUM(IF(month_name='November' AND dayofweek = 4, hh_avg, NULL)) AS nov_wed_hh_avg,
SUM(IF(month_name='November' AND dayofweek = 5, hh_avg, NULL)) AS nov_thu_hh_avg,
SUM(IF(month_name='November' AND dayofweek = 6, hh_avg, NULL)) AS nov_fri_hh_avg,
SUM(IF(month_name='November' AND dayofweek = 7, hh_avg, NULL)) AS nov_sat_hh_avg,

-- pivots : dec
SUM(IF(month_name='December' AND dayofweek = 1, hh_avg, NULL)) AS dec_sun_hh_avg,
SUM(IF(month_name='December' AND dayofweek = 2, hh_avg, NULL)) AS dec_mon_hh_avg,
SUM(IF(month_name='December' AND dayofweek = 3, hh_avg, NULL)) AS dec_tue_hh_avg,
SUM(IF(month_name='December' AND dayofweek = 4, hh_avg, NULL)) AS dec_wed_hh_avg,
SUM(IF(month_name='December' AND dayofweek = 5, hh_avg, NULL)) AS dec_thu_hh_avg,
SUM(IF(month_name='December' AND dayofweek = 6, hh_avg, NULL)) AS dec_fri_hh_avg,
SUM(IF(month_name='December' AND dayofweek = 7, hh_avg, NULL)) AS dec_sat_hh_avg,

-- pivots : jan
SUM(IF(month_name='January' AND dayofweek = 1, hh_max, NULL)) AS jan_sun_hh_max,
SUM(IF(month_name='January' AND dayofweek = 2, hh_max, NULL)) AS jan_mon_hh_max,
SUM(IF(month_name='January' AND dayofweek = 3, hh_max, NULL)) AS jan_tue_hh_max,
SUM(IF(month_name='January' AND dayofweek = 4, hh_max, NULL)) AS jan_wed_hh_max,
SUM(IF(month_name='January' AND dayofweek = 5, hh_max, NULL)) AS jan_thu_hh_max,
SUM(IF(month_name='January' AND dayofweek = 6, hh_max, NULL)) AS jan_fri_hh_max,
SUM(IF(month_name='January' AND dayofweek = 7, hh_max, NULL)) AS jan_sat_hh_max,

-- pivots : feb
SUM(IF(month_name='February' AND dayofweek = 1, hh_max, NULL)) AS feb_sun_hh_max,
SUM(IF(month_name='February' AND dayofweek = 2, hh_max, NULL)) AS feb_mon_hh_max,
SUM(IF(month_name='February' AND dayofweek = 3, hh_max, NULL)) AS feb_tue_hh_max,
SUM(IF(month_name='February' AND dayofweek = 4, hh_max, NULL)) AS feb_wed_hh_max,
SUM(IF(month_name='February' AND dayofweek = 5, hh_max, NULL)) AS feb_thu_hh_max,
SUM(IF(month_name='February' AND dayofweek = 6, hh_max, NULL)) AS feb_fri_hh_max,
SUM(IF(month_name='February' AND dayofweek = 7, hh_max, NULL)) AS feb_sat_hh_max,

-- pivots : mar
SUM(IF(month_name='March' AND dayofweek = 1, hh_max, NULL)) AS mar_sun_hh_max,
SUM(IF(month_name='March' AND dayofweek = 2, hh_max, NULL)) AS mar_mon_hh_max,
SUM(IF(month_name='March' AND dayofweek = 3, hh_max, NULL)) AS mar_tue_hh_max,
SUM(IF(month_name='March' AND dayofweek = 4, hh_max, NULL)) AS mar_wed_hh_max,
SUM(IF(month_name='March' AND dayofweek = 5, hh_max, NULL)) AS mar_thu_hh_max,
SUM(IF(month_name='March' AND dayofweek = 6, hh_max, NULL)) AS mar_fri_hh_max,
SUM(IF(month_name='March' AND dayofweek = 7, hh_max, NULL)) AS mar_sat_hh_max,

-- pivots : apr
SUM(IF(month_name='April' AND dayofweek = 1, hh_max, NULL)) AS apr_sun_hh_max,
SUM(IF(month_name='April' AND dayofweek = 2, hh_max, NULL)) AS apr_mon_hh_max,
SUM(IF(month_name='April' AND dayofweek = 3, hh_max, NULL)) AS apr_tue_hh_max,
SUM(IF(month_name='April' AND dayofweek = 4, hh_max, NULL)) AS apr_wed_hh_max,
SUM(IF(month_name='April' AND dayofweek = 5, hh_max, NULL)) AS apr_thu_hh_max,
SUM(IF(month_name='April' AND dayofweek = 6, hh_max, NULL)) AS apr_fri_hh_max,
SUM(IF(month_name='April' AND dayofweek = 7, hh_max, NULL)) AS apr_sat_hh_max,

-- pivots : may
SUM(IF(month_name='May' AND dayofweek = 1, hh_max, NULL)) AS may_sun_hh_max,
SUM(IF(month_name='May' AND dayofweek = 2, hh_max, NULL)) AS may_mon_hh_max,
SUM(IF(month_name='May' AND dayofweek = 3, hh_max, NULL)) AS may_tue_hh_max,
SUM(IF(month_name='May' AND dayofweek = 4, hh_max, NULL)) AS may_wed_hh_max,
SUM(IF(month_name='May' AND dayofweek = 5, hh_max, NULL)) AS may_thu_hh_max,
SUM(IF(month_name='May' AND dayofweek = 6, hh_max, NULL)) AS may_fri_hh_max,
SUM(IF(month_name='May' AND dayofweek = 7, hh_max, NULL)) AS may_sat_hh_max,

-- pivots : jun
SUM(IF(month_name='June' AND dayofweek = 1, hh_max, NULL)) AS jun_sun_hh_max,
SUM(IF(month_name='June' AND dayofweek = 2, hh_max, NULL)) AS jun_mon_hh_max,
SUM(IF(month_name='June' AND dayofweek = 3, hh_max, NULL)) AS jun_tue_hh_max,
SUM(IF(month_name='June' AND dayofweek = 4, hh_max, NULL)) AS jun_wed_hh_max,
SUM(IF(month_name='June' AND dayofweek = 5, hh_max, NULL)) AS jun_thu_hh_max,
SUM(IF(month_name='June' AND dayofweek = 6, hh_max, NULL)) AS jun_fri_hh_max,
SUM(IF(month_name='June' AND dayofweek = 7, hh_max, NULL)) AS jun_sat_hh_max,

-- pivots : jul
SUM(IF(month_name='July' AND dayofweek = 1, hh_max, NULL)) AS jul_sun_hh_max,
SUM(IF(month_name='July' AND dayofweek = 2, hh_max, NULL)) AS jul_mon_hh_max,
SUM(IF(month_name='July' AND dayofweek = 3, hh_max, NULL)) AS jul_tue_hh_max,
SUM(IF(month_name='July' AND dayofweek = 4, hh_max, NULL)) AS jul_wed_hh_max,
SUM(IF(month_name='July' AND dayofweek = 5, hh_max, NULL)) AS jul_thu_hh_max,
SUM(IF(month_name='July' AND dayofweek = 6, hh_max, NULL)) AS jul_fri_hh_max,
SUM(IF(month_name='July' AND dayofweek = 7, hh_max, NULL)) AS jul_sat_hh_max,

-- pivots : aug
SUM(IF(month_name='August' AND dayofweek = 1, hh_max, NULL)) AS aug_sun_hh_max,
SUM(IF(month_name='August' AND dayofweek = 2, hh_max, NULL)) AS aug_mon_hh_max,
SUM(IF(month_name='August' AND dayofweek = 3, hh_max, NULL)) AS aug_tue_hh_max,
SUM(IF(month_name='August' AND dayofweek = 4, hh_max, NULL)) AS aug_wed_hh_max,
SUM(IF(month_name='August' AND dayofweek = 5, hh_max, NULL)) AS aug_thu_hh_max,
SUM(IF(month_name='August' AND dayofweek = 6, hh_max, NULL)) AS aug_fri_hh_max,
SUM(IF(month_name='August' AND dayofweek = 7, hh_max, NULL)) AS aug_sat_hh_max,

-- pivots : sep
SUM(IF(month_name='September' AND dayofweek = 1, hh_max, NULL)) AS sep_sun_hh_max,
SUM(IF(month_name='September' AND dayofweek = 2, hh_max, NULL)) AS sep_mon_hh_max,
SUM(IF(month_name='September' AND dayofweek = 3, hh_max, NULL)) AS sep_tue_hh_max,
SUM(IF(month_name='September' AND dayofweek = 4, hh_max, NULL)) AS sep_wed_hh_max,
SUM(IF(month_name='September' AND dayofweek = 5, hh_max, NULL)) AS sep_thu_hh_max,
SUM(IF(month_name='September' AND dayofweek = 6, hh_max, NULL)) AS sep_fri_hh_max,
SUM(IF(month_name='September' AND dayofweek = 7, hh_max, NULL)) AS sep_sat_hh_max,

-- pivots : oct
SUM(IF(month_name='October' AND dayofweek = 1, hh_max, NULL)) AS oct_sun_hh_max,
SUM(IF(month_name='October' AND dayofweek = 2, hh_max, NULL)) AS oct_mon_hh_max,
SUM(IF(month_name='October' AND dayofweek = 3, hh_max, NULL)) AS oct_tue_hh_max,
SUM(IF(month_name='October' AND dayofweek = 4, hh_max, NULL)) AS oct_wed_hh_max,
SUM(IF(month_name='October' AND dayofweek = 5, hh_max, NULL)) AS oct_thu_hh_max,
SUM(IF(month_name='October' AND dayofweek = 6, hh_max, NULL)) AS oct_fri_hh_max,
SUM(IF(month_name='October' AND dayofweek = 7, hh_max, NULL)) AS oct_sat_hh_max,

-- pivots : nov
SUM(IF(month_name='November' AND dayofweek = 1, hh_max, NULL)) AS nov_sun_hh_max,
SUM(IF(month_name='November' AND dayofweek = 2, hh_max, NULL)) AS nov_mon_hh_max,
SUM(IF(month_name='November' AND dayofweek = 3, hh_max, NULL)) AS nov_tue_hh_max,
SUM(IF(month_name='November' AND dayofweek = 4, hh_max, NULL)) AS nov_wed_hh_max,
SUM(IF(month_name='November' AND dayofweek = 5, hh_max, NULL)) AS nov_thu_hh_max,
SUM(IF(month_name='November' AND dayofweek = 6, hh_max, NULL)) AS nov_fri_hh_max,
SUM(IF(month_name='November' AND dayofweek = 7, hh_max, NULL)) AS nov_sat_hh_max,

-- pivots : dec
SUM(IF(month_name='December' AND dayofweek = 1, hh_max, NULL)) AS dec_sun_hh_max,
SUM(IF(month_name='December' AND dayofweek = 2, hh_max, NULL)) AS dec_mon_hh_max,
SUM(IF(month_name='December' AND dayofweek = 3, hh_max, NULL)) AS dec_tue_hh_max,
SUM(IF(month_name='December' AND dayofweek = 4, hh_max, NULL)) AS dec_wed_hh_max,
SUM(IF(month_name='December' AND dayofweek = 5, hh_max, NULL)) AS dec_thu_hh_max,
SUM(IF(month_name='December' AND dayofweek = 6, hh_max, NULL)) AS dec_fri_hh_max,
SUM(IF(month_name='December' AND dayofweek = 7, hh_max, NULL)) AS dec_sat_hh_max,

-- pivots : jan
SUM(IF(month_name='January' AND dayofweek = 1, hh_min, NULL)) AS jan_sun_hh_min,
SUM(IF(month_name='January' AND dayofweek = 2, hh_min, NULL)) AS jan_mon_hh_min,
SUM(IF(month_name='January' AND dayofweek = 3, hh_min, NULL)) AS jan_tue_hh_min,
SUM(IF(month_name='January' AND dayofweek = 4, hh_min, NULL)) AS jan_wed_hh_min,
SUM(IF(month_name='January' AND dayofweek = 5, hh_min, NULL)) AS jan_thu_hh_min,
SUM(IF(month_name='January' AND dayofweek = 6, hh_min, NULL)) AS jan_fri_hh_min,
SUM(IF(month_name='January' AND dayofweek = 7, hh_min, NULL)) AS jan_sat_hh_min,

-- pivots : feb
SUM(IF(month_name='February' AND dayofweek = 1, hh_min, NULL)) AS feb_sun_hh_min,
SUM(IF(month_name='February' AND dayofweek = 2, hh_min, NULL)) AS feb_mon_hh_min,
SUM(IF(month_name='February' AND dayofweek = 3, hh_min, NULL)) AS feb_tue_hh_min,
SUM(IF(month_name='February' AND dayofweek = 4, hh_min, NULL)) AS feb_wed_hh_min,
SUM(IF(month_name='February' AND dayofweek = 5, hh_min, NULL)) AS feb_thu_hh_min,
SUM(IF(month_name='February' AND dayofweek = 6, hh_min, NULL)) AS feb_fri_hh_min,
SUM(IF(month_name='February' AND dayofweek = 7, hh_min, NULL)) AS feb_sat_hh_min,

-- pivots : mar
SUM(IF(month_name='March' AND dayofweek = 1, hh_min, NULL)) AS mar_sun_hh_min,
SUM(IF(month_name='March' AND dayofweek = 2, hh_min, NULL)) AS mar_mon_hh_min,
SUM(IF(month_name='March' AND dayofweek = 3, hh_min, NULL)) AS mar_tue_hh_min,
SUM(IF(month_name='March' AND dayofweek = 4, hh_min, NULL)) AS mar_wed_hh_min,
SUM(IF(month_name='March' AND dayofweek = 5, hh_min, NULL)) AS mar_thu_hh_min,
SUM(IF(month_name='March' AND dayofweek = 6, hh_min, NULL)) AS mar_fri_hh_min,
SUM(IF(month_name='March' AND dayofweek = 7, hh_min, NULL)) AS mar_sat_hh_min,

-- pivots : apr
SUM(IF(month_name='April' AND dayofweek = 1, hh_min, NULL)) AS apr_sun_hh_min,
SUM(IF(month_name='April' AND dayofweek = 2, hh_min, NULL)) AS apr_mon_hh_min,
SUM(IF(month_name='April' AND dayofweek = 3, hh_min, NULL)) AS apr_tue_hh_min,
SUM(IF(month_name='April' AND dayofweek = 4, hh_min, NULL)) AS apr_wed_hh_min,
SUM(IF(month_name='April' AND dayofweek = 5, hh_min, NULL)) AS apr_thu_hh_min,
SUM(IF(month_name='April' AND dayofweek = 6, hh_min, NULL)) AS apr_fri_hh_min,
SUM(IF(month_name='April' AND dayofweek = 7, hh_min, NULL)) AS apr_sat_hh_min,

-- pivots : may
SUM(IF(month_name='May' AND dayofweek = 1, hh_min, NULL)) AS may_sun_hh_min,
SUM(IF(month_name='May' AND dayofweek = 2, hh_min, NULL)) AS may_mon_hh_min,
SUM(IF(month_name='May' AND dayofweek = 3, hh_min, NULL)) AS may_tue_hh_min,
SUM(IF(month_name='May' AND dayofweek = 4, hh_min, NULL)) AS may_wed_hh_min,
SUM(IF(month_name='May' AND dayofweek = 5, hh_min, NULL)) AS may_thu_hh_min,
SUM(IF(month_name='May' AND dayofweek = 6, hh_min, NULL)) AS may_fri_hh_min,
SUM(IF(month_name='May' AND dayofweek = 7, hh_min, NULL)) AS may_sat_hh_min,

-- pivots : jun
SUM(IF(month_name='June' AND dayofweek = 1, hh_min, NULL)) AS jun_sun_hh_min,
SUM(IF(month_name='June' AND dayofweek = 2, hh_min, NULL)) AS jun_mon_hh_min,
SUM(IF(month_name='June' AND dayofweek = 3, hh_min, NULL)) AS jun_tue_hh_min,
SUM(IF(month_name='June' AND dayofweek = 4, hh_min, NULL)) AS jun_wed_hh_min,
SUM(IF(month_name='June' AND dayofweek = 5, hh_min, NULL)) AS jun_thu_hh_min,
SUM(IF(month_name='June' AND dayofweek = 6, hh_min, NULL)) AS jun_fri_hh_min,
SUM(IF(month_name='June' AND dayofweek = 7, hh_min, NULL)) AS jun_sat_hh_min,

-- pivots : jul
SUM(IF(month_name='July' AND dayofweek = 1, hh_min, NULL)) AS jul_sun_hh_min,
SUM(IF(month_name='July' AND dayofweek = 2, hh_min, NULL)) AS jul_mon_hh_min,
SUM(IF(month_name='July' AND dayofweek = 3, hh_min, NULL)) AS jul_tue_hh_min,
SUM(IF(month_name='July' AND dayofweek = 4, hh_min, NULL)) AS jul_wed_hh_min,
SUM(IF(month_name='July' AND dayofweek = 5, hh_min, NULL)) AS jul_thu_hh_min,
SUM(IF(month_name='July' AND dayofweek = 6, hh_min, NULL)) AS jul_fri_hh_min,
SUM(IF(month_name='July' AND dayofweek = 7, hh_min, NULL)) AS jul_sat_hh_min,

-- pivots : aug
SUM(IF(month_name='August' AND dayofweek = 1, hh_min, NULL)) AS aug_sun_hh_min,
SUM(IF(month_name='August' AND dayofweek = 2, hh_min, NULL)) AS aug_mon_hh_min,
SUM(IF(month_name='August' AND dayofweek = 3, hh_min, NULL)) AS aug_tue_hh_min,
SUM(IF(month_name='August' AND dayofweek = 4, hh_min, NULL)) AS aug_wed_hh_min,
SUM(IF(month_name='August' AND dayofweek = 5, hh_min, NULL)) AS aug_thu_hh_min,
SUM(IF(month_name='August' AND dayofweek = 6, hh_min, NULL)) AS aug_fri_hh_min,
SUM(IF(month_name='August' AND dayofweek = 7, hh_min, NULL)) AS aug_sat_hh_min,

-- pivots : sep
SUM(IF(month_name='September' AND dayofweek = 1, hh_min, NULL)) AS sep_sun_hh_min,
SUM(IF(month_name='September' AND dayofweek = 2, hh_min, NULL)) AS sep_mon_hh_min,
SUM(IF(month_name='September' AND dayofweek = 3, hh_min, NULL)) AS sep_tue_hh_min,
SUM(IF(month_name='September' AND dayofweek = 4, hh_min, NULL)) AS sep_wed_hh_min,
SUM(IF(month_name='September' AND dayofweek = 5, hh_min, NULL)) AS sep_thu_hh_min,
SUM(IF(month_name='September' AND dayofweek = 6, hh_min, NULL)) AS sep_fri_hh_min,
SUM(IF(month_name='September' AND dayofweek = 7, hh_min, NULL)) AS sep_sat_hh_min,

-- pivots : oct
SUM(IF(month_name='October' AND dayofweek = 1, hh_min, NULL)) AS oct_sun_hh_min,
SUM(IF(month_name='October' AND dayofweek = 2, hh_min, NULL)) AS oct_mon_hh_min,
SUM(IF(month_name='October' AND dayofweek = 3, hh_min, NULL)) AS oct_tue_hh_min,
SUM(IF(month_name='October' AND dayofweek = 4, hh_min, NULL)) AS oct_wed_hh_min,
SUM(IF(month_name='October' AND dayofweek = 5, hh_min, NULL)) AS oct_thu_hh_min,
SUM(IF(month_name='October' AND dayofweek = 6, hh_min, NULL)) AS oct_fri_hh_min,
SUM(IF(month_name='October' AND dayofweek = 7, hh_min, NULL)) AS oct_sat_hh_min,

-- pivots : nov
SUM(IF(month_name='November' AND dayofweek = 1, hh_min, NULL)) AS nov_sun_hh_min,
SUM(IF(month_name='November' AND dayofweek = 2, hh_min, NULL)) AS nov_mon_hh_min,
SUM(IF(month_name='November' AND dayofweek = 3, hh_min, NULL)) AS nov_tue_hh_min,
SUM(IF(month_name='November' AND dayofweek = 4, hh_min, NULL)) AS nov_wed_hh_min,
SUM(IF(month_name='November' AND dayofweek = 5, hh_min, NULL)) AS nov_thu_hh_min,
SUM(IF(month_name='November' AND dayofweek = 6, hh_min, NULL)) AS nov_fri_hh_min,
SUM(IF(month_name='November' AND dayofweek = 7, hh_min, NULL)) AS nov_sat_hh_min,

-- pivots : dec
SUM(IF(month_name='December' AND dayofweek = 1, hh_min, NULL)) AS dec_sun_hh_min,
SUM(IF(month_name='December' AND dayofweek = 2, hh_min, NULL)) AS dec_mon_hh_min,
SUM(IF(month_name='December' AND dayofweek = 3, hh_min, NULL)) AS dec_tue_hh_min,
SUM(IF(month_name='December' AND dayofweek = 4, hh_min, NULL)) AS dec_wed_hh_min,
SUM(IF(month_name='December' AND dayofweek = 5, hh_min, NULL)) AS dec_thu_hh_min,
SUM(IF(month_name='December' AND dayofweek = 6, hh_min, NULL)) AS dec_fri_hh_min,
SUM(IF(month_name='December' AND dayofweek = 7, hh_min, NULL)) AS dec_sat_hh_min,

-- pivots : jan
SUM(IF(month_name='January' AND dayofweek = 1, hh_stddev, NULL)) AS jan_sun_hh_stddev,
SUM(IF(month_name='January' AND dayofweek = 2, hh_stddev, NULL)) AS jan_mon_hh_stddev,
SUM(IF(month_name='January' AND dayofweek = 3, hh_stddev, NULL)) AS jan_tue_hh_stddev,
SUM(IF(month_name='January' AND dayofweek = 4, hh_stddev, NULL)) AS jan_wed_hh_stddev,
SUM(IF(month_name='January' AND dayofweek = 5, hh_stddev, NULL)) AS jan_thu_hh_stddev,
SUM(IF(month_name='January' AND dayofweek = 6, hh_stddev, NULL)) AS jan_fri_hh_stddev,
SUM(IF(month_name='January' AND dayofweek = 7, hh_stddev, NULL)) AS jan_sat_hh_stddev,

-- pivots : feb
SUM(IF(month_name='February' AND dayofweek = 1, hh_stddev, NULL)) AS feb_sun_hh_stddev,
SUM(IF(month_name='February' AND dayofweek = 2, hh_stddev, NULL)) AS feb_mon_hh_stddev,
SUM(IF(month_name='February' AND dayofweek = 3, hh_stddev, NULL)) AS feb_tue_hh_stddev,
SUM(IF(month_name='February' AND dayofweek = 4, hh_stddev, NULL)) AS feb_wed_hh_stddev,
SUM(IF(month_name='February' AND dayofweek = 5, hh_stddev, NULL)) AS feb_thu_hh_stddev,
SUM(IF(month_name='February' AND dayofweek = 6, hh_stddev, NULL)) AS feb_fri_hh_stddev,
SUM(IF(month_name='February' AND dayofweek = 7, hh_stddev, NULL)) AS feb_sat_hh_stddev,

-- pivots : mar
SUM(IF(month_name='March' AND dayofweek = 1, hh_stddev, NULL)) AS mar_sun_hh_stddev,
SUM(IF(month_name='March' AND dayofweek = 2, hh_stddev, NULL)) AS mar_mon_hh_stddev,
SUM(IF(month_name='March' AND dayofweek = 3, hh_stddev, NULL)) AS mar_tue_hh_stddev,
SUM(IF(month_name='March' AND dayofweek = 4, hh_stddev, NULL)) AS mar_wed_hh_stddev,
SUM(IF(month_name='March' AND dayofweek = 5, hh_stddev, NULL)) AS mar_thu_hh_stddev,
SUM(IF(month_name='March' AND dayofweek = 6, hh_stddev, NULL)) AS mar_fri_hh_stddev,
SUM(IF(month_name='March' AND dayofweek = 7, hh_stddev, NULL)) AS mar_sat_hh_stddev,

-- pivots : apr
SUM(IF(month_name='April' AND dayofweek = 1, hh_stddev, NULL)) AS apr_sun_hh_stddev,
SUM(IF(month_name='April' AND dayofweek = 2, hh_stddev, NULL)) AS apr_mon_hh_stddev,
SUM(IF(month_name='April' AND dayofweek = 3, hh_stddev, NULL)) AS apr_tue_hh_stddev,
SUM(IF(month_name='April' AND dayofweek = 4, hh_stddev, NULL)) AS apr_wed_hh_stddev,
SUM(IF(month_name='April' AND dayofweek = 5, hh_stddev, NULL)) AS apr_thu_hh_stddev,
SUM(IF(month_name='April' AND dayofweek = 6, hh_stddev, NULL)) AS apr_fri_hh_stddev,
SUM(IF(month_name='April' AND dayofweek = 7, hh_stddev, NULL)) AS apr_sat_hh_stddev,

-- pivots : may
SUM(IF(month_name='May' AND dayofweek = 1, hh_stddev, NULL)) AS may_sun_hh_stddev,
SUM(IF(month_name='May' AND dayofweek = 2, hh_stddev, NULL)) AS may_mon_hh_stddev,
SUM(IF(month_name='May' AND dayofweek = 3, hh_stddev, NULL)) AS may_tue_hh_stddev,
SUM(IF(month_name='May' AND dayofweek = 4, hh_stddev, NULL)) AS may_wed_hh_stddev,
SUM(IF(month_name='May' AND dayofweek = 5, hh_stddev, NULL)) AS may_thu_hh_stddev,
SUM(IF(month_name='May' AND dayofweek = 6, hh_stddev, NULL)) AS may_fri_hh_stddev,
SUM(IF(month_name='May' AND dayofweek = 7, hh_stddev, NULL)) AS may_sat_hh_stddev,

-- pivots : jun
SUM(IF(month_name='June' AND dayofweek = 1, hh_stddev, NULL)) AS jun_sun_hh_stddev,
SUM(IF(month_name='June' AND dayofweek = 2, hh_stddev, NULL)) AS jun_mon_hh_stddev,
SUM(IF(month_name='June' AND dayofweek = 3, hh_stddev, NULL)) AS jun_tue_hh_stddev,
SUM(IF(month_name='June' AND dayofweek = 4, hh_stddev, NULL)) AS jun_wed_hh_stddev,
SUM(IF(month_name='June' AND dayofweek = 5, hh_stddev, NULL)) AS jun_thu_hh_stddev,
SUM(IF(month_name='June' AND dayofweek = 6, hh_stddev, NULL)) AS jun_fri_hh_stddev,
SUM(IF(month_name='June' AND dayofweek = 7, hh_stddev, NULL)) AS jun_sat_hh_stddev,

-- pivots : jul
SUM(IF(month_name='July' AND dayofweek = 1, hh_stddev, NULL)) AS jul_sun_hh_stddev,
SUM(IF(month_name='July' AND dayofweek = 2, hh_stddev, NULL)) AS jul_mon_hh_stddev,
SUM(IF(month_name='July' AND dayofweek = 3, hh_stddev, NULL)) AS jul_tue_hh_stddev,
SUM(IF(month_name='July' AND dayofweek = 4, hh_stddev, NULL)) AS jul_wed_hh_stddev,
SUM(IF(month_name='July' AND dayofweek = 5, hh_stddev, NULL)) AS jul_thu_hh_stddev,
SUM(IF(month_name='July' AND dayofweek = 6, hh_stddev, NULL)) AS jul_fri_hh_stddev,
SUM(IF(month_name='July' AND dayofweek = 7, hh_stddev, NULL)) AS jul_sat_hh_stddev,

-- pivots : aug
SUM(IF(month_name='August' AND dayofweek = 1, hh_stddev, NULL)) AS aug_sun_hh_stddev,
SUM(IF(month_name='August' AND dayofweek = 2, hh_stddev, NULL)) AS aug_mon_hh_stddev,
SUM(IF(month_name='August' AND dayofweek = 3, hh_stddev, NULL)) AS aug_tue_hh_stddev,
SUM(IF(month_name='August' AND dayofweek = 4, hh_stddev, NULL)) AS aug_wed_hh_stddev,
SUM(IF(month_name='August' AND dayofweek = 5, hh_stddev, NULL)) AS aug_thu_hh_stddev,
SUM(IF(month_name='August' AND dayofweek = 6, hh_stddev, NULL)) AS aug_fri_hh_stddev,
SUM(IF(month_name='August' AND dayofweek = 7, hh_stddev, NULL)) AS aug_sat_hh_stddev,

-- pivots : sep
SUM(IF(month_name='September' AND dayofweek = 1, hh_stddev, NULL)) AS sep_sun_hh_stddev,
SUM(IF(month_name='September' AND dayofweek = 2, hh_stddev, NULL)) AS sep_mon_hh_stddev,
SUM(IF(month_name='September' AND dayofweek = 3, hh_stddev, NULL)) AS sep_tue_hh_stddev,
SUM(IF(month_name='September' AND dayofweek = 4, hh_stddev, NULL)) AS sep_wed_hh_stddev,
SUM(IF(month_name='September' AND dayofweek = 5, hh_stddev, NULL)) AS sep_thu_hh_stddev,
SUM(IF(month_name='September' AND dayofweek = 6, hh_stddev, NULL)) AS sep_fri_hh_stddev,
SUM(IF(month_name='September' AND dayofweek = 7, hh_stddev, NULL)) AS sep_sat_hh_stddev,

-- pivots : oct
SUM(IF(month_name='October' AND dayofweek = 1, hh_stddev, NULL)) AS oct_sun_hh_stddev,
SUM(IF(month_name='October' AND dayofweek = 2, hh_stddev, NULL)) AS oct_mon_hh_stddev,
SUM(IF(month_name='October' AND dayofweek = 3, hh_stddev, NULL)) AS oct_tue_hh_stddev,
SUM(IF(month_name='October' AND dayofweek = 4, hh_stddev, NULL)) AS oct_wed_hh_stddev,
SUM(IF(month_name='October' AND dayofweek = 5, hh_stddev, NULL)) AS oct_thu_hh_stddev,
SUM(IF(month_name='October' AND dayofweek = 6, hh_stddev, NULL)) AS oct_fri_hh_stddev,
SUM(IF(month_name='October' AND dayofweek = 7, hh_stddev, NULL)) AS oct_sat_hh_stddev,

-- pivots : nov
SUM(IF(month_name='November' AND dayofweek = 1, hh_stddev, NULL)) AS nov_sun_hh_stddev,
SUM(IF(month_name='November' AND dayofweek = 2, hh_stddev, NULL)) AS nov_mon_hh_stddev,
SUM(IF(month_name='November' AND dayofweek = 3, hh_stddev, NULL)) AS nov_tue_hh_stddev,
SUM(IF(month_name='November' AND dayofweek = 4, hh_stddev, NULL)) AS nov_wed_hh_stddev,
SUM(IF(month_name='November' AND dayofweek = 5, hh_stddev, NULL)) AS nov_thu_hh_stddev,
SUM(IF(month_name='November' AND dayofweek = 6, hh_stddev, NULL)) AS nov_fri_hh_stddev,
SUM(IF(month_name='November' AND dayofweek = 7, hh_stddev, NULL)) AS nov_sat_hh_stddev,

-- pivots : dec
SUM(IF(month_name='December' AND dayofweek = 1, hh_stddev, NULL)) AS dec_sun_hh_stddev,
SUM(IF(month_name='December' AND dayofweek = 2, hh_stddev, NULL)) AS dec_mon_hh_stddev,
SUM(IF(month_name='December' AND dayofweek = 3, hh_stddev, NULL)) AS dec_tue_hh_stddev,
SUM(IF(month_name='December' AND dayofweek = 4, hh_stddev, NULL)) AS dec_wed_hh_stddev,
SUM(IF(month_name='December' AND dayofweek = 5, hh_stddev, NULL)) AS dec_thu_hh_stddev,
SUM(IF(month_name='December' AND dayofweek = 6, hh_stddev, NULL)) AS dec_fri_hh_stddev,
SUM(IF(month_name='December' AND dayofweek = 7, hh_stddev, NULL)) AS dec_sat_hh_stddev,

-- pivots : jan
SUM(IF(month_name='January' AND dayofweek = 1, hh_median, NULL)) AS jan_sun_hh_median,
SUM(IF(month_name='January' AND dayofweek = 2, hh_median, NULL)) AS jan_mon_hh_median,
SUM(IF(month_name='January' AND dayofweek = 3, hh_median, NULL)) AS jan_tue_hh_median,
SUM(IF(month_name='January' AND dayofweek = 4, hh_median, NULL)) AS jan_wed_hh_median,
SUM(IF(month_name='January' AND dayofweek = 5, hh_median, NULL)) AS jan_thu_hh_median,
SUM(IF(month_name='January' AND dayofweek = 6, hh_median, NULL)) AS jan_fri_hh_median,
SUM(IF(month_name='January' AND dayofweek = 7, hh_median, NULL)) AS jan_sat_hh_median,

-- pivots : feb
SUM(IF(month_name='February' AND dayofweek = 1, hh_median, NULL)) AS feb_sun_hh_median,
SUM(IF(month_name='February' AND dayofweek = 2, hh_median, NULL)) AS feb_mon_hh_median,
SUM(IF(month_name='February' AND dayofweek = 3, hh_median, NULL)) AS feb_tue_hh_median,
SUM(IF(month_name='February' AND dayofweek = 4, hh_median, NULL)) AS feb_wed_hh_median,
SUM(IF(month_name='February' AND dayofweek = 5, hh_median, NULL)) AS feb_thu_hh_median,
SUM(IF(month_name='February' AND dayofweek = 6, hh_median, NULL)) AS feb_fri_hh_median,
SUM(IF(month_name='February' AND dayofweek = 7, hh_median, NULL)) AS feb_sat_hh_median,

-- pivots : mar
SUM(IF(month_name='March' AND dayofweek = 1, hh_median, NULL)) AS mar_sun_hh_median,
SUM(IF(month_name='March' AND dayofweek = 2, hh_median, NULL)) AS mar_mon_hh_median,
SUM(IF(month_name='March' AND dayofweek = 3, hh_median, NULL)) AS mar_tue_hh_median,
SUM(IF(month_name='March' AND dayofweek = 4, hh_median, NULL)) AS mar_wed_hh_median,
SUM(IF(month_name='March' AND dayofweek = 5, hh_median, NULL)) AS mar_thu_hh_median,
SUM(IF(month_name='March' AND dayofweek = 6, hh_median, NULL)) AS mar_fri_hh_median,
SUM(IF(month_name='March' AND dayofweek = 7, hh_median, NULL)) AS mar_sat_hh_median,

-- pivots : apr
SUM(IF(month_name='April' AND dayofweek = 1, hh_median, NULL)) AS apr_sun_hh_median,
SUM(IF(month_name='April' AND dayofweek = 2, hh_median, NULL)) AS apr_mon_hh_median,
SUM(IF(month_name='April' AND dayofweek = 3, hh_median, NULL)) AS apr_tue_hh_median,
SUM(IF(month_name='April' AND dayofweek = 4, hh_median, NULL)) AS apr_wed_hh_median,
SUM(IF(month_name='April' AND dayofweek = 5, hh_median, NULL)) AS apr_thu_hh_median,
SUM(IF(month_name='April' AND dayofweek = 6, hh_median, NULL)) AS apr_fri_hh_median,
SUM(IF(month_name='April' AND dayofweek = 7, hh_median, NULL)) AS apr_sat_hh_median,

-- pivots : may
SUM(IF(month_name='May' AND dayofweek = 1, hh_median, NULL)) AS may_sun_hh_median,
SUM(IF(month_name='May' AND dayofweek = 2, hh_median, NULL)) AS may_mon_hh_median,
SUM(IF(month_name='May' AND dayofweek = 3, hh_median, NULL)) AS may_tue_hh_median,
SUM(IF(month_name='May' AND dayofweek = 4, hh_median, NULL)) AS may_wed_hh_median,
SUM(IF(month_name='May' AND dayofweek = 5, hh_median, NULL)) AS may_thu_hh_median,
SUM(IF(month_name='May' AND dayofweek = 6, hh_median, NULL)) AS may_fri_hh_median,
SUM(IF(month_name='May' AND dayofweek = 7, hh_median, NULL)) AS may_sat_hh_median,

-- pivots : jun
SUM(IF(month_name='June' AND dayofweek = 1, hh_median, NULL)) AS jun_sun_hh_median,
SUM(IF(month_name='June' AND dayofweek = 2, hh_median, NULL)) AS jun_mon_hh_median,
SUM(IF(month_name='June' AND dayofweek = 3, hh_median, NULL)) AS jun_tue_hh_median,
SUM(IF(month_name='June' AND dayofweek = 4, hh_median, NULL)) AS jun_wed_hh_median,
SUM(IF(month_name='June' AND dayofweek = 5, hh_median, NULL)) AS jun_thu_hh_median,
SUM(IF(month_name='June' AND dayofweek = 6, hh_median, NULL)) AS jun_fri_hh_median,
SUM(IF(month_name='June' AND dayofweek = 7, hh_median, NULL)) AS jun_sat_hh_median,

-- pivots : jul
SUM(IF(month_name='July' AND dayofweek = 1, hh_median, NULL)) AS jul_sun_hh_median,
SUM(IF(month_name='July' AND dayofweek = 2, hh_median, NULL)) AS jul_mon_hh_median,
SUM(IF(month_name='July' AND dayofweek = 3, hh_median, NULL)) AS jul_tue_hh_median,
SUM(IF(month_name='July' AND dayofweek = 4, hh_median, NULL)) AS jul_wed_hh_median,
SUM(IF(month_name='July' AND dayofweek = 5, hh_median, NULL)) AS jul_thu_hh_median,
SUM(IF(month_name='July' AND dayofweek = 6, hh_median, NULL)) AS jul_fri_hh_median,
SUM(IF(month_name='July' AND dayofweek = 7, hh_median, NULL)) AS jul_sat_hh_median,

-- pivots : aug
SUM(IF(month_name='August' AND dayofweek = 1, hh_median, NULL)) AS aug_sun_hh_median,
SUM(IF(month_name='August' AND dayofweek = 2, hh_median, NULL)) AS aug_mon_hh_median,
SUM(IF(month_name='August' AND dayofweek = 3, hh_median, NULL)) AS aug_tue_hh_median,
SUM(IF(month_name='August' AND dayofweek = 4, hh_median, NULL)) AS aug_wed_hh_median,
SUM(IF(month_name='August' AND dayofweek = 5, hh_median, NULL)) AS aug_thu_hh_median,
SUM(IF(month_name='August' AND dayofweek = 6, hh_median, NULL)) AS aug_fri_hh_median,
SUM(IF(month_name='August' AND dayofweek = 7, hh_median, NULL)) AS aug_sat_hh_median,

-- pivots : sep
SUM(IF(month_name='September' AND dayofweek = 1, hh_median, NULL)) AS sep_sun_hh_median,
SUM(IF(month_name='September' AND dayofweek = 2, hh_median, NULL)) AS sep_mon_hh_median,
SUM(IF(month_name='September' AND dayofweek = 3, hh_median, NULL)) AS sep_tue_hh_median,
SUM(IF(month_name='September' AND dayofweek = 4, hh_median, NULL)) AS sep_wed_hh_median,
SUM(IF(month_name='September' AND dayofweek = 5, hh_median, NULL)) AS sep_thu_hh_median,
SUM(IF(month_name='September' AND dayofweek = 6, hh_median, NULL)) AS sep_fri_hh_median,
SUM(IF(month_name='September' AND dayofweek = 7, hh_median, NULL)) AS sep_sat_hh_median,

-- pivots : oct
SUM(IF(month_name='October' AND dayofweek = 1, hh_median, NULL)) AS oct_sun_hh_median,
SUM(IF(month_name='October' AND dayofweek = 2, hh_median, NULL)) AS oct_mon_hh_median,
SUM(IF(month_name='October' AND dayofweek = 3, hh_median, NULL)) AS oct_tue_hh_median,
SUM(IF(month_name='October' AND dayofweek = 4, hh_median, NULL)) AS oct_wed_hh_median,
SUM(IF(month_name='October' AND dayofweek = 5, hh_median, NULL)) AS oct_thu_hh_median,
SUM(IF(month_name='October' AND dayofweek = 6, hh_median, NULL)) AS oct_fri_hh_median,
SUM(IF(month_name='October' AND dayofweek = 7, hh_median, NULL)) AS oct_sat_hh_median,

-- pivots : nov
SUM(IF(month_name='November' AND dayofweek = 1, hh_median, NULL)) AS nov_sun_hh_median,
SUM(IF(month_name='November' AND dayofweek = 2, hh_median, NULL)) AS nov_mon_hh_median,
SUM(IF(month_name='November' AND dayofweek = 3, hh_median, NULL)) AS nov_tue_hh_median,
SUM(IF(month_name='November' AND dayofweek = 4, hh_median, NULL)) AS nov_wed_hh_median,
SUM(IF(month_name='November' AND dayofweek = 5, hh_median, NULL)) AS nov_thu_hh_median,
SUM(IF(month_name='November' AND dayofweek = 6, hh_median, NULL)) AS nov_fri_hh_median,
SUM(IF(month_name='November' AND dayofweek = 7, hh_median, NULL)) AS nov_sat_hh_median,

-- pivots : dec
SUM(IF(month_name='December' AND dayofweek = 1, hh_median, NULL)) AS dec_sun_hh_median,
SUM(IF(month_name='December' AND dayofweek = 2, hh_median, NULL)) AS dec_mon_hh_median,
SUM(IF(month_name='December' AND dayofweek = 3, hh_median, NULL)) AS dec_tue_hh_median,
SUM(IF(month_name='December' AND dayofweek = 4, hh_median, NULL)) AS dec_wed_hh_median,
SUM(IF(month_name='December' AND dayofweek = 5, hh_median, NULL)) AS dec_thu_hh_median,
SUM(IF(month_name='December' AND dayofweek = 6, hh_median, NULL)) AS dec_fri_hh_median,
SUM(IF(month_name='December' AND dayofweek = 7, hh_median, NULL)) AS dec_sat_hh_median

FROM `machine-learning-msc.low_carbon_london.household_consumption_daily_agg`

GROUP BY 1,2,3,4
