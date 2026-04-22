# 🗄️ SQL Projects Portfolio

## Overview
This folder contains SQL Server (T-SQL) portfolio projects built using relational databases to answer real-world business and analytical questions.
The focus is on query design, data exploration, insight generation, and Python visualizations using industry-standard SQL Server practices.

---

## 📁 Projects

| # | Project | Database | Complexity |
|---|---|---|---|
| 1 | Brazilian E-Commerce Analysis | Olist Dataset | Advanced |
| 2 | Chinook Music Store Analysis | Chinook Database | Intermediate |

---

## 📊 Project 1: Brazilian E-Commerce Analysis (Olist Dataset)

### Description
An end-to-end SQL analysis of a real-world Brazilian e-commerce dataset from Olist, covering 100,000+ orders placed between 2016 and 2018.
This project simulates real-world e-commerce analytics scenarios such as customer behavior analysis, revenue trend identification, delivery performance evaluation, and product category ranking — across 3 levels of query complexity.

### Key SQL Concepts Used
- SELECT, WHERE, ORDER BY, GROUP BY
- Multi-table JOINs (up to 4 tables)
- CASE statements (order value segmentation)
- DATE functions — DATEDIFF, MONTH, YEAR
- Aggregate functions — SUM, COUNT, AVG, MIN, MAX
- CTEs (Common Table Expressions)
- Window Functions — RANK(), DENSE_RANK(), LAG(), SUM() OVER()
- NULL handling with ISNULL()
- Cross-table data quality reconciliation

### Business Questions Answered

**Level 1 — Foundational:**
- How many unique customers exist in the database?
- What is the distribution of orders by status?
- What is the total revenue generated on the platform?
- Which product categories generate the most revenue?
- Which states have the highest number of customers?

**Level 2 — Intermediate:**
- Who are the top 10 highest spending customers?
- What are the most popular payment methods?
- How are orders distributed by value segments?
- What is the average delivery time for completed orders?
- What are the monthly order trends?

**Level 3 — Advanced (CTEs & Window Functions):**
- Rank customers by total spending using RANK()
- Analyze month-over-month order growth using LAG()
- Rank product categories by revenue using DENSE_RANK()
- Calculate running total of revenue using SUM() OVER()
- Identify repeat vs one-time buyers using chained CTEs

### Key Business Insights
- **Customer Retention Crisis:** 97% of customers made only one purchase — urgent need for loyalty programs
- **B2B Opportunity:** Top spender purchased 8 identical landline phones (13,664 BRL) — suggesting wholesale channel potential
- **Black Friday Impact:** November 2017 saw the biggest single-month spike (+2,913 orders)
- **Delivery Problem:** Rio de Janeiro had 214 delayed orders (34% of all delays) despite being a major metro area
- **Untapped Category:** Children & Youth Fashion generated only 665 BRL — likely due to poor platform visibility, not lack of demand
- **Data Quality Finding:** 775 orders (~0.8%) had payments but no associated items — detected via cross-table reconciliation

### Outcomes
- Completed 15 business questions across 3 complexity levels
- Identified critical customer retention gap (97% one-time buyers)
- Detected B2B purchasing patterns and wholesale opportunity
- Discovered data quality issues through independent cross-table investigation
- Triangulated dataset end date across 3 separate queries

📁 Project Folder: olist/

---

## 📊 Project 2: Chinook Music Store Analysis (SQL Server + Python)

### Description
A comprehensive end-to-end analysis of the Chinook music store database using SQL Server (T-SQL) and Python.
This project goes beyond SQL querying — combining business analysis, SQL concepts practice, data modeling,
and Python visualizations to deliver a complete data analyst portfolio project.

### Key SQL Concepts Used
- SELECT, WHERE, ORDER BY
- GROUP BY, HAVING
- INNER JOIN, LEFT JOIN
- Subqueries
- Window Functions — ROW_NUMBER(), RANK()
- Aggregate functions — SUM, COUNT, AVG
- Date and time functions (T-SQL) — YEAR(), MONTH()
- Views, Functions, Ranking Analysis

### Python & Visualization
- **pyodbc** — Connected Python directly to SQL Server
- **Pandas** — Loaded and manipulated data from DB
- **Matplotlib & Seaborn** — Built 10 business charts
- **Jupyter Notebook** — Interactive visual analysis report

### Project Structure
```
📁 chinook/
   📄 chinookDB.sql                    — Database creation script
   📄 chinook_data_model.md            — Data model description
   📄 analysis.sql                     — 12 Business analysis queries + insights
   📁 sql_concepts/                    — SQL concepts practice
       📄 ranking_analysis.sql         — Ranking functions
       📄 sales_analysis.sql           — Sales focused queries
       📄 sql_functions.sql            — SQL functions practice
       📄 sql_views.sql                — Views practice
   🌐 chinook_visualizations.html      — Exported visual report
   📓 chinook_visualizations.ipynb     — Python visualizations notebook
```

### Business Questions Answered
- Which artists, tracks, and genres generate the highest revenue?
- Who are the top customers based on total purchase value?
- Who is the top customer in each country?
- How does sales performance vary across regions?
- Which track is best selling within each genre?
- How does monthly revenue trend over time?
- Which sales representative generates the highest revenue?

### Python Visualizations — 10 Charts

| # | Chart | Type |
|---|---|---|
| 1 | Top 10 Selling Artists | Horizontal Bar |
| 2 | Most Popular Music Genres | Pie Chart |
| 3 | Top Revenue Generating Genres | Horizontal Bar |
| 4 | Revenue by Country | Horizontal Bar |
| 5 | Top Revenue Generating Customers | Horizontal Bar |
| 6 | Top Customer per Country | Horizontal Bar |
| 7 | Best Selling Track per Genre | Horizontal Bar |
| 8 | Monthly Revenue Trend | Line Chart |
| 9 | Sales Representative Performance | Vertical Bar |
| 10 | Top Selling Tracks Overall | Horizontal Bar |

### Key Business Insights
- **Rock Dominates:** Rock contributes nearly 47% of total tracks sold and leads revenue with USD 482.13
- **USA is Largest Market:** USA generates USD 523.06 in revenue — nearly double second place Canada
- **Stagnant Revenue:** Monthly revenue remained flat at USD 37.62 for 5 years (2021-2025) — urgent need for growth strategy
- **Top Customer:** Helena Holý (Czech Republic) is the highest spending customer at USD 49.62
- **Top Sales Rep:** Jane Peacock leads sales performance with USD 833.04 in total revenue
- **India Emerging:** India appears in top 10 markets showing strong emerging market potential

### Outcomes
- Completed 12 business analysis questions with detailed insights
- Built 10 Python visualizations directly connected to SQL Server
- Identified critical stagnant revenue trend over 5 years
- Delivered complete end-to-end project — SQL + Python + Visualizations

📁 Project Folder: chinook/

---

## 🧠 Skills Demonstrated
- Writing clean, optimized T-SQL queries
- Translating business problems into SQL logic
- Working with normalized relational database schemas
- Advanced query techniques — CTEs, Window Functions, CASE statements
- Data quality investigation and cross-table reconciliation
- Connecting SQL Server to Python using pyodbc
- Building data visualizations using Matplotlib and Seaborn
- Generating actionable business insights from structured data

---

## 🛠️ Tools & Environment
- SQL Server (T-SQL)
- SQL Server Management Studio (SSMS)
- Python (Pandas, Matplotlib, Seaborn)
- Jupyter Notebook
- VS Code
- GitHub

---

## 👤 Author
**Asma Shaik**
Data Analyst | SQL | Python | Data Visualization
