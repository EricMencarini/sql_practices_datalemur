/*
https://datalemur.com/questions/matching-skills

This is the same question as problem #8 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given a table containing job postings from various companies on the LinkedIn platform. Write a query to retrieve the count 
of companies that have posted duplicate job listings.

Definition:

Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.

Explanation:
There is one company ID 345 that posted duplicate job listings. The duplicate listings, IDs 945 and 164 have identical titles and descriptions.
The dataset you are querying against may have different input & output - this is just an example!
*/

WITH count_companies AS
(
SELECT 
    company_id
FROM 
    job_listings
GROUP BY 
    company_id
HAVING 
    COUNT(company_id) > 1
)

SELECT 
    COUNT(*) AS duplicate_companies 
FROM 
    count_companies;
