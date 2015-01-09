alter procedure edg_sp_test
@input1 int,
@input2 int = null
as
if @input2 is null 
begin
	print 'parameter two was not supplied'
	return (-20)
end
print '     ' + @input1
print '     ' + @input2
go