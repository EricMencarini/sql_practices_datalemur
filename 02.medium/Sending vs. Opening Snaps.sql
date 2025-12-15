--https://datalemur.com/questions/time-spent-snaps

/*
This is the same question as problem #25 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.

Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on 
these activities grouped by age group. Round the percentage to 2 decimal places in the output.

Notes:

Calculate the following percentages:
time spent sending / (Time spent sending + Time spent opening)
Time spent opening / (Time spent sending + Time spent opening)
To avoid integer division in percentages, multiply by 100.0 and not 100.
Effective April 15th, 2023, the solution has been updated and optimised.

Explanation
Using the age bucket 26-30 as example, the time spent sending snaps was 5.67 and the time spent opening snaps was 3.

To calculate the percentage of time spent sending snaps, we divide the time spent sending snaps by the total time spent on 
sending and opening snaps, which is 5.67 + 3 = 8.67.

So, the percentage of time spent sending snaps is 5.67 / (5.67 + 3) = 65.4%, and the percentage of time spent opening snaps is 3 / (5.67 + 3) = 34.6%.

The dataset you are querying against may have different input & output - this is just an example!

*/


WITH activity_sending AS
(
 SELECT 
      a.user_id,
      ab.age_bucket,
      SUM(time_spent) AS spent_sending
 FROM 
     activities a
     INNER JOIN age_breakdown ab ON a.user_id = ab.user_id
 WHERE 
     activity_type = 'send'
 GROUP BY 
     1,2
),
activity_open AS
(
 SELECT 
      a.user_id,
      ab.age_bucket,
      SUM(time_spent) AS spent_opening
 FROM 
     activities a
     INNER JOIN age_breakdown ab ON a.user_id = ab.user_id
 WHERE 
     activity_type = 'open'
 GROUP BY 
     1,2
)

SELECT
       acs.age_bucket,
       ROUND(acs.spent_sending / (acs.spent_sending + spent_opening) * 100.0,2) AS send_perc,
       ROUND(aco.spent_opening / (acs.spent_sending + spent_opening) * 100.0,2) AS open_perc
FROM 
     activity_sending acs 
     INNER JOIN activity_open aco ON acs.user_id = aco.user_id
ORDER BY 
     age_bucket ASC;
