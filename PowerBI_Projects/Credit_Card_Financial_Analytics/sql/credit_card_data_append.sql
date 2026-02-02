-- Purpose: Create database and base tables for Credit Card Analysis project
-- Used before loading data into Power BI

/*Adding (dbo.cust_add)new table data into  (dbo.customer)old table*/

INSERT INTO DBO.CUSTOMER
SELECT * FROM DBO.CUST_ADD;

SELECT * FROM DBO.CUSTOMER; 

/* Adding new table(dbo.cc_add) data into credit_card table  */
INSERT INTO DBO.CREDIT_CARD
SELECT * FROM DBO.CC_ADD;

/* ERROR IS COMING ON SMALLINT AS ONE OF VALUES IS GREATER THAN 76000*/
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DBO.CREDIT_CARD';

/*ALTERING SMALL INT COLUMN TO INT*/
ALTER TABLE dbo.credit_card
ALTER COLUMN Total_Trans_Amt INT;