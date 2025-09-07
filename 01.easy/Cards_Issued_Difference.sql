--https://datalemur.com/questions/cards-issued-difference

SELECT card_name,
       max(issued_amount) - min(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC