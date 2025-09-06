https://datalemur.com/questions/sql-page-with-no-likes

SELECT p.page_id
FROM pages p 
LEFT OUTER JOIN page_likes pp ON p.page_id = pp.page_id 
WHERE pp.page_id is NULL
ORDER BY p.page_id ASC
