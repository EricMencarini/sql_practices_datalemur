--https://datalemur.com/questions/spotify-streaming-history

/*
You're given two tables containing data on Spotify users' streaming activity: songs_history which has historical streaming data, and 
songs_weekly which has data from the current week.

Write a query that outputs the user ID, song ID, and cumulative count of song plays up to August 4th, 2022, sorted in descending order.

Assume that there may be new users or songs in the songs_weekly table that are not present in the songs_history table.

Definitions:

song_weeklytable only contains data for the week of August 1st to August 7th, 2022.
songs_history table contains data up to July 31st, 2022. The query should include historical data from this table.
Example Output:
user_id	song_id	song_plays
777	1238	12
695	4520	2
125	9630	1
On 4 August 2022, the data shows that User 777 listened to the song with song ID 1238 for a total of 12 times, with 11 of those times 
occurring before the current week and 1 time occurring within the current week.

However, the streaming data for User 695 with the song ID 9852 are not included in the output because the streaming date for that record 
falls outside the date range specified in the question.

The dataset you are querying against may have different input & output - this is just an example!

*/


WITH songs_history AS 
(
SELECT 
  user_id,
  song_id,
  song_plays
FROM 
  songs_history 

UNION ALL 

SELECT 
  sw.user_id,
  sw.song_id,
  COUNT(sw.song_id) AS song_plays
FROM 
  songs_weekly sw 
WHERE
  DATE(listen_time) <= '2022-08-04'
GROUP BY
  1,2
)

SELECT 
  user_id,
  song_id,
  SUM(song_plays) AS song_plays
FROM 
  songs_history
GROUP BY  
 1,2
ORDER BY 
  song_plays DESC;