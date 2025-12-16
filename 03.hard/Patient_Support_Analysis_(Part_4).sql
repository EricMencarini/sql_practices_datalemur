--https://datalemur.com/questions/long-calls-growth

/*
UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (or, members) to call an advocate and receive support 
for their health care needs – whether that's claims and benefits support, drug coverage, pre- and post-authorisation, medical records, emergency assistance,
 or member portal services.

To analyze the performance of the program, write a query to determine the month-over-month growth rate specifically for long-calls. 
A long-call is defined as any call lasting more than 5 minutes (300 seconds).

Output the year and month in numerical format and chronological order, along with the growth percentage rounded to 1 decimal place.

Explanation:
Call counts: Jan - 1 call; Feb - 0 call; Mar - 1 call; Apr - 3 calls; May - 2 calls; Jun - 2 calls

January: With no previous month's call information, the growth percentage is shown as NULL.
February: The absence of calls compared to January results in a 0.0% growth rate.
March: Witnessing an increase of 1 call compared to February, the growth percentage is +100.0%.
April: Experiencing a surge of 3 calls compared to March, the growth percentage is +200.0%.
May: With a decrease of 1 call compared to April, the growth percentage is -33.3%.
June: Maintaining the same number of calls as May, the growth percentage remains at 0.0%.
The dataset you are querying against may have different input & output - this is just an example!

*/

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
  calls_per_mth;