--https://datalemur.com/questions/sql-highest-grossing

/*
This is the same question as problem #12 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given a table containing data on Amazon customers and their spending on products in different category, write a query 
to identify the top two highest-grossing products within each category in the year 2022. 
The output should include the category, product, and total spend.

Explanation:
Within the "appliance" category, the top two highest-grossing products are "refrigerator" and "washing machine."
In the "electronics" category, the top two highest-grossing products are "vacuum" and "wireless headset."
The dataset you are querying against may have different input & output - this is just an example!

*/

WITH ranked_spend AS (
    SELECT 
        category, 
        product, 
        SUM(spend) AS total_spend,
        RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS rank
    FROM product_spend
    WHERE EXTRACT(YEAR FROM transaction_date) = 2022
    GROUP BY category, product
)
SELECT  category, 
        product, 
        total_spend
FROM ranked_spend
WHERE rank < 3;