
-- Quiz 1 Last Digit 1, 8 SQL Solutions

-- Q3

Select SalesPersonID, year(OrderDate) as Year,
       count(SalesOrderId) as 'Total Orders'
From Sales.SalesOrderHeader
where SalesPersonID in
(select SalesPersonID
 From Sales.SalesOrderHeader
 Group By SalesPersonID
 having count(distinct year(OrderDate)) >= 3)
Group By SalesPersonID, year(OrderDate)
Order by SalesPersonID, year(OrderDate);



-- Q4

with temp1 as
(select SalesPersonID, count(SalesOrderID) NumberOfOrders
 from Sales.SalesOrderHeader
 where year(OrderDate) in (2005, 2006, 2007) and month(OrderDate) in (10, 11,12)
       and TotalDue > 1000
 group by SalesPersonID)

select top 1 with ties t.SalesPersonID, p.LastName, p.FirstName, NumberOfOrders
from temp1 t
join Person.Person p
on t.SalesPersonID = p.BusinessEntityID
order by NumberOfOrders desc;


