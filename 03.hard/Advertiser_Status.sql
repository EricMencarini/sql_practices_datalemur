--https://datalemur.com/questions/updated-status

SELECT user_id,
  CASE 
      WHEN paid IS NULL THEN 'CHURN' 
        WHEN paid IS NOT NULL AND status in ('NEW','EXISTING','RESURRECT') THEN 'EXISTING'
          WHEN paid IS NOT NULL AND status = 'CHURN' THEN 'RESURRECT'
            WHEN paid IS NOT NULL AND status IS NULL  THEN 'NEW'
  END AS new_status

FROM 
  advertiser a
FULL OUTER JOIN 
  daily_pay dp using(user_id)
ORDER BY user_id