--https://datalemur.com/questions/spotify-streaming-history

WITH songs_history AS 
(
SELECT user_id,
       song_id,
       song_plays
  FROM songs_history 

UNION ALL 

SELECT sw.user_id,
       sw.song_id,
       COUNT(sw.song_id) AS song_plays
  FROM songs_weekly sw 
WHERE
  DATE(listen_time) <= '2022-08-04'
GROUP BY
  1,2
)

SELECT 
  user_id,
  song_id,
  SUM(song_plays) AS song_plays
FROM songs_history
GROUP BY  
 1,2
ORDER BY 
  song_plays DESC