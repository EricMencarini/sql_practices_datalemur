--https://datalemur.com/questions/alibaba-compressed-mean

WITH mean_orders AS (
SELECT 
      SUM(1.0 * item_count * order_occurrences) / SUM(order_occurrences) as mean
FROM items_per_order
)

SELECT ROUND(CAST(mean as NUMERIC),1)
FROM mean_orders
