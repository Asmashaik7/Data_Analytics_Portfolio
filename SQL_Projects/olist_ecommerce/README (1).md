# 🛒 Brazilian E-Commerce Analysis — Olist Dataset
### SQL Portfolio Project | SQL Server (T-SQL)

**Analyst:** Asma Shaik  
**GitHub:** [github.com/Asmashaik7](https://github.com/Asmashaik7)  
**Dataset:** [Brazilian E-Commerce by Olist — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

---

## 📌 Project Overview

This project performs end-to-end business analysis on a real-world Brazilian e-commerce dataset from Olist, covering 100,000+ orders placed between 2016 and 2018. Using SQL Server (T-SQL), I explored customer behavior, revenue trends, delivery performance, and product category insights across 3 levels of query complexity.

The goal was to answer real business questions a data analyst would face in an e-commerce company — and present findings with actionable recommendations.

---

## 🛠️ Tools & Skills Used

| Category | Details |
|---|---|
| **Database** | SQL Server (T-SQL) |
| **Query Types** | SELECT, WHERE, GROUP BY, ORDER BY, JOINS |
| **Functions** | COUNT, SUM, AVG, MIN, MAX, ROUND |
| **Intermediate** | Multi-table JOINs, CASE statements, DATE functions (DATEDIFF, MONTH, YEAR) |
| **Advanced** | CTEs (Common Table Expressions), Window Functions (RANK, DENSE_RANK, LAG, SUM OVER) |
| **Data Quality** | Cross-table reconciliation, NULL handling with ISNULL() |

---

## 📊 Dataset Structure

The Olist dataset contains 9 tables in total. This SQL analysis uses 5 core tables:

```
olist_customers_dataset       ← customer details and location
olist_orders_dataset          ← order status and timestamps
olist_order_items_dataset     ← product items per order
olist_order_payments_dataset  ← payment methods and values
olist_products_dataset        ← product categories
```

> 📌 Remaining 4 tables (sellers, reviews, geolocation, category translation) 
> will be incorporated in the upcoming Power BI dashboard extension.

---

## 🔍 Business Questions Answered

### ✅ Level 1 — Foundational Analysis (Q1–Q5)

| # | Business Question | Key Finding |
|---|---|---|
| Q1 | How many unique customers exist? | 96,096 unique customers (3,345 placed repeat orders) |
| Q2 | What is the order status distribution? | 97% successfully delivered, 0.6% cancellation rate |
| Q3 | What is the total platform revenue? | 16,008,872 BRL total revenue |
| Q4 | Which product categories generate most revenue? | Beauty & Health leads at 1,441,248 BRL |
| Q5 | Which states have the most customers? | São Paulo dominates with 42% of all customers |

---

### ✅ Level 2 — Intermediate Analysis (Q6–Q10)

| # | Business Question | Key Finding |
|---|---|---|
| Q6 | Who are the top 10 highest spending customers? | Top spender: 13,664 BRL — bulk B2B purchase of 8 landline phones |
| Q7 | What are the most popular payment methods? | Credit card dominates at 75% of transactions |
| Q8 | How are orders distributed by value segments? | Top 4% high-value customers contribute 25% of revenue |
| Q9 | What is the average delivery time? | Average 12 days; extreme range 0–210 days |
| Q10 | What are the monthly order trends? | Peak: March 2018 with 7,211 orders; strong growth 2016–2018 |

---

### ✅ Level 3 — Advanced Analysis with CTEs & Window Functions (Q11–Q15)

| # | Business Question | Key Finding |
|---|---|---|
| Q11 | Rank customers by total spending | Used CTE + RANK(); top customer spent 13,664 BRL |
| Q12 | Month-over-month order growth | Used LAG(); biggest spike November 2017 (+2,913 orders) — Black Friday effect |
| Q13 | Rank product categories by revenue | Used DENSE_RANK(); 74 categories; Beauty & Health #1 |
| Q14 | Running total of revenue | Used SUM() OVER(); crossed 5M BRL milestone in October 2017 |
| Q15 | Repeat vs one-time buyers | 97% one-time buyers vs only 3% repeat customers |

---

## 💡 Key Business Insights

**1. Customer Retention Crisis 🚨**
> 97% of customers made only one purchase. Olist urgently needs loyalty programs, discount campaigns, and retention strategies to convert one-time buyers into repeat customers.

**2. B2B Opportunity Detected 💼**
> The highest spending customer purchased 8 identical landline phones worth 13,664 BRL — clearly a B2B wholesale transaction. Olist could benefit from a dedicated B2B sales channel with volume discounts.

**3. Black Friday Impact 📈**
> November 2017 saw the biggest single-month order spike (+2,913 orders). Olist should heavily invest in Black Friday campaigns as this drives significant volume.

**4. Rio de Janeiro Delivery Problem 🚚**
> Despite being a major metro area, RJ had 214 delayed orders (34% of all delays) with a 1.8% delay rate vs São Paulo's 0.2%. An RJ distribution center could significantly improve delivery performance.

**5. Untapped Category Opportunity 👕**
> Children & Youth Fashion generated only 665 BRL total — not due to lack of demand but likely poor visibility and promotion on the platform. This represents a significant untapped revenue opportunity.

**6. Data Quality Issue Found 🔍**
> Cross-table revenue reconciliation revealed 775 orders (~0.8%) with payment records but no associated items, suggesting data pipeline issues. Payment table was used as source of truth for revenue analysis.

---

## 📈 Project Structure

```
Brazilian-Ecommerce-SQL-Analysis/
│
├── README.md                          ← You are here!
├── olist_analysis.sql                 ← Complete SQL queries (L1 + L2 + L3)
```

---

## 🎯 What This Project Demonstrates

- ✅ Writing complex multi-table JOINs across 4+ tables
- ✅ Business thinking — going beyond queries to find real insights
- ✅ Data quality investigation and reconciliation
- ✅ Advanced SQL — CTEs, Window Functions, DATE functions
- ✅ Independent data investigation and bonus analysis
- ✅ Clear documentation of findings and recommendations

---

## 🔜 Next Steps

- [ ] Build interactive Power BI dashboard on this dataset
- [ ] Add geographic delivery analysis visualizations
- [ ] Customer segmentation deep dive

---

*Dataset source: [Olist Brazilian E-Commerce — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)*
