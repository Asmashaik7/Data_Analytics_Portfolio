-- ================================================
-- OLIST E-COMMERCE BUSINESS ANALYSIS
-- Tool: SQL Server (T-SQL)
-- Dataset: Brazilian E-Commerce by Olist (Kaggle)
-- Analyst: Asma Shaik
-- GitHub: https://github.com/Asmashaik7

-- ================================================
-- LEVEL 1: FOUNDATIONAL QUERIES
-- ================================================
USE OlistEcommerce;

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


-- ========================================================
-- Q3: What is the total revenue generated on the platform?
-- ========================================================
SELECT 
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM olist_order_payments_dataset;

-- Result: 16,008,872.12 BRL
-- Insight: Olist generated approximately 16 million BRL in total revenue 
-- from all payment transactions between 2016-2018


-- ================================================
-- DATA QUALITY ANALYSIS & RECONCILIATION
-- ================================================
-- Purpose: Validate revenue consistency across multiple tables
-- and identify structural data inconsistencies
-- ================================================

-- Cross-validation: Total revenue from order items table
SELECT 
    ROUND(SUM(price + freight_value), 2) AS total_revenue_items
FROM olist_order_items_dataset;
--Result: 15843553.24 BRL

-- Count distinct orders in each table
SELECT COUNT(DISTINCT order_id) AS orders_in_payments
FROM olist_order_payments_dataset;
-- Result: 99440 orders

SELECT COUNT(DISTINCT order_id) AS orders_in_items
FROM olist_order_items_dataset;
--Result: 98666 orders

--Both difference is 774
-------------------------------
-- Find orders with payments but NO items (data quality issue)
SELECT COUNT(DISTINCT p.order_id) AS orphaned_payment_orders
FROM olist_order_payments_dataset p
LEFT JOIN olist_order_items_dataset oi
    ON p.order_id = oi.order_id
WHERE oi.order_id IS NULL;
-- Result: 775 orders

-- Find orders with items but NO payments (edge case)
SELECT COUNT(DISTINCT oi.order_id) AS orphaned_item_orders
FROM olist_order_items_dataset oi
LEFT JOIN olist_order_payments_dataset p
    ON oi.order_id = p.order_id
WHERE p.order_id IS NULL;
-- Result: 1 order

-- Edge case investigation: Sample order with items but no payment
SELECT order_status
FROM olist_orders_dataset
WHERE order_id = 'bfbd0f9bdef84302105ad712db648a6c';
-- Result: delivered

-- Insight: Discovered 775 orders (~0.8%) with payment records but no 
-- associated items, and 1 order (<0.001%) with items but no payment record.
-- This suggests potential data pipeline issues during order processing.
-- For revenue analysis, payment_value is used as the source of truth 
-- since it reflects actual transaction inflow.

-- =============================================================
-- Q4: Which product categories have generated the most revenue?
-- ==============================================================
SELECT TOP 10 p.product_category_name, 
    ROUND(SUM(oi.price+oi.freight_value),2) AS total_revenue,
    count(DISTINCT oi.order_id) AS category_orders
FROM olist_products_dataset p
JOIN olist_order_items_dataset oi
    ON p.product_id=oi.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;
--Distinct: We count how many unique orders contributed to that category.Simply count, It counts item rows, not orders.

-- Result:
-- beleza_saude (Beauty & Health)         1,441,248.07 BRL    8,836 orders
-- relogios_presentes (Watches & Gifts)   1,305,541.61 BRL    5,624 orders
-- cama_mesa_banho (Bed/Bath/Table)       1,241,681.72 BRL    9,417 orders
-- esporte_lazer (Sports & Leisure)       1,156,656.48 BRL    7,720 orders
-- informatica_acessorios (IT accessories) 1,059,272.40 BRL   6,689 orders

-- Insight: Beauty & Health is the top revenue-generating category at 1.44M BRL,
-- followed by Watches & Gifts at 1.3M BRL. Interestingly, Bed/Bath/Table has MORE orders (9,417) than Beauty & Health (8,836) 
-- but LOWER revenue,lower average order values in home goods vs beauty products.

-- ================================================
-- Q5: Which states have the highest number of customers?
-- ================================================
SELECT TOP 10 customer_state, 
    count(distinct customer_unique_id) as Unique_customers
FROM olist_customers_dataset
GROUP BY customer_state
ORDER BY Unique_customers DESC;

-- Result:
-- SP (São Paulo)        40,302
-- RJ (Rio de Janeiro)   12,384
-- MG (Minas Gerais)     11,259
-- RS (Rio Grande do Sul) 5,277
-- PR (Paraná)            4,882
-- SC (Santa Catarina)    3,534
-- BA (Bahia)             3,277
-- DF (Brasília)          2,075
-- ES (Espírito Santo)    1,964
-- GO (Goiás)             1,952

-- Insight: São Paulo dominates with 40,302 customers (~42% of total customer base),
-- more than 3x the second-place Rio de Janeiro. The top 3 states (SP, RJ, MG) 
-- account for approximately 66% of all customers, showing heavy geographic 
-- concentration in Brazil's southeast region.

-- ==================================================
-- LEVEL 2: INTERMEDIATE QUERIES
-- ==================================================

-- ====================================================
-- Q6: What are the top 10 highest spending customers?
-- ====================================================

SELECT TOP 10 c.customer_unique_id,
    c.customer_city,c.customer_state,
    round(sum(p.payment_value),2) as total_spent_by_customer,
    count(distinct o.order_id) as total_orders
from olist_customers_dataset c
join olist_orders_dataset o
on c.customer_id=o.customer_id
join olist_order_payments_dataset p
on o.order_id=p.order_id
group by customer_unique_id, c.customer_city,c.customer_state
ORDER BY total_spent_by_customer DESC;

-- Result:
-- Customer from Rio de Janeiro, RJ:    13,664.08 BRL (1 order)
-- Customer from Florianópolis, SC:      9,553.02 BRL (3 orders)
-- Customer from Araruama, RJ:           7,571.63 BRL (2 orders)
-- Customer from Vila Velha, ES:         7,274.88 BRL (1 order)
-- Customer from Campo Grande, MS:       6,929.31 BRL (1 order)
-- Customer from Vitória, ES:            6,922.21 BRL (1 order)
-- Customer from Marília, SP:            6,726.66 BRL (1 order)
-- Customer from Divinópolis, MG:        6,081.54 BRL (1 order)
-- Customer from Goiânia, GO:            4,809.44 BRL (1 order)
-- Customer from Mauá, SP:               4,764.34 BRL (1 order)

-- Insight: The highest spender placed one order worth 13,664 BRL (~$2,700 USD equivalent).
-- Interestingly, 8 out of 10 top spenders made only a single large purchase, suggesting
-- these are likely one-time high-value purchases (electronics, furniture, appliances)
-- rather than repeat loyal customers. Only 1 customer (Florianópolis) made multiple orders (3),
-- indicating potential for loyalty program targeting.

-- ================================================
-- DEEP DIVE ANALYSIS: What did the highest spender purchase?
-- ================================================
-- Purpose: Investigate purchase behavior of top customer to understand 
-- if high spending comes from multiple diverse items or bulk purchases

-- Step 1: Identify what product category they bought
SELECT 
    c.customer_unique_id,
    o.order_id,
    oi.order_item_id,
    p.product_category_name
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
WHERE c.customer_unique_id = '0a0a92112bd4c708ca5fde585afaa872'
ORDER BY oi.order_item_id;

-- Result: 8 items, all from telefonia_fixa (landline phones)

-- Step 2: Breakdown of individual item prices
SELECT 
    c.customer_unique_id,
    o.order_id,
    oi.order_item_id,
    p.product_category_name,
    oi.price,
    oi.freight_value,
    ROUND((oi.price + oi.freight_value), 2) AS item_total
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi
    ON o.order_id = oi.order_id
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
WHERE c.customer_unique_id = '0a0a92112bd4c708ca5fde585afaa872'
ORDER BY oi.order_item_id;

-- Result:
-- 8 identical items at 1,680 BRL each
-- Shipping: 28.01 BRL per item
-- Item total: 1,708.01 BRL each
-- Grand total: 8 × 1,708.01 = 13,664.08 BRL

-- Insight: The highest spender made a bulk purchase of 8 identical landline 
-- phones (telefonia_fixa category). This behavior indicates a B2B transaction
-- rather than typical consumer behavior — likely a small business, retail store,
-- or office purchasing equipment in bulk. This suggests Olist could benefit from
-- creating a dedicated B2B sales channel with volume discounts and business 
-- account features to capture more wholesale opportunities.