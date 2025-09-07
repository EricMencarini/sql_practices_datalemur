--https://datalemur.com/questions/sql-top-three-salaries

WITH employee_salary as (
SELECT
      d.department_name,
      e.name,
      e.salary,
      DENSE_RANK() OVER(PARTITION BY d.department_name ORDER BY e.salary DESC) as r_salary
FROM employee e
INNER JOIN department d ON e.department_id = d.department_id
ORDER BY d.department_name ASC, e.salary DESC, e.name
)

SELECT
      department_name,
      name,
      salary
FROM employee_salary
WHERE r_salary < 4