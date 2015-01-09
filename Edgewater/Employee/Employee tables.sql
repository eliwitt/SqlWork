declare @cmdStr nvarchar(4000), @EmployeeKey nvarchar(1000), 
	@personnm nvarchar(1000), 
	@gtt nvarchar(1000), 
	@gtv nvarchar(1000)
--set @EmployeeKey = '21EB2800-DD43-49F2-B2DB-28D2AC3B5C76'
set @EmployeeKey = 'C4C1872A-3EAB-41E6-B2E7-007CA1FE95F0'
select @personnm = last_nm + ', ' + first_nm from emp_person 
where person_key = @EmployeeKey
select @personnm as Person,'ED' as title, * from emp_employeedata
where person_key = @EmployeeKey
select @personnm as Person,'EP' as title, * from emp_employeeproduct
where employee_key = @EmployeeKey
select @personnm as Person,'EPD' as title,* from emp_employeeproductdata
where person_key = @EmployeeKey
select @personnm as Person,'PEP' as title,* from emp_prioremployeeproduct
where employee_key = @EmployeeKey
select @personnm as Person,'ETV' as title,* from emp_employeetablevalue
where person_key = @EmployeeKey
select @personnm as Person,'EEP' as title, * from emp_employeeenrollmentperiod
where person_key = @EmployeeKey
select @gtt = grouptabletype_key from emp_employeetablevalue
where person_key = @EmployeeKey
select @gtv = grouptablevalue_key from emp_employeetablevalue
where person_key = @EmployeeKey
select * from grp_grouptabletype
where grouptabletype_key = @gtt
select * from grp_grouptablevalue
where grouptablevalue_key = @gtv