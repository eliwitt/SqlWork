
--This is for Payroll Deduction Authorization report
--This is to fix the Type Contract issue in the report
--This fix is created by Steve Witt and is first implemented in Benefit Election Report
--Peng Yu tranferred the same issue fix into this Report (Feb-27-2008)

declare @cmdStr 	varchar(4000),
	@Emp_key	varchar(4000),
	@empLst 	varchar(4000),
	@debug		int	

--this @EmployeesList variable is here for testing, the actual value comes from report parameter
--set @EmployeesList='{ADB08E0B-A1E7-49D6-AAE0-04C55878E491},{AE739230-F2A7-4C6C-9D50-0B05AD42866F}, {BC0E259B-453B-4397-8C89-8542B2DF62D1},{D2907B22-EA8E-4D74-B835-0581F24F3639}'
set @empLst = replace(@EmployeesList,'{','')
set @empLst = replace(@empLst,'}','')
--set @empLst = replace(@empLst,'''','')
--
--  set @debug to an integer and you will get print statements
--  0 = turn off
--  1 = high level 
--  2 = detail
--  3 = stop after the build of the cmd str
--set @Emp_key='BC0E259B-453B-4397-8C89-8542B2DF62D1'

set @debug = 2
if object_id('tempdb..#PayrollDeduction') is not null
	drop table #PayrollDeduction

create table #PayrollDeduction (
	Employee_key			uniqueidentifier,
	costtablevalue_key		uniqueidentifier,
	coverage_key			uniqueidentifier,
	groupproduct_key		uniqueidentifier,
	Signature_key			uniqueidentifier,
	Employee_ID			int,
	Full_nm				varchar(130),
	ssn_txt				varchar(10),
	AddressLine1_txt		varchar(60),
	AddressLine2_txt		varchar(60),
	City_txt			varchar(60),
	State				char(2),
	PostalCode_txt			varchar(16),
	Company_nm			varchar(60),
	Department			varchar(60),
	PreTax_flg			char(2),	
	EmployeeYearlyCost_amt		money,	
	DeductionsPerYear_val		int,
	EmployeeStartCost_amt		money,
	DeductionEffective_dt		datetime,
	Product_nm			varchar(140),
	Carrier_nm			varchar(30),
	Benefit				varchar(30),
	PlanYearFrom_dt			datetime,
	PlanYearThru_dt			datetime,
	EmpDateSigned			datetime,
	TypeContract			varchar(60),
	EmployeeProductStatus_vv	varchar(16),
	Enroller			varchar(120),
	ProductType_vv			varchar(60),
	Disclaimer			varchar(60)
)

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

set @cmdStr = '	INSERT INTO #PayrollDeduction (
Employee_key, costtablevalue_key, coverage_key, groupproduct_key,Signature_key,
Employee_ID, Full_nm, SSN_txt, AddressLine1_txt, AddressLine2_txt, City_txt, State,
PostalCode_txt, Company_nm, Department, PreTax_flg, EmployeeYearlyCost_amt, DeductionsPerYear_val,
EmployeeStartCost_amt, DeductionEffective_dt, Product_nm, Carrier_nm, Benefit, PlanYearFrom_dt,
PlanYearThru_dt, EmpDateSigned, TypeContract, EmployeeProductStatus_vv, Enroller, ProductType_vv, Disclaimer)
	
SELECT	Cast(e.Person_key as varchar(40)) Employee_key,
			ep.costtablevalue_key,
			ep.coverage_key, 
			ep.groupproduct_key, 
			rs.reportsignature_key,
			e.Employee_ID, 
			RTrim(e.First_nm) + '' '' + IsNull(e.MiddleInitial_nm, '''')  + '' '' + e.Last_nm Full_nm, 
			IsNull(e.ssn_txt, ''         '') ssn_txt, 
			e.AddressLine1_txt, 
			e.AddressLine2_txt, 
			e.City_txt, 
			state_cd State, 
			e.PostalCode_txt, 
			g.Company_nm, 
   			etv.Department_Long_nm department, 
			ep.PreTax_flg, 
			Cast(IsNull(ep.EmployeeYearlyCost_amt, 0) as money) EmployeeYearlyCost_amt, 
			IsNull(ep.DeductionsPerYear_val, 1) DeductionsPerYear_val, 
			IsNull(ep.EmployeeStartCost_amt,0) EmployeeStartCost_amt, 
			ep.DeductionEffective_dt, 
			cz.ProductDisplay_nm + '' '' + Coalesce(planid.Answer_txt, ep.CoverageLevel_txt, '''') Product_nm, 
			c.OrganizationShort_nm Carrier_nm, 
			gtv.Short_nm Benefit, 
			lep.PlanYearFrom_dt, 
			lep.PlanYearThru_dt, 
			rs.Signed_dttm EmpDateSigned, 
			mc.Coverage_nm TypeContract, 
			ep.EmployeeProductStatus_vv, 
			usr.First_nm + '' '' + usr.Last_nm Enroller,
			pr.ProductType_vv, 
			disclaimer			

FROM		v_EmployeePerson e 
JOIN		v_LatestEnrollmentPeriod lep ON e.Group_key = lep.Group_key 
JOIN		EMP_EmployeeEnrollmentPeriod ee	ON ee.Person_key = e.Person_key AND ee.EnrollmentPeriod_key = lep.EnrollmentPeriod_key 
JOIN		MSC_Organization o ON o.Organization_key = lep.PrimaryGroup_key 
JOIN		GRP_Group g ON g.Group_key = o.Organization_key 
LEFT JOIN  	EMP_EmployeeProduct ep ON e.Person_key = ep.Employee_key
LEFT JOIN	GRP_GroupProduct gp ON gp.GroupProduct_key = ep.GroupProduct_key 
LEFT JOIN	PRD_Customization cz ON	gp.GroupProduct_key = cz.GroupProduct_key 
LEFT JOIN	PRD_Product pr ON gp.Product_key = pr.Product_key 
LEFT JOIN	MSC_Organization c ON pr.Carrier_key = c.Organization_key 
LEFT JOIN	GRP_GroupTableValue gtv ON gp.BenefitType_key = gtv.GroupTableValue_key 
LEFT JOIN	v_EmployeeTableValue etv ON etv.Person_key = e.Person_key 
LEFT JOIN 	EMP_EmployeeProductData display ON display.EmployeeProduct_key = ep.EmployeeProduct_key 
			AND display.Answer_key = ''CA815913-D3AA-4F82-9D6B-85C6519B9101'' 
LEFT JOIN	EMP_EmployeeProductData planid ON planid.EmployeeProduct_key = ep.EmployeeProduct_key 
			AND	planid.Answer_key = ''E2395B16-C217-4D8A-9F53-594BAE4BD8C6'' 
LEFT JOIN	GRP_Enroller enr ON	enr.Enroller_key = ee.Enroller_key 
LEFT JOIN	MSC_User usr ON usr.user_key = enr.user_key  
LEFT JOIN	EMP_ReportSignature rs ON rs.EnrollmentPeriod_key = ee.EnrollmentPeriod_key 
			AND rs.Person_key = ee.Person_key AND rs.enroller_key IS NULL 
			AND rs.Report_key = ''BBBBF791-B2D1-44E3-9D6A-EF1B5C298EF6'' 
			and rs.signed_dttm = (select top 1 rs.signed_dttm from EMP_ReportSignature rs  
						where rs.Person_key = ee.Person_key AND rs.enroller_key IS NULL 
						AND rs.Report_key = ''BBBBF791-B2D1-44E3-9D6A-EF1B5C298EF6'' order by rs.signed_dttm desc )
LEFT JOIN	MSC_Coverage mc ON ep.Coverage_key = mc.Coverage_key 
CROSS JOIN (SELECT Parameter_desc disclaimer FROM MSC_Parameter WHERE Parameter_cd = ''PD_DISCLAIMER'') disc 
WHERE		(ep.EmployeeProductStatus_vv = ''ENROLLED'' 
			OR ep.EmployeeProductStatus_vv = ''EXPIRED'' 
			OR ep.EmployeeProductStatus_vv = ''WAIVED'' 
			OR ep.EmployeeProductStatus_vv IS NULL)  
			AND display.Answer_txt = ''Y'' 
			AND	e.Person_key in (''' + @Emp_key +  ''') 
ORDER BY	e.Last_nm, e.First_nm, e.MiddleInitial_nm'

	if @debug > 0 
		print @cmdStr
	exec (@cmdStr)
	-- adjust the employee list
	set @empLst = substring(@empLst,charindex(',',@empLst) + 1,len(@empLst))
end


declare	@cost_key	uniqueidentifier,
	@cover_key	uniqueidentifier,
	@grpprd_key	uniqueidentifier
--
--  define the cursor
--
declare empcursor cursor for
select Employee_key, costtablevalue_key, coverage_key, groupproduct_key
from #PayrollDeduction
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
			update #PayrollDeduction set TypeContract = (
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
				update #PayrollDeduction set TypeContract = (
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
				update #PayrollDeduction set TypeContract = (select coverage_nm from msc_coverage where coverage_key = @cover_key)
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
select #PayrollDeduction.*, sig.Signature_bin Employee_Signature, sig.Signed_dttm EmpDateSigned
from #PayrollDeduction
left join EMP_ReportSignature sig on signature_key = sig.reportsignature_key
-- end of the script
