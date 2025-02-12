create database task5;
use task5;

drop table if exists Orders;
drop table if exists Salary_History;
drop table if exists Employees;
drop table if exists Departments;
drop table if exists Promotions;
drop table if exists Products;
drop table if exists Customers;
drop table if exists Category_Summary;

CREATE TABLE Customers (
    Customer_id INT IDENTITY(1,1) PRIMARY KEY,
    First_name VARCHAR(50) NOT NULL,
    Last_name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20) UNIQUE,
    Address VARCHAR(255),
    City VARCHAR(50),
    State_province VARCHAR(50),
    Country VARCHAR(50),
    Postal_code VARCHAR(20),
    Date_of_birth DATE,
    Gender varchar(20)
);

CREATE TABLE Departments (
    Department_id INT IDENTITY(101,1) PRIMARY KEY,
    Department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Employees (
    Employee_id INT IDENTITY(1,1) PRIMARY KEY,
    First_name VARCHAR(50) NOT NULL,
    Last_name VARCHAR(50) NOT NULL,
    Department_id INT NOT NULL,
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    FOREIGN KEY (Department_id) REFERENCES Departments(Department_id)
);

CREATE TABLE Salary_History (
    Sync_History_id INT IDENTITY(1,1) PRIMARY KEY,
    Employee_id INT NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    Effective_date DATE NOT NULL,
    FOREIGN KEY (Employee_id) REFERENCES Employees(Employee_id) ON DELETE CASCADE
);

CREATE TABLE Products (
    Product_id INT IDENTITY(1,1) PRIMARY KEY,
    Product_name VARCHAR(100) NOT NULL,
    Category_name VARCHAR(50) NOT NULL,
    Unit_price DECIMAL(10,2) DEFAULT 10 NOT NULL,
    Featured BIT DEFAULT 0 
);

CREATE TABLE Promotions (
    Promotion_id INT IDENTITY(1,1) PRIMARY KEY,
    Product_id INT NOT NULL,
    Promotion_name VARCHAR(100) NOT NULL,
    Start_date DATE NOT NULL,
    End_date DATE NOT NULL,
    DiscountAmount DECIMAL(10,2) DEFAULT 2 NOT NULL,
    Active BIT DEFAULT 1, 
    FOREIGN KEY (Product_id) REFERENCES Products(Product_id) ON DELETE CASCADE
);

CREATE TABLE Orders (
    Order_id INT IDENTITY(1,1) PRIMARY KEY,
    Promotion_id INT NULL,
    Product_id INT NOT NULL,
    Quantity INT DEFAULT 2 NOT NULL,
    Customer_id INT NOT NULL,
    Order_date DATETIME DEFAULT GETDATE() NOT NULL,
    Price DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (Promotion_id) REFERENCES Promotions(Promotion_id),
    FOREIGN KEY (Product_id) REFERENCES Products(Product_id),
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)
);

CREATE TABLE Category_Summary (
    Category_summary_id INT IDENTITY(1,1) PRIMARY KEY,
    Category_name VARCHAR(100) NOT NULL UNIQUE,
    Revenue DECIMAL(15,2) DEFAULT 0 NOT NULL
);

INSERT INTO Departments (Department_name) VALUES ('Sales'), ('HR'), ('IT'), ('Finance'), ('Marketing'), ('Operations'), ('Legal'), ('Support'), ('Engineering'), ('Administration'), ('Logistics'), ('R&D'), ('Procurement'), ('Quality Assurance'), ('Public Relations');

INSERT INTO Employees (First_name, Last_name, Department_id, Salary) VALUES 
('John', 'Doe', 101, 50000.00),
('Jane', 'Smith', 102, 60000.00),
('Robert', 'Johnson', 103, 75000.00),
('Alice', 'Williams', 104, 54000.00),
('Mark', 'Brown', 105, 59000.00),
('Emily', 'Davis', 106, 62000.00),
('James', 'Miller', 107, 71000.00),
('Olivia', 'Wilson', 108, 56000.00),
('William', 'Moore', 109, 63000.00),
('Sophia', 'Taylor', 110, 58000.00),
('Benjamin', 'Anderson', 111, 67000.00),
('Charlotte', 'Thomas', 112, 72000.00),
('Daniel', 'Jackson', 113, 65000.00),
('Emma', 'White', 114, 53000.00);

INSERT INTO Customers (First_name, Last_name, Email, Phone, Address, City, State_province, Country, Postal_code, Date_of_birth, Gender) VALUES
('Michael', 'Scott', 'michael@example.com', '1234567890', '1725 Slough Ave', 'Scranton', 'PA', 'USA', '18505', '1975-03-15', 'Male'),
('Jim', 'Halpert', 'jim@example.com', '1234567891', 'Scranton Business Park', 'Scranton', 'PA', 'USA', '18505', '1978-10-01', 'Male'),
('Pam', 'Beesly', 'pam@example.com', '1234567892', 'Scranton Business Park', 'Scranton', 'PA', 'USA', '18505', '1980-03-25', 'Female'),
('Dwight', 'Schrute', 'dwight@example.com', '1234567893', 'Schrute Farms', 'Scranton', 'PA', 'USA', '18505', '1972-01-20', 'Male');

INSERT INTO Products (Product_name, Category_name, Unit_price, Featured) VALUES 
('Laptop', 'Electronics', 1200.00, 1),
('Smartphone', 'Electronics', 800.00, 1),
('Tablet', 'Electronics', 500.00, 0),
('TV', 'Appliances', 1500.00, 1),
('Refrigerator', 'Appliances', 1000.00, 0);

INSERT INTO Promotions (Product_id, Promotion_name, Start_date, End_date, DiscountAmount, Active) VALUES
(1, 'New Year Sale', '2024-01-01', '2024-01-10', 10.00, 1);



INSERT INTO Orders (Promotion_id, Product_id, Quantity, Customer_id, Order_date, Price)
VALUES (1, 1, 2, 1, '2024-01-05', 2200.00);

INSERT INTO Category_Summary (Category_name, Revenue)
SELECT 'Electronics', 3000.00 WHERE NOT EXISTS (SELECT 1 FROM Category_Summary WHERE Category_name = 'Electronics');

INSERT INTO Employees (First_name, Last_name, Department_id, Salary) VALUES 
('David', 'Clark', 101, 55000.00),
('Sophia', 'Brown', 101, 48000.00),
('Lucas', 'Miller', 102, 62000.00),
('Isabella', 'Johnson', 102, 59000.00);
-- Insert 10 more orders in the current month (assuming current month is February 2025)
INSERT INTO Orders (Promotion_id, Product_id, Quantity, Customer_id, Order_date, Price)
VALUES 
(1, 2, 3, 1, '2025-02-02', 2400.00),
(1, 1, 1, 2, '2025-02-03', 1200.00),
(1, 3, 2, 3, '2025-02-04', 1000.00),
(1, 4, 1, 4, '2025-02-05', 1500.00),
(1, 5, 2, 1, '2025-02-06', 2000.00),
(1, 2, 3, 2, '2025-02-07', 1800.00),
(1, 1, 1, 3, '2025-02-08', 1200.00),
(1, 3, 4, 4, '2025-02-09', 2000.00),
(1, 4, 2, 2, '2025-02-10', 3000.00),
(1, 5, 3, 3, '2025-02-11', 3000.00);


select * from Products;
select * from Employees;
select * from Departments;


--query1
SELECT 
    Employee_id,
    First_name,
    Last_name,
    Department_id,
    Salary,
    RANK() OVER (PARTITION BY Department_id ORDER BY Salary DESC) AS Salary_Rank
FROM Employees
ORDER BY Department_id, Salary_Rank;

--query2.
SELECT TOP 3
    C.Customer_id,
    C.First_name,
    C.Last_name,
    COUNT(O.Order_id) AS TotalOrders,
    DENSE_RANK() OVER (ORDER BY COUNT(O.Order_id) DESC) AS Rank
FROM Orders O
JOIN Customers C ON O.Customer_id = C.Customer_id
WHERE MONTH(O.Order_date) = MONTH(GETDATE()) 
GROUP BY C.Customer_id, C.First_name, C.Last_name
ORDER BY TotalOrders DESC;

select * from Orders;

--3.
SELECT 
    o.Customer_id, 
    c.First_name, 
    c.Last_name, 
    COUNT(o.Order_id) OVER(PARTITION BY o.Customer_id) AS Total_Orders, 
    o.Order_id, 
    o.Order_date, 
    o.Price, 
    ROW_NUMBER() OVER(PARTITION BY o.Customer_id ORDER BY o.Order_date) AS Order_Row_Number
FROM Orders o
JOIN Customers c ON o.Customer_id = c.Customer_id
ORDER BY o.Customer_id, Order_Row_Number;

--4.

--4.1
INSERT INTO Promotions (Product_id, Promotion_name, Start_date, End_date, DiscountAmount, Active)
SELECT TOP 5 
    Product_id, 
    'Limited Offer - ' + Product_name AS Promotion_name, 
    GETDATE(), 
    DATEADD(DAY, 7, GETDATE()),  --7 day add
    10.00, 
    1
FROM Products
ORDER BY NEWID(); 

--4.2
/*select count(Orders.Order_id) as "order placed",Products.Product_id from Orders 
join Products on Orders.Product_id=Products.Product_id 
group by Products.Product_id having count(Orders.Order_id)>2; */

ALTER TRIGGER UpdateFeaturedProducts
ON Orders
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Products
    SET Featured = 1
    WHERE Product_id IN (
        SELECT Products.Product_id
        FROM Orders
        JOIN Products ON Orders.Product_id = Products.Product_id
        GROUP BY Products.Product_id
        HAVING COUNT(Orders.Order_id) > 2
    );
END;

--4.3

create trigger DeletePromotion
on Promotions
after insert
as
begin
    ALTER TABLE Orders NOCHECK CONSTRAINT FK__Orders__Promotio__37703C52;

	delete from Promotions where Start_date<dateadd(month,-6,GETDATE()); --LAST 6 Month
	 ALTER TABLE Orders CHECK CONSTRAINT FK__Orders__Promotio__37703C52;

end;

insert into Promotions (Product_id,Promotion_name,Start_date,End_date,DiscountAmount,Active)
values (1,'Amazon sell','2023-04-01','2023-05-01',20,0);

select * from Promotions;
select * from Products;
select * from Orders;

--update Promotions set
--5.
create view five as 
	select Orders.Order_id,Promotion_id,Product_id,Quantity,Order_date,Price,First_name,Last_name,Email,Phone,Address from Orders 
	join Customers on Orders.Customer_id=Customers.Customer_id;

select * from five;

INSERT INTO Promotions (Product_id, Promotion_name, Start_date, End_date, DiscountAmount, Active)
SELECT TOP 5 Product_id, 
       'Limited Offer', 
       '2024-02-01', 
       '2024-02-10', 
       10.00, 
       1
FROM Products
WHERE Product_id NOT IN (SELECT Product_id FROM Promotions);

select * from Promotions;


--6.
CREATE VIEW vw_DetailedOrderData AS
SELECT 
    o.Order_id,
    o.Order_date,
    o.Customer_id,
    o.Quantity,
    o.Price,
    p.Product_id,
    p.Product_name,
    p.Category_name,
    p.Unit_price,
    p.Featured
FROM Orders o
JOIN Products p ON o.Product_id = p.Product_id
WHERE o.Order_date >= DATEADD(MONTH, -3, GETDATE());  

select * from vw_DetailedOrderData;--7.--drop view vw_EmployeeSalariesCREATE VIEW vw_EmployeeSalaries AS
SELECT Employee_id, First_name, Last_name, Salary
FROM Employees
WHERE Salary > 10000
WITH CHECK OPTION;

SELECT * FROM vw_EmployeeSalaries;

UPDATE vw_EmployeeSalaries 
SET Salary = 12000 
WHERE Employee_id = 2;

UPDATE vw_EmployeeSalaries 
SET Salary = 9000 WHERE Employee_id = 3;

select * from vw_EmployeeSalaries;

--task8.
CREATE FUNCTION CalculateTotalOrderCost (@OrderID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalCost DECIMAL(10,2);

    SELECT @TotalCost = SUM(o.Quantity * p.Unit_price)
    FROM Orders o
    JOIN Products p ON o.Product_id = p.Product_id
    WHERE o.Order_id = @OrderID;

    RETURN ISNULL(@TotalCost, 0);
END;
--drop function dbo.CalculateTotalOrderCost;
SELECT dbo.CalculateTotalOrderCost(1) AS TotalOrderCost;

--9.
CREATE TABLE #Numbers (Value INT);

INSERT INTO #Numbers (Value)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

DECLARE @counter INT = 1;

WHILE @counter <= 10
BEGIN

IF @counter % 2 = 0
    BEGIN
        SET @counter = @counter + 1;
        CONTINUE;
    END

    PRINT 'Current Value: ' + CAST(@counter AS VARCHAR);
    
    IF @counter = 5
    BEGIN
        BREAK;
    END

    SET @counter = @counter + 1;
END

DROP TABLE #Numbers;

--10.
DECLARE @Category VARCHAR(255);
DECLARE @Revenue DECIMAL(10,2);

DECLARE category_cursor CURSOR FOR
SELECT p.Category_name, SUM(o.Quantity * p.Unit_price) AS TotalRevenue
FROM Orders o
JOIN Products p ON o.Product_id = p.Product_id
GROUP BY p.Category_name;


OPEN category_cursor;

FETCH NEXT FROM category_cursor INTO @Category, @Revenue;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Category: ' + @Category + ', Revenue: ' + CAST(@Revenue AS VARCHAR);

    
  /*  INSERT INTO Category_Summary (Category_name, Revenue)
    VALUES (@Category, @Revenue);
	*/
  
    FETCH NEXT FROM category_cursor INTO @Category, @Revenue;
	select * from 
END
CLOSE category_cursor;
DEALLOCATE category_cursor;
