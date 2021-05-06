--ParttA
CREATE DATABASE "Lab4_Jiaqi_Wang";
GO
	  USE "Lab4_Jiaqi_Wang";
CREATE TABLE dbo.TargetCustomers
(
    TargetID varchar(5) NOT NULL PRIMARY KEY,
    FirstName varchar(40) NOT NULL,
    LastName varchar(40) NOT NULL,
    Address varchar(40) NOT NULL,
    City varchar(20) NOT NULL,
    State varchar(40) NOT NULL,
    ZipCode varchar(20) NOT NULL
);

CREATE TABLE dbo.MailingList
(
    MailingListID varchar(5) NOT NULL PRIMARY KEY,
    MailingList varchar(40) NOT NULL
);

CREATE TABLE dbo.TargetMailingLists
(
    TargetID varchar(5) NOT NULL
        REFERENCES TargetCustomers(TargetID),
    MailingListID varchar(5) NOT NULL
        REFERENCES MailingList(MailingListID)
        CONSTRAINT PKTargetMailingList PRIMARY KEY CLUSTERED (TargetID, MailingListID)
);



 --PartB
 use AdventureWorks2008R2;
 WITH temp as(
 SELECT DISTINCT soh1.CustomerID AS CustomerID,
      STUFF(  (SELECT ', '+CAST(SalesPersonID as varchar)
		FROM Sales.SalesOrderHeader soh2
		WHERE soh1.CustomerID=soh2.CustomerID
		FOR XML PATH('')),1,2,'')AS  SalesPersonID
 FROM Sales.SalesOrderHeader soh1)
  SELECT   CustomerID,ISNULL(SalesPersonID,'')
  from temp
  ORDER BY CustomerID DESC;
  
  --partC
USE AdventureWorks2008R2;
WITH Parts(AssemblyID, ComponentID, PerAssemblyQty, EndDate, ComponentLevel) AS
(
	SELECT b.ProductAssemblyID, b.ComponentID, b.PerAssemblyQty, b.EndDate, 0 AS ComponentLevel
	FROM Production.BillOfMaterials AS b
	WHERE b.ProductAssemblyID = 992 AND b.EndDate IS NULL
	UNION ALL
	SELECT bom.ProductAssemblyID, bom.ComponentID, p.PerAssemblyQty, bom.EndDate, ComponentLevel + 1
	FROM Production.BillOfMaterials AS bom
	INNER JOIN Parts AS p
	ON bom.ProductAssemblyID = p.ComponentID AND bom.EndDate IS NULL
)
SELECT  DISTINCT [REDUCTION]=
(SELECT SUM( pr.ListPrice ) 
FROM Parts AS p
INNER JOIN
Production.Product AS pr ON p.ComponentID =pr.ProductID 
GROUP BY ComponentLevel,ComponentID
HAVING ComponentID=815 AND ComponentLevel=0)
-
(SELECT SUM( pr.ListPrice ) 
FROM Parts AS p
INNER JOIN
Production.Product AS pr ON p.ComponentID =pr.ProductID 
GROUP BY ComponentLevel,AssemblyID
HAVING AssemblyID=815 AND ComponentLevel=1)

FROM Parts AS p
INNER JOIN
Production.Product AS pr ON p.ComponentID =pr.ProductID ;
	   