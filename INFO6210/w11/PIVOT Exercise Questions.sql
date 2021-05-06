
/* PIVOT Exercise Questions */

-- Question 1
/* Rewrite the following query to present the same data in a horizontal format,
   as listed below, using the SQL PIVOT command. */

SELECT TerritoryID, SalesPersonID, COUNT(SalesOrderID) AS [Order Count]
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IN (280, 281, 282, 283, 284, 285)
GROUP BY TerritoryID, SalesPersonID
ORDER BY TerritoryID, SalesPersonID;

/*
TerritoryID		280		281		282		283		284		285
	1			95		30		0		189		140		0
	2			0		0		0		0		0		0
	3			0		19		0		0		0		0
	4			0		193		0		0		0		0
	5			0		0		0		0		0		0
	6			0		0		100		0		0		0
	7			0		0		0		0		0		0
	8			0		0		0		0		0		0
	9			0		0		0		0		0		16
	10			0		0		171		0		0		0
*/



-- Question 2

/* Rewrite the following query to present the same data in a horizontal format,
   as listed below, using the SQL PIVOT command. */

SELECT DATENAME(mm, OrderDate) AS [Month], CustomerID,
       SUM(TotalDue) AS TotalOrder
FROM   Sales.SalesOrderHeader
WHERE CustomerID BETWEEN 30020 AND 30024
GROUP BY CustomerID, DATENAME(mm, OrderDate), MONTH(OrderDate)
ORDER BY MONTH(OrderDate);

/*
Month		30020	30021	30022	30023	30024
February	0		3195	9067	181		3335
March		19254	0		0		0		0
May			0		1925	9276	1323	327
June		12905	0		0		0		0
August		0		851		11448	9007	2998
September	26919	0		0		0		0
November	0		6716	6149	734		4979
December	15693	0		0		0		0
*/

/* Hint: Use the month name to build a date. Then use MONTH() to get
         the month number from the date for sorting. */

