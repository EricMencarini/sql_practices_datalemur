--https://datalemur.com/questions/alibaba-compressed-mean

/*
You're trying to find the mean number of items per order on Alibaba, rounded to 1 decimal place using tables which includes information on the count of 
items in each order (item_count table) and the corresponding number of orders for each item count (order_occurrences table).

Explanation
Let's calculate the arithmetic average:
Total items = (1*500) + (2*1000) + (3*800) + (4*1000) = 8900
Total orders = 500 + 1000 + 800 + 1000 = 3300
Mean = 8900 / 3300 = 2.7
The dataset you are querying against may have different input & output - this is just an example!
*/

WITH mean_orders AS (
SELECT 
      SUM(1.0 * item_count * order_occurrences) / SUM(order_occurrences) AS mean
FROM items_per_order
)

SELECT 
      ROUND(CAST(mean AS NUMERIC),1)
FROM mean_orders
