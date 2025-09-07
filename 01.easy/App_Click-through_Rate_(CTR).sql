--https://datalemur.com/questions/click-through-rate

WITH ctr as (
SELECT 
    app_id,
    COUNT(CASE WHEN event_type = 'impression' THEN 1 END) AS quantity_impression,
    COUNT(CASE WHEN event_type = 'click'      THEN 1 END) AS quantity_clicks
FROM events
WHERE EXTRACT(YEAR FROM timestamp) = '2022' 
GROUP BY app_id
)

SELECT app_id,
        ROUND(((100.0 * quantity_clicks) / quantity_impression),2)  AS ctr
FROM ctr