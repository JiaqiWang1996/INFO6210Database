
/* Horizontal Reporting and Data Hierarchy  */

/* Example Set 1 */

-- Vertical Format (Long List)
SELECT CustomerID,SalesOrderID
FROM Sales.SalesOrderHeader 
WHERE CustomerID =14328;

-- Horizontal Format (Short List)
SELECT DISTINCT h.CustomerID,
      (SELECT  ', '+CAST(SalesOrderID as varchar)  
       FROM Sales.SalesOrderHeader s  
       WHERE s.CustomerID = h.CustomerID
       FOR XML PATH('')) AS Orders  
FROM Sales.SalesOrderHeader h
WHERE h.CustomerID =14328;

-----------------------------------------

-- Without using FOR XML PATH
-- Vertical Format (Long List)
SELECT SalesOrderID
FROM Sales.SalesOrderHeader 
WHERE CustomerID =14328;

-- Use FOR XML PATH to format report
-- Horizontal Format (Short List)
SELECT ', ' + CAST(SalesOrderID as varchar)
FROM Sales.SalesOrderHeader 
WHERE CustomerID =14328
FOR XML PATH('');  -- '' means no wrapping

-----------------------------------------

-- Horizontal Format (Short List)
SELECT DISTINCT h.CustomerID,
STUFF((SELECT  ', '+CAST(SalesOrderID as varchar)  -- STUFF gets rid of extra separators
       FROM Sales.SalesOrderHeader s  
       WHERE s.CustomerID = h.CustomerID
       FOR XML PATH('')) , 1, 2, '') AS Orders
FROM Sales.SalesOrderHeader h
WHERE h.CustomerID =14328;

-- Horizontal Format (Short List)
SELECT c.CustomerID,
STUFF((SELECT  ', '+CAST(SalesOrderID as varchar)  
       FROM Sales.SalesOrderHeader s  
       WHERE s.CustomerID = c.CustomerID
       FOR XML PATH('')) , 1, 2, '') AS Orders
FROM Sales.Customer c
WHERE c.CustomerID =14328;


/* Example Set 2 */

-- Vertical Format (Long List)
SELECT h.CustomerID, FirstName, LastName, SalesOrderID
FROM Sales.SalesOrderHeader h
JOIN Sales.Customer c
ON h.CustomerID = c.CustomerID
JOIN Person.Person p
ON c.PersonID = p.BusinessEntityID
WHERE c.CustomerID =14328
ORDER BY CustomerID;

-- Horizontal Format (Short List)
SELECT DISTINCT h.CustomerID, p.FirstName, p.LastName,
STUFF((SELECT  ', '+CAST(SalesOrderID as varchar)  
       FROM Sales.SalesOrderHeader 
       WHERE CustomerID = c.customerid
       ORDER BY SalesOrderID
       FOR XML PATH('')) , 1, 2, '') AS Orders
FROM Sales.SalesOrderHeader h
JOIN Sales.Customer c
ON h.CustomerID = c.CustomerID
JOIN Person.Person p
ON c.PersonID = p.BusinessEntityID
WHERE c.CustomerID =14328
ORDER BY CustomerID;

-- Horizontal Format (Short List)
SELECT c.CustomerID, p.FirstName, p.LastName,
STUFF((SELECT  ', '+CAST(SalesOrderID as varchar) 
       FROM Sales.SalesOrderHeader 
       WHERE CustomerID = c.customerid
       FOR XML PATH('')) , 1, 2, '') AS Orders
FROM Sales.Customer c
JOIN Person.Person p
ON c.PersonID = p.BusinessEntityID
WHERE c.CustomerID =14328
ORDER BY CustomerID;

-- SQL Server 2017 and beyond only
-- Horizontal Format (Short List)
with temp as
(SELECT h.CustomerID, p.FirstName, p.LastName, h.SalesOrderID
 FROM Sales.SalesOrderHeader h
 JOIN Sales.Customer c
 ON h.CustomerID = c.CustomerID
 JOIN Person.Person p
 ON c.PersonID = p.BusinessEntityID)
SELECT	CustomerID, FirstName, LastName,
		STRING_AGG(	cast(temp.SalesOrderID as varchar) 
					, ', ')	as Orders
FROM temp 
WHERE CustomerID =14328
GROUP BY CustomerID, FirstName, LastName
ORDER BY CustomerID;


/* Example Set 3 */

-- Vertical Format (Long List)
SELECT CustomerID, SalesOrderID, CAST(CAST(OrderDate as date) as varchar) ODate
FROM Sales.SalesOrderHeader 
WHERE CustomerID =14328
ORDER BY CustomerID;

-- Horizontal Format (Short List)
SELECT c.CustomerID,
STUFF((SELECT  ', '+CAST(SalesOrderID as varchar)+ ' ' + CAST(CAST(OrderDate as date) as varchar)  
       FROM Sales.SalesOrderHeader 
       WHERE CustomerID = c.customerid
       FOR XML PATH('')) , 1, 2, '') AS Orders
FROM Sales.Customer c
WHERE c.CustomerID =14328
ORDER BY CustomerID;

-- SQL Server 2017 and beyond only
-- Horizontal Format (Short List)
with temp as
(SELECT CustomerID, SalesOrderID, CAST(OrderDate as date) ODate
 FROM Sales.SalesOrderHeader)
SELECT	CustomerID,
		STRING_AGG(	cast(SalesOrderID as varchar)+
		            ' '+
		            cast(ODate as varchar)
					, ', ')	as Orders
FROM temp 
WHERE CustomerID =14328
GROUP BY CustomerID
ORDER BY CustomerID;


