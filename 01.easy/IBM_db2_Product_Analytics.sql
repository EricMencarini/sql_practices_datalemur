--https://datalemur.com/questions/sql-ibm-db2-product-analytics

/*
This is the same question as problem #6 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. 
Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.

Example Output:
tweet_bucket	users_num
1	2
2	1
Explanation:
Based on the example output, there are two users who posted only one tweet in 2022, and one user who posted two tweets in 2022. 
The query groups the users by the number of tweets they posted and displays the number of users in each group.

The dataset you are querying against may have different input & output - this is just an example!

*/

WITH qty_queries AS (
  SELECT
    e.employee_id,
    COUNT(DISTINCT q.query_id) AS unique_queries
  FROM employees e
  LEFT JOIN queries q 
    ON e.employee_id = q.employee_id
   AND q.query_starttime >= '2023-07-01'
   AND q.query_starttime < '2023-10-01'
  GROUP BY e.employee_id
)
SELECT 
    unique_queries,
    COUNT(employee_id) AS employee_count
FROM qty_queries
GROUP BY unique_queries
ORDER BY unique_queries;