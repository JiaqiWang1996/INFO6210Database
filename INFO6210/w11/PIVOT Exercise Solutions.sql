
/* PIVOT Exercise Solutions */

-- Question 1
-- Solution

SELECT TerritoryID, [280], [281], [282], [283], [284], [285]
FROM 
(SELECT TerritoryID, SalesPersonID, SalesOrderID
FROM Sales.SalesOrderHeader) SourceTable
PIVOT
(
COUNT (SalesOrderID)
FOR SalesPersonID IN
( [280], [281], [282], [283], [284], [285] )
) AS PivotTable;



-- Question 2
-- Solution

SELECT [Month],
       ISNULL(cast([30020] as int), 0) '30020',
	   ISNULL(cast([30021] as int), 0) '30021',
	   ISNULL(cast([30022] as int), 0) '30022',
	   ISNULL(cast([30023] as int), 0) '30023',
	   ISNULL(cast([30024] as int), 0) '30024'
FROM (SELECT DATENAME(mm, OrderDate) AS [Month], CustomerID, TotalDue
      FROM Sales.SalesOrderHeader
      WHERE CustomerID BETWEEN 30020 AND 30024
	  ) AS SourceTable
PIVOT
     (SUM(TotalDue) 
      FOR CustomerID IN ([30020], [30021], [30022], [30023], [30024])
     ) AS PivotTable
ORDER BY MONTH([Month]+ ' 1 2019');
