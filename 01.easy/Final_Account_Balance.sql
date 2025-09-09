--https://datalemur.com/questions/final-account-balance

SELECT
  account_id,
  SUM(CASE 
        WHEN transaction_type = 'Deposit' 
          THEN amount ELSE -amount 
              END) AS balance
FROM
  transactions
GROUP BY 
  account_id