https://datalemur.com/questions/time-spent-snaps

WITH activity_sending AS
(
 SELECT 
      a.user_id,
      ab.age_bucket,
      sum(time_spent) AS spent_sending
 FROM activities a
 INNER JOIN age_breakdown ab ON a.user_id = ab.user_id
 WHERE activity_type = 'send'
 GROUP BY 1,2
),
activity_open AS
(
 SELECT 
      a.user_id,
      ab.age_bucket,
      sum(time_spent) AS spent_opening
 FROM activities a
 INNER JOIN age_breakdown ab ON a.user_id = ab.user_id
 WHERE activity_type = 'open'
 GROUP BY 1,2
)

SELECT
       acs.age_bucket,
       ROUND(acs.spent_sending / (acs.spent_sending + spent_opening) * 100.0,2) AS send_perc,
       ROUND(aco.spent_opening / (acs.spent_sending + spent_opening) * 100.0,2) AS open_perc
FROM activity_sending acs 
INNER JOIN activity_open aco ON acs.user_id = aco.user_id
ORDER BY age_bucket ASC
