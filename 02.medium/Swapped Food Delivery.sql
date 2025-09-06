https://datalemur.com/questions/sql-swapped-food-delivery

WITH c_order AS (
    SELECT order_id, 
           item,
           LAG(item) OVER(ORDER BY order_id ASC) AS lagx,
           LEAD(item) OVER(ORDER BY order_id ASC) AS leady
    FROM orders
)
SELECT
      ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS corrected_order_id,
      CASE 
          WHEN order_id % 2 = 0 THEN lagx
          WHEN order_id % 2 = 1 THEN COALESCE(leady,item)
      END AS item
FROM c_order;
