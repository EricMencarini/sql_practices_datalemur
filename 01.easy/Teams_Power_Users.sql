--https://datalemur.com/questions/teams-power-users

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