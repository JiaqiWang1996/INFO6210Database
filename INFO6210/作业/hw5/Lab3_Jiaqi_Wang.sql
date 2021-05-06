--Lab 3-1
/* Modify the following query to add a column that identifies the
performance of salespersons and contains the following feedback
based on the number of orders processed by a salesperson:
'Need to Work Hard' for the order count range 1-100
'Fine' for the order count range of 101 -300
'Strong Performer' for the order count greater than 300
Give the new column an alias to make the report more readable. 
*/
USE AdventureWorks2008R2;
SELECT o.SalesPersonID, p.LastName, p.FirstName,
COUNT(o.SalesOrderid) [Total Orders],
CASE
    WHEN  COUNT(o.SalesOrderid)>300THEN'Strong Performer'
	WHEN  COUNT(o.SalesOrderid)<100THEN'Need to Work Hard'
	ELSE'Fine'
END AS 'Evaluation'
FROM Sales.SalesOrderHeader o
JOIN Person.Person p
ON o.SalesPersonID = p.BusinessEntityID
GROUP BY o.SalesPersonID, p.LastName, p.FirstName
ORDER BY p.LastName, p.FirstName;


--Lab 3-2
/* Modify the following query to add a rank without gaps in the
ranking based on total orders in the descending order. Also
partition by territory.*/
USE AdventureWorks2008R2;
SELECT o.TerritoryID, s.Name, year(o.OrderDate) Year,
COUNT(o.SalesOrderid) [Total Orders],
DENSE_RANK()OVER
            (PARTITION BY o.TerritoryID Order BY COUNT(o.SalesOrderid)DESC)AS RANK
FROM Sales.SalesTerritory s 
JOIN Sales.SalesOrderHeader o
ON s.TerritoryID = o.TerritoryID
GROUP BY o.TerritoryID, s.Name, year(o.OrderDate)
ORDER BY o.TerritoryID;


--Lab 3-3
/* Write a query that returns the male salesperson(s) who received 
the lowest bonus amount in Europe. Include the salesperson's
id and bonus amount in the returned data. Your solution must 
retrieve the tie if there is a tie. */
USE AdventureWorks2008R2;
SELECT TOP 1 WITH TIES sp.BusinessEntityID,	sp.Bonus
FROM Sales.SalesPerson sp
 JOIN HumanResources.Employee e ON sp.BusinessEntityID = e.BusinessEntityID
 JOIN Sales.SalesTerritory st ON sp.TerritoryID = st.TerritoryID
WHERE e.Gender = 'M' AND st.[Group] = 'Europe'
ORDER BY sp.Bonus ;


--Lab 3-4
/* Write a query to retrieve the most valuable customer of each year.
The most valuable customer of a year is the customer who has 
made the most purchase for the year. Use the yearly sum of the 
TotalDue column in SalesOrderHeader as a customer's total purchase 
for a year. If there is a tie for the most valuable customer, 
your solution should retrieve it.
Include the customer's id, total purchase, and total order count 
for the year. Display the total purchase in two decimal places.
Sort the returned data by the year. */
/*USE AdventureWorks2008R2;
WITH temp AS
(SELECT DATEPART( year , soh.OrderDate )Year,soh.CustomerID, ROUND(SUM(soh.TotalDue),2)TotalPurchase,COUNT(soh.SalesOrderID)OrderCount
FROM Sales.SalesOrderHeader soh	
GROUP BY  DATEPART( year , soh.OrderDate ),soh.CustomerID)
SELECT  MAX(a.TotalPurchase)totalpurchase
FROM temp a 
GROUP BY   a.Year,a.CustomerID,a.OrderCount
ORDER BY a.Year	;*/

WITH temp AS (
 SELECT soh.CustomerID, ROUND(SUM(soh.TotalDue),2) AS TotalPurchase, COUNT(soh.SalesOrderID) AS TotalOrderCount, YEAR(soh.OrderDate) as Year,
  RANK () OVER (PARTITION BY YEAR(soh.OrderDate) ORDER BY SUM(soh.TotalDue) DESC) as Rank--customer 之间比
 FROM Sales.SalesOrderHeader soh 
 GROUP BY CustomerID, YEAR(OrderDate)
 )
 Select temp.CustomerID, temp.TotalPurchase, temp.TotalOrderCount, temp.Year
 FROM temp
WHERE temp.Rank=1
ORDER BY temp.Year DESC;




--Lab 3-5
/* Write a query to retrieve the dates in which there was 
at least one product sold but no product in red
was sold. 
Return the "date" and "total product quantity sold
for the date" columns. The order quantity can be found in
SalesOrderDetail. Display only the date for a date.
Sort the returned data by the
"total product quantity sold for the date" column in desc. */

USE AdventureWorks2008R2;
SELECT temp.Date, SUM(temp.OrderQty) as OrderQty
FROM 
 (SELECT CAST(soh.OrderDate AS DATE) as Date, sod.OrderQty, p.Color 
 FROM Sales.SalesOrderDetail sod 
 INNER JOIN Production.Product P
 ON sod.ProductID = p.ProductID 
 INNER JOIN Sales.SalesOrderHeader soh 
 ON sod.SalesOrderID = soh.SalesOrderID
 ) AS temp
WHERE temp.Date NOT IN 
 (
 SELECT CAST(soh2.OrderDate AS DATE) as Date
 FROM Sales.SalesOrderDetail sod2
 INNER JOIN Production.Product P2
 ON sod2.ProductID = p2.ProductID 
 INNER JOIN Sales.SalesOrderHeader soh2
 ON sod2.SalesOrderID = soh2.SalesOrderID
 WHERE p2.Color = 'red'
 )
GROUP BY Date
ORDER BY SUM(temp.OrderQty) DESC;

