https://datalemur.com/questions/sql-third-transaction

WITH Rank_Transactions AS
(
SELECT user_id,
       transaction_date,
       spend,
       ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date ASC) as Rank
FROM transactions
)

SELECT user_id,
       transaction_date,
       spend
FROM Rank_Transactions
WHERE Rank = 3