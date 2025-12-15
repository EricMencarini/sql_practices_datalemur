--https://datalemur.com/questions/sql-second-highest-salary

/*
Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. 
Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

It's possible that multiple employees may share the same second highest salary. In case of duplicate, display the salary only once.

Example Output:
second_highest_salary
2230
The output represents the second highest salary among all employees. In this case, the second highest salary is $2,230.

The dataset you are querying against may have different input & output - this is just an example!

*/


WITH salary_rank AS
(
SELECT 
      salary,
      DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_rank
FROM employee
)

SELECT 
    salary AS second_highest_salary
FROM 
    salary_rank
WHERE 
    dense_rank = 2