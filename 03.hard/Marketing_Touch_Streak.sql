--https://datalemur.com/questions/marketing-touch-streak

WITH consecutive_events_cte AS 
(
  SELECT 
    event_id,
    contact_id,
    event_type,
    DATE_TRUNC('week', event_date) AS event_week,
    
    LAG(DATE_TRUNC('week', event_date)) 
      OVER (PARTITION BY contact_id ORDER BY event_date) AS previous_week,
      
    LEAD(DATE_TRUNC('week', event_date)) 
      OVER (PARTITION BY contact_id ORDER BY event_date) AS forward_week
      
  FROM marketing_touches
)

SELECT DISTINCT
  contacts.email
FROM
  consecutive_events_cte AS events
INNER JOIN crm_contacts AS contacts
  ON events.contact_id = contacts.contact_id

WHERE 1=1
  AND previous_week = event_week - interval '1 week'
  OR  forward_week = event_week  + interval '1 week'
  AND events.contact_id in 
    (SELECT contact_id FROM marketing_touches WHERE event_type = 'trial_request')