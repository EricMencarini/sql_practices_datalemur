 --https://datalemur.com/questions/top-profitable-drugs

/*
CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. Each drug can only be produced by one manufacturer.

Write a query to find the top 3 most profitable drugs sold, and how much profit they made. Assume that there are no ties in the profits. 
Display the result from the highest to the lowest total profit.

Definition:

cogs stands for Cost of Goods Sold which is the direct cost associated with producing the drug.
Total Profit = Total Sales - Cost of Goods Sold

If you like this question, try out Pharmacy Analytics (Part 2)!
Explanation:
Zyprexa made the most profit (of $84,576.53) followed by Varicose Relief (of $80,926.64) and Surmontil (of $79,815.3).

The dataset you are querying against may have different input & output - this is just an example!

*/

SELECT drug,
       (total_sales - cogs) AS Total_Profit
FROM pharmacy_sales
ORDER BY Total_Profit DESC
LIMIT 3