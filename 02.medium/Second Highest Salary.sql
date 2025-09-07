--https://datalemur.com/questions/sql-second-highest-salary

WITH salary_rank AS
(
SELECT 
      salary,
      DENSE_RANK() OVER(ORDER BY salary DESC) AS Rank
FROM employee
)

SELECT 
    salary AS second_highest_salary
FROM salary_rank
WHERE Rank = 2