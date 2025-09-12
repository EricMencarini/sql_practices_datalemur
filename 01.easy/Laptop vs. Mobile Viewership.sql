--https://datalemur.com/questions/laptop-mobile-viewership

--Solution 1:
SELECT
   SUM(CASE 
          WHEN device_type = 'laptop' 
      THEN 1 
      ELSE 0 END) AS laptop_views,
      
   SUM(CASE 
        WHEN device_type IN ('tablet', 'phone') 
      THEN 1 ELSE 0 END) AS mobile_views
   FROM viewership


--Solution 2:
WITH laptop AS
(
  SELECT count(view_time) as contagem
  FROM viewership
  WHERE device_type = 'laptop'
),
mobile AS
(
  SELECT count(view_time) as contagem
  FROM viewership
  WHERE device_type in ('tablet','phone')
)
SELECT (SELECT * FROM laptop) as laptop_views,
       (SELECT * FROM mobile) as mobile_views