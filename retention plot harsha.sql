CREATE TABLE orders(
Id INT,
User_Id INT,
Total INT,
Created TIMESTAMP
);

COPY orders FROM 'C:\Users\USER\Desktop\Q1.csv' WITH CSV HEADER;

SELECT * FROM orders

--*****************************


 CREATE TABLE grouped AS 
 (SELECT user_id,date(created) FROM orders
 GROUP BY user_id,created
  ORDER BY user_id);
SELECT * FROM grouped

-- ******************************************


DROP TABLE IF EXISTS week

CREATE TABLE week AS 
(SELECT id,user_id,total,date(created) AS week_start FROM orders
);
SELECT * FROM week


--***************************************** 
DROP TABLE IF EXISTS minweek

CREATE TABLE minweek AS (
SELECT user_id,min(week_start) FROM week 
GROUP BY user_id
ORDER BY min
);
--when did the respective userid came for the first time 
SELECT * FROM minweek
ORDER BY user_id
--********************************* 

DROP TABLE IF EXISTS final

CREATE TABLE final AS (
SELECT *,(date-min)/7 AS Week_difference FROM grouped AS g JOIN minweek AS m USING(user_id)
);

SELECT * FROM final
ORDER BY min,week_difference

--**********************************

SELECT min AS date_,
count(DISTINCT CASE WHEN week_difference=0 THEN user_id END ) AS week0,
count(DISTINCT CASE WHEN week_difference=1 THEN user_id END ) AS week1,
count(DISTINCT CASE WHEN week_difference=2 THEN user_id END)  AS week2,
count(DISTINCT CASE WHEN week_difference=3 THEN user_id END)  AS week3, 
count(DISTINCT CASE WHEN week_difference=4 THEN user_id END)  AS week4,
count(DISTINCT CASE WHEN week_difference=5 THEN user_id END ) AS week5,
count(DISTINCT CASE WHEN week_difference=6 THEN user_id END)  AS week6,
count(DISTINCT CASE WHEN week_difference=7 THEN user_id END  )AS week7,
count(DISTINCT CASE WHEN week_difference=8 THEN user_id END ) AS week8,
count(DISTINCT CASE WHEN week_difference=9 THEN user_id END ) AS week9,
count(DISTINCT CASE WHEN week_difference=10 THEN user_id END) AS week10
FROM final 
GROUP BY min
ORDER BY min;

--*********************************************************************** 