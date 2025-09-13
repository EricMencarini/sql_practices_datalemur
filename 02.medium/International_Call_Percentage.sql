--https://datalemur.com/questions/international-call-percentage

SELECT
  ROUND(
    (
    SELECT
      COUNT(*)
    FROM
      phone_calls AS a
    INNER JOIN
      phone_info AS b
    ON
      a.caller_id = b.caller_id
    INNER JOIN
      phone_info AS c
    ON
      a.receiver_id = c.caller_id AND
      b.country_id <> c.country_id
    )*100.0 / COUNT(*),1) AS percentage_of_international_phone_calls
FROM
  phone_calls