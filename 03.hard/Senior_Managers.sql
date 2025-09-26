--https://datalemur.com/questions/senior-managers-reportees

SELECT 
  ee.manager_name,
  COUNT(DISTINCT ee.emp_id) AS direct_reportees
FROM
  employees e 
  JOIN employees ee ON e.manager_id = ee.emp_id
    JOIN employees eee ON ee.manager_id = eee.emp_id
GROUP BY
  ee.manager_name
ORDER BY 
  direct_reportees DESC
