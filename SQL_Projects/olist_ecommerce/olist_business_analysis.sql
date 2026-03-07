-- ============================================================
-- OLIST E-COMMERCE BUSINESS ANALYSIS
-- Tool:     SQL Server (T-SQL)
-- Dataset:  Brazilian E-Commerce by Olist (Kaggle)
-- Analyst:  Asma Shaik
-- GitHub:   https://github.com/Asmashaik7
-- ============================================================

USE OlistEcommerce;

-- ============================================================
-- LEVEL 1: FOUNDATIONAL ANALYSIS
-- ============================================================

-- ============================================================
-- Q1: How many unique customers exist in the database?
-- ============================================================
SELECT 
    COUNT(DISTINCT customer_unique_id) AS total_unique_customers
FROM olist_customers_dataset;

-- Result: 96,096 unique customers
-- Insight: The customers table has 99,441 rows but only 96,096 unique 
-- customers — meaning ~3,345 customers placed repeat orders on Olist.

-- ============================================================
-- Q2: What is the distribution of orders by status?
-- ============================================================
SELECT 
    order_status,
    COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;

-- Result:
-- delivered      96,478
-- shipped         1,107
-- canceled          625
-- unavailable       609
-- invoiced          314
-- processing        301
-- created             5
-- approved            2

-- Insight: 97% of orders were successfully delivered with only a 0.6% 
-- cancellation rate, reflecting strong operational efficiency. 
-- 609 unavailable orders flag a potential stock management issue worth investigating.

-- ============================================================
-- Q3: What is the total revenue generated on the platform?
-- ============================================================
SELECT 
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM olist_order_payments_dataset;

-- Result: 16,008,872.12 BRL
-- Insight: Olist generated approximately 16 million BRL in total revenue
-- from all payment transactions between 2016-2018.

-- ============================================================
-- DATA QUALITY ANALYSIS & RECONCILIATION
-- Purpose: Validate revenue consistency across multiple tables
-- ============================================================

-- Cross-validation: Revenue from order items table
SELECT 
    ROUND(SUM(price + freight_value), 2) AS total_revenue_items
FROM olist_order_items_dataset;
-- Result: 15,843,553.24 BRL

-- Orders count in payments table
SELECT COUNT(DISTINCT order_id) AS orders_in_payments
FROM olist_order_payments_dataset;
-- Result: 99,440 orders

-- Orders count in items table
SELECT COUNT(DISTINCT order_id) AS orders_in_items
FROM olist_order_items_dataset;
-- Result: 98,666 orders

-- Orders with payments but NO items
SELECT COUNT(DISTINCT p.order_id) AS orphaned_payment_orders
FROM olist_order_payments_dataset p
LEFT JOIN olist_order_items_dataset oi
    ON p.order_id = oi.order_id
WHERE oi.order_id IS NULL;
-- Result: 775 orders

-- Orders with items but NO payments
SELECT COUNT(DISTINCT oi.order_id) AS orphaned_item_orders
FROM olist_order_items_dataset oi
LEFT JOIN olist_order_payments_dataset p
    ON oi.order_id = p.order_id
WHERE p.order_id IS NULL;
-- Result: 1 order

-- Insight: Cross-table reconciliation revealed 775 orders (~0.8%) with 
-- payment records but no associated items, and 1 delivered order with items 
-- but no payment — indicating data pipeline issues. Payment table was used 
-- as the source of truth for all revenue analysis.

-- ============================================================
-- Q4: Which product categories generate the most revenue?
-- ============================================================
SELECT TOP 10 
    p.product_category_name, 
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS category_orders
FROM olist_products_dataset p
JOIN olist_order_items_dataset oi
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;

-- Result (Top 5):
-- beleza_saude (Beauty & Health)          1,441,248.07 BRL   8,836 orders
-- relogios_presentes (Watches & Gifts)    1,305,541.61 BRL   5,624 orders
-- cama_mesa_banho (Bed/Bath/Table)        1,241,681.72 BRL   9,417 orders
-- esporte_lazer (Sports & Leisure)        1,156,656.48 BRL   7,720 orders
-- informatica_acessorios (IT Accessories) 1,059,272.40 BRL   6,689 orders

-- Insight: Beauty & Health leads at 1.44M BRL despite fewer orders than 
-- Bed/Bath/Table (8,836 vs 9,417), indicating higher average order values 
-- in beauty products vs home goods.

-- ============================================================
-- Q5: Which states have the highest number of customers?
-- ============================================================
SELECT TOP 10 
    customer_state, 
    COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM olist_customers_dataset
GROUP BY customer_state
ORDER BY unique_customers DESC;

-- Result:
-- SP (São Paulo)          40,302
-- RJ (Rio de Janeiro)     12,384
-- MG (Minas Gerais)       11,259
-- RS (Rio Grande do Sul)   5,277
-- PR (Paraná)              4,882
-- SC (Santa Catarina)      3,534
-- BA (Bahia)               3,277
-- DF (Brasília)            2,075
-- ES (Espírito Santo)      1,964
-- GO (Goiás)               1,952

-- Insight: São Paulo dominates with 40,302 customers (~42% of total base),
-- more than 3x the second-place Rio de Janeiro. The top 3 states (SP, RJ, MG) 
-- account for ~66% of all customers, showing heavy geographic concentration 
-- in Brazil's southeast region.

-- ============================================================
-- LEVEL 2: INTERMEDIATE ANALYSIS
-- ============================================================

-- ============================================================
-- Q6: Who are the top 10 highest spending customers?
-- ============================================================
SELECT TOP 10 
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    ROUND(SUM(p.payment_value), 2) AS total_spent,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM olist_customers_dataset c
JOIN olist_orders_dataset o
    ON c.customer_id = o.customer_id
JOIN olist_order_payments_dataset p
    ON o.order_id = p.order_id
GROUP BY c.customer_unique_id, c.customer_city, c.customer_state
ORDER BY total_spent DESC;

-- Result:
-- Rio de Janeiro, RJ:    13,664.08 BRL (1 order)
-- Florianópolis, SC:      9,553.02 BRL (3 orders)
-- Araruama, RJ:           7,571.63 BRL (2 orders)
-- Vila Velha, ES:         7,274.88 BRL (1 order)
-- Campo Grande, MS:       6,929.31 BRL (1 order)

-- Insight: 8 out of 10 top spenders made only a single large purchase, 
-- suggesting one-time high-value transactions rather than loyal repeat customers.

-- ============================================================
-- BONUS: Deep Dive — What did the highest spender purchase?
-- ============================================================

-- Step 1: Identify product category
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

-- Step 2: Individual item price breakdown
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

-- Result: 8 identical items at 1,680 BRL each | 28.01 BRL shipping each
-- Grand total: 8 × 1,708.01 = 13,664.08 BRL

-- Insight: The highest spender made a bulk purchase of 8 identical landline 
-- phones — clearly a B2B wholesale transaction. Olist could benefit from a 
-- dedicated B2B sales channel with volume discounts to capture more such opportunities.

-- ============================================================
-- Q7: What are the most popular payment methods?
-- ============================================================
SELECT 
    payment_type,
    ROUND(SUM(payment_value), 2) AS total_payments,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(payment_value), 2) AS avg_order_value
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_orders DESC;

-- Result:
-- credit_card:  12,542,084 BRL  |  76,505 orders  |  163.32 BRL avg
-- boleto:        2,869,361 BRL  |  19,784 orders  |  145.03 BRL avg
-- voucher:         379,437 BRL  |   3,866 orders  |   65.70 BRL avg
-- debit_card:      217,990 BRL  |   1,528 orders  |  142.57 BRL avg
-- not_defined:           0 BRL  |       3 orders  |    0.00 BRL avg

-- Insight: Credit cards dominate with 75% of transactions and 78% of revenue.
-- Boleto serves 19% of orders for customers without credit cards. 
-- Debit card usage is low (1.5%), reflecting Brazilian preference for 
-- credit card installment options.

-- ============================================================
-- Q8: How are orders distributed by value segments?
-- ============================================================
SELECT
    CASE
        WHEN payment_value < 100 THEN 'Low Value'
        WHEN payment_value BETWEEN 100 AND 500 THEN 'Medium Value'
        ELSE 'High Value'
    END AS order_value_segment,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(payment_value), 2) AS total_revenue,
    ROUND(AVG(payment_value), 2) AS avg_order_value
FROM olist_order_payments_dataset
GROUP BY 
    CASE
        WHEN payment_value < 100 THEN 'Low Value'
        WHEN payment_value BETWEEN 100 AND 500 THEN 'Medium Value'
        ELSE 'High Value'
    END
ORDER BY total_orders DESC;

-- Result:
-- Low Value:    48,493 orders | 2,941,315 BRL |  56.72 BRL avg
-- Medium Value: 47,539 orders | 9,125,335 BRL | 191.01 BRL avg
-- High Value:    4,239 orders | 3,942,223 BRL | 926.27 BRL avg

-- Insight: Just 4% of high-value customers contribute 25% of total revenue 
-- (926 BRL avg). The mid-value segment drives 57% of revenue. Opportunities 
-- exist for VIP programs targeting high-value customers and upselling 
-- strategies to move low-value buyers to the mid-value tier.

-- ============================================================
-- Q9: What is the average delivery time for completed orders?
-- ============================================================
SELECT 
    COUNT(DISTINCT order_id) AS total_orders,
    AVG(DATEDIFF(day, order_purchase_timestamp, order_delivered_customer_date)) AS avg_delivery_days,
    MIN(DATEDIFF(day, order_purchase_timestamp, order_delivered_customer_date)) AS min_delivery_days,
    MAX(DATEDIFF(day, order_purchase_timestamp, order_delivered_customer_date)) AS max_delivery_days,
    order_status
FROM olist_orders_dataset
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
GROUP BY order_status;

-- Result:
-- Total Orders: 96,470
-- Average:  12 days
-- Fastest:   0 days (same day delivery!)
-- Slowest:  210 days (7 months!)

-- Insight: Olist maintains a reasonable 12-day average for Brazil's vast 
-- geography. However, the extreme range (0-210 days) reveals significant 
-- operational variance impacting customer satisfaction.

-- Find the order that took 210 days
SELECT 
    o.order_id,
    c.customer_state,
    c.customer_city,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date) AS delivery_days
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date) = 210;
-- Result: Montanha, ES — remote rural town (~18,000 population)

-- ============================================================
-- BONUS: Delayed Delivery Analysis by State (>50 days)
-- ============================================================
SELECT 
    c.customer_state,
    COUNT(o.order_id) AS delayed_orders,
    ROUND(AVG(DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date)), 2) AS avg_delivery_days
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND DATEDIFF(day, o.order_purchase_timestamp, o.order_delivered_customer_date) > 50
GROUP BY c.customer_state
ORDER BY delayed_orders DESC;

-- Result (Top 5):
-- RJ (Rio de Janeiro):  214 delayed orders | 64 days avg
-- SP (São Paulo):        88 delayed orders | 75 days avg
-- BA (Bahia):            43 delayed orders | 80 days avg
-- CE (Ceará):            34 delayed orders | 73 days avg
-- MG (Minas Gerais):     34 delayed orders | 64 days avg
-- Notable: AP (Amapá) 1 order | 187 days (remote Amazon region)

-- Key Findings:
-- RJ has 214 delayed orders (34% of all delays) despite being a major metro 
-- area — 1.8% delay rate vs SP's 0.2%, suggesting RJ-specific logistics issues.
-- Northern/Amazon states show extreme delays (69-187 days) due to geographic isolation.

-- Business Recommendations:
-- • Audit RJ delivery operations urgently — 214 delays unacceptable for major city
-- • Display realistic delivery timelines at checkout for remote regions
-- • Consider opening RJ distribution center to reduce delays
-- • Implement delivery time prediction model based on customer location

-- ============================================================
-- Q10: What are the monthly order trends?
-- ============================================================
SELECT  
    COUNT(DISTINCT order_id) AS total_orders,  
    MONTH(order_purchase_timestamp) AS month, 
    YEAR(order_purchase_timestamp) AS year 
FROM olist_orders_dataset 
GROUP BY MONTH(order_purchase_timestamp), YEAR(order_purchase_timestamp)  
ORDER BY total_orders DESC;

-- Result (Top months):
-- March 2018:    7,211 orders (peak!)
-- April 2018:    6,939 orders
-- May 2018:      6,873 orders
-- Sep 2016:          4 orders (dataset start)

-- Insight: Olist showed strong consistent growth from 2016 to 2018, peaking 
-- in March 2018 with 7,211 orders. Sep/Oct 2018 show only 16 and 4 orders 
-- respectively — indicating incomplete data rather than actual decline.

-- ============================================================
-- LEVEL 3: ADVANCED ANALYSIS — CTEs & WINDOW FUNCTIONS
-- ============================================================

-- ============================================================
-- Q11: Rank customers by total spending
-- ============================================================
WITH customer_spent AS
(
    SELECT 
        c.customer_unique_id,
        ROUND(SUM(op.payment_value), 2) AS total_spent
    FROM olist_customers_dataset c
    JOIN olist_orders_dataset o
        ON c.customer_id = o.customer_id
    JOIN olist_order_payments_dataset op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
)
SELECT 
    customer_unique_id,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS rank_by_spent
FROM customer_spent;

-- Result (Top 5):
-- Rank 1: 0a0a92112bd4c708ca5fde585afaa872 | 13,664.08 BRL
-- Rank 2: 46450c74a0d8c5ca9395da1daac6c120 |  9,553.02 BRL
-- Rank 3: da122df9eeddfedc1dc1f5349a1a690c |  7,571.63 BRL
-- Rank 4: 763c8b1c9c68a0229c42c9fc6f662b93 |  7,274.88 BRL
-- Rank 5: dc4802a71eae9be1dd28f5d788ceb526 |  6,929.31 BRL

-- Insight: Using CTE and RANK(), top customers were ranked by total spending. 
-- The highest spending customer spent 13,664.08 BRL in a single bulk purchase 
-- of 8 landline phones — consistent with B2B transaction behavior identified 
-- in Q6. Top 5 customers all spent above 6,929 BRL.

-- ============================================================
-- Q12: Month-over-Month Order Growth
-- ============================================================
WITH monthly_sales AS
(
    SELECT 
        COUNT(DISTINCT order_id) AS total_orders,
        MONTH(order_purchase_timestamp) AS month,
        YEAR(order_purchase_timestamp) AS year
    FROM olist_orders_dataset
    GROUP BY MONTH(order_purchase_timestamp), 
             YEAR(order_purchase_timestamp)
)
SELECT
    year,
    month,
    total_orders,
    LAG(total_orders) OVER (ORDER BY year, month) AS previous_month_orders,
    total_orders - LAG(total_orders) OVER (ORDER BY year, month) AS month_growth
FROM monthly_sales;

-- Result (Key Highlights):
-- Nov 2017: 7,544 orders | Growth: +2,913 (biggest spike — Black Friday!)
-- Sep 2018:    16 orders | Growth: -6,496 (incomplete data, not real decline)
-- First row (Sep 2016): NULL — no prior month data exists

-- Insight: Month-over-month analysis using LAG() revealed strong growth 
-- throughout 2017, peaking in November 2017 with +2,913 orders — driven by 
-- Black Friday. Consistent growth from 2016 to mid-2018. Negative growth in 
-- Sep/Oct 2018 represents incomplete data rather than actual decline.

-- ============================================================
-- Q13: Rank product categories by revenue
-- ============================================================
WITH category_revenue_ranking AS
(
    SELECT 
        ISNULL(p.product_category_name, 'Uncategorized') AS category_name,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
    FROM olist_order_items_dataset oi
    JOIN olist_products_dataset p
        ON oi.product_id = p.product_id
    GROUP BY p.product_category_name
)
SELECT 
    category_name,
    total_revenue,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS category_rank
FROM category_revenue_ranking;

-- Result (Key highlights):
-- Rank  1: beleza_saude (Beauty & Health)        | 1,441,248.07 BRL
-- Rank 20: Uncategorized                         |   207,705.09 BRL
-- Rank 72: cds_dvds_musicais                     |       954.99 BRL
-- Rank 73: fashion_roupa_infanto_juvenil          |       665.36 BRL
-- Rank 74: seguros_e_servicos (Insurance)         |       324.51 BRL

-- Insight: 74 categories ranked using DENSE_RANK(). Beauty & Health leads 
-- at 1.44M BRL. Bottom 3 categories generated under 1,000 BRL total. 
-- Notably, Children & Youth Fashion (665 BRL) represents an untapped 
-- opportunity — low revenue likely reflects poor platform visibility rather 
-- than lack of demand. Insurance low revenue is expected as consumers 
-- typically purchase directly from providers. NULL categories (Rank 20, 
-- 207,705 BRL) highlight a data quality issue worth resolving.

-- ============================================================
-- Q14: Running Total of Revenue
-- ============================================================
WITH running_total AS
(
    SELECT 
        MONTH(o.order_purchase_timestamp) AS month,
        YEAR(o.order_purchase_timestamp) AS year,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
    FROM olist_order_items_dataset oi
    JOIN olist_orders_dataset o
        ON oi.order_id = o.order_id
    GROUP BY MONTH(o.order_purchase_timestamp), 
             YEAR(o.order_purchase_timestamp)
)
SELECT 
    year,
    month,
    total_revenue,
    SUM(total_revenue) OVER (ORDER BY year, month) AS running_total_revenue
FROM running_total;

-- Result (Key Highlights):
-- First month: Sep 2016  |       354.75 BRL | Running:      354.75 BRL
-- 5M milestone: Oct 2017 |   769,312.37 BRL | Running:  5,157,164.64 BRL
-- Peak month:   Nov 2017 | 1,179,143.77 BRL | Running:  6,336,308.41 BRL
-- Final month:  Sep 2018 |       166.46 BRL | Running: 15,843,553.24 BRL

-- Insight: Olist accumulated 15,843,553.24 BRL by mid-2018, crossing the 
-- 5M BRL milestone in October 2017. Monthly revenue grew from 354.75 BRL 
-- in Sep 2016 to over 1,000,000 BRL per month in 2018.
-- Data Quality Note: Sep 2018 shows only 166.46 BRL vs 1M+ in prior months,
-- confirming dataset ends around August 2018 — consistent across Q10, Q12, 
-- and Q14 (triangulation of incomplete data finding).

-- ============================================================
-- Q15: Repeat vs One-time Buyers
-- ============================================================
WITH orders_per_customer AS
(
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT oi.order_id) AS orders_count
    FROM olist_customers_dataset c
    JOIN olist_orders_dataset oi
        ON c.customer_id = oi.customer_id
    WHERE oi.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
customer_segment AS
(
    SELECT
        customer_unique_id,
        orders_count,
        CASE
            WHEN orders_count = 1 THEN 'One-time Customer'
            ELSE 'Repeat Customer'
        END AS customer_type
    FROM orders_per_customer
)
SELECT 
    customer_type,
    COUNT(customer_unique_id) AS total_customers
FROM customer_segment
GROUP BY customer_type
ORDER BY total_customers DESC;

-- Result:
-- One-time Customers: 90,557 (97%)
-- Repeat Customers:    2,801  (3%)

-- Insight: Out of 93,358 delivered customers, 97% made only one purchase 
-- while just 3% are repeat buyers. This critical retention gap suggests 
-- Olist should urgently implement loyalty programs, personalized discounts, 
-- and re-engagement campaigns to convert one-time buyers into loyal customers.

-- ============================================================
-- END OF ANALYSIS
-- Analyst: Asma Shaik | github.com/Asmashaik7
-- ============================================================
