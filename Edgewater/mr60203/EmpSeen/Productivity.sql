--
-- productivity
--
-- Count the employees seen by the enroller
set @cmdStr = '
declare @seengrpid uniqueidentifier,
	@seenuser uniqueidentifier,
	@seenCt int
declare EmpSeen scroll cursor for
SELECT gep.Group_key, u.user_key, count(distinct cast(e.person_key as varchar(36)))
		FROM EMP_Employee e
		-- products that the user has enrolled in
		JOIN EMP_EmployeeProduct ep ON ep.Employee_key = e.Person_key
		join emp_employeeproductenrollment epe on epe.employeeproduct_key = ep.employeeproduct_key
		-- find the enroller of this product
		JOIN EMP_EmployeeEnrollmentPeriod eep ON epe.EnrollmentPeriod_key = eep.EnrollmentPeriod_key
		 and eep.Person_key = e.Person_key
		JOIN	GRP_Enroller ge ON ge.Enroller_key = epe.Enroller_key
		JOIN 	MSC_User u on u.User_key = ge.User_key
		-- Organizational information
		JOIN GRP_EnrollmentPeriod gep ON eep.EnrollmentPeriod_key = gep.EnrollmentPeriod_key
		inner join grp_group grp on gep.group_key = grp.group_key
		WHERE ep.EmployeeProductStatus_vv = ''ENROLLED'' or ep.EmployeeProductStatus_vv = ''WAIVED'' '
if len(@grpStr) > 0
	set @cmdStr = @cmdStr + '			and gep.group_key in ( ' + @grpStr + ' )'
if len(@divStr) > 0
	set @cmdStr = @cmdStr + '	AND	grp.InternalDivision_key in ( ' + @divStr + ' )'
if len(@rangeStr) > 0
	set @cmdStr = @cmdStr + @rangeStr
set @cmdStr = @cmdStr + ' group by gep.group_key, u.user_key
open EmpSeen
fetch first from EmpSeen into @seengrpid, @seenuser, @seenCt
while @@fetch_status = 0
begin
	update #Productivity set empseen = @seenCt where group_key = @seengrpid and user_key = @seenuser
	fetch next from EmpSeen into @seengrpid, @seenuser, @seenCt
end
close EmpSeen
deallocate EmpSeen'
if @debug < 3
	exec (@cmdStr)
else
	print 'emp counts enroller' + @cmdStr

