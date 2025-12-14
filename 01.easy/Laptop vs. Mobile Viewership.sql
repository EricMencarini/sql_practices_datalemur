/*
https://datalemur.com/questions/laptop-mobile-viewership

This is the same question as problem #3 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone.
Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and 
phone viewership. Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views.

Effective 15 April 2023, the solution has been updated with a more concise and easy-to-understand approach.

Example Output
laptop_views	mobile_views
2	3
Explanation
Based on the example input, there are a total of 2 laptop views and 3 mobile views.

The dataset you are querying against may have different input & output - this is just an example!
*/

SELECT
   SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
   SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views

FROM 
   viewership;


--Solution 2:
WITH laptop AS
(
  SELECT 
    COUNT(view_time) AS contagem
  FROM 
    viewership
  WHERE 
    device_type = 'laptop'
),
mobile AS
(
  SELECT 
    COUNT(view_time) AS contagem
  FROM 
    viewership
  WHERE 
    device_type IN ('tablet','phone')
)
SELECT
 (SELECT * FROM laptop) AS laptop_views,
 (SELECT * FROM mobile) AS mobile_views;