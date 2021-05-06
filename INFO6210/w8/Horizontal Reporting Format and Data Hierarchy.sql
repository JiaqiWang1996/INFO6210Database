

SELECT h.CustomerID,
STUFF((SELECT  ', '+RTRIM(CAST(SalesOrderID as char))  
       FROM Sales.SalesOrderHeader s  
       WHERE s.CustomerID = h.CustomerID
       ORDER BY SalesOrderID
       FOR XML PATH('')) , 1, 2, '') AS Orders
FROM Sales.SalesOrderHeader h
WHERE h.CustomerID =14328;





SELECT DISTINCT h.CustomerID,
STUFF((SELECT  ', '+RTRIM(CAST(SalesOrderID as char))  
       FROM Sales.SalesOrderHeader s  
       WHERE s.CustomerID = h.CustomerID
       ORDER BY SalesOrderID
       FOR XML PATH('')) , 1, 2, '') AS Orders
FROM Sales.SalesOrderHeader h
WHERE h.CustomerID =14328;





SELECT h.CustomerID,
STUFF((SELECT  ', '+RTRIM(CAST(SalesOrderID as char))  
       FROM Sales.SalesOrderHeader s  
	   WHERE s.CustomerID = h.CustomerID
       ORDER BY SalesOrderID
       FOR XML PATH('')) , 1, 2, '') AS Orders
FROM Sales.Customer h
WHERE h.CustomerID =14328;
