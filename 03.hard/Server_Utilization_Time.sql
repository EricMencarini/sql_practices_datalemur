--https://datalemur.com/questions/total-utilization-time

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
  get_even_days