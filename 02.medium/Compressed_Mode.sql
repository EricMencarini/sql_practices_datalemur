--https://datalemur.com/questions/alibaba-compressed-mode

WITH rank_items AS 
(
SELECT 
  item_count,
  order_occurrences,
  DENSE_RANK() OVER(ORDER BY order_occurrences DESC) AS rank_i
FROM 
  items_per_order
)

SELECT 
  item_count AS mode
FROM 
  rank_items
WHERE
  rank_i = 1
