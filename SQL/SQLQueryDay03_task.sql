create database task3;
use task3;
/*
create table Customer (CustomerId int primary key IDENTITY(1,1),FirstName VARCHAR(50) NOT NULL,LastName VARCHAR(50) NOT NULL,
Email VARCHAR(100)  NOT NULL unique ,Phone VARCHAR(20)  NOT NULL unique);

create table Product (ProductID INT primary key IDENTITY(101,1),Name VARCHAR(100) NOT NULL,Price DECIMAL(10,2) NOT NULL,
Description TEXT NOT NULL);


create table Orders (OrderId int primary key IDENTITY(1001,1),CustomerId int NOT NULL,OrderDate datetime NOT NULL,Qty INT NOT NULL,
Rate DECIMAL(10,2) NOT NULL ,TotalAmount DECIMAL(10,2) NOT NULL,ProductID INT  NOT NULL,
FOREIGN KEY(CustomerId) REFERENCES Customer(CustomerId),FOREIGN KEY(ProductID) REFERENCES Product(ProductID));

create table Payment (PaymentID INT PRIMARY KEY IDENTITY(10001,1),OrderID INT NOT NULL,Amount DECIMAL(10,2) NOT NULL,PaymentDate DATETIME NOT NULL,FOREIGN KEY(OrderID) REFERENCES Orders(OrderId)); 

drop table Payment;
*/

select * from Customer;
select * from Product;
select * from Payment;
select * from Orders;


--1.

CREATE PROCEDURE InsertCustomer
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50) ,
	@Email VARCHAR(100),
	@Phone VARCHAR(20)
AS
BEGIN
	INSERT INTO Customer (FirstName,LastName,Email,Phone)
	values (@FirstName,@LastName,@Email,@Phone);

END;	

EXEC InsertCustomer 'mansi','nayak','mn20@gmail.com','8956895605';
EXEC InsertCustomer 'ganesh','shah','ganesh201@gmail.com','945789590';
EXEC InsertCustomer 'krishna','raval','krish19@gmail.com','8884578956';
EXEC InsertCustomer 'Amit', 'Sharma', 'amit.sharma@email.com', '9876543210';
EXEC InsertCustomer 'Priya', 'Patel', 'priya.patel@email.com', '8765432109';
EXEC InsertCustomer 'Rahul', 'Verma', 'rahul.verma@email.com', '7654321098';
EXEC InsertCustomer 'Neha', 'Kapoor', 'neha.kapoor@email.com', '6543210987';
EXEC InsertCustomer 'Vikram', 'Singh', 'vikram.singh@email.com', '5432109876';
EXEC InsertCustomer 'Sanjay', 'Mehta', 'sanjay.mehta@email.com', '9123456780';
EXEC InsertCustomer 'Ritika', 'Sharma', 'ritika.sharma@email.com', '9234567891';

select * from Customer;

create procedure InsertProduct	
	@Name VARCHAR(100),
	@Price DECIMAL(10,2),
	@Description TEXT 	

as 
begin
	insert into Product (Name,Price,Description) values (@Name,@Price,@Description);
end;



EXEC InsertProduct 'Laptop', 799.99, 'High-performance laptop with 16GB RAM and 512GB SSD';
EXEC InsertProduct 'Smartphone', 599.49, 'Latest model with 5G connectivity and 128GB storage';
EXEC InsertProduct 'Wireless Earbuds', 89.99, 'Noise-canceling wireless earbuds with long battery life';
EXEC InsertProduct 'Gaming Mouse', 49.99, 'Ergonomic gaming mouse with customizable RGB lighting';
EXEC InsertProduct 'Mechanical Keyboard', 129.99, 'Mechanical keyboard with Cherry MX switches';
EXEC InsertProduct 'Smartwatch', 199.99, 'Fitness tracking smartwatch with heart rate monitor';
EXEC InsertProduct '4K Monitor', 349.99, 'Ultra HD 4K monitor with 144Hz refresh rate';
EXEC InsertProduct 'External Hard Drive', 120.99, '2TB external hard drive with USB 3.0 support';
EXEC InsertProduct 'Bluetooth Speaker', 79.99, 'Portable Bluetooth speaker with deep bass';
EXEC InsertProduct 'Wireless Charger', 39.99, 'Fast wireless charging pad for smartphones';

select * from Product;

CREATE PROCEDURE InsertOrder
	
    INSERT INTO Orders (CustomerID ,OrderDate, Qty, Rate, TotalAmount, ProductID)
    VALUES (@CustomerID,@OrderDate, @Qty, @Rate, @TotalAmount, @ProductID);
END;


EXEC InsertOrder 2,'2024-02-01', 2, 500.00, 1000.00, 101;
EXEC InsertOrder 1,'2024-02-02', 1, 1500.00, 1500.00, 102;
EXEC InsertOrder 3,'2024-02-03', 3, 200.00, 600.00, 103;
EXEC InsertOrder 4,'2024-02-04', 4, 300.00, 1200.00, 104;
EXEC InsertOrder 5,'2024-02-05', 2, 600.00, 1200.00, 105;
EXEC InsertOrder 7,'2024-02-06', 5, 100.00, 500.00, 106;
EXEC InsertOrder 6,'2024-02-07', 1, 1000.00, 1000.00, 107;
EXEC InsertOrder 8,'2024-02-08', 2, 1200.00, 2400.00, 108;
EXEC InsertOrder 9,'2024-02-09', 3, 400.00, 1200.00, 109;
EXEC InsertOrder 10,'2024-02-10', 4, 350.00, 1400.00, 110;

select * from Orders;
--update Orders set OrderDate='2024-02-04 03:00:00.000' where OrderId=1026;
--update Orders set OrderDate='2024-02-04 02:30:00.000' where OrderId=1027;
--update Orders set OrderDate='2021-10-24 04:30:00.000' where OrderId=1028;


CREATE PROCEDURE InsertPayment
    @OrderID INT,
    @Amount DECIMAL(10,2),
    @PaymentDate DATETIME
AS
BEGIN
    INSERT INTO Payment (OrderID, Amount, PaymentDate)
    VALUES (@OrderID, @Amount, @PaymentDate);
END;

drop procedure InsertPayment;

EXEC InsertPayment 1021, 1000.00, '2024-02-01';
EXEC InsertPayment 1022, 1500.00, '2024-02-02';
EXEC InsertPayment 1023, 600.00, '2024-02-03';
EXEC InsertPayment 1024, 1200.00, '2024-02-04';
EXEC InsertPayment 1025, 1200.00, '2024-02-05';
EXEC InsertPayment 1026, 500.00, '2024-02-06';
EXEC InsertPayment 1027, 1000.00, '2024-02-07';
EXEC InsertPayment 1028, 2400.00, '2024-02-08';
EXEC InsertPayment 1029, 1200.00, '2024-02-09';
EXEC InsertPayment 1030, 1400.00, '2024-02-10';
EXEC InsertPayment 1031, 1400.00, '2024-01-10';

--update  Payment set PaymentDate='2023-08-18' where OrderID=1028;

select * from Payment;


--2.
create procedure UpdateCustomer
	@CustomerId int,
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50) ,
	@Email VARCHAR(100),
	@Phone VARCHAR(20)
AS
BEGIN
	update Customer set FirstName=@FirstName,LastName=@LastName,Email=@Email,Phone=@Phone where CustomerId=@CustomerId;
	select * from Customer;
END;

EXEC UpdateCustomer 2, 'Ganesha', 'Shah', 'ganesh200@gmail.com', '8457845890';
EXEC UpdateCustomer 3, 'Rajesh', 'Patel', 'rajesh.patel@email.com', '9876543210';
EXEC UpdateCustomer 4, 'Amit', 'Gupta', 'amit.gupta@email.com', '9984776655';
EXEC UpdateCustomer 5, 'Sita', 'Iyer', 'sita.iyer@email.com', '8888888888';
EXEC UpdateCustomer 6, 'Anil', 'Kumar', 'anil.kumar@email.com', '8777665544';
EXEC UpdateCustomer 7, 'Priya', 'Desai', 'priya.desai@email.com', '9333556677';

CREATE PROCEDURE UpdateProduct
    @ProductID INT,
    @Name VARCHAR(100),
    @Price DECIMAL(10,2),
    @Description TEXT
AS
BEGIN
    UPDATE Product
    SET Name = @Name,
        Price = @Price,
        Description = @Description
    WHERE ProductID = @ProductID;

    SELECT * FROM Product WHERE ProductID = @ProductID;
END;
select * from Orders;

CREATE PROCEDURE UpdateOrder
    @OrderID INT,
    @CustomerID INT,
    @OrderDate DATETIME,
    @Qty INT,
    @Rate DECIMAL(10,2),
    @TotalAmount DECIMAL(10,2),
    @ProductID INT
AS
BEGIN
    UPDATE Orders
    SET CustomerId = @CustomerID,
        OrderDate = @OrderDate,
        Qty = @Qty,
        Rate = @Rate,
        TotalAmount = @TotalAmount,
        ProductID = @ProductID
    WHERE OrderId = @OrderID;

    SELECT * FROM Orders WHERE OrderId = @OrderID;
END;

drop procedure UpdateOrder;

EXEC UpdateOrder 1021, 1, '2024-02-01 00:00:00', 2, 799.99, 1599.98, 101;
EXEC UpdateOrder 1022, 2, '2024-02-02 00:00:00', 1, 599.49, 599.49, 102;
EXEC UpdateOrder 1023, 3, '2024-02-03 00:00:00', 3, 89.99, 269.97, 103;
EXEC UpdateOrder 1024, 4, '2024-02-04 00:00:00', 1, 49.99, 49.99, 104;
EXEC UpdateOrder 1025, 5, '2024-02-05 00:00:00', 2, 129.99, 259.98, 105;
EXEC UpdateOrder 1026, 6, '2024-02-06 00:00:00', 1, 199.99, 199.99, 106;
EXEC UpdateOrder 1027, 7, '2024-02-07 00:00:00', 4, 349.99, 1399.96, 107;
EXEC UpdateOrder 1028, 8, '2024-02-08 00:00:00', 2, 1200.00, 2400.00, 108;
EXEC UpdateOrder 1029, 9, '2024-02-09 00:00:00', 3, 400.00, 1200.00, 109;
EXEC UpdateOrder 1030, 10, '2024-02-10 00:00:00', 4, 350.00, 1400.00, 110;

CREATE PROCEDURE UpdatePayment
    @PaymentID INT,
    @OrderID INT,
    @Amount DECIMAL(10,2),
    @PaymentDate DATETIME
AS
BEGIN
    UPDATE Payment
    SET OrderID = @OrderID,
        Amount = @Amount,
        PaymentDate = @PaymentDate
    WHERE PaymentID = @PaymentID;

    SELECT * FROM Payment WHERE PaymentID = @PaymentID;
END;

EXEC UpdatePayment 10001, 1021, 1500.00, '2024-02-01';
EXEC UpdatePayment 10002, 1022, 1600.00, '2024-02-02';
EXEC UpdatePayment 10003, 1023, 650.00, '2024-02-03';
EXEC UpdatePayment 10004, 1024, 1300.00, '2024-02-04';
EXEC UpdatePayment 10005, 1025, 1250.00, '2024-02-05';
EXEC UpdatePayment 10006, 1026, 520.00, '2024-02-06';
EXEC UpdatePayment 10007, 1027, 1050.00, '2024-02-07';
EXEC UpdatePayment 10008, 1028, 2450.00, '2024-02-08';
EXEC UpdatePayment 10009, 1029, 1250.00, '2024-02-09';
EXEC UpdatePayment 10010, 1030, 1450.00, '2024-02-10';


--3.
alter PROCEDURE GetCustomerData
AS
BEGIN
    SELECT * FROM Customer;
	 SELECT * FROM Product;
	 SELECT * FROM Orders;
	 SELECT * FROM Payment;


END;
/*
CREATE PROCEDURE GetProductData
AS
BEGIN
    SELECT * FROM Product;
END;

CREATE PROCEDURE GetOrderData
AS
BEGIN
    SELECT * FROM Orders;
END;

CREATE PROCEDURE GetPaymentData
AS
BEGIN
    SELECT * FROM Payment;
END;
*/
 
EXEC GetCustomerData;
/*EXEC GetProductData;
EXEC GetOrderData;
EXEC GetPaymentData;*/

--4.
create procedure DelCustomer
@Custid int
as
begin
	delete from Customer where CustomerId=@Custid;
	select * from Customer;
end;

exec DelCustomer 10;

CREATE PROCEDURE DelProduct
    @ProductId INT
AS
BEGIN
    DELETE FROM Product WHERE ProductID = @ProductId;
    SELECT * FROM Product;
END;

EXEC DelProduct 110;

CREATE PROCEDURE DelOrder
    @OrderId INT
AS
BEGIN
    DELETE FROM Orders WHERE OrderId = @OrderId;
    SELECT * FROM Orders;
END;

EXEC DelOrder 1030;

CREATE PROCEDURE DelPayment
    @PaymentId INT
AS
BEGIN
    DELETE FROM Payment WHERE PaymentID = @PaymentId;
    SELECT * FROM Payment;
END;

EXEC DelPayment 10010;

--5.
create procedure UpdatePrice
	@Price DECIMAL(10,2),
	@Prod int
as
begin
	update Product set Price=@Price where ProductID=@Prod;
	select * from Product;
end;

exec UpdatePrice 50.00,104 ;

--6.
create procedure Calculate
	@Customerid int,
	@orderdate datetime,
	@quantity int,
	@rate DECIMAL(10,2) ,
	@prodid int

as
begin
	declare @total decimal(10,2);
	set @total=@rate*@quantity;
	 INSERT INTO Orders (CustomerId, OrderDate, Qty, Rate, TotalAmount, ProductID)
    VALUES (@Customerid, @orderdate, @quantity, @rate, @total, @prodid);

	select * from Orders;

end;

exec calculate 2,'2024-02-05 05:30:05.000',20,200,102

--7.
create procedure PaymentSeven
	@orderid int,
	@amount DECIMAL(10,2) ,
	@payment DATETIME ="2025-04-13 00:55:50:000"
as
begin
	insert into Payment (OrderID,Amount,PaymentDate) values (@orderid,@amount,@payment);
	select * from Payment;
end

exec PaymentSeven 1022,1600

--8.

	create procedure EightJoin
	as
	begin
		select sum(Amount) as Total_Payment,FirstName as CustomerName from Customer join Orders on Customer.CustomerId=Orders.CustomerId
		join Payment on Payment.OrderID=Orders.OrderID 
		group by FirstName;
	end;

	exec EightJoin
	

--9.
create procedure Nine
as
begin
SELECT 
        c.CustomerId,
        c.FirstName,
        c.LastName,
        c.Email,
        c.Phone
    FROM 
        Customer c
    LEFT JOIN 
        Orders o ON c.CustomerId = o.CustomerId
    LEFT JOIN 
        Payment p ON o.OrderId = p.OrderID
    WHERE 
        p.PaymentID IS NULL; 

end;

exec Nine;
--select * from Orders
--select * from Payment

--10.
create procedure TenCalculate
	@StartDate DATETIME,
    @EndDate DATETIME
as 
begin
	select sum(TotalAmount)as total_revenue from Orders where OrderDate between @StartDate and @EndDate;
end;

exec TenCalculate '2024-01-01','2024-02-01'


--11.
create procedure RetriveData
as 
begin
	select OrderId,Customer.CustomerId,FirstName,OrderDate,Orders.ProductID,Name,Price 
	from Orders 
	join Customer on Orders.CustomerId=Customer.CustomerId 
	join Product on Product.ProductID=Orders.ProductID;

end;

exec RetriveData;

select * from Customer;
--12.
alter procedure Twelve
@val int
as
begin
	select top (@val) * 
	from Payment 
	join Orders on Payment.OrderID=Orders.OrderId 
	join Customer on Customer.CustomerId=Orders.CustomerId 
	order by Amount desc ;

end;

exec Twelve 3;

--13.
ALTER PROCEDURE Thirteen
@months INT  -- Number of months to check
AS
BEGIN
    SELECT DISTINCT 
        C.CustomerId, 
        C.FirstName AS CustomerName, 
        P.PaymentId, 
        P.Amount, 
        P.PaymentDate
    FROM Payment P
    JOIN Orders O ON P.OrderID = O.OrderId
    JOIN Customer C ON O.CustomerId = C.CustomerId
    WHERE P.PaymentDate >= DATEADD(MONTH, -@months, GETDATE())  
    ORDER BY P.PaymentDate DESC;
END;


exec Thirteen 22;


SELECT *  FROM Payment
/*
CREATE PROCEDURE usp_task-23
    @MonthsAgo INT
AS
BEGIN
    SELECT o.OrderID, o.CustomerID, o.OrderDate, o.Rate, o.Qty, o.TotalAmount, o.ProductID
    FROM Orders o
    INNER JOIN Payment p ON o.OrderID = p.OrderID
    WHERE DATEDIFF(MONTH, p.PaymentDate, GETDATE()) <= @MonthsAgo
    ORDER BY o.OrderDate;
END;*/

--14.
select * from Product;
select * from Orders;
select * from Customer;

alter procedure Forteen
as
begin
	select sum(Price) as "Total Revenue",Category from Product group by Category;

end;

exec Forteen;



/*alter table Product add  Category varchar(20);
update Product set  Category='IT' where ProductID=101;
update Product set  Category='Electronic' where ProductID=102 or ProductId=103;
update Product set  Category='IT' where ProductID=104 or ProductID=105;

update Product set  Category='Electronic' where ProductID=106 or ProductId=109;
update Product set  Category='Other' where ProductID=107 or ProductId=108;
*/

/*
create procedure Forteen
as
begin
	SELECT 
		p.Name, 
		SUM(o.Qty * p.Price) AS TotalRevenue
	FROM 
		Orders o
	JOIN 
		Product p ON o.ProductID = p.ProductID
	GROUP BY 
		p.Name;
end;

exec Forteen;
*/

--15.
create procedure Fifteen
as
begin
	SELECT top 1
		p.Name, 
		SUM(o.Qty * p.Price) AS TotalRevenue
	FROM 
		Orders o
	JOIN 
		Product p ON o.ProductID = p.ProductID
	GROUP BY 
		p.Name
	order by TotalRevenue desc;
end;

exec Fifteen;

--16.
alter procedure sixteen
@val date,
@val2 date
as
begin
	select FirstName,Name from Customer 
	join Orders on Customer.CustomerId=Orders.CustomerId 
	join Product on Product.ProductID=Orders.ProductID where
	CAST(OrderDate AS DATE) between @val and @val2

end;

drop procedure sixteen;

exec sixteen '2023-01-01','2024-02-05' --28-02

--17.

alter procedure Seventeen
as
begin
	select Customer.CustomerId,avg(TotalAmount)as "Average Order Val" from Orders 
	join Customer on Orders.CustomerId=Customer.CustomerId
	 group by Customer.CustomerId ;
end;


exec Seventeen;

--18.
alter procedure Eighteen
@val int
as
begin
	SELECT Customer.CustomerId, MAX(TotalAmount) AS HighestTotalAmount
	FROM Orders
	JOIN Customer ON Orders.CustomerId = Customer.CustomerId
	GROUP BY Customer.CustomerId
	ORDER BY HighestTotalAmount DESC;

end;
exec Eighteen 2;

--19.
alter procedure Nineteen
@y int
as
begin
	SELECT 
		c.CustomerId, 
		c.FirstName + ' ' + c.LastName AS CustomerName,
		COUNT(o.OrderID) AS TotalOrders,
		sum(TotalAmount) as TotalRevenue
	FROM 
		Orders o
	JOIN 
		Customer c ON o.CustomerId = c.CustomerId
	WHERE 
		YEAR(o.OrderDate) = @y
	GROUP BY 
		c.CustomerId, c.FirstName, c.LastName
end;

exec Nineteen 2023


--20.
create procedure Twenty
@StartDate date,
@EndDate date
as
begin
	SELECT 
		o.OrderID,
		o.CustomerId,
		o.OrderDate,
		o.TotalAmount
	FROM 
		Orders o
	LEFT JOIN 
		Payment p ON o.OrderID = p.OrderID
	WHERE 
		(p.PaymentDate IS NULL OR p.PaymentDate NOT BETWEEN @StartDate AND @EndDate)
		AND o.OrderDate BETWEEN @StartDate AND @EndDate
	ORDER BY 
		o.OrderDate DESC;

end;
exec Twenty '2023-01-01','2024-02-12';
		
--21.
--select * from Orders where OrderDate = @var;
select * from Customer ;
select * from Orders;

alter PROCEDURE IdentifyConsecutivePurchases
    @Days INT
AS
BEGIN
    SELECT 
        o1.CustomerId,
        c.FirstName,
        o1.OrderId AS FirstOrder,
        o1.OrderDate AS FirstOrderDate,
        o2.OrderId AS SecondOrder,
        o2.OrderDate AS SecondOrderDate
    FROM Orders o1
    JOIN Orders o2 ON o1.CustomerId = o2.CustomerId  
        AND DATEDIFF(DAY, o1.OrderDate, o2.OrderDate) BETWEEN 1 AND @Days
    JOIN Customer c ON o1.CustomerId = c.CustomerId
    ORDER BY o1.CustomerId, o1.OrderDate;
END;


exec IdentifyConsecutivePurchases 20




create procedure TwentyOne
@var datetime
as
begin
	select * from Orders where OrderDate like '%02:00:00.000';

end

exec TwentyOne '2023-01-01 02:00:00.000';






--22.
alter PROCEDURE QueryTwentyTwo
	@N int
	AS
	
	SELECT CustomerID, SUM(TotalAmount) AS TotalRevenue
	FROM Orders
	WHERE OrderDate >= DATEADD(MONTH, -@N, GETDATE()) --left---
	GROUP BY CustomerID;

EXEC QueryTwentyTwo 5


/*
	select sum(Price) as "Total Revenue",Category,month(PaymentDate) as "month" from Product join
	Orders on Orders.ProductID=Product.ProductID  
	join Payment on Payment.OrderID=Orders.OrderId group by Category,month(PaymentDate) 
	having month(PaymentDate)<5;
	*/


	--3 and 10


--23.
create procedure TwentyThree
as
begin
	SELECT o.OrderID, o.CustomerID, o.OrderDate, o.TotalAmount, p.ProductID, p.Price
	FROM Orders o
	JOIN Product p ON o.ProductID = p.ProductID
	WHERE p.Price > (SELECT AVG(Price) FROM Product);

end;
exec TwentyThree

--24.
update  Orders set OrderDate='2023-01-10 02:30:00.000' where OrderId=1034;

select * from Product;
select * from Customer;
select * from Orders;
select * from Payment;
WITH OrderDifferences AS (
    SELECT 
        o1.CustomerID,
        c.FirstName,
        c.LastName,
        o1.OrderID AS CurrentOrder,
        o2.OrderID AS PreviousOrder,
        DATEDIFF(DAY, o2.OrderDate, o1.OrderDate) AS DaysBetweenOrders
    FROM Orders o1
    JOIN Orders o2 
        ON o1.CustomerID = o2.CustomerID 
        AND o1.OrderDate > o2.OrderDate
    JOIN Customer c 
        ON o1.CustomerID = c.CustomerID
)
SELECT 
    CustomerID,
    FirstName,
    LastName,
    AVG(DaysBetweenOrders) AS AvgDaysBetweenOrders
FROM OrderDifferences
GROUP BY CustomerID, FirstName, LastName
ORDER BY AvgDaysBetweenOrders ASC;


--25.
select * from Orders where OrderId=1021; --searching
select top 5 * from Payment order by Amount ; --sorting and pagination	

alter procedure TwentyFive
	@sort varchar(20),
	@id int,
	@pageno int,
	@pagesize int
as
begin
	select * from Orders where OrderId=@id; --searching
	--sorting and pagination	
	DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'SELECT TOP 5 * FROM Orders ORDER BY TotalAmount ' + @sort;
    EXEC sp_executesql @sql;

	declare @cal int;
	set @cal=(@pageno*@pagesize)-1;
	
	declare @result nvarchar(max);
	SET @result = N'SELECT TOP ' + CAST(@cal AS NVARCHAR(10)) + N' * FROM Orders';
	exec sp_executesql @result;

end;
exec TwentyFive "desc",1021,1,5;


	select * from Customer;
	select * from Payment;
	select * from Orders;
	select * from Product;

--25.
CREATE PROCEDURE GetOrderspagination
    @PageNumber INT,  
    @PageSize INT,  
    @SortColumn NVARCHAR(50) = 'OrderDate',  
    @SortOrder NVARCHAR(4) = 'ASC',  
    @SearchTerm NVARCHAR(100) = NULL  
AS  
BEGIN  
    SET NOCOUNT ON;  

    SELECT 
        o.OrderID,  
        o.CustomerID,  
        c.FirstName + ' ' + c.LastName AS CustomerName,  
        o.OrderDate,  
        o.ProductID,  
        p.Name AS ProductName,  
        o.Qty,  
        o.Rate,  
        o.TotalAmount  
    FROM Orders o  
    JOIN Customer c ON o.CustomerID = c.CustomerID  
    JOIN Product p ON o.ProductID = p.ProductID  
    WHERE (@SearchTerm IS NULL OR 
           o.CustomerID LIKE '%' + @SearchTerm + '%' OR 
           o.ProductID LIKE '%' + @SearchTerm + '%')  
    ORDER BY  
        CASE WHEN @SortColumn = 'OrderDate' AND @SortOrder = 'ASC' THEN o.OrderDate END ASC,
        CASE WHEN @SortColumn = 'OrderDate' AND @SortOrder = 'DESC' THEN o.OrderDate END DESC,
        CASE WHEN @SortColumn = 'TotalAmount' AND @SortOrder = 'ASC' THEN o.TotalAmount END ASC,
        CASE WHEN @SortColumn = 'TotalAmount' AND @SortOrder = 'DESC' THEN o.TotalAmount END DESC  
    OFFSET (@PageNumber - 1) * @PageSize ROWS  
    FETCH NEXT @PageSize ROWS ONLY;  
END;
EXEC GetOrderspagination @PageNumber = 1, @PageSize = 1, @SortColumn = 'OrderDate', @SortOrder = 'DESC', @SearchTerm = '1';
