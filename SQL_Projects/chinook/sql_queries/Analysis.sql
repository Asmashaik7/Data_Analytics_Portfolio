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


