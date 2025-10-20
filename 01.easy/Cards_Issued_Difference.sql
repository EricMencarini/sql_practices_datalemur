/*
https://datalemur.com/questions/cards-issued-difference

Your team at JPMorgan Chase is preparing to launch a new credit card, and to gain some insights, 
you're analyzing how many credit cards were issued each month.

Write a query that outputs the name of each credit card and the difference in the number of issued cards between the month with the highest 
issuance cards and the lowest issuance. Arrange the results based on the largest disparity.

Example Output:
card_name	difference
Chase Freedom Flex	15000
Chase Sapphire Reserve	10000
Chase Freedom Flex's best month was 70k cards issued and the worst month was 55k cards, so the difference is 15k cards.

Chase Sapphire Reserve’s best month was 180k cards issued and the worst month was 170k cards, so the difference is 10k cards.

The dataset you are querying against may have different input & output - this is just an example!
*/

SELECT card_name,
       MAX(issued_amount) - MIN(issued_amount) AS difference
FROM 
    monthly_cards_issued
GROUP BY 
    card_name
ORDER BY 
    difference DESC