--https://datalemur.com/questions/median-search-freq

/*
Google's marketing team is making a Superbowl commercial and needs a simple statistic to put on their TV ad: 
the median number of searches a person made last year.

However, at Google scale, querying the 2 trillion searches is too costly. 
Luckily, you have access to the summary table which tells you the number of searches made last year and how many Google users fall into that bucket.

Write a query to report the median of searches made by a user. Round the median to one decimal point.

Example Output:
median
2.5
By expanding the search_frequency table, we get [1, 1, 2, 2, 3, 3, 3, 4] which has a median of 2.5 searches per user.

The dataset you are querying against may have different input & output - this is just an example!

p.s. here's more Google SQL Interview Questions to practice!

*/

WITH users AS (
  SELECT
    searches,
    num_users,
    SUM(num_users) OVER(ORDER BY searches) AS running_total
  FROM search_frequency
),
total_num_users AS (
  SELECT SUM(num_users) AS total_users FROM search_frequency
)
SELECT 
  ROUND(AVG(searches), 1) AS median
FROM (
  SELECT 
    searches
  FROM 
    users, total_num_users
  WHERE 
    running_total >= (total_users + 1) / 2
  ORDER BY 
    searches
  LIMIT 2
) avg;
