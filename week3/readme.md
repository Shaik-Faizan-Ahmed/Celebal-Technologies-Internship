# Week 3 SQL Assignment – Superstore Sales Analysis

## Overview

This repository contains my Week 3 submission for the Celebal Summer Internship 2026.

The objective of this assignment was to analyze the Superstore sales dataset using advanced SQL concepts such as:

* Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* JOIN Operations
* Aggregations and Business Analysis Queries

The dataset was imported into MySQL and transformed into structured tables for performing customer and sales analysis.

---

# Repository Contents

## 1. week3_asgmt_Sk_Faizan_Ahmed_pt1.sql

This SQL script contains the complete implementation of Part 1 of the assignment.

### Contents

#### Database Setup

* Create database
* Select active database

#### Data Preparation

* Create Customers table
* Create Products table
* Create Orders table
* Insert data using `SELECT DISTINCT`

#### Subqueries

* Orders with sales greater than average sales
* Highest sales order for each customer
* Orders with profit greater than average profit
* Customers with more orders than average
* Customers with above-average sales orders
* Products with sales higher than average product sales

#### CTEs

* Total sales per customer
* Customers with above-average total sales
* Total profit per customer
* Order count per customer
* Top customers by sales
* Average order value per customer

#### Window Functions

* Customer ranking using `RANK()`
* Customer ranking using `DENSE_RANK()`
* Order numbering using `ROW_NUMBER()`
* Top order per customer
* Running sales total
* Previous order comparison using `LAG()`

#### Combined Analysis

* JOIN + CTE + Window Function
* Customer Name
* Total Sales
* Customer Rank

#### Business Queries

* Top 5 customers
* Bottom 5 customers
* Single-order customers
* Above-average customers
* Highest order value per customer

---

## 2. Sk-faizan-ahmed-week3-pt1-report.docx

This document contains the detailed report for Part 1.

### Contents

* Task-wise implementation
* SQL queries
* Query outputs/screenshots
* Query explanations
* Brief insights for each query
* Observations after each task
* Final business insights
* Assignment conclusion

The report explains how Subqueries, CTEs, Window Functions, and JOIN operations were used to analyze sales data and generate customer insights.

---

## 3. week3_asgmt_Sk_Faizan_Ahmed_pt2.sql

This SQL script contains the implementation of Part 2.

### Contents

#### Step 1: Setup Data

* Create Customers table
* Create Products table
* Create Orders table
* Insert data using `SELECT DISTINCT`

#### Step 2: Required Queries

##### Subqueries

* Orders with sales greater than average sales
* Highest sales order for each customer

##### CTEs

* Total sales per customer
* Customers with above-average total sales

##### Window Functions

* Rank customers by total sales
* Assign row numbers to orders within customers
* Display top 3 customers based on sales

#### Step 3: Final Combined Query

* Customer Name
* Total Sales
* Rank
* JOIN + CTE + Window Function

#### Mini Project

* Top 5 customers
* Bottom 5 customers
* Single-order customers
* Above-average customers
* Highest order value per customer

---

## 4. Sk-faizan-ahmed-week3-pt2-report.docx

This document contains the detailed report for Part 2.

### Contents

* Step-by-step implementation
* SQL queries
* Output screenshots
* Query explanations
* Business insights
* Final observations
* Final insights
* Conclusion

The report demonstrates the practical use of advanced SQL concepts for solving real-world business problems using sales data.

---
