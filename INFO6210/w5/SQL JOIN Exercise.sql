

/* Question: Retrieve customers who have never purchased Product 716 */ 

-- Use JOIN to get customers who have never purchased Product 716
select distinct sh.CustomerID
from Sales.SalesOrderHeader sh
join Sales.SalesOrderDetail sd
     on sh.SalesOrderID = sd.SalesOrderID
where sd.ProductID <> 716
order by sh.CustomerID;


/* Is this solution correct? Please explain. */

/* If this solution is wrong, please correct it. */

