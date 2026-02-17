-- ================================================
-- OLIST E-COMMERCE BUSINESS ANALYSIS
-- Tool: SQL Server (T-SQL)
-- Dataset: Brazilian E-Commerce by Olist (Kaggle)
-- Analyst: Asma Shaik

-- ================================================
-- LEVEL 1: FOUNDATIONAL QUERIES
-- ================================================

-- Q1: How many unique customers do we have?
SELECT 
    COUNT(DISTINCT customer_unique_id) AS total_unique_customers
FROM olist_customers_dataset;

-- Result: 96,096 unique customers
-- Insight: Customers table has 99,441 rows but only 96,096 unique customers
-- meaning ~3,345 customers placed repeat orders on Olist!


-- Q2: Order distribution by status
SELECT 
    order_status,
    COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;

-- Result:
-- delivered      96478
-- shipped         1107
-- canceled         625
-- unavailable      609
-- invoiced         314
-- processing       301
-- created            5
-- approved           2

-- Insight: 97% of orders successfully delivered!
-- Only 0.6% cancellation rate = strong operational efficiency
-- 609 unavailable orders = potential stock management issue worth flagging!