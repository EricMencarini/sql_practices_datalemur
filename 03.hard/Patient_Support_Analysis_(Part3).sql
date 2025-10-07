--https://datalemur.com/questions/patient-call-history

/*
UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (or, members) to call an 
advocate and receive support for their health care needs – whether that's claims and benefits support, drug coverage, 
pre- and post-authorisation, medical records, emergency assistance, or member portal services.

Write a query to obtain the number of unique callers who made calls within a 7-day interval of their previous calls. 
If a caller made more than two calls within the 7-day period, count them only once.

If you like this question, try out Patient Support Analysis (Part 4)!

Example Output:
policy_holder_count
2
Explanation:
Policy holder IDs 14 and 15 each made two calls within a 7-day interval. For example, ID 14 made calls on 02/17/2023 and 02/21/2023, 
and ID 14 on 01/08/2023 and 01/09/2023 consecutively. Hence, the count of unique callers is two.

The dataset you are querying against may have different input & output - this is just an example!

*/

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
