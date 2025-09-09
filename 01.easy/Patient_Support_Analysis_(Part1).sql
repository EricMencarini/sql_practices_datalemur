--https://datalemur.com/questions/frequent-callers

WITH total_call AS
(
SELECT 
  COUNT(case_id)
FROM
  callers
GROUP BY
  policy_holder_id
HAVING COUNT
  (case_id) > 2
)

SELECT 
  COUNT(*) AS policy_holder_count
FROM total_call