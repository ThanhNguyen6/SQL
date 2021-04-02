--Assignment Day3 –SQL:  Comprehensive practice
/*Answer following questions
1.	In SQL Server, assuming you can find the result by using both joins and subqueries, which one would you prefer to use and why?
If I can find the result using both joins and subqueries, I woul dprefer to use join for faster performance.
2.	What is CTE and when to use it?
CTE is Common table expressions. We will use CTE for recursive queries and substitute for a view when the
general use of a view is not required; that is, you do not have to store the definition in metadata.
Using a CTE offers the advantages of improved readability and ease in maintenance of complex queries.

3.	What are Table Variables? What is their scope and where are they created in SQL Server?
A table variable is a data type that can be used within a Transact-SQL batch, 
stored procedure, or function—and is created and defined similarly to a table, 
only with a strictly defined lifetime scope. 
Unlike regular tables or temporary tables, table variables can’t have indexes or FOREIGN KEY constraints added to them.
Table variables do allow some constraints to be used in the table definition (PRIMARY KEY, UNIQUE, CHECK).

4.	What is the difference between DELETE and TRUNCATE? Which one will have better performance and why?
Delete and truncate both be used to delete data of the table.
However, truncate delete the entire database of the table without maintaining the integrity of the table.
On other hand, delete statement can be used for deleting the specific data.
truncate is faster than delete.

5.	What is Identity column? How does DELETE and TRUNCATE affect it?
identity column is a way to generate key values in SQL Server tables
truncate reseeds iddentity values whereas delete doesnt.
truncate removes all records and doesn't fire triggers.

6.	What is difference between “delete from table_name” and “truncate table table_name”?
both delete all rows 
but "delete from table_name" does not reset identity key values and truncate does
*/

--Write queries for following scenarios
--All scenarios are based on Database NORTHWND.
--1.	List all cities that have both Employees and Customers.
select city from Customers 
where city in (select city from Employees group by city)
group by city;
--2.	List all cities that have Customers but no Employee.
--a.	Use sub-query
select city from Customers 
where city not in (select distinct city from Employees)
group by city;
--b.	Do not use sub-query
select distinct c.city from Customers as c
left join (select distinct city from Employees) as e
on c.city=e.city
where e.city is null;

--3.	List all products and their total order quantities throughout all orders.
select p.productname, o.sumQuantity from Products as p
left join (select productID, sum(quantity) as sumQuantity from [Order Details] group by ProductID) as o
on p.ProductID = o.ProductID;

--4.	List all Customer Cities and total products ordered by that city.
select c.city, sum(od.Quantity) as sumQuantity from Customers as c
left join Orders as o on c.city= o.ShipCity
inner join [Order Details] as od on o.OrderID=od.OrderID
group by c.city;
--5.	List all Customer Cities that have at least two customers.
--a.	Use union
select c.city from customers as c group by c.city having count(*) >=2
union
select o.shipcity from orders as o group by o.ShipCity

--b.	Use sub-query and no union
select distinct o.shipCity from orders as o
where o.shipcity in (select city from Customers group by city having count(*) >=2)
--6.	List all Customer Cities that have ordered at least two different kinds of products.
select o.Shipcity, count(*) as productTypes from Customers as c
right join orders as o on o.shipcity=c.city
inner join [Order Details] as od on o.OrderID=od.OrderID
group by o.ShipCity having count(*) >=2;

--7.	List all Customers who have ordered products, but have the ‘ship city’ on 
  the order different from their own customer cities.
select distinct c.customerId, c.contactname, c.city, o.ShipCity from customers as c
left join orders as o on o.CustomerID=c.CustomerID and c.City <> o.ShipCity;
--8.	List 5 most popular products, their average price, and the customer city that ordered most quantity of it.

select * from (
select c.city, dt.ProductId, dt.average, DENSE_RANK() over(partition by dt.productId order by dt.[total quantity] desc) as rnk
from customers as c right join (
select o.customerid, od.productID, sum(od.quantity) as 'total quantity', AVG(od.UnitPrice) as average from [Order Details] as od
inner join orders as o on od.OrderID=o.OrderID
group by od.ProductID, o.CustomerID) as dt on c.CustomerID= dt.CustomerID) as dt2
where rnk=1 and dt2.ProductID in 
(select top 5 productId from [Order Details] group by ProductID order by sum(quantity));

--9.	List all cities that have never ordered something but we have employees there.
--a.	Use sub-query
all cities that have order
 all cities that have employee
select e.city from Employees as e
where e.city not in (select distinct shipcity from orders);

----b.	Do not use sub-query
select e.city from employees as e
left join (select distinct shipcity from orders) as o
on e.city=o.ShipCity where o.ShipCity is null;

--10.	List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is,
--and also the city of most total quantity of products ordered from. (tip: join  sub-query)

select  o.shipcity from orders as o 
where o.ShipCity in (
	select top 1 o.ShipCity as totalQuantity from [Order Details] as od
	inner join orders as o on od.OrderID=o.OrderID
	group by o.ShipCity order by sum(od.Quantity))
group by o.ShipCity order by count(*) 


--11. How do you remove the duplicates record of a table?
-- create cte using row_number() over the column then delete the duplicate row where rank >1

--12. Sample table to be used for solutions below- Employee
--( empid integer, mgrid integer, deptid integer, salary integer) Dept (deptid integer, deptname text)
-- Find employees who do not manage anybody.
select empid from employee where empid not in (select distinct mgrid from employee)

--13. Find departments that have maximum number of employees.
--(solution should consider scenario having more than 1 departments that have maximum number of employees). 
--Result should only have - deptname, count of employees sorted by deptname.

with cte as
(select e.deptid, count(*) as numEmployee from employee as e group by e.deptid)

select d.deptname, dt.numemployee from Dept as d
right join 
(select *, rank() over (order by numEmployee) as rnk from cte where rnk=1) as dt
on d.deptid=dt.deptid
order by d.deptname

--14. Find top 3 employees (salary based) in every department. 
--Result should have deptname, empid, salary sorted by deptname and then employee with high to low salary.
-- Employee
--( empid integer, mgrid integer, deptid integer, salary integer)
--Dept (deptid integer, deptname text)
select *
from 
(select d.deptname, e.empid, e.salary from employee as e
left join dept as d on e.deptid=d.deptid) as dt
where DENSE_RANK() over(partition by dt.deptname order by dt.salary desc) <= 3



--GOOD  LUCK.
