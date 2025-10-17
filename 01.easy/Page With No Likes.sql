--https://datalemur.com/questions/sql-page-with-no-likes

/*
Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").

Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.

pages Table:

Example Output:
page_id
20701
The dataset you are querying against may have different input & output - this is just an example!

p.s. If you have literally no idea how to solve this, maybe give our free SQL tutorial a try first?

*/

SELECT p.page_id
FROM pages p 
    LEFT OUTER JOIN page_likes pp ON p.page_id = pp.page_id 
WHERE 
    pp.page_id IS NULL
ORDER BY 
    p.page_id ASC
