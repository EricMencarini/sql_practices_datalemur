--https://datalemur.com/questions/user-retention

/*
This is the same question as problem #23 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given a table containing information on Facebook user actions. 
Write a query to obtain number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".

Hint:
An active user is defined as a user who has performed actions such as 'sign-in', 'like', or 'comment' in both the current month and the previous month.

Example
In June 2022, there was only one monthly active user (MAU) with the user_id 445.

Please note that the output provided is for June 2022 as the user_actions table only contains event dates for that month. 
You should adapt the solution accordingly for July 2022.

The dataset you are querying against may have different input & output - this is just an example!

*/

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
