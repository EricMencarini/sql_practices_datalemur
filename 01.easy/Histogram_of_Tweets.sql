--https://datalemur.com/questions/sql-histogram-tweets

WITH tweet_msg AS
(
SELECT user_id,
  COUNT(tweet_id) AS tweet_bucket
FROM
 tweets
WHERE EXTRACT(YEAR FROM tweet_date) = 2022
GROUP BY 
  user_id
ORDER BY tweet_bucket ASC
)

SELECT 
  tweet_bucket,
  count(user_id) AS users_num
FROM tweet_msg
GROUP BY tweet_bucket