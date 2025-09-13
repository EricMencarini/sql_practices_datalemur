--https://datalemur.com/questions/median-search-freq

WITH users AS (
  SELECT
    searches,
    num_users,
    SUM(num_users) OVER(ORDER BY searches) AS running_total
  FROM search_frequency
),
total_num_users AS (
  SELECT SUM(num_users) AS total_users FROM search_frequency
)
SELECT 
  ROUND(AVG(searches), 1) AS median
FROM (
  SELECT 
    searches
  FROM 
    users, total_num_users
  WHERE 
    running_total >= (total_users + 1) / 2
  ORDER BY 
    searches
  LIMIT 2
) avg;
