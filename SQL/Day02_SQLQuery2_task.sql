create database task2;
use task2;
/*
create table Departments (DepartmentId int primary key IDENTITY(1,1),DepartmentName text NOT NULL,Location varchar(50) NOT NULL,);

create table Customers (CustomerId int primary key IDENTITY(101,1),CustomerName text NOT NULL,Email varchar(20) NOT NULL,Phone biginT NOT NULL,DepartmentId int NOT NULL,constraint mob check(len(Phone)=10 and Phone LIKE '[0-9]%'),FOREIGN KEY(DepartmentId) REFERENCES Departments(DepartmentId));



create table Orders (OrderId int primary key IDENTITY(1001,1),CustomerId int,OrderDate date NOT NULL,TotalAmount Decimal(10,2) NOT NULL,FOREIGN KEY(CustomerId) REFERENCES Customers(CustomerId));

insert into Departments (DepartmentName,Location) VALUES ('IT','Ahmedabad'),('Bug','Surat'),('Developer','Punjab'),
('Tester','Up'));


exec sp_columns Departments;

insert into Customers (CustomerName,Email,Phone,DepartmentId) VALUES('mansi','mn20@gmail.com',9685695620,2),('krishna','krish20@gmail.com',89564578965,1);
insert into Customers (CustomerName,Email,Phone,DepartmentId) VALUES ('ganesha','ganesh201@gmail.com',8457895620,3);
insert into Customers (CustomerName,Email,Phone,DepartmentId) VALUES ('pooja','pooja201@gmail.com',8956458950,1);
insert into Customers (CustomerName,Email,Phone,DepartmentId) VALUES ('prerna','prerna201@gmail.com',8945789560,3),('ginni','ginni191@gmail.com',789895602,1),
insert into Customers (CustomerName,Email,Phone,DepartmentId) VALUES ('om','om21@yahoo.in',8457895620,1);

insert into Orders (CustomerId,OrderDate,TotalAmount) VALUES (105,'2025-01-05',5000),(101,'2024-08-12',10000),(101,'2020-04-18',80000),(101,'2021-04-18',147800);
insert into Orders (CustomerId,OrderDate,TotalAmount) VALUES (105,'2024-11-15',500),(105,'2024-08-10',100),(101,'2024-06-28',800);
insert into Orders (CustomerId,OrderDate,TotalAmount) VALUES (101,'2023-11-15',500);


*/


insert into Orders (OrderDate,TotalAmount) VALUES ('2020-08-15',10000);

--QUERY1.--

SELECT OrderId,CustomerName,OrderDate FROM Orders join Customers on Orders.CustomerId=Customers.CustomerId;


--Query2 or we can use full join too-- 
SELECT OrderId,CustomerName,OrderDate FROM Orders left join Customers on Orders.CustomerId=Customers.CustomerId;
--or
SELECT OrderId,CustomerName,OrderDate FROM Orders left join Customers on Orders.CustomerId!=Customers.CustomerId;

--Query3

SELECT OrderId,CustomerName,OrderDate FROM Customers left join Orders on Customers.CustomerId=Orders.CustomerId;

--Query4
--only blank record dis
--SELECT OrderId,CustomerName,OrderDate FROM Orders left join Customers on Orders.CustomerId=Customers.CustomerId where CustomerName is null;

SELECT OrderId,CustomerName,OrderDate FROM Customers full outer join Orders on Customers.CustomerId=Orders.CustomerId;

--Query5
SELECT * from Customers cross join Orders;

--Query6 
select top 3 Customers.CustomerId,count(Orders.CustomerId),sum(TotalAmount) as total from Customers join Orders on Customers.CustomerId=Orders.CustomerId group by Customers.CustomerId,TotalAmount  order by TotalAmount desc;
--or
SELECT TOP 3 
    c.CustomerId, 
    CAST(c.CustomerName AS NVARCHAR(255)) AS CustomerName,  
    SUM(o.TotalAmount) AS TotalSpent
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerId = o.CustomerId
GROUP BY 
    c.CustomerId, CAST(c.CustomerName AS NVARCHAR(255))  
ORDER BY 
    TotalSpent DESC;


--SELECT count(CustomerId) as TotalOrders,CustomerId,TotalAmount from Orders group by CustomerId order by TotalOrders desc;

--Query7
SELECT OrderId,CustomerName,OrderDate FROM Orders left join Customers on Orders.CustomerId=Customers.CustomerId where CustomerName is null;
--or
SELECT Customers.CustomerId,CustomerName,Email,Phone FROM Customers left join Orders on Customers.CustomerId=Orders.CustomerId where Orders.CustomerId IS NULL;

--Query8

select count(OrderId) as "total_order",Customers.CustomerId,CAST(CustomerName as nvarchar(20)) as CustomerName,
sum(Orders.TotalAmount) as "total amount" from Orders join Customers on Orders.CustomerId=Customers.CustomerId
where year(OrderDate)=2024
group by Customers.CustomerId,CAST(CustomerName as nvarchar(20)) ;


--Query9 bki
select avg(TotalAmount) from Departments join Customers on Departments.DepartmentId=Customers.CustomerId join Orders on Customers.CustomerId=Orders.CustomerId 
group by 


select top 5 DepartmentId,DepartmentName FROM Departments;

select top 5 
d.DepartmentId,
CAST(DepartmentName as nvarchar(200))as "Department Name",
avg(o.TotalAmount)as "Average Total Amount Spent" 
	FROM  Customers c
join 
	Departments d on c.DepartmentId=d.DepartmentId 
join Orders o on o.CustomerId=c.CustomerId 
group by d.DepartmentId,CAST(DepartmentName as nvarchar(200))
order by "Average Total Amount Spent" Desc;



--Query10
SELECT top 1
    COUNT(c.CustomerId) AS "Total Orders", 
    c.DepartmentId, 
    CAST(d.DepartmentName AS NVARCHAR(200)) AS DepartmentName  
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerId = o.CustomerId
JOIN 
    Departments d ON c.DepartmentId = d.DepartmentId
GROUP BY 
    c.DepartmentId, CAST(d.DepartmentName AS NVARCHAR(200)) 
ORDER BY   
	"Total Orders" DESC  ;
   

select * from Departments;
select * from Customers;
select * from Orders;

--11.
select top 3 c.CustomerId,CAST(c.CustomerName as NVARCHAR(200))as CustomerName,sum(TotalAmount)as "Total Amount"
from Customers c 
join Orders o on c.CustomerId=o.CustomerId 
group by c.CustomerId,
CAST(c.CustomerName as NVARCHAR(200)),
OrderDate 
having OrderDate like '2024%' order by sum(TotalAmount) Desc;

--12.
SELECT 
    d.DepartmentId,
    CAST(d.DepartmentName AS NVARCHAR(200)) AS "DepartmentName",
    COUNT(c.CustomerId) AS "Total Employees",  
    COUNT(o.OrderId) AS "Total Orders"  
FROM 
    Departments d
JOIN 
    Customers c ON d.DepartmentId = c.DepartmentId  
JOIN 
    Orders o ON o.CustomerId = c.CustomerId 
GROUP BY 
    d.DepartmentId, CAST(d.DepartmentName AS NVARCHAR(200))  
HAVING 
    COUNT(c.CustomerId) >= 2;  

--13.

SELECT 
    C.CustomerId,
    CAST(c.CustomerName AS NVARCHAR(200))as CustomerName,
    C.Email,
    C.Phone
FROM Customers C
JOIN Orders O ON C.CustomerId = O.CustomerId
WHERE YEAR(O.OrderDate) IN (2023, 2024)
GROUP BY C.CustomerId,  CAST(c.CustomerName AS NVARCHAR(200)), C.Email, C.Phone
HAVING COUNT(DISTINCT YEAR(O.OrderDate)) = 2;