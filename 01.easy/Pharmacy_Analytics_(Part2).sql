--https://datalemur.com/questions/non-profitable-drugs

/*
CVS Health is analyzing its pharmacy sales data, and how well different products are selling in the market. 
Each drug is exclusively manufactured by a single manufacturer.

Write a query to identify the manufacturers associated with the drugs that resulted in losses for 
CVS Health and calculate the total amount of losses incurred.

Output the manufacturer's name, the number of drugs associated with losses, and the total losses in absolute value. 
Display the results sorted in descending order with the highest losses displayed at the top.

If you like this question, try out Pharmacy Analytics (Part 3)!

Explanation:
The first three rows indicate that some drugs resulted in losses. Among these, Biogen had the highest losses, 
followed by AbbVie and Eli Lilly. However, the Medi-Chord drug manufactured by Biogen reported a profit and was excluded from the result.

The dataset you are querying against may have different input & output - this is just an example!

*/
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