--https://datalemur.com/questions/second-day-confirmation

/*
Assume you're given tables with information about TikTok user sign-ups and confirmations through email and text. 
New users on TikTok sign up using their email addresses, and upon sign-up, each user receives a text message confirmation to activate their account.

Write a query to display the user IDs of those who did not confirm their sign-up on the first day, but confirmed on the second day.

Definition:

action_date refers to the date when users activated their accounts and confirmed their sign-up through text messages.

Example Output:
user_id
1052
Explanation:
Only User 1052 confirmed their sign-up on the second day.

The dataset you are querying against may have different input & output - this is just an example!

*/

SELECT user_id
FROM 
  emails e 
  INNER JOIN texts t 
    ON e.email_id = t.email_id
WHERE 1=1
  AND t.action_date = e.signup_date + INTERVAL '1 day'
  AND t.signup_action ='Confirmed'
