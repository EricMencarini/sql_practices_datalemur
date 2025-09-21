--https://datalemur.com/questions/consecutive-filing-years

WITH consecutive_years AS 
(
SELECT 
  user_id,
  ROW_NUMBER() 
    OVER(PARTITION BY user_id ORDER BY filing_date 
      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS previous_current_year
FROM 
  filed_taxes
WHERE
  product ILIKE '%Turbo%'
)

SELECT 
  user_id
FROM
  consecutive_years
GROUP BY 
  user_id
HAVING 
  COUNT(user_id) > 2
ORDER BY 
  user_id