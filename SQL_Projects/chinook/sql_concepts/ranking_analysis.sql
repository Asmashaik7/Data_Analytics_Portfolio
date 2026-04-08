USE Chinook;

/* =========================================================
   SECTION 1: Employee Seniority Ranking
   Business Question:
   How can employees be ranked based on their hire date?
   ========================================================= */

-- RANK() assigns a rank to employees based on HireDate
-- Employees hired earlier receive a higher priority rank
-- If two employees share the same HireDate, they receive the same rank
-- Gaps may appear in ranking values

SELECT FirstName,
       LastName,
       HireDate,
       RANK() OVER (ORDER BY HireDate) AS RankByHireDate
FROM Employee;



/* =========================================================
   SECTION 2: Customer Spending Ranking
   Business Question:
   Which customers are the highest spenders,
   ranked by total purchase amount?
   ========================================================= */

-- DENSE_RANK() ranks customers based on total spending
-- Customers with the same total spending receive the same rank
-- No gaps appear in ranking values

SELECT CustomerID,
       SUM(Total) AS TotalSpending,
       DENSE_RANK() OVER (ORDER BY SUM(Total) DESC) AS SpendingRank
FROM Invoice
GROUP BY CustomerID;



/* =========================================================
   SECTION 3: Running Total of Invoice Sales
   Business Question:
   How does cumulative sales grow over time?
   ========================================================= */

-- SUM() as a window function calculates a running total
-- Invoices are ordered by InvoiceDate
-- Each row shows cumulative sales up to that invoice

SELECT InvoiceID,
       Total,
       SUM(Total) OVER (ORDER BY InvoiceDate) AS RunningTotal
FROM Invoice;
