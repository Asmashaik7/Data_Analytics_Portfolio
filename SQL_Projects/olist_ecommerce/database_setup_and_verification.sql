-- STEP 1: Confirm all 5 tables exist
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- STEP 2: Check row counts in all tables
SELECT 'olist_customers_dataset' AS TableName, COUNT(*) AS TotalRows FROM olist_customers_dataset
UNION ALL
SELECT 'olist_orders_dataset', COUNT(*) FROM olist_orders_dataset
UNION ALL
SELECT 'olist_order_items_dataset', COUNT(*) FROM olist_order_items_dataset
UNION ALL
SELECT 'olist_products_dataset', COUNT(*) FROM olist_products_dataset
UNION ALL
SELECT 'olist_order_payments_dataset', COUNT(*) FROM olist_order_payments_dataset;

-- ================================================
-- TABLE EXPLORATION -- understanding our data
-- ================================================

-- Explore customers table
SELECT TOP 5 * FROM olist_customers_dataset;

-- Explore orders table
SELECT TOP 5 * FROM olist_orders_dataset;

-- Explore order items table
SELECT TOP 5 * FROM olist_order_items_dataset;

-- Explore products table
SELECT TOP 5 * FROM olist_products_dataset;

-- Explore payments table
SELECT TOP 5 * FROM olist_order_payments_dataset;

 ================================================
-- DATA QUALITY NOTE:
-- products table has a typo in column name
-- 'product_lenght_cm' should be 'product_length_cm'
-- This is a known issue in the Olist dataset
-- When using this column always use: product_lenght_cm (with typo)
-- ================================================