--https://datalemur.com/questions/repeated-payments

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