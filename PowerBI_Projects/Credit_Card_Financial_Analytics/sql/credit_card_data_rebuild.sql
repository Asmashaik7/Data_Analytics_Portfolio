/*
Purpose:
Investigate duplicate records caused by repeated
Week-53 append operations and rebuild clean tables.
*/
============================================================
--Step 1

--Validation queries

SELECT COUNT(*) FROM dbo.credit_card;
SELECT COUNT(*) FROM dbo.customer;
/*
10478
*/
=============================================================
--Step 2

--Duplicate analysis

SELECT Client_Num, COUNT(*)
FROM dbo.customer
GROUP BY Client_Num
HAVING COUNT(*) > 1;
--Output is 185 duplicate rows from customer table


SELECT Client_Num, COUNT(*)
FROM dbo.credit_card
GROUP BY Client_Num
HAVING COUNT(*) > 1;
--Output is 185 duplicate rows from credit card table
==============================================================
--Step 3

--Drop tables

DROP TABLE dbo.credit_card;
DROP TABLE dbo.customer;
==============================================================
--Step 4

--Recreate tables
--I will run the schema setup script and recreate the tables
==============================================================

/* STEP 5 : Load Raw Data
====================================================================

Use SQL Server Import Wizard

customer.csv     --> dbo.customer
credit_card.csv  --> dbo.credit_card

Source File Row Counts

customer.csv     = 10108
credit_card.csv  = 10108

Validation Query
*/

SELECT COUNT(*) AS customer_row_count
FROM dbo.customer;
/*
Result:
customer_row_count
10108
*/

SELECT COUNT(*) AS credit_card_row_count
FROM dbo.credit_card;
/*
Result:
credit_card_row_count
10108
*/

/*
Source-to-Target Validation

customer.csv      = 10108
dbo.customer      = 10108

credit_card.csv   = 10108
dbo.credit_card   = 10108

Validation Status : PASSED
Performed source-to-target validation after data import to ensure row counts matched between CSV files and SQL Server tables 
before executing incremental load operations.*/

/*====================================================================
STEP 6 : Append Week-53 Data
====================================================================
Source Files

cust_add.csv = 185 rows
cc_add.csv   = 185 rows

Append Queries
*/

INSERT INTO dbo.customer
SELECT *
FROM dbo.cust_add;

INSERT INTO dbo.credit_card
SELECT *
FROM dbo.cc_add;


/*====================================================================
STEP 6 : Validate Row Counts After Append
====================================================================*/

SELECT COUNT(*) AS customer_row_count
FROM dbo.customer;
/*
Result:
10293
*/

SELECT COUNT(*) AS credit_card_row_count
FROM dbo.credit_card;
/*
Result:
10293
*/

/*
Validation

customer
10108 + 185 = 10293

credit_card
10108 + 185 = 10293

Validation Status : PASSED
*/
