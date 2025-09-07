--https://datalemur.com/questions/sql-highest-grossing

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