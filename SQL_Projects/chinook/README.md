# 🎵 Chinook Music Store — Complete Data Analysis Project

## 📌 Project Overview
This project performs a comprehensive data analysis on the **Chinook Music Store** database,
a sample database that simulates a digital music store similar to iTunes.
The project covers database setup, data modeling, SQL concepts, business analysis,
and Python visualizations — making it a complete end-to-end data analyst portfolio project.

---

## 🛠️ Tools & Technologies Used
- **SQL Server (SSMS)** — Data exploration and querying
- **Python** — Data analysis and visualization
- **Pandas** — Data manipulation
- **Matplotlib & Seaborn** — Data visualization
- **pyodbc** — SQL Server to Python connection
- **Jupyter Notebook** — Interactive analysis environment
- **GitHub** — Version control and portfolio

---

## 🗂️ Project Structure

```
📁 Chinook_Project
   📄 README.md                        — Project overview (this file)
   📄 chinookDB.sql                    — Database creation script
   📄 chinook_data_model.md            — Data model description
   📄 analysis.sql                     — 12 Business analysis queries + insights
   📁 sql_concepts/                    — SQL concepts practice
       📄 ranking_analysis.sql         — Ranking functions (ROW_NUMBER, RANK)
       📄 sales_analysis.sql           — Sales focused queries
       📄 sql_functions.sql            — SQL functions practice
       📄 sql_views.sql                — Views practice
   🌐 chinook_visualizations.html      — Exported visual report
   📓 chinook_visualizations.ipynb     — Python visualizations notebook
```

---

## 📊 Business Analysis — 12 Questions

| # | Business Question | Key Finding |
|---|---|---|
| 1 | Employees reporting to IT Manager | Robert King & Laura Callahan |
| 2 | Customers with high purchase frequency | All customers with 7+ invoices identified |
| 3 | Top revenue generating customers | Helena Holý leads with USD 49.62 |
| 4 | Top selling artists | Iron Maiden leads with USD 68.31 |
| 5 | Most popular music genres | Rock dominates with 487 tracks sold |
| 6 | Top revenue generating genres | Rock leads with USD 482.13 |
| 7 | Revenue by country | USA leads with USD 523.06 |
| 8 | Top customer in each country | Helena Holý (Czech Republic) leads globally |
| 9 | Best selling track per genre | Dazed and Confused tops Rock genre |
| 10 | Monthly revenue trend | Revenue stagnant at USD 37.62 for 5 years |
| 11 | Sales rep performance | Jane Peacock leads with USD 833.04 |
| 12 | Top selling tracks overall | Four tracks tied at 4 sales each |

---

## 📈 Python Visualizations — 10 Charts

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

---

## 🎯 Key Business Insights

### 🎵 Music & Genre
- Rock dominates both genre popularity and revenue contributing nearly 47% of total tracks sold.
- Latin and Alternative & Punk follow as second and third most popular genres.
- Jazz remains a niche genre with the lowest revenue of USD 43.56.

### 🎸 Artists & Tracks
- Iron Maiden leads all artists with USD 68.31 in total sales.
- No single track dominates — four tracks share the highest purchase count of 4.
- Customer preferences are diverse with no single dominant track.

### 🌍 Geography & Markets
- USA is the largest market generating USD 523.06 in revenue.
- India appears in the top 10 markets showing emerging market potential.
- Helena Holý from Czech Republic is the highest spending individual customer.

### 💰 Sales & Revenue
- Monthly revenue has remained stagnant at approximately USD 37.62 for 5 years (2021-2025).
- Business urgently needs new customer acquisition strategies and marketing campaigns.
- Jane Peacock is the top performing sales representative with USD 833.04 in total revenue.

### ✅ Recommendations
- Launch targeted marketing campaigns for Rock genre lovers.
- Focus on USA and Canada markets for upselling opportunities.
- Introduce loyalty rewards for top customers like Helena Holý.
- Investigate reasons for flat revenue and build a growth strategy.
- Learn from Jane Peacock's approach to improve other sales reps performance.

---

## 🗃️ Database Tables Used
| Table | Description |
|---|---|
| Album | Music albums |
| Artist | Artist details |
| Customer | Customer information |
| Employee | Staff and sales reps |
| Genre | Music genres |
| Invoice | Purchase records |
| InvoiceLine | Line items per invoice |
| MediaType | File formats |
| Playlist | Curated playlists |
| PlaylistTrack | Tracks in playlists |
| Track | Individual songs |

---

## 👤 Author
**Asma Shaik**
Data Analyst | SQL | Python | Data Visualization
