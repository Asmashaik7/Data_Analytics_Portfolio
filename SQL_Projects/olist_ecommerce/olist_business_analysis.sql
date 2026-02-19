-- ================================================
-- OLIST E-COMMERCE BUSINESS ANALYSIS
-- Tool: SQL Server (T-SQL)
-- Dataset: Brazilian E-Commerce by Olist (Kaggle)
-- Analyst: Asma Shaik
-- GitHub: https://github.com/Asmashaik7

-- ================================================
-- LEVEL 1: FOUNDATIONAL QUERIES
-- ================================================

-- Q1: How many unique customers do we have in our database?
SELECT 
    COUNT(DISTINCT customer_unique_id) AS total_unique_customers
FROM olist_customers_dataset;

-- Result: 96,096 unique customers
-- Insight: Customers table has 99,441 rows but only 96,096 unique customers
-- meaning ~3,345 customers placed repeat orders on Olist!

-- =======================================================
-- Q2: What is the distribution of orders by order status?
-- =======================================================
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


-- =====================================================
-- Q3: What is the total revenue generated on the platform?
-- ========================================================
SELECT 
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM olist_order_payments_dataset;

-- Result: 16,008,872.12
-- Insight: Olist generated approximately 16 million BRL in total revenue 
-- from all payment transactions between 2016-2018


-- =============================================================
-- Q4: Which product categories have generated the most revenue?
-- ==============================================================
SELECT TOP 10 p.product_category_name, 
    ROUND(SUM(oi.price+oi.freight_value),2) AS total_revenue,
    count(DISTINCT OI.order_id) AS category_orders
FROM olist_products_dataset p
JOIN olist_order_items_dataset oi
    ON p.product_id=oi.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;

-- Result:
-- beleza_saude (Beauty & Health)         1,441,248.07 BRL    8,836 orders
-- relogios_presentes (Watches & Gifts)   1,305,541.61 BRL    5,624 orders
-- cama_mesa_banho (Bed/Bath/Table)       1,241,681.72 BRL    9,417 orders
-- esporte_lazer (Sports & Leisure)       1,156,656.48 BRL    7,720 orders
-- informatica_acessorios (IT accessories) 1,059,272.40 BRL   6,689 orders

-- Insight: Beauty & Health is the top revenue-generating category at 1.44M BRL,
-- followed by Watches & Gifts at 1.3M BRL. Interestingly, Bed/Bath/Table has MORE orders (9,417) than Beauty & Health (8,836) 
-- but LOWER revenue,lower average order values in home goods vs beauty products.