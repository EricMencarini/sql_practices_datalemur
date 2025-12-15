--https://datalemur.com/questions/sql-third-transaction

/*

This is the same question as problem #11 in the SQL Chapter of Ace the Data Science Interview!

Assume you are given the table below on Uber transactions made by users. 
Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

Example Output:
user_id	spend	transaction_date
111	89.60	02/05/2022 12:00:00
The dataset you are querying against may have different input & output - this is just an example!

p.s. for more Uber SQL interview tips & problems, check out the Uber SQL Interview Guide

*/


WITH Rank_Transactions AS
(
SELECT user_id,
       transaction_date,
       spend,
       ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date ASC) as rn_rank
FROM 
    transactions
)

SELECT user_id,
       transaction_date,
       spend
FROM 
    Rank_Transactions
WHERE 
    rn_rank = 3