-- This script will process the list of employees passed by the UI
-- for each employee we will retrieve his enrollment info and insert into 
-- a temp table
--
-- script variables
declare @debug		int, 
	@EmployeesList	varchar(4000),
	@cmdStr 	varchar(4000),
	@empLst 	varchar(4000),
	@Emp_key	varchar(4000)
-- initialize the variables
-- EmployeesList is the variable used by the reports so we will comment this out once 
-- the script is copied into the report
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

	To get test ids run the following query

	select * from v_employeePerson
	where group_key = '27b9430f-bcd3-4034-9eb3-aad7d71d478c'
	order by last_nm

	This query gives you the same list of employees you see on the Employee Reports page copy the group key 
	from the address line.

*/
--
--	US Fence Employees in production
--
--  ashton 586FF532-36CA-43F5-843B-00DDA5A94CA9
--  banks 9EF59308-0822-4781-A13D-56D7AA4F05DB
--  allen 825240C7-F282-469F-B32F-5186DB0CA451
--  belt 7DE68AED-4E77-40E3-91A3-506E9F152534  got a product text!!!
--  
--
--  Companion Voluntary Vision, is set up in TEST and attached to group, Pure Life Water Co
-- Bailey 01CD8916-AF0D-41E9-B2AE-6581471FF1A8 Employee
--	E8F1AEB9-998C-45A6-8338-F0A3BADB9FCC
--	6EBE91BD-A294-4554-A545-8B0F1AFF052F
-- test set @EmployeesList = '''C4C1872A-3EAB-41E6-B2E7-007CA1FE95F0'',''A41EABBF-E7EB-49D6-BE41-A42118463145'','
set @EmployeesList = '''BC0E259B-453B-4397-8C89-8542B2DF62D1'','
--set @empLst = @EmployeesList
set @empLst = replace(@EmployeesList,'{','')
set @empLst = replace(@empLst,'}','')
--set @empLst = replace(@empLst,'''','')
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

create table #EmpEnroll (
	Employee_key		uniqueidentifier,
	costtablevalue_key	uniqueidentifier,
	coverage_key		uniqueidentifier,
	groupproduct_key	uniqueidentifier,
	signature_key		uniqueidentifier,
	Full_nm			varchar(130),
	ssn_txt			varchar(10),
	AddressLine1_txt	varchar(60),
	AddressLine2_txt	varchar(60),
	City_txt		varchar(60),
	State			char(2),
	PostalCode_txt		varchar(16),
	Company_nm		varchar(60),
	Group_nm		varchar(60),
	location		varchar(60),
	EmployeePriorYearlyCost_amt	money,
	EmployeeYearlyCost_amt		money,
	EmployerYearlyCost_amt		money,
	DeductionsPerYear_val	int,
	Product_nm		varchar(140),
	Carrier_nm		varchar(30),
	Benefit			varchar(30),
	PlanYearFrom_dt		datetime,
	PlanYearThru_dt		datetime,
	TypeContract		varchar(60),
	EmployeeProductStatus_vv	varchar(16),
	Enroller		varchar(120),
	[Grouping]		varchar(60)
)

--
-- process the selected employees
--
if @debug > 0
	print 'Begin the employeeslist processing'
--
-- loop thru the employeelist string and process employee
--
if charindex(',',@empLst)= 0
	set @empLst = @empLst + ','
if @debug > 1
	print 'The list ' + @empLst
while (charindex(',',@empLst)>0)
begin
	-- retrieve the next employee key
	set @Emp_key = ltrim(rtrim(substring(@empLst, 1,charindex(',',@empLst)-1)))
	
	if @debug > 1
		print @Emp_key
	-- for each employee insert their info into a temp table
	set @cmdStr = '
	insert into #EmpEnroll ( Employee_key, costtablevalue_key, coverage_key, groupproduct_key,
		signature_key, Full_nm, ssn_txt, AddressLine1_txt, AddressLine2_txt, City_txt, State, PostalCode_txt, 
		Company_nm, Group_nm, location, EmployeePriorYearlyCost_amt, EmployeeYearlyCost_amt,
		EmployerYearlyCost_amt, DeductionsPerYear_val, Product_nm, Carrier_nm, Benefit, PlanYearFrom_dt,
		PlanYearThru_dt, EmployeeProductStatus_vv, Enroller, [Grouping])
	SELECT	Cast(e.Person_key as varchar(40)),
		ep.costtablevalue_key,ep.coverage_key, ep.groupproduct_key,
		rs.reportsignature_key,
		RTrim(e.First_nm) + IsNull(''  '' + e.MiddleInitial_nm, '''') + '' '' + e.Last_nm,
		IsNull(e.ssn_txt, ''         '') ssn_txt,
		e.AddressLine1_txt,
		e.AddressLine2_txt,
		e.City_txt,
		state_cd,
		e.PostalCode_txt,
		g.Company_nm,
		o.Organization_nm,
		etv.Location_Long_nm,
		IsNull(ep.EmployeeStartCost_amt, 0) EmployeePriorYearlyCost_amt,
		IsNull(ep.EmployeeYearlyCost_amt, 0) EmployeeYearlyCost_amt,
		IsNull(ep.EmployerYearlyCost_amt, 0) EmployerYearlyCost_amt,
		IsNull(ep.DeductionsPerYear_val, 1) DeductionsPerYear_val,
		cz.ProductDisplay_nm + '' '' + Coalesce(planid.Answer_txt, ep.CoverageLevel_txt, '''') Product_nm,
		c.OrganizationShort_nm Carrier_nm,
		gtv.Short_nm Benefit,
		lep.PlanYearFrom_dt,
		lep.PlanYearThru_dt,
		ep.EmployeeProductStatus_vv,
		usr.First_nm + '' '' + usr.Last_nm Enroller,
		CASE COALESCE(ep.EmployeeProductStatus_vv, '''')
			WHEN ''WAIVED'' THEN ''Coverage Waived''
			WHEN '''' THEN NULL
			ELSE
				CASE ep.PreTax_Flg
					WHEN ''Y'' THEN ''Pre-Tax Elections''
					ELSE	''Post-Tax Elections''
				END
		END [Grouping]
	FROM		v_EmployeePerson e
	JOIN		v_LatestEnrollmentPeriod lep ON e.Group_key = lep.Group_key
	JOIN		EMP_EmployeeEnrollmentPeriod ee	ON ee.Person_key = e.Person_key AND ee.EnrollmentPeriod_key = lep.EnrollmentPeriod_key
	JOIN		MSC_Organization o ON o.Organization_key = lep.PrimaryGroup_key
	JOIN		GRP_Group g ON g.Group_key = o.Organization_key
	LEFT JOIN	EMP_EmployeeProduct ep ON ep.employee_key = e.person_key
			AND (ep.EmployeeProductStatus_vv = ''ENROLLED'' OR ep.EmployeeProductStatus_vv = ''WAIVED'')
	LEFT JOIN	EMP_EmployeeProductData planid ON planid.EmployeeProduct_key = ep.EmployeeProduct_key
			AND planid.Answer_key = ''E2395B16-C217-4D8A-9F53-594BAE4BD8C6''
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
			AND rs.Report_key = ''C110A714-BBFF-4BCC-B2BD-F9ABABCEBB6D''
	WHERE e.Person_key in (' + @Emp_key + ')'
	if @debug > 0 
		print @cmdStr
	exec (@cmdStr)
	-- adjust the employee list
	set @empLst = substring(@empLst,charindex(',',@empLst) + 1,len(@empLst))
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
		if exists(select displayoverride_txt from grp_groupproductdimensionvalue 
				where groupproductdimension_key in (
					select groupproductdimension_key from grp_groupproductdimension grpprddi
						right join prd_dimensionvalue prddival on grpprddi.dimension_key = prddival.dimension_key
						and answervalue_key  in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9')
						and ((dimensionvalue_key = (select dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key))
						or (dimensionvalue_key = (select dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key)))
					where grpprddi.groupproduct_key = @grpprd_key)
				and dimensionvalue_key = (
					select dimensionvalue_key from prd_dimensionvalue
					where answervalue_key  in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9')
					and ((dimensionvalue_key = (select dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key))
					or dimensionvalue_key = (select dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key)))
				and displayoverride_txt is not null
				) 
			begin
			--
			-- use the group override text
			--
			if @debug > 1
				print 'Use the group text for ' + convert(char(36), @Emp_key)
			update #EmpEnroll set TypeContract = (
				select displayoverride_txt from grp_groupproductdimensionvalue 
				where groupproductdimension_key in (
					select groupproductdimension_key from grp_groupproductdimension grpprddi
						right join prd_dimensionvalue prddival on grpprddi.dimension_key = prddival.dimension_key
						and answervalue_key  in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9')
						and ((dimensionvalue_key = (select dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key))
						or (dimensionvalue_key = (select dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key)))
					where grpprddi.groupproduct_key = @grpprd_key)
				and dimensionvalue_key = (
					select dimensionvalue_key from prd_dimensionvalue
					where answervalue_key  in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9')
					and ((dimensionvalue_key = (select dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key))
					or dimensionvalue_key = (select dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key))) )
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
						where answervalue_key in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9')
						and ((dimensionvalue_key in (select Dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key))
						or dimensionvalue_key in (select Dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key)))
				where Employee_key = @Emp_key and groupproduct_key = @grpprd_key
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
--
-- Now dump the table and get the employee's signature data on the way out
--
--
select #EmpEnroll.*, sig.Signature_bin Employee_Signature, sig.Signed_dttm EmpDateSigned
from #EmpEnroll
left join EMP_ReportSignature sig on signature_key = sig.reportsignature_key
-- end of the script
if @debug > 0 
	Print 'That''s a wrap!!!'