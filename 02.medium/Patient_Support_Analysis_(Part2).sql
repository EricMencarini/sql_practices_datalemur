--https://datalemur.com/questions/uncategorized-calls-percentage

/*
UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (or, members) to call an advocate and receive support 
for their health care needs – whether that's claims and benefits support, drug coverage, pre- and post-authorisation, medical records, 
emergency assistance, or member portal services.

Calls to the Advocate4Me call centre are classified into various categories, but some calls cannot be neatly categorised. 
These uncategorised calls are labeled as “n/a”, or are left empty when the support agent does not enter anything into the call category field.

Write a query to calculate the percentage of calls that cannot be categorised. Round your answer to 1 decimal place. For example, 45.0, 48.5, 57.7.

Explanation:
Out of the total of 5 calls registered, one call was not categorised. Therefore, the percentage of uncategorised calls is calculated as 
20.0% (1 out of 5 multiplied by 100 and rounded to one decimal place).

The dataset you are querying against may have different input & output - this is just an example!

*/

SELECT 
  ROUND(100.0 * 
  SUM(
    CASE WHEN 
      call_category IS NULL 
                    OR call_category = 'n/a' 
                      THEN 1 ELSE 0 END) / COUNT(*),1) AS uncategorised_call_pct 
FROM 
  callers

