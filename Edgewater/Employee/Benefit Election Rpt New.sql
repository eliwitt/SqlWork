-- This script will process the list of employees passed by the UI
-- for each employee we will retrieve his enrollment info and insert into 
-- a temp table
-- script variables
declare @debug		int, 
	@EmployeesList	varchar(4000),
	@Emp_key	uniqueidentifier
-- initialize the variables
-- EmployeesList is the variable used by the reports so we will comment this out once 
-- the script is copied into the report
set @EmployeesList = ''
set @EmployeesList = '1AEDA0FB-9ABF-4179-8FC1-0719E26393BB,'
--
--  set @debug to an integer and you will get print statements
--  0 = turn off
--  1 = high level 
--  2 = detail
--  3 = stop after the build of the cmd str
set @debug = 2

-- check the existance of the temp table
if object_id('tempdb..#EmpEnroll') is not null
	drop table #EmpEnroll
--
/*  The report code in ExecuteReport.aspx.cs follows:
		private NameValueCollection AddEmployeeParams()
		{
			EmployeeBOCollection employees;
			StringBuilder sb = new StringBuilder();
			
			employees = AAWebSession.Current.EmployeesToViewReportsFor;
			if(employees != null)
			{
				
				foreach(EmployeeBO employee in employees)
				{
					if(sb.Length > 0)sb.Append(",");
					sb.AppendFormat("'{0}'", employee.Person_key);
				}
			}
	As you can see the employees are placed in a string '{}','{}',...
*/
--
-- process the selected employees
--
if @debug > 0
	print 'Begin the employeeslist processing'
--
-- loop thru the employeelist string and process employee
--
if charindex(',',@EmployeesList)= 0
	set @EmployeesList = @EmployeesList + ','
if @debug > 1
	print 'The list ' + @EmployeesList
while (charindex(',',@EmployeesList)>0)
begin
	-- retrieve the next employee key
	set @Emp_key = ltrim(rtrim(substring(@EmployeesList, 1,charindex(',',@EmployeesList)-1))) 
	
	if @debug > 1
		print @Emp_key
	-- for each employee insert their info into a temp table
	SELECT	Cast(e.Person_key as varchar(40)) Employee_key,
		ep.costtablevalue_key,ep.coverage_key, ep.groupproduct_key,
		RTrim(e.First_nm) + IsNull('  ' + e.MiddleInitial_nm, '') + ' ' + e.Last_nm Full_nm,
		IsNull(e.ssn_txt, '         ') ssn_txt,
		e.AddressLine1_txt,
		e.AddressLine2_txt,
		e.City_txt,
		state_cd State,
		e.PostalCode_txt,
		g.Company_nm,
		o.Organization_nm Group_nm,
		etv.Location_Long_nm location,
		IsNull(ep.EmployeeStartCost_amt, 0) EmployeePriorYearlyCost_amt,
		IsNull(ep.EmployeeYearlyCost_amt, 0) EmployeeYearlyCost_amt,
		IsNull(ep.EmployerYearlyCost_amt, 0) EmployerYearlyCost_amt,
		IsNull(ep.DeductionsPerYear_val, 1) DeductionsPerYear_val,
		cz.ProductDisplay_nm + ' ' + Coalesce(planid.Answer_txt, ep.CoverageLevel_txt, '') Product_nm,
		c.OrganizationShort_nm Carrier_nm,
		gtv.Short_nm Benefit,
		lep.PlanYearFrom_dt,
		lep.PlanYearThru_dt,
		'                       ' as TypeContract,
		ep.EmployeeProductStatus_vv,
		usr.First_nm + ' ' + usr.Last_nm Enroller,
		rs.Signature_bin Employee_Signature,
		rs.Signed_dttm EmpDateSigned,
		CASE COALESCE(ep.EmployeeProductStatus_vv, '')
			WHEN 'WAIVED' THEN 'Coverage Waived'
			WHEN '' THEN NULL
			ELSE
				CASE ep.PreTax_Flg
					WHEN 'Y' THEN 'Pre-Tax Elections'
					ELSE	'Post-Tax Elections'
				END
		END Grouping
	into 		#EmpEnroll
	FROM		v_EmployeePerson e
	JOIN		v_LatestEnrollmentPeriod lep ON e.Group_key = lep.Group_key
	JOIN		EMP_EmployeeEnrollmentPeriod ee	ON ee.Person_key = e.Person_key AND ee.EnrollmentPeriod_key = lep.EnrollmentPeriod_key
	JOIN		MSC_Organization o ON o.Organization_key = lep.PrimaryGroup_key
	JOIN		GRP_Group g ON g.Group_key = o.Organization_key
	LEFT JOIN	EMP_EmployeeProduct ep ON ep.employee_key = e.person_key
			AND (ep.EmployeeProductStatus_vv = 'ENROLLED' OR ep.EmployeeProductStatus_vv = 'WAIVED')
	LEFT JOIN	EMP_EmployeeProductData planid ON planid.EmployeeProduct_key = ep.EmployeeProduct_key
			AND planid.Answer_key = 'E2395B16-C217-4D8A-9F53-594BAE4BD8C6'
	LEFT JOIN	GRP_GroupProduct gp ON gp.GroupProduct_key = ep.GroupProduct_key
	LEFT JOIN	PRD_Customization cz ON cz.GroupProduct_key = gp.GroupProduct_key
	LEFT JOIN	PRD_Product pr ON gp.Product_key = pr.Product_key
	LEFT JOIN	MSC_Organization c ON pr.Carrier_key = c.Organization_key
	LEFT JOIN	GRP_GroupTableValue gtv ON gp.BenefitType_key = gtv.GroupTableValue_key
	LEFT JOIN	v_EmployeeTableValue etv ON e.Person_key = etv.Person_key
	LEFT JOIN	GRP_Enroller enr ON enr.Enroller_key = ee.Enroller_key
	LEFT JOIN	MSC_User usr ON usr.user_key = enr.user_key
	LEFT JOIN	EMP_ReportSignature rs ON rs.EnrollmentPeriod_key = ee.EnrollmentPeriod_key
			AND rs.Person_key = ee.Person_key AND rs.enroller_key IS NULL
			AND rs.Report_key = 'C110A714-BBFF-4BCC-B2BD-F9ABABCEBB6D'
	WHERE e.Person_key in ( @Emp_key )
	-- adjust the employee list
	set @EmployeesList = substring(@EmployeesList,charindex(',',@EmployeesList) + 1,len(@EmployeesList))
end
--
-- attempt to update the typecontract field
--
declare	@cost_key	uniqueidentifier,
	@cover_key	uniqueidentifier,
	@grpprd_key	uniqueidentifier
--
--  define the cursor
--
declare empcursor cursor for
select Employee_key, costtablevalue_key, coverage_key, groupproduct_key
from #EmpEnroll
-- open the cursor
open empcursor
-- read the one of the row in the result set
fetch next from empcursor
into @Emp_key, @cost_key, @cover_key, @grpprd_key
--
-- now loop thru the result set and update the employee info
--
while (@@FETCH_STATUS = 0)
begin
	if @debug > 1
		print 'user ' + convert(char(36), @Emp_key) + ' cost ' + convert(char(36), @cost_key) + ' grpprd ' + convert(char(36), @grpprd_key)
	if ((@cost_key is null) and (@cover_key is null))
		begin
		if @debug > 1
			print 'Skip this user ' + convert(char(36), @Emp_key) + ' grpprd ' + convert(char(36), @grpprd_key)
		end
	else
		begin
		if @debug > 1
			print 'Process this user ' + convert(char(36), @Emp_key) + ' cost ' + convert(char(36), @cost_key) + ' grpprd ' + convert(char(36), @grpprd_key)
		--
		-- now that we have the employee(s) info let's update the coverage for the reports
		--
		if exists(select dimensionvalue_key from grp_groupproductdimensionvalue 
			where dimensionvalue_key = (
				select dimensionvalue_key from prd_dimensionvalue
				where dimensionvalue_key = (select dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key)
				or dimensionvalue_key = (select dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key)
				and answervalue_key  in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9')
			) and displayoverride_txt is not null ) 
			begin
			--
			-- use the group override text
			--
			if @debug > 1
				print 'Use the group text for ' + convert(char(36), @Emp_key)
			update #EmpEnroll set TypeContract = (
				select displayoverride_txt from grp_groupproductdimensionvalue 
					where dimensionvalue_key = (
						select dimensionvalue_key from prd_dimensionvalue
						where dimensionvalue_key = (select dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key)
						or dimensionvalue_key = (select dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key)
						and answervalue_key  in (select answervalue_key from ans_answervalue where answer_key = '3F83256C-7D80-455C-ABF1-9FF3148AE6F9')
					) and displayoverride_txt is not null )
			where Employee_key = @Emp_key and groupproduct_key = @grpprd_key
			end
		else
			begin
			--
			-- we need to determine if we should use the product text
			--
			if exists(select dimensionvalue_key from prd_dimensionvalue 
					where dimensionvalue_key in (select Dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key)
					or dimensionvalue_key in (select Dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key)
					and answervalue_key in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9') 
				)
				begin
				if @debug > 1
					print 'Use the product text for ' + convert(char(36), @Emp_key)
				update #EmpEnroll set TypeContract = (
					select override_txt from prd_dimensionvalue 
						where dimensionvalue_key in (select Dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key)
						or dimensionvalue_key in (select Dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key)
						and answervalue_key in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9') 
					)
				end
			else
				begin
				--
				-- use the coverage text
				--
				if @debug > 1
					print 'Use the coverage text for ' + convert(char(36), @Emp_key)
				update #EmpEnroll set TypeContract = (select coverage_nm from msc_coverage where coverage_key = @cover_key)
					where Employee_key = @Emp_key and groupproduct_key = @grpprd_key
				end
			end
		end
	if @debug > 1
		print '-----------------------------------------------------'
	-- read the next row in the result set
	fetch next from empcursor
		into @Emp_key, @cost_key, @cover_key, @grpprd_key
end
-- housekeeping cleanup the cursor
close empcursor
deallocate empcursor

select * from #EmpEnroll
-- end of the script
if @debug > 0 
	Print 'That''s a wrap!!!'