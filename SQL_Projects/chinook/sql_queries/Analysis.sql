-- Question: Find employees who report to the IT Manager

USE Chinook;

SELECT FirstName,
       LastName,
       ReportsTo
FROM Employee
WHERE ReportsTo = (
    SELECT EmployeeId
    FROM Employee
    WHERE Title = 'IT Manager'
);

-- Result
-- Robert  King       6
-- Laura   Callahan   6

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

-- Insight:
-- These customers have made more than 6 purchases, indicating high engagement
-- and potential candidates for loyalty programs or targeted promotions.

/* =========================================================
   SECTION 3: Top Revenue Generating Customers
   Business Question:
   Which customers generate the highest revenue?
   ========================================================= */

SELECT c.CustomerId,
       c.FirstName,
       c.LastName,
       SUM(i.Total) AS TotalSpent
FROM Customer c
JOIN Invoice i
ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

-- Insight:
-- Helena Holý is the highest spending customer (49.62).
-- Puja Srivastava is the lowest spending customer (36.64).
-- Most customers spend between 37–40, showing balanced revenue distribution.

/* =========================================================
   SECTION 4: Top Selling Artists
   Business Question:
   Which artists generate the highest sales revenue?
   ========================================================= */

SELECT ar.Name AS Artist,
       SUM(il.UnitPrice * il.Quantity) AS TotalSales
FROM InvoiceLine il
JOIN Track t 
ON il.TrackId = t.TrackId
JOIN Album al 
ON t.AlbumId = al.AlbumId
JOIN Artist ar 
ON al.ArtistId = ar.ArtistId
GROUP BY ar.Name
ORDER BY TotalSales DESC
LIMIT 10;

-- Insight:
-- Identifies the artists contributing the most revenue to the store.