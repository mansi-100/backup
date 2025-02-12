create procedure mansi(@pid int)
as
begin
select * from Orders where OrderId=@pid;
end
drop procedure mansi;

exec mansi 1001;

--user defined datatype
create type mansi from varchar(20)

create table udf (id int,name mansi)
declare @name1 mansi; --declare var
set @name1='mansi1';

--assign val
insert into udf(id,name) values (1,@name1);

