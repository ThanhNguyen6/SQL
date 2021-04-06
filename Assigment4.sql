/*Answer following questions
1.	What is View? What are the benefits of using views?
A view is a virtual table whose contents are defined by a query. 
Like a real table, a view consists of a set of named columns and rows of data
Benefits of views:
- Simplify data manipulation
- enable you to create a backward compatible interface for a table when its schema changes
- to customize data
- useful to combine similary structure data from different servers
2.	Can data be modified through views?
Data can be modified through views
3.	What is stored procedure and what are the benefits of using it?
A stored procedure is a groups of 1 or more T-SQL statements into a logical unit, store as an object in a SQL server database
Benefits of Stored Procedure:
- increase database security by limited direct access
- faster execution/ improve performance because the database can optimize the data access plan
used by the procedure and cache it for subsequent reuse.
- reduce network traffic for larer ad hoc queries
- stored procedures encourage code reusability.
- help centralize your T-SQL code in the data tier.
4.	What is the difference between view and stored procedure?
- view does not accepts parameters but stored procedure does 
- View can be used as a building block in large query but stored procedure does not
- View can contain only one sing select query but stored procedure can contain several statement like if, else, loop, etc
- View can not perform modification to any table but stored procedure does
- Unlike user-defined functions or views, when a stored procedure is execured for the first time, SQL
 determines the most optimal query access plan and stores it in the plan memory cache.
 SQL server can then reuse the plan onsubsequent executions of this stored procedure.

5.	What is the difference between stored procedure and functions?
- Funtion can be only used in a SQL statement, mostly in a select statement or representing a data or a dataset
- A function can be called by a procedure but a procedure cannot be called by a function
- DML statements cannot be executed within a function but can be executed within a procedure.
- Whenever a function is called it is first compiled before being called but stored procedure is compiled once
- A select statement can have a function call but can't have a procedure call.
6.	Can stored procedure return multiple result sets?
Stored procedure can return multiple result sets
7.	Can stored procedure be executed as part of SELECT Statement? Why?
Stored procedure can be executed as part of SELECT statement if that stored procedure return a resutl set.
If it return multiple result set then tit cannot be executed as part of SELECT statement 
8.	What is Trigger? What types of Triggers are there?
- trigger is a special type of stored procedure that is executed when a specific event happens.
- type of triggers:
+ DDL triggers
+ DML triggers
+ CLR triggers
+ Logon Triggers
9.	What are the scenarios to use Triggers?
Usage of Triggers are:
- Enforeced integrity beyond simple referential integrity
- implement business rules
- maintain audit record of changes
- Accomplish cascading updates and deletes
10.	What is the difference between Trigger and Stored Procedure?
- trigger is a special type of stored procedure which only fired when a specific event happen.
- trigger can execure automatically based on event while stored procedure can be invoke explicitly by the user
- trigger can't take input as parameter while stored procedure can
- trigger can't return values while stored procedure can
- can't used transaction statements like commit, rollback inside a trigger
*/

--Write queries for following scenarios
--Use Northwind database. All questions are based on assumptions described by the Database Diagram sent to you yesterday.
-- When inserting, make up info if necessary. Write query for each step. Do not use IDE. BE CAREFUL WHEN DELETING DATA OR DROPPING TABLE.
--1.	Lock tables Region, Territories, EmployeeTerritories and Employees. Insert following information into the database. In case of an error, no changes should be made to DB.
--a.	A new region called “Middle Earth”;
Insert into region values(5, 'Middle Earth');
--b.	A new territory called “Gondor”, belongs to region “Middle Earth”;
insert into Territories values(12345, 'Gondor', 5)
--c.	A new employee “Aragorn King” who's territory is “Gondor”.
insert into Employees(LastName, FirstName) values('King', 'Aragorn')

--2.	Change territory “Gondor” to “Arnor”.
update Territories set TerritoryDescription='Arnor' where TerritoryID=12345
--3.	Delete Region “Middle Earth”. (tip: remove referenced data first) (Caution: do not forget WHERE or you will delete everything.)
-- In case of an error, no changes should be made to DB. Unlock the tables mentioned in question 1.
Delete from Region where RegionDescription='Middle Earth'
--4.	Create a view named “view_product_order_[your_last_name]”, list all products and total ordered quantity for that product.

Create View  view_product_order_Nguyen as
select p.productID, sum(od.Quantity) as 'total quantity' from Products as p 
		inner join [Order Details] as od on p.ProductID=od.ProductID
		group by p.ProductID
go
select * from view_product_order_Nguyen

--5.	Create a stored procedure “sp_product_order_quantity_[your_last_name]”
-- that accept product id as an input and total quantities of order as output parameter.
drop procedure dbo.total_quantity
go
create Procedure dbo.total_quantity
 @ProductID int,
 @quantities int OUTPUT
AS
 select @quantities=sum(quantity) from dbo.[Order Details] where ProductID=@ProductID group by ProductID
go

declare @qu int
execute dbo.total_quantity 23, @qu OUTPUT
print @qu

--6.	Create a stored procedure “sp_product_order_city_[your_last_name]” that accept product name as an input and 
-- top 5 cities that ordered most that product combined with the total quantity of that product ordered from that city as output.
create procedure sp_product_order_city_nguyen
	@ProductName nvarchar(40)
as
	declare @proID int
	select @proID= productID from dbo.Products where ProductName=@ProductName
	select top 5 shipcity, sum(quantity) as 'total quantity' from [Order Details] as od
	inner join Orders as o on od.OrderID=od.OrderID
	group by od.ProductID, ShipCity having od.ProductID=@proID 
	order by [total quantity] desc
go

execute sp_product_order_city_nguyen @ProductName='Chai'
--7.	Lock tables Region, Territories, EmployeeTerritories and Employees. 
-- Create a stored procedure “sp_move_employees_[your_last_name]” that automatically find all employees in territory “Tory”; 
--if more than 0 found, insert a new territory “Stevens Point” of region “North” to the database, and then move those employees to “Stevens Point”.
drop procedure sp_move_employees_nguyen
go
create procedure sp_move_employees_nguyen
as
	declare @rowCount int
	select distinct e.EmployeeID from EmployeeTerritories as e inner join EmployeeTerritories as et
	on e.EmployeeID=et.EmployeeID
	inner join Territories as t on et.TerritoryID=t.TerritoryID
	where t.TerritoryDescription='Tory'
	select @rowCount=@@ROWCOUNT
	if @rowCount > 0
	begin
		insert into Territories values(12346,'Steven Point', '3')
		update EmployeeTerritories set TerritoryID=12346 where TerritoryID=
		(select TerritoryID from Territories where TerritoryDescription='Troy')
	end
	
go
execute sp_move_employees_nguyen

--8.	Create a trigger that when there are more than 100 employees in territory “Stevens Point”, move them back to Troy.
--(After test your code,) remove the trigger. Move those employees back to “Troy”, if any. Unlock the tables.
create trigger temp
on employees
after insert
as
begin
	declare @rowCount int
	select distinct e.EmployeeID from EmployeeTerritories as e inner join EmployeeTerritories as et
	on e.EmployeeID=et.EmployeeID
	inner join Territories as t on et.TerritoryID=t.TerritoryID
	where t.TerritoryDescription='Steven Point'
	select @rowCount=@@ROWCOUNT
	if @rowCount > 100
	begin
		update EmployeeTerritories set TerritoryID=12345 where TerritoryID=
		(select TerritoryID from Territories where TerritoryDescription='Steven Point')
	end
end
--9.	Create 2 new tables “people_your_last_name” “city_your_last_name”.
--City table has two records: {Id:1, City: Seattle}, {Id:2, City: Green Bay}. 
--People has three records: {id:1, Name: Aaron Rodgers, City: 2}, {id:2, Name: Russell Wilson, City:1}, {Id: 3, Name: Jody Nelson, City:2}.
--Remove city of Seattle. If there was anyone from Seattle, put them into a new city “Madison”.
Create a view “Packers_your_name” lists all people from Green Bay. If any error occurred, no changes should be made to DB.
(after test) Drop both tables and view.
Create table city_nguyen(id int primary key, city nvarchar(20))
Create table people_nguyen(ind int primary key, name nvarchar(20), city int)
go
insert into people_nguyen values(1, 'Seattle'), (2, 'Green Bay')
insert into city_nguyen values(1, 'Aaron Rodgers', 2), (2, 'Russell Wilson', 1), (3, 'Jody Nelson', 2)
go
delete from city_nguyen where city='Seattle'
insert into city_nguyen values(3, 'Madison')
update people_nguyen set city=3 where city=1
go
create view Packers_nguyen
as 
	select * from people_nguyen where city=2
go
--10.	 Create a stored procedure “sp_birthday_employees_[you_last_name]” that creates a new table “birthday_employees_your_last_name” 
--and fill it with all employees that have a birthday on Feb. (Make a screen shot) drop the table.
--Employee table should not be affected.

create procedure sp_birthday_employees_nguyen
as
	create table birthday_employees_nguyen(id int primary key, [last name] nvarchar(20), [first name] nvarchar(20), birthdate datetime)
	insert into birthday_employees_nguyen(id, [last name], [first name], birthdate) 
	select e.EmployeeId, e.LastName, e.FirstName, e.BirthDate from dbo.Employees as e
	where month(e.birthdate)=2;
go
execute sp_birthday_employees_nguyen
drop table birthday_employees_nguyen

--11.	Create a stored procedure named “sp_your_last_name_1” that returns all cites that have at least 2 customers who have bought no or only one kind of product.
--Create a stored procedure named “sp_your_last_name_2” that returns the same but using a different approach. (sub-query and no-sub-query).

create procedure sp_nguyen1
as
	select distinct c.city from Customers as c where c.CustomerID in 
	(select o.CustomerID from Orders as o 
	inner join [Order Details] as od on od.OrderID=o.OrderID
	group by o.CustomerID, od.ProductID having count(od.productId) <2 and COUNT(o.customerID) >=2)
go

create procedure sp_nguyen_2
as
	select c.city, c.customerId from customers as c 
	inner join orders as o on c.CustomerID=o.CustomerID
	inner join [Order Details] as od on od.OrderID=o.OrderID
	group by c.CustomerID, c.city, od.ProductID having count(od.ProductID) <2 and count(c.customerID)>=2

go

--12.	How do you make sure two tables have the same data?
 select * from table1
 except
 select * from table2
--14.
--First Name	Last Name	Middle Name
--John	Green	
--Mike	White	M
--Output should be
--Full Name
--John Green
--Mike White M.
 select [first name] + ' ' + [last name] + ' ' + [middle name] + '.'
--Note: There is a dot after M when you output.
--15.
--Student	Marks	Sex
--Ci	70	F
--Bob	80	M
--Li	90	F
--Mi	95	M
--Find the top marks of Female students.
--If there are to students have the max score, only output one.
 select top 1 from studentTable where sex='F' order by marks decs
--16.
--Student	Marks	Sex
--Li	90	F
--Ci	70	F
--Mi	95	M
--Bob	80	M
--How do you out put this?
 select student, marks, sex from studentTable where sex='f' order by marks decs
 union
 select student, marks, sex from studentTable where sex='m' order by marks decs
--GOOD  LUCK.
