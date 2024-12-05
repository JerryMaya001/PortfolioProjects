---Instruction: All Result must be in 2 d.p
SELECT *
FROM sales_data_sample

---1. Find the total sales made product line by year. Sort your result by year and Sales in Descending order.
SELECT PRODUCTLINE, YEAR_ID, CAST (SUM(SALES) AS decimal(10,2)) AS TOTAL_SALES
FROM sales_data_sample
GROUP BY PRODUCTLINE, YEAR_ID
ORDER BY YEAR_ID DESC, TOTAL_SALES DESC

---2. How many product are currently being shipped?
SELECT COUNT('Shipped') AS SHIPPED_PRODUCTS
FROM sales_data_sample
--WHERE STATUS = 'Shipped'

---3. Using the Customer name, which customer has the highest frequency in our store? 
SELECT TOP 1 FULL_NAME, COUNT(FULL_NAME) AS PURCHASES_MADE
FROM sales_data_sample
GROUP BY FULL_NAME
ORDER BY COUNT(FULL_NAME) DESC

---4. Which state has the highest Orders from each state.
SELECT TOP 1 STATE, COUNT(STATE) AS PURCHASES_MADE
FROM sales_data_sample
GROUP BY STATE
ORDER BY COUNT(STATE) DESC

---5. How many quantity of products were ordered by state? If State is NULL change is to UNNAMED   HINT: Use the ISNULL command
SELECT ISNULL(STATE, 'UNNAMED') AS STATE, SUM(QUANTITYORDERED) AS TOTAL_QUANTITYORDERED
FROM sales_data_sample 
GROUP BY STATE

---6. List the countries that have ordered more than 2000 products? Your result should include Territory, Country and quantity ordered.
SELECT TERRITORY, COUNTRY, SUM(QUANTITYORDERED) AS Total_QuantityOrdered
FROM sales_data_sample
GROUP BY TERRITORY, COUNTRY
HAVING SUM(QUANTITYORDERED) > 2000
ORDER BY Total_QuantityOrdered DESC

---7. Which territory has the highest number of countries?
SELECT TOP 1 TERRITORY, COUNT(*) AS Total_Purchase
FROM sales_data_sample
GROUP BY TERRITORY
ORDER BY Total_Purchase DESC

---8. Find the Sales value of all orders there were CANCELLED across each Product Line. Your result should be sort by Product line & Sales value in Descending order.
SELECT PRODUCTLINE, CAST(SUM(SALES) AS decimal(10,2)) AS Total_sales, STATUS
FROM sales_data_sample
GROUP BY PRODUCTLINE, STATUS
HAVING STATUS = 'CANCELLED'
ORDER BY PRODUCTLINE, Total_sales DESC

---9. Find the total sales and quantity of products have been SHIPPED. Your result should include Product Line, Status, Sales & Quantity.
SELECT PRODUCTLINE, STATUS, CAST(SUM(SALES) AS decimal(10,2)) AS Total_Sales, CAST(SUM(QUANTITYORDERED) AS decimal(10,2)) AS Total_QuantityOrdered
FROM sales_data_sample
GROUP BY PRODUCTLINE, STATUS
HAVING STATUS = 'SHIPPED'
ORDER BY Total_Sales DESC, Total_QuantityOrdered DESC

---10. Find the total quantity & Sales value of Product there are either DISPUTED or ON HOLD in 2004. 
SELECT PRODUCTLINE,STATUS, CAST(SUM(SALES) AS decimal(10,2)) AS Total_Sales, CAST (SUM(QUANTITYORDERED) AS decimal(10,2)) AS Total_QuantityOrdered
FROM sales_data_sample
WHERE YEAR_ID = 2004 AND STATUS IN ('DISPUTED', 'ON HOLD')
GROUP BY PRODUCTLINE, STATUS

---11. Find the total number of orders with sales value across greater than 10,000 dollars across different countries. Your result should include, State, Country, & City columns.   N:B: NULL States should be named NOT STATED.
SELECT COALESCE(STATE, 'NOT STATED') AS STATE, CITY, COUNTRY, COUNT(*) AS TOTAL_ORDER
FROM sales_data_sample
WHERE SALES > 10000
GROUP BY COALESCE(STATE, 'NOT STATED'), CITY, COUNTRY

---12. Find the total number of  orders and the average Sales of Small Sized transactions that are either SHIPPED or IN PROCESS. 
---Your result should include Country, State, Deal Size, and Status. Order your result by Country in ascending order, 
---number of orders & sales in descending order.  N:B: NULL States should be named NOT STATED, Country, State, Deal Size, and Status
SELECT 
	COUNTRY, COALESCE(STATE, 'NOT STATED'), DEALSIZE, STATUS, COUNT(*) AS TOTAL_ORDER, CAST (AVG(SALES) AS decimal(10,2)) AS AVERAGE_SALES
FROM sales_data_sample
	WHERE   STATUS IN ('SHIPPED', 'IN PROCESS' ) AND
			DEALSIZE = 'SMALL'
GROUP BY COUNTRY, COALESCE(STATE, 'NOT STATED'), DEALSIZE, STATUS