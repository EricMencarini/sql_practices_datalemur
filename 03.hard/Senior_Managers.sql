--https://datalemur.com/questions/senior-managers-reportees

/*
Assume we have a table of Google employees with their corresponding managers.

A manager is an employee with a direct report. 
A senior manager is an employee who manages at least one manager, but none of their direct reports is senior managers themselves.
Write a query to find the senior managers and their direct reports.

Output the senior manager's name and the count of their direct reports. The senior manager with the most direct reports should be the first result.

Assumption:

An employee can report to two senior managers.

Example Output:
manager_name	direct_reportees
Rick	1
Rick is a senior manager who has one manager directly reporting to him, which is employee id 101.

The dataset you are querying against may have different input & output - this is just an example!

*/

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
