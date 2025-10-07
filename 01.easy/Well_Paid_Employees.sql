--https://datalemur.com/questions/sql-well-paid-employees

/*
Companies often perform salary analyses to ensure fair compensation practices. 
One useful analysis is to check if there are any employees earning more than their direct managers.

As a HR Analyst, you're asked to identify all employees who earn more than their direct managers. 
The result should include the employee's ID and name.

Example Output:
employee_id	employee_name
3	Olivia Smith
The output shows that Olivia Smith earns $7,000, surpassing her manager, William David who earns $6,800.

The dataset you are querying against may have different input & output - this is just an example!
*/

SELECT e.employee_id,
       e.name
FROM employee e 
  JOIN employee ee 
    ON e.manager_id = ee.employee_id 
WHERE e.salary > ee.salary
  
