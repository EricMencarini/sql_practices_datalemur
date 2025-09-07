--https://datalemur.com/questions/completed-trades

SELECT DISTINCT 
        u.city, 
        COUNT(order_id) as total_orders

FROM trades t 
JOIN users u on t.user_id = u.user_id
  WHERE status = 'Completed'
GROUP BY u.city
ORDER BY total_orders DESC
LIMIT 3
