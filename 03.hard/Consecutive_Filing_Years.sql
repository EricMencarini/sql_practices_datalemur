--https://datalemur.com/questions/consecutive-filing-years

/*
You're provided with two tables: the advertiser table contains information about advertisers and their respective payment status, 
and the daily_pay table contains the current payment information for advertisers, and it only includes advertisers who have made payments.

Write a query to update the payment status of Facebook advertisers based on the information in the daily_pay table. 
The output should include the user ID and their current payment status, sorted by the user id.

The payment status of advertisers can be classified into the following categories:

New: Advertisers who are newly registered and have made their first payment.
Existing: Advertisers who have made payments in the past and have recently made a current payment.
Churn: Advertisers who have made payments in the past but have not made any recent payment.
Resurrect: Advertisers who have not made a recent payment but may have made a previous payment and have made a payment again recently.

Explanation:
The advertiser "bing" is classified as "CHURN" because no payment record is found in the daily_pay table.
The advertiser "yahoo" is labeled as "EXISTING" since they have made a recent payment, as indicated by the presence of their payment record.
Similarly, the advertiser "alibaba" is also classified as "EXISTING" due to their recent payment.
The dataset you are querying against may have different input & output - this is just an example!

*/


WITH consecutive_years AS 
(
SELECT 
  user_id,
  ROW_NUMBER() 
    OVER(PARTITION BY user_id ORDER BY filing_date 
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS previous_current_year
FROM 
  filed_taxes
WHERE
  product ILIKE '%Turbo%'
)

SELECT 
  user_id
FROM
  consecutive_years
GROUP BY 
  user_id
HAVING 
  COUNT(user_id) > 2
ORDER BY 
  user_id;