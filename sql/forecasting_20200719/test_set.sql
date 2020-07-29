CREATE OR REPLACE TABLE `machine-learning-msc.forecasting_20200719.test_set` AS 


WITH households AS (
  SELECT 
  DISTINCT
  lcl_id,
  train_test_split
  FROM `machine-learning-msc.low_carbon_london.som_clusters_20200712`  
  WHERE train_test_split = 'test'
  )
  
SELECT 
households.lcl_id,
households.train_test_split,
stat.* EXCEPT(lcl_id)

FROM households 
LEFT JOIN `machine-learning-msc.low_carbon_london.household_consumption_stats` stat
  ON stat.lcl_id = households.lcl_id
  
WHERE EXTRACT(MINUTE FROM stat.ts) IN (0, 30)