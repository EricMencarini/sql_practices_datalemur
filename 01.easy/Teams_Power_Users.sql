--https://datalemur.com/questions/teams-power-users

/*
Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. 
Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based
on the count of the messages.

Assumption:
No two users have sent the same number of messages in August 2022.

*/

WITH top_users AS
(
SELECT sender_id, 
       count(*) AS message_count
FROM messages
  WHERE 1=1 
  AND EXTRACT(YEAR from sent_date) = '2022'
  AND   EXTRACT(MONTH from sent_date) = '08'
GROUP BY sender_id
ORDER BY COUNT(*) DESC
)

SELECT * 
FROM top_users
LIMIT 2