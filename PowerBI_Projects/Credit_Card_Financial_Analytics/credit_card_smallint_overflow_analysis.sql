USE ccdb

SELECT * FROM dbo.credit_card;

SELECT * FROM dbo.customer;
----------------------------------------------
--Check row counts
SELECT COUNT(*) FROM dbo.credit_card;
/*Results
10108
*/
SELECT COUNT(*) FROM dbo.customer;
/*Results
10108
*/
--the above row count shows that the data of week-53 didnt appended yet in both the tables.
-------------------

SELECT * FROM dbo.cc_add

SELECT * FROM dbo.cust_add

--Check row counts
SELECT COUNT(*) as cc_add_row_count FROM dbo.cc_add
/*Results:
cc_add_row_count
185 */

SELECT COUNT(*) as cust_add_row_count FROM dbo.cust_add
/*
cust_add_row_count
185 */

--While appending new weekly transaction data, I encountered a SQL Server overflow error because the Total_Trans_Amt column was defined as SMALLINT. 
--After investigating the schema and checking the data, I found transaction values as high as 79,463, exceeding the SMALLINT limit of 32,767. 
--I altered the datatype to INT and successfully completed the data load.

SELECT
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='credit_card';
/*
Result:
COLUMN_NAME			DATA_TYPE
Client_Num			int
Card_Category		nvarchar
Annual_Fees			int
Activation_30_Days	nvarchar
Customer_Acq_Cost	int
Week_Start_Date		datetime2
Week_Num			nvarchar
Qtr					nvarchar
current_year		int
Credit_Limit		float
Total_Revolving_Bal	nvarchar
Total_Trans_Amt		smallint	--This causing the ERROR
Total_Trans_Vol		int
Avg_Utilization_Ratio	nvarchar
Use_Chip			nvarchar
Exp_Type			nvarchar
Interest_Earned		float
Delinquent_Acc		nvarchar
*/

SELECT MAX(Total_Trans_Amt)
FROM dbo.credit_card;
/*
Result

Max_Transaction_Amount = 79463

SMALLINT Range

Minimum = -32,768
Maximum =  32,767

Observed Value = 79,463

Conclusion

SMALLINT cannot store this value.
INT range:
-2,147,483,648
to
 2,147,483,647 */


select Client_Num from dbo.credit_card where Total_Trans_Amt=79463
/*Results:
Client_Num
920819113
*/

select * from dbo.credit_card where Total_Trans_Amt=79463
/*
Result:
Client_Num	Card_Category	Annual_Fees	Activation_30_Days	Customer_Acq_Cost	Week_Start_Date	Week_Num	Qtr		current_year	Credit_Limit	Total_Revolving_Bal	Total_Trans_Amt	Total_Trans_Vol	Avg_Utilization_Ratio	Use_Chip	Exp_Type	Interest_Earned		Delinquent_Acc
920819113	Blue			175			0					95					2023-12-31		Week-53		4.00	2023			4063			0					79463			70					0					Chip 		Fuel		1492.59997558594	0
*/



