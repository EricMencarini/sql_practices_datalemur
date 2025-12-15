--https://datalemur.com/questions/amazon-shopping-spree

/*
In an effort to identify high-value customers, Amazon asked for your help to obtain data about users who go on shopping sprees. 
A shopping spree occurs when a user makes purchases on 3 or more consecutive days.

List the user IDs who have gone on at least 1 shopping spree in ascending order.

Example Output:
user_id
2
Explanation
In this example, user_id 2 is the only one who has gone on a shopping spree.

The dataset you are querying against may have different input & output - this is just an example!

*/


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
  user_id ASC;