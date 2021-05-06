--AUTHOR Jiaqi Wang

--Lab2.Question1
USE AdventureWorks2008R2;
SELECT soh.SalesPersonID AS SPID,soh.SalesOrderID AS SOID,CAST(soh.OrderDate AS Date)AS OD,ROUND(soh.TotalDue, 2)As TD
From Sales.SalesOrderHeader  soh
WHERE soh.SalesPersonID IN('276') AND soh.TotalDue>40000
ORDER BY SalesPersonID,OrderDate;


--Lab2.Question2
USE AdventureWorks2008R2;
SELECT soh.TerritoryID AS TID,COUNT(DISTINCT soh.SalesOrderID)TC, CAST(ROUND(SUM(soh.TotalDue ),0)AS int)AS TS
From Sales.SalesOrderHeader  soh
GROUP BY TerritoryID --group  BY before HAVING
HAVING  COUNT(DISTINCT soh.SalesOrderID)>5000--An aggregate may not appear in the WHERE clause unless it is in a subquery contained in a HAVING clause or a select list, and the column being aggregated is an outer reference.
ORDER BY TerritoryID ;


--Lab2.Question3
 USE AdventureWorks2008R2;
 SELECT  p.ProductID AS PID,p.Name AS PN,p.ListPrice AS PLP,p.SellStartDate AS PSSD
 FROM Production.Product p
 WHERE p.ListPrice>
 (SELECT ListPrice
 FROM Production.Product
 WHERE ProductID='888')
 ORDER BY ListPrice DESC;


--Lab2.Question4
USE AdventureWorks2008R2;
SELECT p.ProductID AS Pid, p.Name AS Pn, s.SoldQuantity
FROM Production.Product p
INNER JOIN
(
	SELECT ProductID, SUM(OrderQty) AS SoldQuantity
	FROM Sales.SalesOrderDetail
	GROUP BY ProductID 
	HAVING SUM(OrderQty) > 2000
) AS s
ON p.ProductID = s.ProductID
ORDER BY SoldQuantity DESC;


--Lab2.Question5
 /*USE AdventureWorks2008R2;
SELECT DISTINCT oh.CustomerID
FROM  Sales.SalesOrderHeader oh
WHERE(
SELECT COUNT(DISTINCT ProductID)
FROM Sales.SalesOrderDetail	od
 WHERE od.SalesOrderID=oh.SalesOrderID
 AND od.ProductID IN (710,715)
)=2
ORDER BY CustomerID;*/

USE AdventureWorks2008R2;
SELECT  oh.CustomerID
FROM Sales.SalesOrderHeader oh
INNER JOIN Sales.SalesOrderDetail od
ON oh.SalesOrderID=od.SalesOrderID
WHERE od.ProductID=710
INTERSECT
SELECT oh.CustomerID
FROM Sales.SalesOrderHeader oh
INNER JOIN Sales.SalesOrderDetail od
ON oh.SalesOrderID=od.SalesOrderID
WHERE od.ProductID=715
ORDER BY CustomerID;


--Lab2.Question6
/*USE AdventureWorks2008R2;
SELECT 	 DISTINCT st.TerritoryID,st.Name AS TerritoryName,
(SELECT ROUND(MAX(TotalDue),2)
FROM Sales.SalesOrderHeader
HAVING MAX(TotalDue)<'140000'
) AS HighestOrderValue
FROM Sales.SalesTerritory st
INNER JOIN Sales.SalesOrderHeader od
ON  od.TerritoryID=st.TerritoryID
ORDER BY TerritoryID;*/

USE AdventureWorks2008R2;
SELECT oh.TerritoryID,st.Name,ROUND(MAX(oh.TotalDue),2) AS 	HighestOrderValue
FROM Sales.SalesOrderHeader oh
INNER JOIN Sales.SalesTerritory st
ON oh.TerritoryID=st.TerritoryID
GROUP BY oh.TerritoryID,st.Name
HAVING MAX(oh.TotalDue)<140000
ORDER BY TerritoryID;

