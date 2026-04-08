/* =========================================================
   SECTION 1: Understanding Customer–Support Representative Relationship
   Business Question:
   How can we retrieve customer details along with
   their assigned support representative?
   ========================================================= */

-- Basic join to understand the relationship between
-- customers and their assigned support representatives

SELECT *
FROM Customer c
LEFT JOIN Employee e
ON c.SupportRepId = e.EmployeeId;



/* =========================================================
   SECTION 2: Selecting Relevant Columns for Reuse
   Business Question:
   What customer and support representative details
   are required for reporting and analysis?
   ========================================================= */

-- Selecting only required columns to keep the result clean
-- This query will be converted into a reusable view

SELECT c.FirstName,
       c.LastName,
       c.CustomerId,
       c.Email,
       e.EmployeeId AS SupportRepID,
       e.FirstName AS SupportRepName
FROM Customer c
LEFT JOIN Employee e
ON c.SupportRepId = e.EmployeeId;



/* =========================================================
   SECTION 3: Creating a View for Reusability
   Business Question:
   How can we avoid rewriting the same join logic repeatedly?
   ========================================================= */

-- Creating a view to store the customer–support representative mapping
-- The view acts as a virtual table and can be reused in multiple queries

CREATE VIEW CustomerDetail AS
SELECT c.FirstName,
       c.LastName,
       c.CustomerId,
       c.Email,
       e.EmployeeId AS SupportRepID,
       e.FirstName AS SupportRepName
FROM Customer c
LEFT JOIN Employee e
ON c.SupportRepId = e.EmployeeId;



/* =========================================================
   SECTION 4: Using the View
   Business Question:
   How can we query the view just like a table?
   ========================================================= */

-- Fetch all records from the view
SELECT *
FROM CustomerDetail;



/* =========================================================
   SECTION 5: Filtering Data Using the View
   Business Question:
   Which customers are handled by a specific support representative?
   ========================================================= */

-- Filtering customers handled by a specific support representative
-- Demonstrates simplicity and readability when using views

SELECT *
FROM CustomerDetail
WHERE SupportRepName = 'Jane';
