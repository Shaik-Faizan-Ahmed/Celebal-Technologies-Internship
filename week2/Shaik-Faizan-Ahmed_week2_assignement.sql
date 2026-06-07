-- Celebal Technologies Internship Week-2 Assignment by Shaik Faizan Ahmed [23B81A05L3] CVR COLLEGE
-- Steps: 1.Load dataset into a SQL database.
-- creating a database
CREATE DATABASE superstore_db;
-- use database
USE superstore_db;
-- Imported Sample - Superstore.csv into MySQL Workbench using Table Data Import Wizard (Create New Table option). Total records imported: 9694.
SELECT COUNT(*) FROM superstore;
SELECT * FROM superstore LIMIT 10;
-- Table Schema
DESCRIBE superstore;


-- 2.Explore table (schema, sample data)

-- checking total records
SELECT COUNT(*) AS total_records
FROM superstore;

-- total columns
SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA='superstore_db'
AND TABLE_NAME='superstore';

-- sample data
SELECT *
FROM superstore
LIMIT 5;

-- check categories
SELECT DISTINCT Category
FROM superstore;

-- check regions
SELECT DISTINCT Region
FROM superstore;

-- check segements
SELECT DISTINCT Segment
FROM superstore;


-- 3.Apply WHERE filters (region, category, date, sales)

-- Region Filter
SELECT *
FROM superstore
WHERE Region='West';

-- Category Filter
SELECT *
FROM superstore
WHERE Category='Technology';

-- Date Filter
SELECT *
FROM superstore
WHERE STR_TO_DATE(`Order Date`,'%m/%d/%Y')
BETWEEN '2017-01-01' AND '2017-12-31';

-- Sales Filter
SELECT *
FROM superstore
WHERE Sales>1000;


-- 4.Use GROUP BY for aggregations (sales, quantity, averages).

-- Total Sales by Region
SELECT Region,
SUM(Sales) AS total_sales
FROM superstore
GROUP BY Region;

-- total sales by category
SELECT Category,
SUM(Sales) AS total_sales
FROM superstore
GROUP BY Category;

-- total sales by sub-category
SELECT `Sub-Category`,
SUM(Sales) AS total_sales
FROM superstore
GROUP BY `Sub-Category`
ORDER BY total_sales DESC;

-- Total Quantity Sold by Category
SELECT Category,
SUM(Quantity) AS total_quantity
FROM superstore
GROUP BY Category;

-- Total Quantity Sold by Region
SELECT Region,
SUM(Quantity) AS total_quantity
FROM superstore
GROUP BY Region;

-- Average Sales by Customer Segment
SELECT Segment,
AVG(Sales) AS avg_sales
FROM superstore
GROUP BY Segment;

-- Average Profit by Category
SELECT Category,
AVG(Profit) AS avg_profit
FROM superstore
GROUP BY Category;

-- Maximum and Minimum Sales by Category
SELECT Category,
MAX(Sales) AS max_sales,
MIN(Sales) AS min_sales
FROM superstore
GROUP BY Category;


--  5.Sort and limit results (top products, top categories).

-- Top 10 Products by Sales
SELECT `Product Name`,
SUM(Sales) AS total_sales
FROM superstore
GROUP BY `Product Name`
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 Customers by Sales
SELECT `Customer Name`,
SUM(Sales) AS total_sales
FROM superstore
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

-- Top 5 States by Sales
SELECT State,
SUM(Sales) AS total_sales
FROM superstore
GROUP BY State
ORDER BY total_sales DESC
LIMIT 5;

-- Top Categories by Sales
SELECT Category,
SUM(Sales) AS total_sales
FROM superstore
GROUP BY Category
ORDER BY total_sales DESC;


-- 6.Solve use cases (monthly trends, top customers, duplicates).

-- Monthly Sales Trend
SELECT
YEAR(STR_TO_DATE(`Order Date`,'%m/%d/%Y')) AS year,
MONTH(STR_TO_DATE(`Order Date`,'%m/%d/%Y')) AS month,
SUM(Sales) AS total_sales
FROM superstore
GROUP BY
YEAR(STR_TO_DATE(`Order Date`,'%m/%d/%Y')),
MONTH(STR_TO_DATE(`Order Date`,'%m/%d/%Y'))
ORDER BY year,month;

-- Monthly Profit Trend
SELECT
YEAR(STR_TO_DATE(`Order Date`,'%m/%d/%Y')) AS year,
MONTH(STR_TO_DATE(`Order Date`,'%m/%d/%Y')) AS month,
SUM(Profit) AS total_profit
FROM superstore
GROUP BY
YEAR(STR_TO_DATE(`Order Date`,'%m/%d/%Y')),
MONTH(STR_TO_DATE(`Order Date`,'%m/%d/%Y'))
ORDER BY year,month;

-- Top 10 Customers by Sales
SELECT `Customer Name`,
SUM(Sales) AS total_sales
FROM superstore
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 Customers by Profit
SELECT `Customer Name`,
SUM(Profit) AS total_profit
FROM superstore
GROUP BY `Customer Name`
ORDER BY total_profit DESC
LIMIT 10;

-- Most Profitable Category
SELECT Category,
SUM(Profit) AS total_profit
FROM superstore
GROUP BY Category
ORDER BY total_profit DESC;

-- Most Profitable Sub-Category
SELECT `Sub-Category`,
SUM(Profit) AS total_profit
FROM superstore
GROUP BY `Sub-Category`
ORDER BY total_profit DESC;

-- Top 10 Products by Profit
SELECT `Product Name`,
SUM(Profit) AS total_profit
FROM superstore
GROUP BY `Product Name`
ORDER BY total_profit DESC
LIMIT 10;

-- Top 10 States by Profit
SELECT State,
SUM(Profit) AS total_profit
FROM superstore
GROUP BY State
ORDER BY total_profit DESC
LIMIT 10;
 
-- Duplicate Records Check
SELECT `Row ID`,
COUNT(*) AS duplicate_count
FROM superstore
GROUP BY `Row ID`
HAVING COUNT(*)>1;


-- 7.Validate results (row counts, data quality).

-- Total Records
SELECT COUNT(*) AS total_records
FROM superstore;

-- Missing Sales Values
SELECT COUNT(*) AS missing_sales
FROM superstore
WHERE Sales IS NULL;

-- Missing Profit Values
SELECT COUNT(*) AS missing_profit
FROM superstore
WHERE Profit IS NULL;

-- Missing Customer Names
SELECT COUNT(*) AS missing_customer_names
FROM superstore
WHERE `Customer Name` IS NULL;

-- Negative Profit Orders
SELECT *
FROM superstore
WHERE Profit<0;

-- Data Quality Summary
SELECT
COUNT(*) AS total_records,
COUNT(Sales) AS sales_records,
COUNT(Profit) AS profit_records,
COUNT(`Customer Name`) AS customer_records
FROM superstore;