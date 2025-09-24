--https://datalemur.com/questions/long-calls-growth

WITH calls_per_mth AS
(
SELECT 
  EXTRACT(YEAR FROM call_date)  AS yr,
  EXTRACT(MONTH FROM call_date) AS mth,
  COUNT(case_id)                AS current_mth_calls
FROM 
  callers
WHERE
 call_duration_secs >= 300
GROUP BY
 1,2
)

SELECT 
  yr,
  mth,
  --current_mth_calls,
  --LAG(current_mth_calls) OVER(PARTITION BY yr ORDER BY mth) as last_mth_calls,
  ROUND(
    ((current_mth_calls - LAG(current_mth_calls) OVER(PARTITION BY yr ORDER BY mth))  * 100.0 
        / LAG(current_mth_calls) OVER(PARTITION BY yr ORDER BY mth)),1) AS long_calls_growth_pct
FROM
  calls_per_mth