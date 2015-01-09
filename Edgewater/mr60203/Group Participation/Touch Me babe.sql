declare @EmployeeKey nvarchar(1000), @personnm nvarchar(1000)
set @EmployeeKey = '21EB2800-DD43-49F2-B2DB-28D2AC3B5C76'
select @personnm = last_nm + ', ' + first_nm from emp_person
where person_key = @EmployeeKey
select @personnm,'ED' as title, * from emp_employeedata
where person_key = @EmployeeKey
select @personnm,'EP' as title, * from emp_employeeproduct
where employee_key = @EmployeeKey
select @personnm,'EPD' as title,* from emp_employeeproductdata
where person_key = @EmployeeKey
select @personnm,'PEP' as title,* from emp_prioremployeeproduct
where employee_key = @EmployeeKey
select @personnm,'ETV' as title,* from emp_employeetablevalue
where person_key = @EmployeeKey
select @personnm,'EEP' as title, * from emp_employeeenrollmentperiod
where person_key = @EmployeeKey