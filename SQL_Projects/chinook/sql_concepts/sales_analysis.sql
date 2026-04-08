/* =========================================================
   SECTION 1: Employee Reporting Structure
   Business Question:
   Which employees directly report to the IT Manager?
   ========================================================= */

-- Identify employees who report to the IT Manager
-- Subquery finds the EmployeeId of the IT Manager
-- Outer query fetches employees reporting to that manager

SELECT FirstName,
       LastName,
       ReportsTo
FROM Employee
WHERE ReportsTo = (
    SELECT EmployeeId
    FROM Employee
    WHERE Title = 'IT Manager'
);



/* =========================================================
   SECTION 2: Customers with High Purchase Frequency
   Business Question:
   Which customers have placed more than 6 invoices?
   ========================================================= */

-- Step 1: Identify CustomerIds with more than 6 invoices
-- This groups invoices by customer and filters frequent buyers

SELECT CustomerId
FROM Invoice
GROUP BY CustomerId
HAVING COUNT(InvoiceId) > 6;



/* =========================================================
   SECTION 3: Fetch Customer Details Using Subquery
   Business Question:
   Retrieve customer names for customers
   who placed more than 6 invoices
   ========================================================= */

-- Subquery returns multiple CustomerIds
-- IN operator is used to handle multiple results

SELECT CustomerId,
       FirstName,
       LastName
FROM Customer
WHERE CustomerId IN (
    SELECT CustomerId
    FROM Invoice
    GROUP BY CustomerId
    HAVING COUNT(InvoiceId) > 6
);



/* =========================================================
   SECTION 4: Customer Invoice Count Using Subquery + JOIN
   Business Question:
   Show customers with more than 6 invoices
   along with their total invoice count
   ========================================================= */

-- Subquery creates a virtual table with
-- CustomerId and total invoice count
-- JOIN is used to attach customer details

SELECT c.CustomerId,
       c.FirstName,
       c.LastName,
       i.Invoice_Count
FROM Customer c
JOIN (
    SELECT CustomerId,
           COUNT(InvoiceId) AS Invoice_Count
    FROM Invoice
    GROUP BY CustomerId
    HAVING COUNT(InvoiceId) > 6
) i
ON c.CustomerId = i.CustomerId;
