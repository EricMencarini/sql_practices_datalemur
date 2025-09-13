--https://datalemur.com/questions/yoy-growth-rate

WITH current_year AS
(
SELECT
  EXTRACT(YEAR FROM transaction_date) AS year,
  product_id,
  SUM(spend)AS curr_year_spend
FROM
  user_transactions
GROUP BY
  year, product_id
)

SELECT
  year,
  product_id,
  curr_year_spend,
  LAG(curr_year_spend) OVER(PARTITION BY product_id ORDER BY year) AS prev_year_spend,
  ROUND(((curr_year_spend - LAG(curr_year_spend) OVER(PARTITION BY product_id ORDER BY year)) 
  / LAG(curr_year_spend) OVER(PARTITION BY product_id ORDER BY year)) *100.0,2) AS yoy_rate
FROM
  current_year