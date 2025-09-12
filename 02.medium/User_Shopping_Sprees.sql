--https://datalemur.com/questions/amazon-shopping-spree

WITH amount_per_day AS
(
SELECT
  user_id,
  SUM(amount) OVER(PARTITION BY user_id ORDER BY transaction_date)
FROM
  transactions
)

SELECT
  user_id
FROM 
  amount_per_day
GROUP BY
  user_id
HAVING 
  COUNT(user_id) >= 3
ORDER BY 
  user_id ASC