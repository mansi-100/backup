use demo;
select concat(DeviceName,DeviceType) as mydata from Devices;

select DeviceName as "device name" from Devices;
select DeviceName as [device name] from Devices;

select * from Devices;

select count(DeviceName) as count,DeviceName  from Devices group by DeviceName having count(DeviceName)>=2;

insert into Devices values(1804,'Wordrobe','Kitchen','LG','OPAWSPAAP2');

/*joins*/
select * from Users;
select * from Marketing;



select count(UserId) from Users join Marketing on Users.UserId=Marketing.User_Id ;

select UserId,
email ,
CASE UserId 
	when 1 THEN 'one'
	when 2 THEN 'two'
	ELSE 'Other'
	end as mydata /*col name mydata is*/
from Users;

create procedure first
as
begin
select * from Users;
end;

exec first;