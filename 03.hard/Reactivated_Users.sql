--Solution1: Only the dataset
WITH calc_last_month_activity AS
(
SELECT 
  user_id,
  login_date,
  EXTRACT(MONTH FROM login_date) AS mth,
  LAG(EXTRACT(MONTH FROM login_date)) OVER(PARTITION BY user_id ORDER BY login_date) AS last_mth_activity
FROM 
  user_logins
ORDER BY
  1
),
 calc_reativation_mth AS
(
SELECT 
 --user_id,
 --login_date,
 mth,
 --last_mth_activity,
 CASE 
  WHEN mth - 1 != last_mth_activity AND mth != last_mth_activity THEN 1
    WHEN last_mth_activity IS NULL THEN 1 
      ELSE 0  
 END AS calc_reativation
FROM 
  calc_last_month_activity
)

SELECT
 mth,
 SUM(calc_reativation) AS reactivated_users
FROM 
  calc_reativation_mth
GROUP BY 
  mth
HAVING 
  SUM(calc_reativation) > 0
ORDER BY
  mth

--Solution 2: Considering the table has multiple years;
WITH calc_last_month_activity AS
(
SELECT 
  user_id,
  login_date,
  DATE_TRUNC('month', login_date)::date AS mth,
  LAG(DATE_TRUNC('month', login_date)::date) OVER(PARTITION BY user_id ORDER BY login_date) AS last_mth_activity
FROM 
  user_logins
ORDER BY
  user_id
),
 calc_reativation_mth AS
(
SELECT 
 --user_id,
 --login_date,
 mth,
 --last_mth_activity,
 CASE 
    WHEN last_mth_activity IS NULL THEN 1
    WHEN DATE_PART('month', mth) - DATE_PART('month', last_mth_activity) != 1
    AND mth != last_mth_activity THEN 1
      ELSE 0  
 END AS calc_reativation
FROM 
  calc_last_month_activity
)

SELECT
 EXTRACT(MONTH FROM mth),
 SUM(calc_reativation) AS reactivated_users
FROM 
  calc_reativation_mth
GROUP BY 
  mth
HAVING 
  SUM(calc_reativation) > 0
ORDER BY
  mth