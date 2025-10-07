--https://datalemur.com/questions/marketing-touch-streak

/*
As a Data Analyst on Snowflake's Marketing Analytics team, your objective is to analyze customer relationship management (CRM) 
data and identify contacts that satisfy two conditions:

Contacts who had a marketing touch for three or more consecutive weeks.
Contacts who had at least one marketing touch of the type 'trial_request'.
Marketing touches, also known as touch points, represent the interactions or points of contact between a brand and its customers.

Your goal is to generate a list of email addresses for these contacts.

Explanation:
Among the contacts, only Contact ID 1 (andy.markus@att.net) satisfies both conditions specified in the problem. 
Contact ID 1 had a marketing touch with an event type of 'trial_request' and the marketing touch points occurred consecutively over a period of 3 weeks. 
This meets both conditions of having a marketing touch for three or more consecutive weeks.

On the other hand, Contact ID 2 (rajan.bhatt@capitalone.com) is not included in the generated list. 
Although they had a marketing touch with the event type 'trial_request', their touch points took place within the same week. 
Consequently, this does not meet the requirement of consecutive marketing touches for 3 weeks.

The dataset you are querying against may have different input & output - this is just an example!

*/

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