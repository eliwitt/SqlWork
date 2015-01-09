declare @myResult varchar(256), @myInt tinyint
exec @myResult = GoAutoTemp.dbo.f_vehicle_getdesc 1002, 1
select @myResult
if GoAutoTemp.dbo.f_canamendpolicy(1002) = 1 
begin
	select 'Yes'
end
select @myInt = GoAutoTemp.dbo.f_canamendpolicy(1002)
select @myInt