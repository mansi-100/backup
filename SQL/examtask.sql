create database exam;
use exam;

create table Customers (CustomerId int primary key identity(1,1),name varchar(20) not null,
email varchar(40) unique not null,Address varchar(60) not null);
insert into Customers (name,email,Address)
values ('John Doe','john@example.com','123 Elm st'),('Jane Smith','jane@example.com','456 Oak st'),('Alice Brown','alice@example.com','789 Pine st');

insert into Customers values 
('Michael Johnson', 'michael@example.com', '101 Maple St'),
('Emily Davis', 'emily@example.com', '202 Birch St'),
('David Wilson', 'david@example.com', '303 Cedar St'),
('Sophia Martinez', 'sophia@example.com', '404 Spruce St'),
('Daniel Anderson', 'daniel@example.com', '505 Walnut St');

insert into Customers (name, email, Address) values 
('mansi','mansi88@gmail.com','101 ahm'),
('aditi','aditi33@gmsil.com','404 jpr');
--drop table Customers;

select * from Customers;

create table Products (ProductId int primary key identity(101,1),Prodname varchar(30) not null,price decimal(10,2) not null,stockQuantity int not null);
insert into Products (Prodname,price,stockQuantity) values ('Laptop',800,50),('Smartphone',500,30),('Headphones',150,100);
insert into Products (Prodname, price, stockQuantity) values 
('Tablet', 300, 40),
('Smartwatch', 200, 60),
('Camera', 600, 20),
('Printer', 150, 25),
('Monitor', 250, 35);
--drop table Products;
select * from Products;

create table Orders (OrderId int primary key identity(201,1),CustomerId int not null,OrderDate date not null,TotalAmount int not null,
foreign key(CustomerId) references Customers(CustomerId));
insert into Orders (CustomerId,OrderDate,TotalAmount) values (1,'2024-08-10',1200),(2,'2024-08-03',500),(1,'2024-08-05',800);
insert into Orders (CustomerId, OrderDate, TotalAmount) values 
(3, '2024-08-12', 900),
(4, '2024-08-15', 400),
(5, '2024-08-18', 700),
(1, '2024-08-20', 300),
(2, '2024-08-22', 600);
--drop table Orders;

insert into Orders (CustomerId, OrderDate, TotalAmount) values 
(9,'2023-01-01',700),
(10,'2023-02-01',700);

truncate table Orders;

select * from OrderDetail;

create table OrderDetail(OrderDetailId int primary key identity (301,1),OrderId int not null,ProductId int not null,Price int not null,
quantity int not null,foreign key(OrderId) references Orders(OrderId),foreign key (ProductId) references Products (ProductId));
insert into OrderDetail (OrderId,ProductId,Price,quantity) values (201,101,100,2),(202,102,200,1),(203,103,300,3);
insert into OrderDetail (OrderId, ProductId, Price, quantity) values 
(204, 104, 300, 1),
(205, 105, 200, 2),
(206, 106, 600, 1),
(207, 107, 150, 1),
(208, 108, 250, 2),
(204, 101, 800, 1),
(205, 102, 500, 1),
(206, 103, 150, 2),
(207, 104, 300, 1),
(208, 105, 200, 1),
(204, 106, 600, 1),
(205, 107, 150, 2),
(206, 108, 250, 1),
(207, 101, 800, 1),
(208, 102, 500, 1),
(204, 103, 150, 1),
(205, 104, 300, 2),
(206, 105, 200, 1),
(207, 106, 600, 1),
(208, 107, 150, 1);
select * from OrderDetail;

drop table OrderDetail;



select * from Customers;
select * from Products;
select * from Orders;
select * from OrderDetail;


--2.
SELECT 
    Customers.CustomerId, 
    Customers.Name, 
    SUM(Orders.TotalAmount) AS TotalAmountSpent
FROM Orders 
JOIN Customers ON Customers.CustomerId = Orders.CustomerId 
GROUP BY Customers.CustomerId, Customers.Name 
ORDER BY TotalAmountSpent DESC;

--3.

select top 5 Products.ProductId,Prodname,sum(quantity)as OrderCount   from Products join OrderDetail on Products.ProductId=OrderDetail.ProductId
group by Products.ProductId,Prodname order by OrderCount desc;

--4.
alter procedure insertProd
	@prodid int,
	@name varchar(30),
	@price decimal(10,2),
	@quantity int	
as
begin
	if exists (select * from Products where ProductId=@prodid)--select 1 means wheather the record is exist or not 
	begin
		update Products set Prodname=@name,price=@price,stockQuantity=@quantity where ProductId=@prodid;
		select * from Products;
	end
	else 
	begin
		insert into Products (Prodname,price,stockQuantity)   VALUES (@name, @price, @quantity);
		select * from Products;

	end
end;
select * from Products;

exec insertProd 109,'cpu',500,10;
exec insertProd 111,'CPU',10000,10;

select * from Products;
select * from Orders;
select * from OrderDetail;


--5
alter procedure insertOrder
	@custid int,
	@date date,
	@prodid int,
	@quantity int

as
begin
    DECLARE @orderid INT;

	
		declare @price int;
		select  @price=price from Products where ProductId=@prodid;

		insert into Orders (CustomerId,OrderDate,TotalAmount)   VALUES (@custid, @date, @price*@quantity);


		set @orderid=scope_identity();
		insert into OrderDetail (OrderId,ProductId,Price,quantity) values (@orderid,@prodid,@price,@quantity);

		select * from Orders;
		select * from OrderDetail;

		update Products set stockQuantity=stockQuantity-@quantity;
		select * from Products;


end

exec insertOrder 4,'2020-02-05',107,1; --custid,date,prodid,quantity

--6.
create function discount
(
	@TotalAmount DECIMAL(10, 2)
)
returns DECIMAL(10,2)
AS
begin
	DECLARE @discount decimal(10,2)
	if @TotalAmount >= 1000
	set @discount = @TotalAmount * 0.20;
	else if @TotalAmount >=500
	set @discount = @TotalAmount * 0.10;
	else 
	set @discount = 0;
return @discount;
end;

SELECT OrderID, TotalAmount, 
       dbo.Discount(TotalAmount) AS DiscountAmount
FROM Orders;
SELECT * FROM Orders;
--7.
alter procedure Seven
	@id int
as
begin
	SELECT OrderID, TotalAmount as OriginalAmount,
       dbo.Discount(TotalAmount) AS DiscountApplied,
	    CASE 
            WHEN TotalAmount >= 1000 THEN '20%'
            WHEN TotalAmount >= 500 THEN '10%'
            ELSE '0%'
        END AS DiscountRate,
	   TotalAmount-dbo.Discount(TotalAmount) as FinalAmount
FROM Orders where OrderID=@id;
end;

exec Seven 201;

--8.
alter procedure Eight
	@id varchar(20)

as
begin
	 SELECT p.ProductId,Prodname,stockQuantity,price
    FROM Products p
    INNER JOIN (
        SELECT value AS ProductId
        FROM STRING_SPLIT(@id, ',')
    ) AS sv ON p.ProductId = sv.ProductId;
end

exec Eight '101,102,104';

--9.
select * from Products;
select * from Orders;
select * from Products;
select * from OrderDetail;


SELECT 
    p.ProductId,
    p.Prodname AS ProductName,
    SUM(od.Quantity) AS TotalSold,
    SUM(od.Price * od.Quantity) AS TotalRevenue,
    AVG(od.Quantity) AS AvgOrderQty,
    STDEV(od.Quantity) AS StdDevOrderQty
FROM 
    Products p
JOIN 
    OrderDetail od ON p.ProductId = od.ProductId
GROUP BY 
    p.ProductId, p.Prodname;

--10.
select * from Products;
select * from OrderDetail;
select * from Customers;
select * from Orders;

insert into Orders (CustomerId,OrderDate,TotalAmount) values (1,'2024-02-01',1200);
--select * from Customers left join Orders  on Customers.CustomerId=Orders.CustomerId where OrderId is null;
alter PROCEDURE GetInactiveCustomers
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.CustomerID, 
        c.Name AS CustomerName,
        MAX(o.OrderDate) AS LastOrderDate
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerID, c.Name
    HAVING 
        MAX(o.OrderDate) < DATEADD(MONTH, -6, GETDATE()); 
END;

EXEC GetInactiveCustomers;

select * from Customers;
select * from Orders;

--11.
alter procedure Elevan
as
begin
	select Orders.CustomerId,name as CustomerName,
	case 
		when count(Orders.CustomerId)>=3 and sum(TotalAmount)>1000 then 'Gold'
		when count(Orders.CustomerId)=2 and sum(TotalAmount)>500 then 'Silver'
		else 'Bronze'
		end as Category,count(Orders.CustomerId) as "Number Of Orders" ,
	sum(TotalAmount) as "OrderAmount"
	from Orders join Customers on Orders.CustomerId=Customers.CustomerId 
	group by name,Orders.CustomerId
	having Orders.CustomerId>3;
end


exec Elevan;

--insert into Orders (CustomerId,OrderDate,TotalAmount) values (9,'2024-08-10',12000);
