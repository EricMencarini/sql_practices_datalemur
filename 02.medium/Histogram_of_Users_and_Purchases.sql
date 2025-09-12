--https://datalemur.com/questions/histogram-users-purchases

WITH order_purchase AS
(
SELECT 
  user_id,
  transaction_date,
  RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS order_date,
  product_id
FROM
  user_transactions
)

SELECT 
  transaction_date,
  user_id, 
  COUNT(product_id) AS 	purchase_count
FROM 
  order_purchase
WHERE 
  order_date = 1
GROUP BY 
  user_id, transaction_date
ORDER BY 
  transaction_date ASC