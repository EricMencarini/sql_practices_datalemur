--https://datalemur.com/questions/reactivated-users

/*
This is the same question as problem #31 in the SQL Chapter of Ace the Data Science Interview!

Imagine you're provided with a table containing information about user logins on Facebook in 2022. Write a query that determines the number of reactivated users for a given month. Reactivated users are those who were inactive the previous month but logged in during the current month.

Output the month in numerical format along with the count of reactivated users.

Here's some important assumptions to consider:

The user_logins table only contains data for the year 2022 and there are no missing dates within that period.
For instance, if a user whose first login date is on 3 March 2022, we assume that they had previously logged in during the year 2021. Although the data for their previous logins is not present in the user_logins table, we consider these users as reactivated users.

Example Output:
mth	reactivated_users
2	1
3	2
5	2
In February 2022, we have 1 reactivated user, user 123. They had previously logged in during 2021 and recently reactivated their account in February 2022.

In March 2022, we have 2 reactivated users. Users 112 and 245 were inactive in the previous months but logged in during March 2022, 
indicating that they reactivated their accounts.

Moving on to May 2022, we still have 2 reactivated users. User 123, who had previously reactivated in February 2022, 
reactivated their account again in May 2022. Additionally, user 725, who was inactive in the previous months, logged in during May 2022, 
indicating that they reactivated their account once again.

The dataset you are querying against may have different input & output - this is just an example!

*/

--Solution1: Only the dataset
WITH calc_last_month_activity AS
(
SELECT 
  user_id,
  login_date,
  EXTRACT(MONTH FROM login_date) AS mth,
  LAG(EXTRACT(MONTH FROM login_date)) OVER(PARTITION BY user_id ORDER BY login_date) AS last_mth_activity
FROM 
  user_logins
ORDER BY
  1
),
 calc_reativation_mth AS
(
SELECT 
 --user_id,
 --login_date,
 mth,
 --last_mth_activity,
 CASE 
  WHEN mth - 1 != last_mth_activity AND mth != last_mth_activity THEN 1
    WHEN last_mth_activity IS NULL THEN 1 
      ELSE 0  
 END AS calc_reativation
FROM 
  calc_last_month_activity
)

SELECT
 mth,
 SUM(calc_reativation) AS reactivated_users
FROM 
  calc_reativation_mth
GROUP BY 
  mth
HAVING 
  SUM(calc_reativation) > 0
ORDER BY
  mth;

--Solution 2: Considering the table has multiple years;
WITH calc_last_month_activity AS
(
SELECT 
  user_id,
  login_date,
  DATE_TRUNC('month', login_date)::date AS mth,
  LAG(DATE_TRUNC('month', login_date)::date) OVER(PARTITION BY user_id ORDER BY login_date) AS last_mth_activity
FROM 
  user_logins
ORDER BY
  user_id
),
 calc_reativation_mth AS
(
SELECT 
 --user_id,
 --login_date,
 mth,
 --last_mth_activity,
 CASE 
    WHEN last_mth_activity IS NULL THEN 1
    WHEN DATE_PART('month', mth) - DATE_PART('month', last_mth_activity) != 1
    AND mth != last_mth_activity THEN 1
      ELSE 0  
 END AS calc_reativation
FROM 
  calc_last_month_activity
)

SELECT
 EXTRACT(MONTH FROM mth),
 SUM(calc_reativation) AS reactivated_users
FROM 
  calc_reativation_mth
GROUP BY 
  mth
HAVING 
  SUM(calc_reativation) > 0
ORDER BY
  mth;