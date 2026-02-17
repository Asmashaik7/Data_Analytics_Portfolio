# 🛒 Olist E-Commerce Business Intelligence Analysis

**Tool:** SQL Server (T-SQL)
**Dataset:** [Brazilian E-Commerce Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — Kaggle
**Analyst:** Asma Shaik
**GitHub:** [Asmashaik7](https://github.com/Asmashaik7)

---
> 🚧 **Status: Work in Progress** — Analysis being built progressively.
> Last updated: February 2026
---

## 📌 Project Overview

This project analyzes real-world e-commerce data from **Olist** — Brazil's largest department store marketplace. Using SQL Server, I explored customer behavior, revenue trends, order patterns, and product performance to answer key business questions that a data analyst would face in a real job.

The analysis is structured in **3 progressive levels** — from foundational queries to advanced window functions and CTEs — demonstrating growth in SQL complexity and business thinking.

---

## 🗂️ Dataset Description

The dataset contains transactional data from **2016 to 2018** across multiple tables:

| Table | Description | Rows |
|-------|-------------|------|
| olist_customers_dataset | Customer information and location | 99,441 |
| olist_orders_dataset | Order status and timestamps | 99,441 |
| olist_order_items_dataset | Products per order with price and freight | 112,650 |
| olist_products_dataset | Product catalog with categories | 32,951 |
| olist_order_payments_dataset | Payment methods and values | 103,886 |

> **Data Quality Note:** The products table contains a known column name typo — `product_lenght_cm` instead of `product_length_cm`. This is preserved as-is from the original Olist dataset.

> **Customer ID Note:** Olist uses two customer identifiers — `customer_id` at order level and `customer_unique_id` at person level. All unique customer analysis uses `customer_unique_id` for accuracy.

---

## ❓ Business Questions Answered

### 🔹 Level 1 — Foundational Analysis
- How many unique customers does Olist have?
- What is the distribution of orders by status?
- What is the total revenue generated on the platform?
- Which product categories have the most listings?
- Which states have the highest number of customers?

### 🔸 Level 2 — Intermediate Analysis
- Which product categories generate the most revenue?
- Who are the top 10 highest spending customers?
- What payment methods do customers prefer?
- How are orders segmented by order value (Low / Medium / High)?
- What is the average delivery time by order status?
- Which months had the highest number of orders?

### 🔺 Level 3 — Advanced Analysis
- What is the month-over-month revenue trend?
- How are customers ranked by total spend using Window Functions?
- What is the running total of revenue over time?
- Which product categories rank highest by revenue using DENSE_RANK?
- What percentage of total revenue does each payment method contribute?

---

## 📁 Repository Structure

```
olist_ecommerce/
│
├── README.md                              ← You are here
├── 01_database_setup_and_verification.sql ← Setup, exploration & data quality checks
├── 02_olist_business_analysis.sql         ← Main analysis — Level 1, 2 & 3 queries
└── insights/
    └── key_insights.md                    ← Top business findings in plain English
```

---

## 🔑 Key Insights

- **97% of all orders were successfully delivered** — indicating strong operational efficiency on the Olist platform
- **96,096 unique customers** placed orders, with ~3,345 customers placing repeat orders
- **609 orders marked as unavailable** — suggesting a stock management issue worth investigating
- **Multiple payment methods** per order are common — payments table has more rows than orders table due to split payments
- Detailed insights available in [`insights/key_insights.md`](insights/key_insights.md)

---

## 🛠️ Tools & Technologies
```
| Category | Details |
|----------|---------|
| Database | SQL Server (T-SQL) |
| IDE | SQL Server Management Studio (SSMS) |
| Dataset Source | Kaggle — Olist Brazilian E-Commerce |
| Version Control | Git & GitHub |
```
---

## 🚀 How to Use This Project

1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
2. Create a database called `OlistEcommerce` in SQL Server
3. Import the 5 CSV files using SSMS Import Flat File wizard
4. Run `01_database_setup_and_verification.sql` to verify your setup
5. Run `02_olist_business_analysis.sql` to explore all business queries

---

## 👩‍💻 About Me

I am an aspiring Data Analyst transitioning into tech after a career break, with a background in SEO. I am building hands-on projects in SQL, Python, and Power BI to demonstrate real-world analytical skills.

> *"You're not late. You're evolving — and every skill you build rewrites your comeback story."*

�LinkedIn: [shaik-asma-nov11](https://www.linkedin.com/in/shaik-asma-nov11/)
📂 Portfolio: [Data Analytics Portfolio](https://github.com/Asmashaik7/Data_Analytics_Portfolio)
