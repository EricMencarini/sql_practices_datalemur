--https://datalemur.com/questions/sql-average-post-hiatus-1

SELECT user_id,
       (CAST(MAX(post_date) AS date) - CAST(MIN(post_date) AS date)) AS days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id
HAVING COUNT(*) > 1;
