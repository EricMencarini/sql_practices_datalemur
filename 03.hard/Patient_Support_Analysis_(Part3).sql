--https://datalemur.com/questions/patient-call-history

WITH seven_days_calc AS
(
  SELECT
    policy_holder_id,
    CASE
      WHEN ROUND(
             EXTRACT(EPOCH FROM call_date 
               - LAG(call_date) OVER (PARTITION BY policy_holder_id ORDER BY call_date)) 
                    / (24*60*60), 2) <= 7
      THEN 1 ELSE 0
    END AS seven_days_gap
    
    --LAG(call_date) OVER (PARTITION BY policy_holder_id ORDER BY call_date) AS previous_date
  FROM callers
)

SELECT 
  COUNT(DISTINCT policy_holder_id) AS policy_holder_count
FROM 
  seven_days_calc
WHERE 
  seven_days_gap = 1
