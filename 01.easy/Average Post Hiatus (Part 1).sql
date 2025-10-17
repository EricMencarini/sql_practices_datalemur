--https://datalemur.com/questions/sql-average-post-hiatus-1

/*
Given a table of Facebook posts, for each user who posted at least twice in 2021, 
write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. 

Output the user and number of the days between each user's first and last post.
p.s. If you've read the Ace the Data Science Interview and liked it, consider writing us a review

*/

SELECT user_id,
       (CAST(MAX(post_date) AS date) - CAST(MIN(post_date) AS date)) AS days_between
FROM 
    posts
WHERE 
    EXTRACT(YEAR FROM post_date) = 2021
GROUP BY 
    user_id
HAVING 
    COUNT(*) > 1
