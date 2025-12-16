--https://datalemur.com/questions/yoy-growth-rate

/*
This is the same question as problem #32 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given a table containing information about Wayfair user transactions for different products. 
Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.

The output should include the year in ascending order, product ID, current year's spend, previous year's spend and year-on-year 
growth percentage, rounded to 2 decimal places.

Explanation:
Product ID 123424 is analyzed for multiple years: 2019, 2020, 2021, and 2022.

In the year 2020, the current year's spend is 1000.20, and there is no previous year's spend recorded (indicated by an empty cell).
In the year 2021, the current year's spend is 1246.44, and the previous year's spend is 1000.20.
In the year 2022, the current year's spend is 2145.32, and the previous year's spend is 1246.44.
To calculate the year-on-year growth rate, we compare the current year's spend with the previous year's spend.For instance, 
the spend grew by 24.62% from 2020 to 2021, indicating a positive growth rate.

The dataset you are querying against may have different input & output - this is just an example!

*/

WITH current_year AS
(
SELECT
  EXTRACT(YEAR FROM transaction_date) AS year,
  product_id,
  SUM(spend)AS curr_year_spend
FROM
  user_transactions
GROUP BY
  year, product_id
)

SELECT
  year,
  product_id,
  curr_year_spend,
  LAG(curr_year_spend) OVER(PARTITION BY product_id ORDER BY year) AS prev_year_spend,
  ROUND(((curr_year_spend - LAG(curr_year_spend) OVER(PARTITION BY product_id ORDER BY year)) 
  / LAG(curr_year_spend) OVER(PARTITION BY product_id ORDER BY year)) *100.0,2) AS yoy_rate
FROM
  current_year;