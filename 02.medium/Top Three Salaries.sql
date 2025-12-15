--https://datalemur.com/questions/sql-top-three-salaries

/*
As part of an ongoing analysis of salary distribution within the company, your manager has requested a report identifying high earners in each department. 
A 'high earner' within a department is defined as an employee with a salary ranking among the top three salaries within that department.

You're tasked with identifying these high earners across all departments. Write a query to display the employee's name along with their department name 
and salary. In case of duplicates, sort the results of department name in ascending order, then by salary in descending order. 
If multiple employees have the same salary, then order them alphabetically.

Note: Ensure to utilize the appropriate ranking window function to handle duplicate salaries effectively.

As of June 18th, we have removed the requirement for unique salaries and revised the sorting order for the results.


Example Output:
department_name	name	salary
Data Analytics	James Anderson	4000
Data Analytics	Emma Thompson	3800
Data Analytics	Daniel Rodriguez	2230
Data Science	Noah Johnson	6800
Data Science	William Davis	6800
The output displays the high earners in each department.

In the Data Analytics deaprtment, James Anderson leads with a salary of $4,000, followed by Emma Thompson earning $3,800, and Daniel Rodriguez with $2,230.
In the Data Science department, both Noah Johnson and William Davis earn $6,800, with Noah listed before William due to alphabetical ordering.
The dataset you are querying against may have different input & output - this is just an example!

*/

WITH employee_salary AS (
SELECT
      d.department_name,
      e.name,
      e.salary,
      DENSE_RANK() OVER(PARTITION BY d.department_name ORDER BY e.salary DESC) as dense_r_salary
FROM employee e
      INNER JOIN department d ON e.department_id = d.department_id
ORDER BY 
      d.department_name ASC, e.salary DESC, e.name
)

SELECT
      department_name,
      name,
      salary
FROM 
      employee_salary
WHERE 
      dense_r_salary < 4;