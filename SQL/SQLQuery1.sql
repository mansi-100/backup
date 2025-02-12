/*create database Company;
*/
use Company; 

CREATE TABLE Users (UserId int PRIMARY KEY ,UserName varchar(20) NOT NULL,email varchar(30) NOT NULL);

CREATE TABLE Devices (DeviceId int PRIMARY KEY,DeviceName varchar(40) NOT NULL,DeviceType varchar(50) NOT NULL,Manufacturer varchar(50) NOT NULL,SerialNumber varchar(100) NOT NULL UNIQUE);

CREATE TABLE Applications (ApplicationId int PRIMARY KEY,ApplicationName varchar(20) NOT NULL,Version decimal(10,2) NOT NULL,DeveloperName text NOT NULL);


CREATE TABLE Marketing (MarketingId int PRIMARY KEY IDENTITY(101,1),CampaignName VARCHAR(100) NOT NULL,StartDate date NOT NULL,EndDate date NOT NULL,Budget Decimal(10,2) NOT NULL,User_Id int NOT NULL,
FOREIGN KEY(User_Id) REFERENCES Users(UserId));


CREATE TABLE Personal (PersonalId int PRIMARY KEY IDENTITY(1001,1),FirstName varchar(20) NOT NULL,LastName varchar(20) NOT NULL,Salary Decimal(10,3) NOT NULL,DOB date NOT NULL,CONSTRAINT d1 CHECK(DOB<=GETDATE()),
User_Id int,FOREIGN KEY(User_Id) REFERENCES Users(UserId));


insert into Users values (1,'mansi101','mn20@gmail.com');
insert into Users values (2,'krishna845','krish20@yahoo.in'),(3,'ganesh489','ganesh201@gmail.com');

insert into Devices values(1801,'Laptop','Electric','Lenovo','SMTPSQO20');
insert into Devices values (1802,'DVD','Eletric','Samsung','LOPWKJ2O0'),(1803,'Wordrobe','House','Wooden','OPWKROWO22');


insert into Applications values (2001,'Woman Security','2.0','Mansi nayak'),(2002,'Amazon','2.453','Krishna');
insert into Applications values (2003,'Pubg','7.02','Ganesh Desai');


INSERT INTO Marketing (CampaignName, StartDate, EndDate, Budget, User_Id) 
VALUES 
('Summer Sale', '2023-06-01', '2023-06-30', 5000, 1),
('Holiday Promotion', '2023-12-01', '2023-12-31', 10000, 2),
('New Product Launch', '2023-09-15', '2023-10-15', 7500, 3);


INSERT INTO Personal (FirstName,LastName,Salary,DOB,User_Id) values('Krishna','raval',10000,'2003-01-01',2);
INSERT INTO Personal (FirstName,LastName,Salary,DOB,User_Id) values('mansi','nayak',60000,'2000-04-09',1);
INSERT INTO Personal (FirstName,LastName,Salary,DOB,User_Id) values('ganesh','desai',40000,'2005-08-19',3);


select * from Users;
select * from Devices;
select * from Applications;
select * from Marketing;
select * from Personal;


select Personal.User_Id,PersonalId,MarketingId,FirstName,LastName,Salary,CampaignName,StartDate,EndDate,Budget from Personal join Marketing on Personal.User_Id=Marketing.User_Id;


/*
ALTER TABLE Personal
ADD CONSTRAINT unique_user UNIQUE (User_Id);
*/


