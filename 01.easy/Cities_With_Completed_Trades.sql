--https://datalemur.com/questions/completed-trades

/*
This is the same question as problem #2 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system.

Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. 
Output the city name and the corresponding number of completed trade orders.

Example Output:
city	total_orders
San Francisco	3
Boston	2
Denver	1
In the given dataset, San Francisco has the highest number of completed trade orders with 3 orders. Boston holds the second position with 2 orders, and Denver ranks third with 1 order.

The dataset you are querying against may have different input & output - this is just an example!

*/

SELECT DISTINCT 
        u.city, 
        COUNT(order_id) as total_orders

FROM trades t 
JOIN users u on t.user_id = u.user_id
  WHERE status = 'Completed'
GROUP BY u.city
ORDER BY total_orders DESC
LIMIT 3
