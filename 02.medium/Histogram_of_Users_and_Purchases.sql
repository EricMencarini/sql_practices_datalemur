--https://datalemur.com/questions/histogram-users-purchases

/*
This is the same question as problem #13 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given a table on Walmart user transactions. Based on their most recent transaction date, 
write a query that retrieve the users along with the number of products they bought.

Output the user's most recent transaction date, user ID, and the number of products, sorted in chronological order by the transaction date.

Example Output:
transaction_date	user_id	purchase_count
07/08/2022 12:00:00	115	1
07/08/2022 12:00:000	123	2
07/10/2022 12:00:00	159	1
The dataset you are querying against may have different input & output - this is just an example!

*/

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
  COUNT(product_id) AS purchase_count
FROM 
  order_purchase
WHERE 
  order_date = 1
GROUP BY 
  user_id, transaction_date
ORDER BY 
  transaction_date ASC;