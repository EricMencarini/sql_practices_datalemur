--https://datalemur.com/questions/total-drugs-sales

/*
CVS Health wants to gain a clearer understanding of its pharmacy sales and the performance of various products.

Write a query to calculate the total drug sales for each manufacturer. Round the answer to the nearest million and report your results in 
descending order of total sales. In case of any duplicates, sort them alphabetically by the manufacturer name.

Since this data will be displayed on a dashboard viewed by business stakeholders, please format your results as follows: "$36 million".

If you like this question, try out Pharmacy Analytics (Part 4)!

Explanation
The total sales for Biogen is $4 million ($2,041,758.41 + $500,101.61 + $1,084,258.00 = $3,626,118.02) and for Eli Lilly is $3 million 
($293,452.54 + $2,521,023.73 = $2,814,476.27).

The dataset you are querying against may have different input & output - this is just an example!


*/

SELECT
  manufacturer,
  CASE 
    WHEN SUM(total_sales) > 1000000 THEN
      '$' || ROUND(SUM(total_sales)/1000000) || ' ' || 'million'
    END as sales_mil
FROM 
  pharmacy_sales
GROUP BY
  manufacturer
ORDER BY
  SUM(total_sales) DESC, 
  manufacturer ASC
