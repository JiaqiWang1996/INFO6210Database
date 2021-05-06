--Q3
/* Using AdventureWorks2008R2, list the total number 
of orders processed in each year by a salesperson. 
Include only the salesperson(s) who has processed at least 
one order per year for at least three separate years.
Return the salesperson id, year, and the total number of orders 
processed in each year by the salesperson.
Sort the returned data first by SalesPersonID, then by year. */
USE AdventureWorks2008R2;
  SELECT soh.SalesPersonID AS ID ,YEAR(soh.OrderDate) AS year,COUNT(sod.SalesOrderID)AS ordercount
  FROM  sales.SalesOrderHeader soh 
  JOIN Sales.SalesOrderDetail  sod ON soh.SalesOrderID=sod.SalesOrderID
  GROUP BY 	YEAR(soh.OrderDate),soh.SalesPersonID
HAVING soh.SalesPersonID IN(
   
  SELECT  soh.SalesPersonID
FROM  sales.SalesOrderHeader soh 
  JOIN Sales.SalesOrderDetail  sod ON soh.SalesOrderID=sod.SalesOrderID
  GROUP BY 	YEAR(soh.OrderDate),soh.SalesPersonID
  HAVING  COUNT(soh.SalesOrderID)>0	AND  COUNT(YEAR(soh.OrderDate))>2
  )
  ORDER BY soh.SalesPersonID , YEAR(soh.OrderDate)






  --Q4
  /* Using AdventureWorks2008R2, write a query to retrieve 
the sales person who has the largest number
of large orders in the last quarters of 2005, 2006 and 2007 combined. A large order
is an order which has a value greater than $1000. Use TotalDue in SalesOrderHeader
as an order's value. Return the salesperson id,   salesperson's last and first names,
and count of large orders. If the re is a tie, it needs to be ret rieved. */
USE AdventureWorks2008R2;
With temp AS
(SELECT  soh.SalesPersonID AS salesperson_id ,DATEPART(QUARTER,soh.OrderDate) AS quarter,YEAR(soh.OrderDate) AS year,SUM(soh.TotalDue) as total,COUNT(soh.SalesOrderID) AS ordercount
FROM 	Sales.SalesOrderHeader 	soh
JOIN   Sales.SalesPerson sp ON soh.TerritoryID=sp.TerritoryID
 GROUP BY YEAR(soh.OrderDate), DATEPART(QUARTER,soh.OrderDate),soh.SalesPersonID
 HAVING DATEPART(QUARTER,soh.OrderDate)=4 AND  YEAR(soh.OrderDate) IN (2005,2006,2007) AND soh.TotalDue>1000
)
SELECT 	TOP 1 WITH TIES t.salesperson_id,MAX(t.ordercount)
FROM temp t
  