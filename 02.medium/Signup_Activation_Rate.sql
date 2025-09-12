--https://datalemur.com/questions/signup-confirmation-rate

SELECT
    ROUND(
      (COUNT(t.email_id)::DECIMAL / COUNT(e.email_id)),2) AS activation_rate
FROM 
  emails e 
LEFT JOIN texts t 
    ON e.email_id = t.email_id 
    AND t.signup_action = 'Confirmed'
