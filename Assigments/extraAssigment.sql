--Select ContactName, City from (Select * from Customers) dt


/*
 customer details with total orders
*/

/*
Select c.ContactName,c.Phone,c.Fax,count(o.orderid) as 'TotalOrder'
from Customers c left join Orders o
on c.CustomerId = o.CustomerID
group by c.ContactName,c.Phone,c.Fax

*/

/*
select c.CompanyName,c.City,c.Phone,c.Fax,dt.TotalOrders   from Customers c left join
(select count(orderid) as 'TotalOrders', CustomerId from orders
group by CustomerId ) dt
on c.CustomerID = dt.CustomerID

*/

--rank functions 
-- rank and dense_rank


Select * from 
(select ProductId, ProductName,UnitPrice, 
dense_RANK() over(Order by UnitPrice desc) rnk from Products) dt
where dt.rnk = 12

select ProductId, ProductName,UnitPrice,
Dense_RANK() over(Order by UnitPrice desc) rnk from Products



Select productid,supplierid, productname,unitprice from products order by SupplierID


select * from (
select productid, supplierid, productname, unitprice, dense_rank() 
over(partition by supplierid order by unitprice desc) rnk from products
)dt
where dt.rnk = 1



-- find the detail of top 3 customers from every city who have placed maximum number of orders

select * from
(select c.ContactName,c.ContactTitle,c.City,dt.CustomerID,dt.TotalOrders, 
dense_rank() over(partition by c.city order by dt.TotalOrders desc) rnk
from customers c inner join
(Select CustomerId, count(orderid) as 'TotalOrders' from orders group by CustomerID)dt
on dt.CustomerID= c.CustomerID
)dt2
where dt2.rnk <=3


-- common table expression (CTE) /with query

with OrderCount
as
(
    Select CustomerId, Count(orderid) as 'total' from Orders group by CustomerId
),
CustomerRanking
as(
Select c.ContactName,c.Phone,c.City,oc.total , 
DENSE_RANK() over(PARTITION by c.city order by oc.total desc) rnk  from ordercount oc inner join Customers c on 
oc.CustomerID = c.CustomerID
)
select * from customerranking where rnk<=3



-- recursiveness 










select count(UnitPrice), SupplierID from products group by SupplierID



select productid, supplierid, productname, unitprice, dense_rank() 
over(partition by supplierid order by unitprice desc) rnk from products;




---
with cte_EmpHeirarchy
as
(

Select EmployeeId, FirstName, ReportsTo, 1 as 'lvl' from Employees where ReportsTo is null
 union all
 select e.EmployeeID,e.FirstName,e.ReportsTo,ce.lvl+1  from Employees
 e inner join cte_EmpHeirarchy ce on e.ReportsTo = ce.EmployeeID
)

select * from cte_EmpHeirarchy


/*
    A

	LocName         Distance
	   A               0
	   B              50
	   C              150
	   D              299


REsultset
    LocName          Distance
	B to A               50
	C to B              100
	D to C              149


*/
declare @table_A Table
(locName nvarchar Not null,
distance int)
insert into @table_A(locname, distance)
values ('A', 0),
		('B', 50),
		('C', 250),
		('D', 299);


with cte_distance as (select t.LocName, t.Distance, t.locname as toLoc from @table_A as t where t.locname='A'
	Union all
	select d.locName + ' to ' + d2.toLoc, d.distance - d2.distance, d.locName from @table_A as d 
	inner join cte_distance as d2 on d.locName=d2.toLoc)

select * from cte_distance


/*
           Employee
		   Name     Salary    Department
		   Smith     2000         HR
		   Smith     2000         HR
		   Peter     3000         QA
		   Peter     3000         QA
		   Peter     3000         QA
		   John      3400         QA
		   John      3400         QA
		   John      3400         QA

		   
		   delete the duplicate only

		   Employee
		   Name     Salary    Department
		   Smith     2000         HR
		   Peter     3000         QA
		   John      3400         QA

*/
--declare @table_e Table
--(Name nvarchar(20) Not null,
--salary int,
--department nvarchar(20) not null)
--insert into @table_e(name, salary, department)
--values ('s', 2,'hr' ),
--		('s', 2,'hr' ),
--		('p', 3,'qa' ),
--		('p', 3,'qa' ),
--		('p', 3,'qa' ),
--		('j', 4,'qa' ),
--		('j', 4,'qa' ),
--		('j', 4,'qa' );
	
With cte as 
(select *, ROW_NUMBER() over(partition by name, salary, department order by name, salary, department) as rnk from employees)

delete from cte where rnk > 1
select * from employees







