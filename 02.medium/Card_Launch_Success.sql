--https://datalemur.com/questions/card-launch-success

WITH rank_card AS
(
SELECT 
  card_name,
  issued_amount,
  RANK() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month ASC) AS card_rank
FROM 
  monthly_cards_issued
)


SELECT 
  card_name,
  issued_amount
FROM  
  rank_card
WHERE 
  card_rank = 1
ORDER BY
  issued_amount DESC