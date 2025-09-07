--https://datalemur.com/questions/sql-well-paid-employees

SELECT e.employee_id,
       e.name
FROM employee e 
  JOIN employee ee 
    ON e.manager_id = ee.employee_id 
WHERE e.salary > ee.salary
  
