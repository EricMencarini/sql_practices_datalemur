--https://datalemur.com/questions/repeated-payments

/*
Sometimes, payment transactions are repeated by accident; it could be due to user error, 
API failure or a retry error that causes a credit card tobe charged twice.

Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. 
Count such repeated payments.

Assumptions:

The first transaction of such payments should not be counted as a repeated payment. This means, if there are two transactions performed by a 
merchant with the same credit card and for the same amount within 10 minutes, there will only be 1 repeated payment.

Example Output:
payment_count
1
Explanation
Within 10 minutes after Transaction 1, Transaction 2 is conducted at Merchant 1 using the same credit card for the same amount. 
This is the only instance of repeated payment in the given sample data.

Since Transaction 3 is completed after Transactions 2 and 1, each of which occurs after 20 and 28 minutes, 
respectively hence it does not meet the repeated payments' conditions. Whereas, Transactions 4 and 6 have different amounts.

The dataset you are querying against may have different input & output - this is just an example!

*/

WITH calc_seconds AS
(
SELECT 
  merchant_id,
  credit_card_id,
  ROUND(EXTRACT(EPOCH FROM transaction_timestamp)) AS seconds
FROM
  transactions
),
  calc_diff_seconds AS
(
SELECT
  merchant_id,
  credit_card_id,
  ----------------------Debug lines
  --seconds,
  --LAG(seconds) OVER(PARTITION BY merchant_id, credit_card_id) last_seconds,
  --seconds - LAG(seconds) OVER(PARTITION BY merchant_id, credit_card_id),
  CASE 
    WHEN 
      seconds - LAG(seconds) OVER(PARTITION BY merchant_id, credit_card_id) < 600
    THEN 1 ELSE 0
  END AS calculation
FROM
  calc_seconds
)


SELECT 
  SUM(calculation) AS payment_count
FROM 
  calc_diff_seconds