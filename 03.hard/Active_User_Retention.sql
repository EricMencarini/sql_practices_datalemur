--https://datalemur.com/questions/user-retention

WITH active_month AS 
(
    SELECT EXTRACT(month FROM event_date) as mth,
           user_id,
           event_id
    FROM user_actions
    WHERE EXTRACT(month FROM event_date) = 07
),
    
    previous_month AS 
(
    SELECT EXTRACT(month FROM event_date) as mth,
           user_id,
           event_id
    FROM user_actions
    WHERE EXTRACT(month FROM event_date) = 06
)

SELECT mth, 
       COUNT(DISTINCT user_id) AS monthly_active_users
FROM 
  active_month
WHERE 
  user_id IN (SELECT DISTINCT user_id FROM previous_month)
GROUP BY 
  mth
