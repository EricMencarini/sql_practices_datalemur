--https://datalemur.com/questions/total-utilization-time

/*
Amazon Web Services (AWS) is powered by fleets of servers. Senior management has requested data-driven solutions to optimize server usage.

Write a query that calculates the total time that the fleet of servers was running. The output should be in units of full days.

Assumptions:

Each server might start and stop several times.
The total time in which the server fleet is running can be calculated as the sum of each server's uptime.

Example Output:
total_uptime_days
21
Explanation
In the example output, the combined uptime of all the servers (from each start time to stop time) totals 21 full days.

The dataset you are querying against may have different input & output - this is just an example!

*/

WITH get_days_diff AS
(
SELECT
  ROW_NUMBER() OVER(PARTITION BY server_id ORDER BY status_time) AS ordering_rows,
  ROUND((EXTRACT(EPOCH FROM status_time) - EXTRACT(EPOCH FROM LAG(status_time) OVER(PARTITION BY server_id ORDER BY status_time))) / 86400,1)::INT AS days_diff
FROM
  server_utilization
),
  get_even_days AS
(
SELECT
  CASE
    WHEN ordering_rows % 2 = 0 THEN days_diff ELSE 0 END as calc_even_days
FROM
  get_days_diff
)

SELECT 
  SUM(calc_even_days) AS total_uptime_days
FROM
  get_even_days;