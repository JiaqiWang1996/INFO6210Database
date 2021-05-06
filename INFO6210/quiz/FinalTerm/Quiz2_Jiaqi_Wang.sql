-- Last Digit of NUID:1
-- Your NUID: 001023711
-- Your Name: Jiaqi Wang



-- Question 1 (4 points)

/* Using AdventureWorks2008R2, rewrite the following query to 
   present the same data in a horizontal format,
   as listed below, based on the SQL PIVOT command. */
select (p.LastName + ', ' + p.FirstName) FullName, datepart(dw, sh.OrderDate) Weekday, count(SalesOrderID) TotalOrder
from Sales.SalesOrderHeader sh
join Person.Person p
on sh.SalesPersonID = p.BusinessEntityID
group by p.LastName + ', ' + p.FirstName, datepart(dw, sh.OrderDate)
order by FullName;

--pivot table
use AdventureWorks2008R2;
select  FullName,[1]as[Sun],[2]as[Mon],[3]as[Tue],[4]as[Wed],[5]as[Thr],[6]as[Fri],[7]as[Sat]
from
(select (p.LastName + ', ' + p.FirstName) FullName, datepart(dw, sh.OrderDate) Weekday, SalesOrderID
from Sales.SalesOrderHeader sh
join Person.Person p
on sh.SalesPersonID = p.BusinessEntityID
)as sourcetable
pivot
(	count(SalesOrderID) for  Weekday in([1],[2],[3],[4],[5],[6],[7])
)  as pivottable

/*
FullName					Sun		Mon		Tue		Wed		Thr		Fri		Sat
Abbas, Syed					2		0		2		0		3		1		8
Alberts, Amy				2		2		5		7		8		7		8
Ansman-Wolfe, Pamela		11		19		20		10		7		12		16
Blythe, Michael				57		39		63		54		82		64		91
Campbell, David				28		19		33		20		35		20		34
Carson, Jillian				49		43		65		58		117		81		60
Ito, Shu					32		18		29		22		51		40		50
Jiang, Stephen				8		2		11		7		9		4		7
Mensa-Annan, Tete			20		7		17		16		30		20		30
Mitchell, Linda				40		36		67		58		94		62		61
Pak, Jae					47		16		52		35		66		62		70
Reiter, Tsvi				53		41		64		59		98		52		62
Saraiva, Jos?			29		36		37		38		55		31		45
Tsoflias, Lynn				22		7		12		10		13		8		37
Valdez, Rachel				19		13		17		14		19		12		36
Vargas, Garrett				20		21		35		32		55		37		34
Varkey Chudukatil, Ranjit	22		8		21		24		44		29		27
*/




-- Question 2 (5 points)

/*
Using AdventureWorks2008R2, write a query to retrieve 
the customers and their order info.

Return the customer id, a customer's total purchase,
and a customer's top 5 orders. 

The top 5 orders have the 5 highest order values. 
Use TotalDue as the order value. If there is a tie, 
the tie must be retrieved.

Include only the customers who have had at least one order
which contained more than 70 unique products.

Sort the returned data by CustomerID. Return the data in
the format specified below.
*/

/*
CustomerID	TotalPurchase	Orders
29712		653973.76		51739, 46987, 69437, 57061, 50225
29722		954021.92		45529, 48306, 47365, 44750, 53465
30048		678828.84		51160, 46657, 67316, 49879, 55297
30107		650362.05		51721, 57046, 69422, 43869, 63157
*/
use AdventureWorks2008R2;
with temp as 
(select CustomerID,TotalDue, SalesOrderID,sum(t1.TotalDue)AS TotalPurchase,
RANK() OVER (PARTITION BY CustomerID ORDER BY TotalDue DESC ) AS OrderRank
from Sales.SalesOrderHeader 
 group by CustomerID
)
SELECT DISTINCT 
	t2.CustomerID as CustomerID,sum(t1.TotalDue)AS TotalPurchase,
	STUFF
	(
		(SELECT  ', '+t1.SalesOrderID  
		FROM temp t1 
		WHERE t1.CustomerID = t2.CustomerID  AND t1.OrderRank< 6
		FOR XML PATH('')) , 1, 2, '') AS Orders
FROM temp t2
group by CustomerID;



-- Question 3 (6 points)

 /* Given the following tables, there is a $100
    club annual membership fee per customer.
    There is a business rule, if a customer has spent more
	than $5000 for the current year, then the membership fee
	is waived for the current year. But if the total spending
	of the current year gets below $5000 after the fee has
	been waived, the fee will be charged again. The total
	spending may be reduced by a return. 
	
	Please write a trigger to implement the business rule.
	The membership fee is stored in the Customer table. */
use Lab4_Jiaqi_Wang;
create table Customer
(CustomerID int primary key,
 LastName varchar(50),
 FirstName varchar(50),
 MembershipFee money);

create table SalesOrder
(OrderID int primary key,
 CustomerID int references Customer(CustomerID),
 OrderDate date not null);

create table OrderDetail
(OrderID int references SalesOrder(OrderID),
 ProductID int,
 Quantity int not null,
 UnitPrice money not null
 primary key(OrderID, ProductID));

 go
 CREATE TRIGGER trig_Spending
ON "Lab4_Jiaqi_Wang".dbo.Customer
FOR UPDATE,INSERT, DELETE
AS 
BEGIN
 
   update dbo.Customer
   set 	MembershipFee=0
   where(select SUM(od.Quantity*od.UnitPrice)as total
   from   OrderDetail od 
    INNER JOIN SalesOrder so on so.OrderID=od.OrderID
	   inner join Customer c on c.CustomerID=so.CustomerID
	   group by c.CustomerID
   ) >5000
END;
go