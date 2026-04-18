-- SECTION 1: Find employees who report to the IT Manager

USE Chinook;

SELECT FirstName+' '+LastName as Name,
       ReportsTo
FROM Employee
WHERE ReportsTo = (
    SELECT EmployeeId
    FROM Employee
    WHERE Title = 'IT Manager'
);

/*Result
Name	ReportsTo
Robert King	6
Laura Callahan	6 */

-- Insight
-- Two employees (Robert King and Laura Callahan) report directly to the IT Manager.


/* =========================================================
   SECTION 2: Customers with High Purchase Frequency
   Business Question:
   Which customers have placed more than 6 invoices?
   ========================================================= */

-- Step 1: Identify CustomerIds with more than 6 invoices
-- This groups invoices by customer and filters frequent buyers

SELECT CustomerId,
    COUNT(InvoiceId) AS Total_Invoices
FROM Invoice
GROUP BY CustomerId
HAVING COUNT(InvoiceId) > 6;

/*Results:
CustomerId	Total_Invoices
1	7
2	7
..
57	7
58	7
*/

-- Insight:
-- These customers have made more than 6 purchases, indicating high engagement and potential candidates for loyalty programs or targeted promotions.

/* =========================================================
   SECTION 3: Top Revenue Generating Customers
   Business Question:
   Which customers generate the highest revenue?
   ========================================================= */

SELECT c.CustomerId,
       c.FirstName+' '+c.LastName as Name,
       SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i
ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

/*Result:
CustomerId	Name	TotalSpent
6	Helena Holý	49.62
26	Richard Cunningham	47.62
57	Luis Rojas	46.62
....
38	Niklas Schröder	37.62
47	Lucas Mancini	37.62
59	Puja Srivastava	36.64 */


-- Insight:
-- Helena Holý is the highest spending customer (49.62).
-- Puja Srivastava is the lowest spending customer (36.64).
-- Most customers spend between 37–40, showing balanced revenue distribution.

/* =========================================================
   SECTION 4: Top Selling Artists
   Business Question:
   Which artists generate the highest sales revenue?
   ========================================================= */

SELECT Top 10 
       ar.ArtistId,
       ar.Name AS Artist,
       SUM(il.UnitPrice * il.Quantity) AS TotalSales
FROM InvoiceLine il
JOIN Track t 
ON il.TrackId = t.TrackId
JOIN Album al 
ON t.AlbumId = al.AlbumId
JOIN Artist ar 
ON al.ArtistId = ar.ArtistId
GROUP BY ar.ArtistId, ar.Name
ORDER BY TotalSales DESC;

/*Result:
ArtistId	Artist	TotalSales
90	Iron Maiden	68.31
50	Metallica	61.38
150	U2	51.48
22	Led Zeppelin	44.55
149	Lost	39.80
113	Os Paralamas Do Sucesso	30.69
124	R.E.M.	30.69
82	Faith No More	25.74
118	Pearl Jam	23.76
58	Deep Purple	23.76

-- Business Insight:
-- A small number of artists generate a large share of total revenue.
-- Iron Maiden leads overall sales, suggesting strong customer demand for their tracks in the Chinook store.

 =========================================================
SECTION 5: Most Popular Music Genres

Business Question:
Which music genres are purchased the most by customers in the Chinook store?
 =========================================================*/
 
 SELECT TOP 5 
       g.GenreId,
       g.Name AS Genre,
       SUM(il.Quantity) AS TracksSold
FROM Genre g
JOIN Track t
     ON g.GenreId = t.GenreId
JOIN InvoiceLine il
     ON t.TrackId = il.TrackId
GROUP BY g.GenreId, g.Name
ORDER BY TracksSold DESC;

/*Result:
GenreId	Genre	TracksSold
1	Rock	487
7	Latin	207
4	Alternative & Punk	158
3	Metal	146
2	Jazz	44
*/

-- Business Insight:
-- Rock music strongly dominates customer purchases in the Chinook store,indicating that rock artists contribute heavily to overall demand.

/* =========================================================
   SECTION 6: Top Revenue-Generating Music Genres

   Business Question:
   Which music genres generate the highest total revenue 
   from track purchases in the Chinook store?
   ========================================================= */

select top 5 g.genreid,g.Name,
 sum(il.Unitprice*il.quantity) as Total_revenue
 from genre g
 join Track t
 on g.genreid=t.genreid
 join InvoiceLine il
 on t.TrackId=il.trackid
 group by g.genreid,g.Name
 order by Total_revenue desc;

/*Result:
genreid	Name	Total_revenue
1	Rock	482.13
7	Latin	204.93
4	Alternative & Punk	156.42
3	Metal	144.54
2	Jazz	43.56
*/

-- Business Insight:
-- Rock dominates genre revenue in the Chinook store, indicating strong customer demand for rock-related tracks. 
-- Latin and Alternative & Punk also contribute significantly but remain far behind Rock in total sales.

/* =========================================================
   SECTION 7: Revenue by Country

   Business Question:
   Which countries generate the highest total revenue 
   for the Chinook music store?
   ========================================================= */
   select top 10 BillingCountry,
   sum(total) as total_revenue_by_country
   from Invoice
   group by BillingCountry
   order by total_revenue_by_country desc;

/*Result:
BillingCountry	total_revenue_by_country
USA	523.06
Canada	303.96
France	195.10
Brazil	190.10
Germany	156.48
United Kingdom	112.86
Czech Republic	90.24
Portugal	77.24
India	75.26
Chile	46.62
*/

-- Insight:
-- The United States generates the highest revenue (523.06) for the Chinook store,making it the largest market.
-- Canada and France follow as the next strongest contributors.
-- While countries like India and Chile generate comparatively lower revenue.

/* =========================================================
   SECTION 8: Top Customer in Each Country

   Business Question:
   Which customers generate the highest revenue 
   within each country in the Chinook store?
   ========================================================= */
   use chinook;

   select * 
   from
   (
   select c.customerid,c.FirstName +' '+c.LastName as Name,
   i.Billingcountry,
   sum(i.total) as Total_revenue_country,
   row_number() over(partition by Billingcountry order by sum(i.total) desc )as rn
   from Customer c
   join invoice i
   on c.CustomerId=i.CustomerID
   group by c.customerid,c.FirstName,c.LastName,i.Billingcountry
   ) t
   where rn=1;

/*Result:
customerid	Name	Billingcountry	Total_revenue_country	rn
56	Diego Gutiérrez	Argentina	37.62	1
55	Mark Taylor	Australia	37.62	1
...
6	Helena Holý	Czech Republic	49.62	1
9	Kara Nielsen	Denmark	37.62	1
...
52	Emma Jones	United Kingdom	37.62	1
26	Richard Cunningham	USA	47.62	1
*/

-- Note:
-- ROW_NUMBER() is used to return one top customer per country.
-- RANK() can be used instead if ties should be included.
-- Full result includes top customers for all countries.

-- Business Insight:
-- Each country has a top-performing customer.
-- Top customers across countries contribute similar levels of revenue, with slight variation.
-- Helena Holý in the Czech Republic stands out as the highest-spending individual customer in the dataset.

/* =========================================================
   SECTION 9: Best Selling Track per Genre

   Business Question:
   Which track is the most purchased within each genre
   in the Chinook music store?
   ========================================================= */

SELECT GenreName,TrackName,TrackSold
FROM (
    SELECT g.Name as GenreName,
            t.Name as TrackName,
           sum(il.quantity) as TrackSold,
           ROW_NUMBER() OVER (PARTITION BY g.Name ORDER BY sum(il.quantity) desc) AS rn
    FROM genre g
    join track t
    on g.genreid=t.genreid
    join invoiceline il
    on t.trackid=il.trackid
    group by g.name,t.name
    ) t
WHERE rn = 1;

/*
Result:
GenreName	TrackName	TrackSold
Alternative	All Night Thing	1
Alternative & Punk	Untitled	2
...
Rock	Dazed and Confused	4
...
World	Já Foi	1
*/

-- Insight:
-- This analysis identifies the most purchased track within each genre.
-- "Dazed and Confused" is the top-selling track in the Rock genre with the highest number of purchases (4).

-- Business Insight:
-- The best-selling track varies across genres, with relatively low purchase counts per track. This indicates a wide distribution of
-- customer preferences rather than dominance by a few tracks.

/* =========================================================
   SECTION 10: Monthly Revenue Trend

   Business Question:
   How does revenue change over time on a monthly basis
   in the Chinook music store?
   ========================================================= */

   select year(invoicedate) as Year,
            month(invoicedate) as Month,
            sum(total) as Total
from INVOICE
group by Year(invoicedate),Month(invoicedate)
order by Year,Month;

/*
Result:
Year	Month	Total
2021	1	35.64
2021	2	37.62
...
2025	11	49.62
2025	12	38.62
*/

-- Insight:
-- Monthly revenue in the Chinook store remains relatively stable over time, with most months generating similar revenue (~37.62).
-- However, occasional spikes in certain months indicate periods of higher sales activity.
-- While a few months show lower revenue, suggesting variability in customer purchases.

/* =========================================================
   SECTION 11: Sales Representative Performance

   Business Question:
   Which sales representatives generate the highest revenue for the Chinook music store?
    ========================================================= */
   use chinook;
   
   select e.employeeId, e.Firstname +' '+e.lastname as Sales_Rep_Name, sum(i.total) as Total_Revenue
   from Employee e
   join Customer c
   on e.EmployeeId=c.SupportRepId
   join invoice i
   on c.CustomerID=i.CustomerID
   group by e.employeeId, e.Firstname,e.lastname
   order by Total_Revenue desc;

   /* Result:
   employeeId	Sales_Rep_Name	Total_Revenue
    3	Jane Peacock	833.04
    4	Margaret Park	775.40
    5	Steve Johnson	720.16
    */

   -- Insight:
    -- Jane Peacock leads in revenue generation among sales representatives,indicating strong customer performance,
    -- followed by Margaret Park and Steve Johnson.

/* =========================================================
   SECTION 12: Top Selling Tracks Overall

   Business Question:
   Which tracks are purchased the most overall in the Chinook music store?
   ========================================================= */

   SELECT top 10 t.Name AS TrackName,
       SUM(il.Quantity) AS TotalSold
FROM Track t
JOIN InvoiceLine il
    ON t.TrackId = il.TrackId
GROUP BY t.Name
ORDER BY TotalSold DESC;

/* Result:
TrackName	TotalSold
Dazed and Confused	4
Eruption	4
The Number Of The Beast	4
Untitled	4
Sure Know Something	3
Animal	2
As Rosas Não Falam (Beth Carvalho)	2
Battery	2
Believe	2
Better Than You	2
*/

-- Insight:
-- Multiple tracks share the highest purchase count (4), indicating no single  dominant track.
-- Customer purchases are distributed across several popular songs, suggesting diverse listening preferences.

-- Note:
-- Multiple tracks have equal top sales, which could also be analyzed using
-- RANK() instead of TOP to include all tied results.

SELECT TrackName, TotalSold
FROM (
    SELECT t.Name AS TrackName,
           SUM(il.Quantity) AS TotalSold,
           RANK() OVER (
               ORDER BY SUM(il.Quantity) DESC
           ) AS rnk
    FROM Track t
    JOIN InvoiceLine il
        ON t.TrackId = il.TrackId
    GROUP BY t.Name
) t
WHERE rnk = 1;

/*Result:
TrackName	TotalSold
Dazed and Confused	4
Eruption	4
The Number Of The Beast	4
Untitled	4
*/

-- Insight:
-- Multiple tracks share the highest purchase count, indicating no single dominant track.
-- Customer preferences are distributed across several tracks rather than concentrated on one.
-- Using RANK() ensures all top-performing tracks are included when ties occur.

/* 

---------------------------------------------------------
-- FINAL SUMMARY
---------------------------------------------------------

-- Key Insights:

-- Rock dominates genre sales and revenue, indicating strong customer preference for rock music in the Chinook store.

-- Revenue remains relatively stable over time, with minor fluctuations across months, suggesting consistent purchasing behavior.

-- The USA is the highest revenue-generating market, followed by Canada and France, making it the primary target region.

-- Sales representatives contribute differently to revenue, highlighting variations in customer management and performance.

-- Customer spending is fairly evenly distributed, with no extreme outliers, indicating balanced revenue contribution across users.

   ========================================================= */
