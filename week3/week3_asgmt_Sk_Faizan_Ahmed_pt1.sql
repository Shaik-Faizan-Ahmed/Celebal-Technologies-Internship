-- week 3 assignment by Shaik Faizan Ahmed
create database week3_db;

use week3_db;

-- The Superstore dataset was imported into a table named superstore_raw using the MySQL Table Data Import Wizard.

-- creating tables

CREATE TABLE customers
(
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50)
);

CREATE TABLE products
(
    product_id VARCHAR(50),
    product_name VARCHAR(255),
    category VARCHAR(100),
    sub_category VARCHAR(100)
);

CREATE TABLE orders
(
    order_id VARCHAR(50),
    order_date DATETIME,
    ship_date DATETIME,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    product_id VARCHAR(50),
    sales DOUBLE,
    quantity INT,
    profit DOUBLE
);

-- inserting the data

INSERT INTO customers
SELECT DISTINCT `Customer ID`, `Customer Name`, Segment
FROM superstore_raw;

INSERT INTO products
SELECT DISTINCT `Product ID`,`Product Name`,Category,`Sub-Category`
FROM superstore_raw;

INSERT INTO orders
SELECT DISTINCT `Order ID`,`Order Date`,`Ship Date`,`Ship Mode`,`Customer ID`,`Product ID`,Sales,Quantity,Profit
FROM superstore_raw;

-- subqueries to filter data


-- find orders with sales greater than average sales
SELECT *
FROM orders
WHERE sales>(SELECT AVG(sales) FROM orders);


CREATE INDEX idx_cust ON orders(customer_id);
-- find highest sales order for each customer
SELECT *
FROM orders o
WHERE sales=(
    SELECT MAX(sales)
    FROM orders
    WHERE customer_id=o.customer_id
);

-- find orders with profit greater than average profit 

SELECT * FROM orders
WHERE profit>(SELECT AVG(profit) FROM orders);

-- find customers who placed more orders than average customer

SELECT customer_id, COUNT(DISTINCT order_id)as total_orders
FROM orders GROUP BY customer_id
HAVING COUNT(DISTINCT order_id)>(SELECT AVG(ord_cnt)
    FROM(SELECT COUNT(DISTINCT order_id)as ord_cnt
			FROM orders GROUP BY customer_id) t
);

-- find customers who placed above average sales orders

SELECT DISTINCT customer_id
FROM orders
WHERE sales>(SELECT AVG(sales) FROM orders);

-- find products with sales higher than average product sales

SELECT product_id,SUM(sales) total_sales
FROM orders
GROUP BY product_id
HAVING SUM(sales)>( SELECT AVG(prod_sales)
    FROM (SELECT SUM(sales) prod_sales
			FROM orders GROUP BY product_id) t
);


-- using CTEs to compute aggregations

-- calculate total sales for each customer

WITH cs AS(
    SELECT customer_id,SUM(sales) as total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM cs;

-- find customers whose total sales are above average

WITH cs AS(SELECT customer_id,SUM(sales) as total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM cs WHERE total_sales>(SELECT AVG(total_sales)FROM cs);

-- calculate total profit for each customer

WITH cp AS(
    SELECT customer_id,SUM(profit) as total_profit
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM cp;

-- count total orders placed by each customer

WITH co AS(
    SELECT customer_id,COUNT(DISTINCT order_id) as order_count
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM co;

-- top 10 customers by sales
WITH cs AS(
    SELECT customer_id, SUM(sales) as total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM cs
ORDER BY total_sales DESC
LIMIT 10;

-- average order value per customers
WITH ao AS(
    SELECT customer_id, AVG(sales) as avg_order_value
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM ao;


-- applying window functions

-- Rank customers based on total sales 

WITH cs AS (
    SELECT customer_id,SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id, total_sales,
       RANK() OVER(ORDER BY total_sales DESC) sales_rank
FROM cs;

-- assign dense rank to customers 

WITH cs AS (
    SELECT customer_id,SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id,total_sales,
       DENSE_RANK() OVER(ORDER BY total_sales DESC) d_rank
FROM cs;

-- assign row numbers to orders within each customer 

SELECT customer_id,order_id,sales,
       ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY sales DESC) row_num
FROM orders;

-- find top order for every customer 
SELECT *
FROM (SELECT customer_id,order_id,sales,
           ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY sales DESC) rn
FROM orders) t
WHERE rn=1;

-- calculate running sales total for each customer 

SELECT customer_id,order_id,sales,
       SUM(sales) OVER(PARTITION BY customer_id ORDER BY order_date) run_total
FROM orders;

-- compare current order sales with previous order sales

SELECT customer_id,order_id,sales,
       LAG(sales) OVER(PARTITION BY customer_id ORDER BY order_date) prev_sales
FROM orders;

-- combining JOIN + CTE + Window Functions

-- display customer name, total sales and rank

WITH cs AS(
    SELECT customer_id,SUM(sales) as total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_name,cs.total_sales,
       RANK() OVER(ORDER BY cs.total_sales DESC) as customer_rank
FROM cs
JOIN customers c
ON cs.customer_id=c.customer_id
ORDER BY customer_rank;


-- solving business queries

-- find top 5 customers by total sales 

SELECT * FROM (SELECT customer_id, SUM(sales) as total_sales
    FROM orders
    GROUP BY customer_id
) t
ORDER BY total_sales DESC
LIMIT 5;

-- find bottom 5 customers by total sales 

SELECT * FROM (SELECT customer_id,SUM(sales) as total_sales
    FROM orders
    GROUP BY customer_id
) t
ORDER BY total_sales
LIMIT 5;

-- find customers who placed only one order 

SELECT customer_id,COUNT(DISTINCT order_id) as total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id)=1;

-- find customers whose sales are above average 

WITH cs AS (SELECT customer_id,SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM cs WHERE total_sales>(SELECT AVG(total_sales)FROM cs);

-- find highest order value for each customer 

SELECT customer_id,MAX(sales) as highest_order
FROM orders
GROUP BY customer_id;


/*
Insights from the dataset:
1. A small number of customers contribute the highest sales.
2. Several customers have sales above the average customer sales.
3. Some customers placed only one order.
4. Window functions helped rank customers and analyze orders.
5. CTEs simplified aggregation and reporting.
*/

/*
what i learned from this assignment:

1. Used SELECT DISTINCT to populate customer, product, and order tables from the raw dataset while removing duplicate records.
2. Applied subqueries to compare rows against aggregate values such as average sales and highest sales per customer.
3. Used CTEs to perform aggregations like total sales, total profit, and order counts in a more readable way.
4. Applied window functions such as ROW_NUMBER(), RANK(), DENSE_RANK(), and LAG() for ranking and analytical calculations.
5. Combined JOINs, CTEs, and window functions to generate customer-level sales rankings.
6. Solved business-oriented queries to identify top customers, bottom customers, single-order customers, and customers with above-average sales.
*/