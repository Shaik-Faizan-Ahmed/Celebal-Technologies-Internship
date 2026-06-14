-- week 3 assignment part 2 by Shaik Faizan Ahmed
-- Step 1: Setup Data
-- creating the database

CREATE DATABASE week3_db;
USE week3_db;

-- creating the table

CREATE TABLE customers(
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50)
);

CREATE TABLE products(
    product_id VARCHAR(50),
    product_name VARCHAR(255),
    category VARCHAR(100),
    sub_category VARCHAR(100)
);

CREATE TABLE orders(
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

INSERT INTO customers
SELECT DISTINCT `Customer ID`,`Customer Name`,Segment
FROM superstore_raw;

INSERT INTO products
SELECT DISTINCT `Product ID`,`Product Name`,Category,`Sub-Category`
FROM superstore_raw;

INSERT INTO orders
SELECT DISTINCT `Order ID`,`Order Date`,`Ship Date`,`Ship Mode`,`Customer ID`,`Product ID`,Sales,Quantity,Profit
FROM superstore_raw;

-- verifying the data
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;

-- Step 2: Perform Required Queries

-- 1.	Find all orders where sales are greater than the average sales. (Subquery) 
SELECT * FROM orders
WHERE sales>(SELECT AVG(sales) FROM orders);

-- 2.	Find the highest sales order for each customer. (Subquery)
SELECT * FROM orders o
WHERE sales=( SELECT MAX(sales) FROM orders WHERE customer_id=o.customer_id
);

-- 3.	Calculate total sales for each customer. (CTE) 

WITH cs AS(
    SELECT customer_id,SUM(sales) as total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM cs;

-- 4.	Find customers whose total sales are above average. (CTE + Subquery) 

WITH cs AS(
    SELECT customer_id,SUM(sales) as total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM cs WHERE total_sales>( SELECT AVG(total_sales) FROM cs);

-- 5.	Rank all customers based on total sales. (Window Function) 

WITH cs AS(
    SELECT customer_id,SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id,total_sales,
       RANK() OVER(ORDER BY total_sales DESC) sales_rank
FROM cs;

-- 6.	Assign row numbers to each order within a customer. (Window Function + PARTITION BY) 

SELECT customer_id,order_id,sales,
       ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY sales DESC) row_num
FROM orders;

-- 7.	Display top 3 customers based on total sales. (Window Function) 
 
 WITH cs AS(
    SELECT customer_id,SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM( SELECT customer_id,total_sales,
RANK() OVER(ORDER BY total_sales DESC) rnk
FROM cs) t
WHERE rnk<=3;

-- Step 3: Final Combined Query

-- Display Customer Name, Total Sales, and Rank (JOIN + CTE + Window Function)

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

-- Mini Project: Customer Sales Insights

-- 1.	Who are the top 5 customers? 

SELECT * FROM(
    SELECT customer_id,SUM(sales) as total_sales
    FROM orders
    GROUP BY customer_id
)t
ORDER BY total_sales DESC
LIMIT 5;

-- 2.	Who are the bottom 5 customers? 

SELECT * FROM(
    SELECT customer_id,SUM(sales) as total_sales
    FROM orders
    GROUP BY customer_id
)t
ORDER BY total_sales
LIMIT 5;

-- 3.	Which customers made only one order? 

SELECT customer_id,COUNT(DISTINCT order_id) as total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id)=1;

-- 4.	Which customers have above-average sales? 

WITH cs AS(
    SELECT customer_id,SUM(sales) total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM cs
WHERE total_sales>(
    SELECT AVG(total_sales)
    FROM cs
);

-- 5.	What is the highest order value per customer?

SELECT customer_id,MAX(sales) as highest_order
FROM orders
GROUP BY customer_id;