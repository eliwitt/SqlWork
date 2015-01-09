declare @cmdStr nvarchar(1000),
	@orgStr nvarchar(4000),
	@FromDate smalldatetime,
	@ThruDate smalldatetime,
	@Group_key nvarchar(100)
set @GRoup_key = 'All'
set @FromDate = '01/01/2007'
set @ThruDate = '07/30/2007'
set @orgStr = 'Select distinct *, 1 as GroupingValue from
(SELECT		grp.Company_nm, 
                                go.Organization_nm Group_nm, 
                                go.logo_bin Logo, 
                                ido.Organization_nm InternalDivision_nm,
                                employee.SSN_txt,
		employee.Employee_ID,
		Cast(employee.Person_key as varchar(40)) Employee,
		go.OrganizationShort_nm Group_ID,
		UPPER(employee.Last_nm) Emp_Last, 
		UPPER(employee.First_nm) Emp_First, 
		UPPER(employee.First_nm) + '' '' + UPPER(employee.Last_nm) Emp_Name,
		UPPER(employee.MiddleInitial_nm) Emp_MI, 
		CASE IsNull(dp.Last_nm, '''')
		When '''' then employee.PersonType_vv				
		--Else	ISNull(NullIf(dp.Relationship_vv, ''''), dp.DependentType_vv)
		Else	REPLACE(dp.DependentType_vv, ''CHILD'', ''DEPENDENT'')
		END Relationship,
		UPPER(ISNull(dp.Last_nm, employee.Last_nm)) Last_nm,
		UPPER(ISNull(dp.First_nm, employee.First_nm)) First_nm,
		UPPER(ISNull(dp.First_nm, employee.First_nm))  + '' '' + UPPER(ISNull(dp.Last_nm, employee.Last_nm)) Person_Name,
		CASE IsNull(dp.Last_nm, '''')
			WHEN '''' then employee.SSN_txt
			ELSE dp.SSN_txt 
			END Relation_SSN,		
		a.audit_dttm,
		UPPER(ans.Field_Label_txt) Field_Label_txt,
		CASE(ans.Validation_Format_vv)
		WHEN ''DATE'' Then Convert(varchar(40), Cast(ad.OldValue_txt as DateTime), 101)
		WHEN ''DATE_PRIOR'' Then Convert(varchar(40), Cast(ad.OldValue_txt as DateTime), 101)
		ELSE UPPER(ad.OldValue_txt) 
		END OldValue_txt,
		CASE(ans.Validation_Format_vv)
		WHEN ''DATE'' Then Convert(varchar(40), Cast(ad.NewValue_txt as DateTime), 101)
		WHEN ''DATE_PRIOR'' Then Convert(varchar(40), Cast(ad.NewValue_txt as DateTime), 101)
		ELSE UPPER(ad.NewValue_txt) 
		END NewValue_txt

FROM 	(Select	Group_key, Person_key Employee_key, Person_key 
			From	EMP_Employee
			Where	Group_key in ('

if (@Group_key = 'All')
begin
	set @cmdStr = 'Select IncludedGroup_key from v_ReportingGroup'
end
else
begin
	set @cmdStr = 'Select IncludedGroup_key from v_ReportingGroup where ReportingGroup_key '
	if (CHARINDEX(',',@Group_key) > 0)
	begin
		set @cmdStr = @cmdStr + ' in (' + @Group_key + ')'
	end
	else
	begin
		set @cmdStr = @cmdStr + ' = ' + @Group_key 
	end
end
--exec(@cmdStr)
set @orgStr = @orgStr + @cmdStr +
')
			UNION

			Select	Group_key, Employee_key, EMP_Dependent.Dependent_key
			From	EMP_Dependent
			JOIN	EMP_Employee on EMP_Employee.Person_key = EMP_Dependent.Employee_key
			Where	Group_key in (' + @cmdStr + 
')

) Relation


JOIN 		v_EmployeePerson employee ON employee.Person_key = Relation.Employee_key
JOIN		MSC_Organization go	ON go.Organization_key = employee.Group_key
JOIN 		MSC_AuditTable t ON t.Table_key = Relation.Person_key
JOIN		MSC_Audit a	ON 	a.Audit_key = t.Audit_key
JOIN		MSC_AuditDetail ad ON ad.AuditTable_key = t.AuditTable_key
JOIN		ANS_ANSWER ans ON ans.table_nm = t.table_nm AND ans.column_nm = ad.column_nm
LEFT JOIN	v_DependentPerson dp on Relation.Person_key = dp.Person_key
join 		Grp_Group grp on go.Organization_key = grp.Group_key
LEFT JOIN		MSC_Organization ido ON		grp.InternalDivision_key = ido.Organization_key

WHERE 	t.table_nm in (''EMP_Employee'', ''EMP_Dependent'', ''EMP_Person'')
AND 	a.Audit_dttm >= ''' + cast(@FromDate as nvarchar(20)) + ''' AND	a.Audit_dttm <= ''' + cast(@ThruDate as nvarchar(20)) + '''
) o

Order by	               Company_nm,
                               Group_nm,
                               InternalDivision_nm,
                               Employee,
		Emp_Last, 
		Emp_First, 
		Emp_MI, 
		Employee_id,
		Relationship'
--
-- To get the command uncomment the print line
--
--print @orgStr
exec(@orgStr)