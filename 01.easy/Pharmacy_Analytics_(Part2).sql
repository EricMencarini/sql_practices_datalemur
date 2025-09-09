--https://datalemur.com/questions/non-profitable-drugs

SELECT 
  manufacturer,
  COUNT(product_id) AS drug_count,
  ABS(SUM(total_sales - cogs)) AS Total_Loss
FROM 
  pharmacy_sales
WHERE 
  (total_sales - cogs) < 0
GROUP BY
  manufacturer
ORDER BY
  Total_Loss DESC