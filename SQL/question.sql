create table empDemo (empid int,fname varchar(20));

alter table empDemo add  lname varchar(20);

exec sp_columns empDemo ;

alter table empDemo change lname lastname varchar(20); --wont work in mssql so use sp_rename procedure

EXEC sp_rename 'empDemo', 'empDemo1';

exec sp_columns empDemo1 ;
