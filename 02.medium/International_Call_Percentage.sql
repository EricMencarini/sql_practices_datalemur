--https://datalemur.com/questions/international-call-percentage

/*
A phone call is considered an international call when the person calling is in a different country than the person receiving the call.

What percentage of phone calls are international? Round the result to 1 decimal.

Assumption:

The caller_id in phone_info table refers to both the caller and receiver.

Explanation
There is a total of 4 calls with 2 of them being international calls (from caller_id 1 => receiver_id 5, and caller_id 5 => receiver_id 1). 
Thus, 2/4 = 50.0%
The dataset you are querying against may have different input & output - this is just an example!

*/

SELECT
  ROUND(
    (
    SELECT
      COUNT(*)
    FROM
      phone_calls AS a
    INNER JOIN
      phone_info AS b
    ON
      a.caller_id = b.caller_id
    INNER JOIN phone_info AS c ON a.receiver_id = c.caller_id 
      AND b.country_id <> c.country_id
    )*100.0 / COUNT(*),1) AS percentage_of_international_phone_calls
FROM
  phone_calls;