--https://datalemur.com/questions/total-drugs-sales

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
