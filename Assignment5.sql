/*Assignment Day 5–SQL:  Comprehensive practice
Answer following questions
1.	What is an object in SQL?
An object in sql is a general term that identifies any of the following: views, tables, functions, stored procedure, and etc.

2.	What is Index? What are the advantages and disadvantages of using Indexes?
An index is a physical structure containing pointers to the data. Indices are created in an 
existing table to locate rows more quickly and efficiently. It is possible to create an index on 
one or more columns of a table, and each index is given a name. The users cannot see the 
indexes; they are just used to speed up queries. Effective indexes are one of the best ways 
to improve performance in a database application. A table scan happens when there is no 
index available to help a query. In a table scan SQL Server examines every row in the table 
to satisfy the query results. Table scans are sometimes unavoidable, but on large tables, 
scans have a terrific impact on performance.

Disadvantage of index:
-indexes are stored on disk, so if the table is large it will take up space. however, the disk space is cheap 
enough to trade for application performance, particularly when a dtabase serves a large number of users
- It will slow down update, delete command becuase the database might need to move the entire row into a new position 
if we update a record and change value of indexed column in a clustered index.

3.	What are the types of Indexes?
- A Clustered index is a special type of index that reorders the way records in the table 
are physically stored. Therefore table can have only one clustered index. The leaf 
nodes of a clustered index contain the data pages.
- A Non-Clustered index is a special type of index in which the logical order of the 
index does not match the physical stored order of the rows on disk. The leaf node of 
a non-clustered index does not consist of the data pages. Instead, the leaf nodes 
contain index rows.

4.	Does SQL Server automatically create indexes when a table is created? If yes, under which constraints?
SQL server automatically create indexes when a table is created if there is constraint about unique or primary key

5.	Can a table have multiple clustered index? Why?
Table can only have 1 clustered index because the data rows themselves can be stored in only 1 order.

6.	Can an index be created on multiple columns? Is yes, is the order of columns matter?
The index can be created on multiple columns, and the order of column matters because it will be sorted by the order of column

7.	Can indexes be created on views?
Yes. Indexex can be created on views

8.	What is normalization? What are the steps (normal forms) to achieve normalization?
Normalization is the process of organizing data to minimize redundancy and ensures date consistency.
There are 3 steps to achieve normalization:
1-First form of normalization
Data in each column should be atomic, no multiples values separated by comma.
The table does not contain any repeating column group
Identify each record using primary key.
2- Second Normalization
The table must meet all the conditions of 1NF
Move redundant data to separate table
Create relationships between these tables using foreign keys

3- Third Normalization
Table must meet all the conditions of 1NF and 2nd.
Does not contain columns that are not fully dependent on primary key.

9.	What is denormalization and under which scenarios can it be preferable?

denormalization is opposite of normalization in which we add redundant data to 1 or more tables.
This can help us avoid costly joins in a relational database. Denormalization does not mean not doing normalization.
It is an optimization technique that is applied after normalization.

when you want to speed up data retrieval then we can do denormalization because we do fewer joins.
The queries to retrieve data can be simpler

10.	How do you achieve Data Integrity in SQL Server?
To achieve data integrity in sql server,we need to ensure these 3 integrityies: domain integrity (column),
entity integrity (row integrity), and referential integrity

11.	What are the different kinds of constraint do SQL Server have?
There are 5 types of constraint:
- Primary key
- Foreign Key
- Check
- Unique
- Not Null

12.	What is the difference between Primary Key and Unique Key?
PRIMARY KEY constraints identify the column or set of columns that have values that uniquely identify a row in a table 
UNIQUE constraints enforce the uniqueness of the values in a set of columns 
A table can have only one PRIMARY KEY constraint, Multiple UNIQUE constraints can be defined on a table 

13.	What is foreign key?
A foreign key (FK) is a column or combination of columns that is used to establish and enforce a link between the data in two tables.
You can create a foreign key by defining a FOREIGN KEY constraint when you create or modify a table. 
In practice, A FOREIGN KEY constraint does not have to be linked only to a PRIMARY KEY constraint in another table;
it can also be defined to reference the columns of a UNIQUE constraint in another table, or even any Indexes. 
In textbook, it has to be a PK of another table.

14.	Can a table have multiple foreign keys?
A table can have multiple foreign keys

15.	Does a foreign key have to be unique? Can it be null?
A foreign key doesn't have to be uniqued and can be null

16.	Can we create indexes on Table Variables or Temporary Tables?
We can create indexes on table variables or temporary tables

17.	What is Transaction? What types of transaction levels are there in SQL Server?
Transactions by definition are a logical unit of work  Transaction is a single recoverable unit of work that executes either: Completely
or Not at all
A logical unit of work is a SQL operation or a set of SQL statements executed against a database Usually include at least one statement
and Changes the database from one consistent state to another
There are transaction commit and transaction rollback

*/
--Write queries for following scenarios
--1.	Write an sql statement that will display the name of each customer and the sum of order totals placed by that customer during the year 2002
-- Create table customer(cust_id int,  iname varchar (50)) 
-- create table order(order_id int,cust_id int,amount money,order_date smalldatetime)

select c.iname, sum(*) from customer as c 
inner join order as o on c.cust_id=o.cust_id
where Year(o.order_date)=2002
group by c.iname

-- 2.  The following table is used to store information about company’s personnel:
--Create table person (id int, firstname varchar(100), lastname varchar(100))
--write a query that returns all employees whose last names  start with “A”.

select * from person where lastname LIKE 'A%'

--3.  The information about company’s personnel is stored in the following table:
--Create table person(person_id int primary key, manager_id int null, name varchar(100)not null) 
--The filed managed_id contains the person_id of the employee’s manager.
--Please write a query that would return the names of all top managers
-- (an employee who does not have  a manger, and the number of people that report directly to this manager.

select p.name, count(*) from person as p 
inner join person as p2 on p2.manager_id= p.person_id
where p.manager_id is null
group by p.name
--4.  List all events that can cause a trigger to be executed.
-- insert, delete, update
--5. Generate a destination schema in 3rd Normal Form.  
--Include all necessary fact, join, and dictionary tables, and all Primary and Foreign Key relationships.  
--The following assumptions can be made:
--a. Each Company can have one or more Divisions.
--b. Each record in the Company table represents a unique combination 
--c. Physical locations are associated with Divisions.
--d. Some Company Divisions are collocated at the same physical of Company Name and Division Name.
--e. Contacts can be associated with one or more divisions and the address, but are differentiated by suite/mail drop records.
-- status of each association should be separately maintained and audited.
--create table Company(c_name nvarchar(20) unique primary key)
--create table division(d_id primary key, d_name nvarchar(20), c_name Foreign key, address varchar(2))
--create table contact(id primary key, record_type nvarchar(20), d_id)
--GOOD  LUCK.
