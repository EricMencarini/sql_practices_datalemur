 --https://datalemur.com/questions/top-profitable-drugs

SELECT drug,
       (total_sales - cogs) AS Total_Profit
FROM pharmacy_sales
ORDER BY Total_Profit DESC
LIMIT 3