--https://datalemur.com/questions/duplicate-job-listings

WITH count_companies AS
(
SELECT 
    company_id
FROM job_listings
GROUP BY company_id
HAVING COUNT(company_id) > 1
)

SELECT 
    COUNT(*) AS duplicate_companies 
FROM count_companies
