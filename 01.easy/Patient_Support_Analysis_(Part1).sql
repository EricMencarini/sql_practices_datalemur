--https://datalemur.com/questions/frequent-callers

/*
UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (or, members) to call an advocate and receive 
support for their health care needs – whether that's claims and benefits support, drug coverage, pre- and post-authorisation, medical records, 
emergency assistance, or member portal services.

Write a query to find how many UHG policy holders made three, or more calls, assuming each call is identified by the case_id column.

If you like this question, try out Patient Support Analysis (Part 2)!

Example Output:
policy_holder_count
1
Explanation:
The only caller who made three, or more calls is policy holder ID 2.

The dataset you are querying against may have different input & output - this is just an example!

*/

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