--Lab5-1
USE "Lab4_Jiaqi_Wang";
--  Create a table-valued  function
Go
CREATE FUNCTION dbo.calculateTotalSales
(@Year int, @Month int)
RETURNS TABLE
AS
RETURN
(
	SELECT ISNULL(SUM(TotalDue), 0) AS TotalDue
	FROM AdventureWorks2008R2.sales.SalesOrderHeader soh
 	WHERE  YEAR(soh.DueDate) = @Year AND MONTH(soh.DueDate) = @Month 
);
 Go
 --  Execute the new function
SELECT * FROM Lab4_Jiaqi_Wang.dbo.calculateTotalSales(2008, 1);




--Lab5-2
 USE"Lab4_Jiaqi_Wang";
 CREATE TABLE DateRange
(
	DateID INT IDENTITY,
	DateValue DATE,
	Month INT,
	DayOfWeek INT
);
Go
CREATE PROCEDURE StoredProcedure
	@StartingDate DATE,
    @ConsecutiveDaysNum INT
AS
DECLARE @count INT
SET @count = 0;
WHILE(@count < @ConsecutiveDaysNum)
BEGIN
	SET IDENTITY_INSERT Lab4_Jiaqi_Wang.dbo.DateRange OFF;
	INSERT INTO Lab4_Jiaqi_Wang.dbo.DateRange
	(
		DateValue,
		Month,
		DayOfWeek
	)
	VALUES
	(
		DATEADD(DAY, @count, @StartingDate),
		MONTH(DATEADD(DAY, @count, @StartingDate)),
		DATEPART(WEEKDAY, DATEADD(DAY, @count, @StartingDate))
	);
	SET @count = @count + 1;
END;

Go
DECLARE @StartingDate DATE
DECLARE @ConsecutiveDaysNum INT

SET @ConsecutiveDaysNum = 100
SET @StartingDate = '2011-11-11'

EXEC StoredProcedure @StartingDate, @ConsecutiveDaysNum;

SELECT * FROM Lab4_Jiaqi_Wang.dbo.DateRange;
Go



--Lab5-3
 USE"Lab4_Jiaqi_Wang";
 CREATE TABLE Customer
(
	CustomerID VARCHAR(20) PRIMARY KEY,
	CustomerLName VARCHAR(30),
	CustomerFName VARCHAR(30),
	CustomerStatus VARCHAR(10)
);

CREATE TABLE SaleOrder
(
	OrderID INT IDENTITY PRIMARY KEY,
	CustomerID VARCHAR(20) REFERENCES Customer(CustomerID),
	OrderDate DATE,
	OrderAmountBeforeTax INT
);

CREATE TABLE SaleOrderDetail
(
	OrderID INT REFERENCES SaleOrder(OrderID),
	ProductID INT,
	Quantity INT,
	UnitPrice INT,
	PRIMARY KEY (OrderID, ProductID)
);
Go
--DROP TRIGGER  UpdateStatus
CREATE TRIGGER UpdateStatus
ON "Lab4_Jiaqi_Wang".dbo.Customer
FOR INSERT, UPDATE, DELETE AS
BEGIN
	UPDATE dbo.Customer
	SET CustomerStatus='Preferred'
	WHERE(
	SELECT 	SUM(so.OrderAmountBeforeTax) AS total
	FROM Customer c
	join   SaleOrder so
	ON so.CustomerID=c.CustomerID
	)> 5000
END;
Go

INSERT Customer VALUES (10, 'Jiaqi', 'Wang',null)
INSERT SaleOrder VALUES (10, '2011-11-11', 10000)
 SELECT * FROM Lab4_Jiaqi_Wang.dbo.Customer;