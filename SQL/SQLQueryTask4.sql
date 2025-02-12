create database task4;
use task4;

create table Customer (CustomerId int primary key identity(1,1),Name varchar(20),city varchar(30),state varchar(30),Address varchar(50));
drop table Customer;
create table Product (ProductId  int primary key identity(101,1),ProductName varchar(20),CustomerID varchar(20),category varchar(40),qty int,price decimal(10,2));

create table Orders (OrderId int primary key IDENTITY(1001,1),CustomerId int NOT NULL,
OrderDate datetime NOT NULL,Qty INT NOT NULL,
Rate DECIMAL(10,2) NOT NULL ,TotalAmount DECIMAL(10,2) NOT NULL,ProductID INT  NOT NULL,
FOREIGN KEY(CustomerId) REFERENCES Customer(CustomerId),FOREIGN KEY(ProductID) REFERENCES Product(ProductId));


SELECT * FROM Orders;


create table Payment (PaymentID INT PRIMARY KEY IDENTITY(10001,1),OrderID INT NOT NULL,Amount DECIMAL(10,2) NOT NULL,
PaymentDate DATETIME NOT NULL,FOREIGN KEY(OrderID) REFERENCES Orders(OrderId)); 

exec sp_columns Payment;

exec sp_columns Customer;
--1.
create type CustomerType as table(
	Name varchar(20),
	city varchar(30),
	state varchar(30),
	Address varchar(50)
);
--drop type CustomerType;

ALTER PROCEDURE BulkCustomers
    @Customer CustomerType READONLY
AS
BEGIN
    INSERT INTO Customer (Name, city, state, Address) 
    --SELECT Name, city, state, Address FROM @Customer;
	 SELECT Name, city, state, Address FROM Customer;
	 select * from Customer;
END;
--drop procedure BulkCustomer;
declare @customer CustomerType;


INSERT INTO @customer (Name, City, State, Address)
VALUES ('Viv1', 'ABAD', 'GUJ', 'VASTRAL')
    --('Mansi', 'Ahmedabad', 'Gujarat', 'Krishnanagar', 'mansi@example.com'),
    --('Krishna', 'Surat', 'Gujarat', 'Kanpur', 'krishna@example.com'),
    --('John Doe', 'New York', 'NY', '123 Main St', 'johndoe@example.com'),
    --('Jane Smith', 'Los Angeles', 'CA', '456 Elm St', 'janesmith@example.com'),
    --('Ananya Patel', 'Mumbai', 'Maharashtra', 'Andheri East', 'ananya@example.com'),
    --('Ravi Kumar', 'Bangalore', 'Karnataka', 'MG Road', 'ravi.kumar@example.com'),
    --('Emily Johnson', 'Chicago', 'Illinois', '456 Oak St', 'emily.johnson@example.com'),
    --('Sanjay Mehta', 'Delhi', 'Delhi', 'Connaught Place', 'sanjay.mehta@example.com'),
    --('David Brown', 'San Francisco', 'California', 'Market Street', 'david.brown@example.com'),
    --('Aarav Sharma', 'Pune', 'Maharashtra', 'Kothrud', 'aarav.sharma@example.com'),
    --('Sophia Williams', 'Houston', 'Texas', 'Main Street', 'sophia.williams@example.com'),
    --('Liam Anderson', 'Los Angeles', 'California', 'Sunset Boulevard', 'liam.anderson@example.com'),
    --('Maya Singh', 'Chennai', 'Tamil Nadu', 'T Nagar', 'maya.singh@example.com'),
    --('Ethan Davis', 'Boston', 'Massachusetts', 'Beacon Hill', 'ethan.davis@example.com'),
    --('Noah Harris', 'Dallas', 'Texas', 'Elm Street', 'noah.harris@example.com'),
    --('Olivia Martinez', 'Miami', 'Florida', 'Ocean Drive', 'olivia.martinez@example.com'),
    --('James Wilson', 'Seattle', 'Washington', 'Pine Street', 'james.wilson@example.com'),
    --('Charlotte Lee', 'Denver', 'Colorado', '16th Street', 'charlotte.lee@example.com'),
    --('Jack Smith', 'Phoenix', 'Arizona', 'Camelback Rd', 'jack.smith@example.com'),
    --('Lucas Clark', 'Austin', 'Texas', 'Lamar Blvd', 'lucas.clark@example.com'),
    --('Amaya Robinson', 'New Jersey', 'New Jersey', 'Broadway', 'amaya.robinson@example.com'),
    --('Mason Lewis', 'San Diego', 'California', 'Pacific Beach', 'mason.lewis@example.com'),
    --('Grace White', 'Washington DC', 'District of Columbia', 'Capitol Hill', 'grace.white@example.com'),
    --('Benjamin Thompson', 'Detroit', 'Michigan', 'Woodward Ave', 'benjamin.thompson@example.com');

EXEC BulkCustomers @customer;


EXEC BulkCustomer @customer;

select * from Customer;

exec sp_columns Product;
exec sp_columns [Order];


--product

CREATE TYPE ProductType AS TABLE(
    ProductName VARCHAR(20),
    CustomerID VARCHAR(20),
    category VARCHAR(40),
    qty INT,
    price DECIMAL(10, 2) 
);


declare @productdata ProductType;
INSERT INTO @productdata(ProductName, CustomerID, category, qty, price)
VALUES
    ('Laptop', '1', 'Electronics', 50, 1000.00),
    ('Smartphone', '2', 'Electronics', 100, 500.00),
    ('Tablet', '3', 'Electronics', 30, 300.00),
    ('Smartwatch', '4', 'Electronics', 200, 150.00),
    ('Headphones', '5', 'Electronics', 150, 50.00),
    ('Microwave', '6', 'Appliances', 60, 200.00),
    ('Washing Machine', '7', 'Appliances', 45, 350.00),
    ('Refrigerator', '8', 'Appliances', 35, 500.00),
    ('Air Conditioner', '9', 'Appliances', 25, 800.00),
    ('Blender', '10', 'Appliances', 80, 100.00),
    ('Sofa', '11', 'Furniture', 40, 700.00),
    ('Table', '12', 'Furniture', 60, 150.00),
    ('Chair', '13', 'Furniture', 90, 75.00);


INSERT INTO Product(ProductName, CustomerID, category, qty, price)
select ProductName, CustomerID, category, qty, price
from @productdata;

exec sp_columns Orders;

--order
create type OrderType as table(
	CustomerId int,OrderDate datetime,Qty INT ,
	Rate DECIMAL(10,2),TotalAmount DECIMAL(10,2),ProductID int
)
declare @orderData OrderType; --select this and under insert statement together to run because declare creates temp val
insert into @orderData (CustomerId,OrderDate,Qty,Rate,TotalAmount,ProductID)
values 
(1, '2025-02-01', 2, 500.00, 1000.00, 101),
    (2, '2025-02-02', 3, 300.00, 900.00, 102),
    (3, '2025-02-03', 5, 100.00, 500.00, 103),
    (4, '2025-02-04', 1, 150.00, 150.00, 104),
    (5, '2025-02-05', 4, 50.00, 200.00, 105),
    (6, '2025-02-06', 2, 200.00, 400.00, 106),
    (7, '2025-02-07', 3, 350.00, 1050.00, 107),
    (8, '2025-02-08', 1, 500.00, 500.00, 108),
    (9, '2025-02-09', 2, 800.00, 1600.00, 109),
    (10, '2025-02-10', 3, 100.00, 300.00, 110);

insert into Orders (CustomerId,OrderDate,Qty,Rate,TotalAmount,ProductID)
select CustomerId,OrderDate,Qty,Rate,TotalAmount,ProductId from @orderData;

--payment
create type PaymentType as table(
	OrderID INT ,Amount DECIMAL(10,2),
	PaymentDate DATETIME 
);

declare @paymentdata PaymentType;
insert into @paymentdata (OrderID,Amount,PaymentDate)
VALUES 
    (1001, 1000.00, '2025-02-01'),
    (1002, 900.00, '2025-02-02'),
    (1003, 500.00, '2025-02-03'),
    (1004, 150.00, '2025-02-04'),
    (1005, 200.00, '2025-02-05'),
    (1006, 400.00, '2025-02-06'),
    (1007, 1050.00, '2025-02-07'),
    (1008, 500.00, '2025-02-08'),
    (1009, 1600.00, '2025-02-09'),
    (1010, 300.00, '2025-02-10');

insert into Payment (OrderID,Amount,PaymentDate)
select OrderID,Amount,PaymentDate from @paymentdata;



select * from Product;
select * from Customer;
select * from Orders;
select * from Payment;


--drop type ProductType;
--drop procedure BulkProduct;

--2.
select top 10 * from Customer order by city;

--3.
select * from Customer where city like 'ahm%';

--4.
select * from Customer where city in ('Ahmedabad','Mumbai');

--5.
merge into Product as target
using (values 
	('Mobile',5,'Electronics',50000),
	('Tablet',4,'Electronics',2500),
	('Other',5,'Miscallaneous',5000)
)as source (ProductName,CustomerID,category,price)
ON target.ProductName = source.ProductName
when matched then 
	update set ProductName=source.ProductName,CustomerID=source.CustomerID,category=source.category,price=source.price
when not matched then 
	insert(ProductName,CustomerID,category,price)
	values (source.ProductName,source.CustomerID,source.category,source.price);

select * from Product;

--6.
merge into Customer as target
using (values 
	('ganesha','Lahor','Punjab','Rajpur'),
	('juhi','Ahmedabad','Gujarat','Raipur'),
	('Johnn','New York','NYY','1200 main')
)as source (Name,city,state,Address)
ON target.Name = source.Name
when matched then 
	update set Name=source.Name,city=source.city,state=source.state,Address=source.Address
when not matched then 
	insert(Name,city,state,Address)
	values (source.Name,source.city,source.state,source.Address);

select * from Customer;

/*update Payment set Amount=850 where OrderID=1002;
update Payment set Amount=400 where OrderID=1003;
update Payment set Amount=150 where OrderID=1004;
update Payment set Amount=150 where OrderID=1005;
*/

--7.
alter procedure seven
	@custid int,
	@orderdate datetime,
	@qty int,
	@rate  decimal(10,2),
	@total decimal(10,2),
	@prodid int,
	@partial decimal(10,2)
	as
	begin
	 DECLARE @id INT;
		insert into Orders (CustomerId,OrderDate,Qty,Rate,TotalAmount,ProductID) 
		values (@custid,@orderdate,@qty,@rate,@total,@prodid);
		select * from Orders where CustomerId=@custid;

		
		set @id=SCOPE_IDENTITY();

		insert into Payment (OrderID,partial_amount,PaymentDate) values (@id,@partial,@orderdate);
		---select * from Payment;
		---select * from Orders;
		select * from Payment where OrderID=@id;

	end;

exec seven 5,'2024-11-08 03:50:02',5,500,500,103,180

EXEC sp_rename 'Payment.Amount', 'partial_amount', 'COLUMN';

select * from Orders;
select * from Payment;


--8.
alter procedure eight
	@custid int
as
begin
	 ALTER TABLE Orders NOCHECK CONSTRAINT FK__Orders__Customer__6FE99F9F;

	delete from Customer where CustomerId=@custid;
	select * from Customer;

end;

exec eight 1;
select * from Customer;
select * from Orders;

--task1.
select * from Product;
select * from Orders;
select * from Customer;

/*ALTER TABLE Customer
ALTER COLUMN email VARCHAR(50);  */
select sum(partial_amount) as "Total Revenue" ,
category,ProductName 
from Orders 
join Product on Orders.ProductID=Product.ProductId
join Payment on Payment.OrderID=Orders.OrderId 
group by category,ProductName;
/*
alter table Customer add email varchar(20);*/
/*
UPDATE Customer SET email = 'mansi@gmail.com' WHERE CustomerId = 1;
UPDATE Customer SET email = 'krishna@gmail.com' WHERE CustomerId = 2;
UPDATE Customer SET email = 'john.doe@gmail.com' WHERE CustomerId = 3;
UPDATE Customer SET email = 'jane.smith@gmail.com' WHERE CustomerId = 4;
UPDATE Customer SET email = 'ananya.patel@gmail.com' WHERE CustomerId = 5;
UPDATE Customer SET email = 'ravi.kumar@gmail.com' WHERE CustomerId = 6;
UPDATE Customer SET email = 'emily.johnson@gmail.com' WHERE CustomerId = 7;
UPDATE Customer SET email = 'sanjay.mehta@gmail.com' WHERE CustomerId = 8;
UPDATE Customer SET email = 'david.brown@gmail.com' WHERE CustomerId = 9;
UPDATE Customer SET email = 'sophia.williams@gmail.com' WHERE CustomerId = 11;
UPDATE Customer SET email = 'liam.anderson@gmail.com' WHERE CustomerId = 12;
UPDATE Customer SET email = 'maya.singh@gmail.com' WHERE CustomerId = 13;
UPDATE Customer SET email = 'ethan.davis@gmail.com' WHERE CustomerId = 14;
UPDATE Customer SET email = 'noah.harris@gmail.com' WHERE CustomerId = 15;
UPDATE Customer SET email = 'olivia.martinez@gmail.com' WHERE CustomerId = 16;
UPDATE Customer SET email = 'james.wilson@gmail.com' WHERE CustomerId = 17;
UPDATE Customer SET email = 'charlotte.lee@gmail.com' WHERE CustomerId = 18;
UPDATE Customer SET email = 'jack.smith@gmail.com' WHERE CustomerId = 19;
UPDATE Customer SET email = 'lucas.clark@gmail.com' WHERE CustomerId = 20;
UPDATE Customer SET email = 'amaya.robinson@gmail.com' WHERE CustomerId = 21;
UPDATE Customer SET email = 'mason.lewis@gmail.com' WHERE CustomerId = 22;
UPDATE Customer SET email = 'grace.white@gmail.com' WHERE CustomerId = 23;
UPDATE Customer SET email = 'benjamin.thompson@gmail.com' WHERE CustomerId = 24;
UPDATE Customer SET email = 'ganesha@gmail.com' WHERE CustomerId = 25;
UPDATE Customer SET email = 'juhi@gmail.com' WHERE CustomerId = 26;


*/

--task2.
WITH OrderCounts AS (
    SELECT 
        Orders.CustomerId,
		email,
        MONTH(OrderDate) AS Monthh,
        COUNT(Orders.OrderId) AS OrderCount
    FROM Orders
    JOIN Customer ON Orders.CustomerId = Customer.CustomerId
    WHERE OrderDate >= DATEADD(MONTH, -6, GETDATE()) 
    GROUP BY Orders.CustomerId, MONTH(OrderDate),email
)
SELECT 
    c.CustomerId,
    c.Name,
	c.email,
    oc.Monthh,
    oc.OrderCount
FROM OrderCounts oc
JOIN Customer c ON oc.CustomerId = c.CustomerId
WHERE oc.OrderCount >= 3; 

-- Customers with more than 5 orders

select * from Customer;
select * from Orders;

--update Orders set OrderDate='2024-10-19 02:00:00' where OrderId=1014;

--insert into Orders (CustomerId,OrderDate,Qty,Rate,TotalAmount,ProductID) values (1,'2025-02-10 02:20:20:00',2,100,1000.00,101);

--task3.
with Cte1 as(
	select sum(TotalAmount)/count(OrderId) as "average order value",
	Name as "Customer name",sum(TotalAmount)as "total amount",
	count(OrderId)as "Total order" 
	from Orders join Customer on Orders.CustomerId=Customer.CustomerId 
	group by Customer.CustomerId ,Name

)
select * from Cte1;

--task4.
alter table Product drop column qty ;
select * from Product;
select * from Orders;

with data2 as(
	select Product.ProductId,ProductName,qty as "Qty sold" from Product join 
	Orders on Product.ProductId=Orders.ProductID group by Product.ProductId,qty,ProductName 


)
select * from data2 ORDER BY "Qty sold" DESC;

--task5.
create table Customer1 (CustomerId int primary key identity(1,1),Name varchar(20),Address varchar(40));
create table CustomerProducts (ProductId int identity(1,1),ProductName varchar(20),CustomerIDs varchar(20));

insert into Customer1 (Name,Address) values ('Jeshal','Amreli'),('Jigna','Ahmedabad'),('Rajesh','Baroda');
insert into CustomerProducts (ProductName,CustomerIDs) values('Nokia','1,2,3'),('Iphone','2,3'),('Samsung','1');

select * from Customer1;
select * from CustomerProducts;

SELECT 
    c.CustomerId,
    c.Name,
    c.Address,
    STRING_AGG(p.ProductName, ',') AS Products
FROM Customer1 c
JOIN CustomerProducts p 
    ON ',' + p.CustomerIds + ',' LIKE '%,' + CAST(c.CustomerId AS VARCHAR) + ',%'
GROUP BY c.CustomerId, c.Name, c.Address;


/*

WITH CustomerProducts AS (
    SELECT 
        cp.ProductId,
        cp.ProductName,
        TRIM(value) AS CustomerID
    FROM CustomerProducts cp
    CROSS APPLY STRING_SPLIT(cp.CustomerIDs, ',')
)
*/