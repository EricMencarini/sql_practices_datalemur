--https://datalemur.com/questions/sql-histogram-tweets

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
Based on the example output, there are two users who posted only one tweet in 2022, and one user who posted two tweets in 2022. The query groups the users by the number of tweets they posted and displays the number of users in each group.

The dataset you are querying against may have different input & output - this is just an example!

*/


WITH tweet_msg AS
(
SELECT user_id,
  COUNT(tweet_id) AS tweet_bucket
FROM
  tweets
WHERE 
  EXTRACT(YEAR FROM tweet_date) = 2022
GROUP BY 
  user_id
ORDER BY tweet_bucket ASC
)

SELECT 
  tweet_bucket,
  COUNT(user_id) AS users_num
FROM tweet_msg
GROUP BY tweet_bucket