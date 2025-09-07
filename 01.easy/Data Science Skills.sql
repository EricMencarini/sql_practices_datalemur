--https://datalemur.com/questions/matching-skills

SELECT candidate_id
FROM candidates
WHERE skill in ('Python', 'Tableau','PostgreSQL')
GROUP BY candidate_id
HAVING count(candidate_id) > 2