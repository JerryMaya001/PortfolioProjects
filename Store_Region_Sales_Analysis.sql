USE ANALYTICS

SELECT *
FROM accounts

SELECT *
FROM orders

SELECT *
FROM web_events

SELECT *
FROM Sales_Reps

SELECT *
FROM region

---1. Provide a table for all web_events associated with account name of Walmart. There should be three columns.Be sure to include the primary_poc,
---time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.

SELECT A.Account_name, A.primary_poc, WE.channel, O.occurred_at
FROM web_events AS WE
JOIN accounts AS A
ON WE.account_id = A.id
JOIN orders AS O
ON O.account_id = A.id
WHERE WE.account_id = 1001

---2. Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: 
---the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name. 
SELECT  A.Account_name, SR.Rep_name, R.Region_name
FROM region AS R
JOIN Sales_Reps AS SR
ON SR.Region_id = R.id
JOIN accounts AS A
ON A.sales_rep_id = SR.id
ORDER BY A.Account_name 

---3.Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.
SELECT A.Account_name, SUM(O.total_amt_usd) AS TOTAL_AMT_USD
FROM accounts AS A
JOIN orders AS O
ON A.id = O.account_id
GROUP BY A.Account_name

---4. Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? 
---Your query should return only three values - the date, channel, and account name.
SELECT TOP 1 A.Account_name, WE.channel, WE.occurred_at
FROM web_events AS WE
JOIN accounts AS A
ON A.id = WE.account_id
ORDER BY occurred_at DESC

---5. Write a query that calculate the amount of dollar spend on Gloss, Poster and Standard products in each region. 
---Your result should include Region name, and Primary Poc. 
SELECT  R.Region_name, A.primary_poc, SUM(O.gloss_amt_usd) AS TOTAL_GLOSS_AMT_USD, SUM(O.poster_amt_usd) AS TOTAL_POSTER_AMT_USD,
SUM(O.standard_amt_usd) AS TOTAL_STANDARD_AMT_USD
FROM Sales_Reps AS SR
JOIN accounts AS A
ON A.sales_rep_id = SR.id
JOIN region AS R
ON R.id = SR.Region_id
JOIN orders AS O
ON O.account_id = A.id
GROUP BY A.primary_poc, R.Region_name

---6. Write a script that count the number of orders made monthly through different Web event channel. Your result should include Channel, 
---Account name, & Date. Sort your result by date and number of orders
SELECT A.Account_name, O.occurred_at, WE.channel, COUNT(*) AS COUNTS
FROM accounts AS A
JOIN orders AS O
ON A.id = O.account_id
JOIN web_events AS WE
ON WE.account_id = A.id
GROUP BY A.Account_name, O.occurred_at, WE.channel
ORDER BY O.occurred_at ,COUNTS DESC

---7. Write a query that returns any Sales Rep that sold Poster, Gloss, Standard & Total quantity of products above 20,000. 
---Your result should include the Rep name, & Region.
SELECT SR.Rep_name, R.Region_name, O.poster_qty, O.gloss_qty, O.standard_qty, O.total
FROM Sales_Reps AS SR
JOIN region AS R
ON SR.Region_id = R.id
JOIN accounts AS A
ON SR.id = A.sales_rep_id
JOIN orders AS O
ON O.account_id = A.id
WHERE O.total > 20000

---8. For each account, determine the average amount of each type of paper they purchased across their orders. 
---Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.
SELECT A.Account_name, AVG(O.standard_qty) AS AVG_STANDARD_QTY, AVG(O.gloss_qty) AS AVG_GLOSS_QTY, AVG(O.poster_qty) AS AVG_POSTER_QTY
FROM orders AS O
JOIN accounts AS A
ON O.account_id = A.id
GROUP BY A.Account_name

---9. Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have 
---3 columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
SELECT SR.Rep_name, WE.channel, COUNT(*) AS COUNTS
FROM web_events AS WE
JOIN accounts AS A
ON WE.account_id = A.id
JOIN Sales_Reps AS SR
ON SR.id = A.sales_rep_id
GROUP BY SR.Rep_name, WE.channel
ORDER BY COUNTS DESC

---10. Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have 
---3 columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
SELECT R.Region_name, WE.channel, COUNT(*) AS COUNTS
FROM web_events AS WE
JOIN accounts AS A
ON WE.account_id = A.id
JOIN Sales_Reps AS SR
ON SR.id = A.sales_rep_id
JOIN region AS R
ON R.id = SR.Region_id
GROUP BY R.Region_name, WE.channel
ORDER BY COUNTS DESC

--- TOTAL ORDERS BY REGIONS
SELECT R.Region_name, COUNT(*) AS COUNTS
FROM region AS R
JOIN Sales_Reps AS SR
ON R.id = SR.Region_id
JOIN accounts AS A
ON A.sales_rep_id = SR.id
JOIN orders AS O
ON O.account_id = A.id
GROUP BY R.Region_name
ORDER BY COUNTS DESC
