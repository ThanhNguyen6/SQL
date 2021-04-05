--1--
select count(1) from production.product;
--2--
select count([ProductSubcategoryID]) from Production.Product;
--3--
select ProductSubcategoryID, count(1) as CountedProducts 
from Production.Product 
where ProductSubcategoryID is not null
group by ProductSubcategoryID;

--4--
select count(1) from Production.Product where ProductSubcategoryID is null;

--5--
select distinct ProductID from Production.ProductInventory;

--6--
select ProductID, sum(Quantity) as TheSum from Production.ProductInventory where LocationID=40 group by ProductID having sum(Quantity) < 100;

--7--
select Shelf, ProductID, sum(Quantity) as TheSum from Production.ProductInventory where LocationID=40 group by ProductID, Shelf having sum(Quantity) < 100;
--8--
select avg(quantity) as AverageQuantity from Production.ProductInventory where LocationID=10;
--9--
select ProductID, shelf, avg(quantity) as averageQuantity from Production.ProductInventory group by ProductID, shelf;

--10--
select ProductID, shelf, avg(quantity) as averageQuantity from Production.ProductInventory where shelf <>'N/A' group by ProductID, shelf;
--11--
select Color, Class, count(1) as TheCount, avg(ListPrice) as AvgPrice from Production.Product
where color is not null and class is not null
group by Color, Class;

--12--
select c.[Name] as Country, s.[Name] as Province from Person.CountryRegion as c join Person.StateProvince as s on s.CountryRegionCode=c.CountryRegionCode;

--13--
select c.[Name] as Country, s.[Name] as Province 
from Person.CountryRegion as c join Person.StateProvince as s on s.CountryRegionCode=c.CountryRegionCode 
where c.[Name] In ('Germany', 'Canada');
--14--
declare @now datetime = getdate();
select p.ProductName
from dbo.[Orders] as o join dbo.[Order Details] as od on o.OrderID=od.OrderID
join dbo.Products as p on p.ProductID = od.ProductID
where datediff(year,@now, o.OrderDate) < 25
group by p.ProductName having count(1) >= 1;
--15--
select top 5 shippostalcode, count([shippostalcode]) as [count] from dbo.Orders group by ShipPostalCode order by count([shippostalcode]) desc;
--16--
select top 5 shippostalcode, count([shippostalcode]) as [count] from dbo.Orders
where datediff(year, getdate(), OrderDate) < 20
group by ShipPostalCode order by count([shippostalcode]) desc;

--17--
select city, count(1) as numberCustomer from dbo.Customers group by city;
--18--
select c.city as City, count(1) as customer from dbo.Customers as c
group by c.city having count(1) > 10;

--19--
select CompanyName from dbo.Customers as c
join 
(select distinct customerID from dbo.Orders
where OrderDate > '19980101') as o
on c.CustomerID=o.CustomerID;
--20--
select distinct c.CompanyName from dbo.Customers as c
join 
(select CustomerID from dbo.orders
group by customerid, orderdate having orderdate=max(orderdate)) as p
on c.CustomerID = p.CustomerID;
--21--
select c.Companyname, sum(od.quantity) as productCount from dbo.customers as c
join dbo.orders as o on c.CustomerID=o.CustomerID
join dbo.[Order Details] as od on od.OrderID=o.OrderID
group by c.CompanyName;
--22--
select c.customerId, sum(od.quantity) as productCount from dbo.customers as c
join dbo.orders as o on c.CustomerID=o.CustomerID
join dbo.[Order Details] as od on od.OrderID=o.OrderID
group by c.CustomerId having sum(od.quantity) > 100;
--23--
select distinct su.companyname as [Supplier Company Name], 
	sh.companyname as [Shipping Company Name]
from dbo.Suppliers as su 
join dbo.Products as prod on su.SupplierID=prod.SupplierID
join dbo.[Order Details] as od on prod.ProductID=od.ProductID
join dbo.Orders as o on od.OrderID=o.OrderId
join dbo.Shippers as sh on sh.ShipperID=o.ShipVia
order by su.CompanyName;

--24--
select o.orderdate, p.productname from dbo.Orders as o
join dbo.[Order Details] as od on o.OrderID=od.OrderID
join dbo.Products as p on p.ProductID=od.ProductID 
order by o.OrderDate;
--25--
select e1.Lastname +' '+ e2.Firstname as first, e2.Lastname +' '+ e2.Firstname as second
from dbo.Employees as e1 join dbo.Employees as e2
on e1.EmployeeID<>e2.EmployeeID and e1.Title=e2.Title;

--26--
select * from dbo.Employees;
select lastname +' '+ firstname as name from dbo.Employees
where EmployeeID in (
select ReportsTo from dbo.Employees
group by ReportsTo having count(*) > 2);

--27--
select city, ContactName, 'Customers' as Type from dbo.Customers
union
select city,contactname, 'Supplier' as Type from dbo.Suppliers

--28--
select f1.t1, f2.t2 from t1 inner join t2
on f1.t1=f2.t2;

-- f1.t1    f2.t2
--  2        2


--29--
select f1.t1, f2.t2 from t1 left join t2
on f1.t1=f2.t2;

-- f1.t1    f2.t2
--  1        null
--  2        2
--  3        null



