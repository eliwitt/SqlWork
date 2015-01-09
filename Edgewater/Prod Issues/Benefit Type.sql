-- This script will process the all employees in the given group

-- we copy the same logic for the benefit election because we need the type contract.

--

-- script variables

 

declare @debug             int, 
		@typeval	varchar(500),
            @OrgName       varchar(4000)
set @typeval = ''
 

-- initialize the variables

-- EmployeesList is the variable used by the reports so we will comment this out once 

-- the script is copied into the report

 

set @OrgName = ''

set @OrgName = 'Cibo Euro Cafe%'

 

 

--

--  set @debug to an integer and you will get print statements

--  0 = turn off

--  1 = high level 

--  2 = detail

--  3 = stop after the build of the cmd str

set @debug = 2

 

-- check the existance of the temp table

 

if object_id('tempdb..#EmpProd') is not null

           drop table #EmpProd

 

SELECT emp_person.Person_key employee_key, EMP_EmployeeProduct.costtablevalue_key,

EMP_EmployeeProduct.coverage_key, EMP_EmployeeProduct.groupproduct_key,

EMP_Person.Last_nm, EMP_Person.First_nm, EMP_Person.MiddleInitial_nm, 

EMP_Person.SSN_txt, EMP_Employee.Employee_ID, EMP_Person.AddressLine1_txt, 

EMP_Person.AddressLine2_txt, EMP_Person.City_txt, MSC_State.State_cd, 

EMP_Person.PostalCode_txt, EMP_Person.HomePhone_txt, EMP_EmployeeProduct.DeductionsPerYear_val, 

EMP_EmployeeProduct.PreTax_flg, PRD_Product.Product_nm, MSC_Organization_1.Organization_nm, 

PRD_Customization.ProductDisplay_nm, EMP_EmployeeProduct.CoverageBenefit_txt, 

([EmployeeYearlyProductCost_amt]/[DeductionsPerYear_val]) AS EmployeePerDeductionCost, 

[EmployerYearlyProductCost_amt]/[DeductionsPerYear_val] AS EmployerPerDeductionCost, 

EMP_EmployeeEnrollmentPeriod.EnrollmentStatus_vv, EMP_EmployeeProduct.EmployeeProductStatus_vv,

@typeval as TypeContract

into                   #EmpProd

FROM MSC_State 

INNER JOIN ((MSC_Organization AS MSC_Organization_1 

INNER JOIN (PRD_Product 

INNER JOIN ((EMP_EmployeeProduct INNER JOIN ((((GRP_Group INNER JOIN EMP_Employee ON GRP_Group.Group_key = EMP_Employee.Group_key) INNER JOIN EMP_Person ON EMP_Employee.Person_key = EMP_Person.Person_key) INNER JOIN MSC_Organization ON GRP_Group.Group_key = MSC_Organization.Organization_key) INNER JOIN EMP_EmployeeEnrollmentPeriod ON (EMP_Employee.Person_key = EMP_EmployeeEnrollmentPeriod.Person_key) AND (EMP_Person.Person_key = EMP_EmployeeEnrollmentPeriod.Person_key)) ON EMP_EmployeeProduct.Employee_key = EMP_Employee.Person_key) INNER JOIN GRP_GroupProduct ON (EMP_EmployeeProduct.GroupProduct_key = GRP_GroupProduct.GroupProduct_key) AND (GRP_Group.Group_key = GRP_GroupProduct.Group_key)) ON PRD_Product.Product_key = GRP_GroupProduct.Product_key) ON MSC_Organization_1.Organization_key = PRD_Product.Carrier_key) INNER JOIN PRD_Customization ON GRP_GroupProduct.GroupProduct_key = PRD_Customization.GroupProduct_key) ON MSC_State.State_key = EMP_Person.State_key

WHERE (((EMP_EmployeeProduct.EmployeeProductStatus_vv)='ENROLLED') AND ((MSC_Organization.Organization_nm) Like @OrgName))

ORDER BY EMP_Person.Last_nm, EMP_Person.First_nm

 

--

-- attempt to update the typecontract field

--

 

declare  @cost_key        uniqueidentifier,

            @cover_key      uniqueidentifier,

            @Emp_key       uniqueidentifier,

            @grpprd_key     uniqueidentifier

 

--

--  define the cursor

--

declare empcursor cursor for

select Employee_key, costtablevalue_key, coverage_key, groupproduct_key

from #EmpProd

 

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

                                                where (dimensionvalue_key = (select dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key)

                                                or dimensionvalue_key = (select dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key))

                                                and answervalue_key  in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9')

                                    ) and displayoverride_txt is not null ) 

                                    begin

                                    --

                                    -- use the group override text

                                    --

                                    if @debug > 1

                                         print 'Use the group text for ' + convert(char(36), @Emp_key)

 

                                    update #EmpProd set TypeContract = (

                                                select top 1 displayoverride_txt from grp_groupproductdimensionvalue 

                                                            where dimensionvalue_key = (

                                                                        select dimensionvalue_key from prd_dimensionvalue

                                                                        where (dimensionvalue_key = (select dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key)

                                                                        or dimensionvalue_key = (select dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key))

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

                                                            where (dimensionvalue_key in (select Dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key)

                                                            or dimensionvalue_key in (select Dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key))

                                                            and answervalue_key in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9') 

                                                )

                                                begin

                                                if @debug > 1

                                                     print 'Use the product text for ' + convert(char(36), @Emp_key)

                                                update #EmpProd set TypeContract = (

                                                            select override_txt from prd_dimensionvalue 

                                                                        where (dimensionvalue_key in (select Dimensionvalue_x_key from prd_costtablevalue where costtablevalue_key = @cost_key)

                                                                        or dimensionvalue_key in (select Dimensionvalue_y_key from prd_costtablevalue where costtablevalue_key = @cost_key))

                                                                        and answervalue_key in (select answervalue_key from ans_answervalue where answer_key = '3f83256c-7d80-455c-abf1-9ff3148ae6f9') 

                                                            )

                                                            where Employee_key = @Emp_key and groupproduct_key = @grpprd_key

                                                end

                                    else

                                                begin

                                                --

                                                -- use the coverage text

                                                --

                                                if @debug > 1

                                                     print 'Use the coverage text for ' + convert(char(36), @Emp_key)

 

                                                update #EmpProd set TypeContract = (select coverage_nm from msc_coverage where coverage_key = @cover_key)

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

select * from #EmpProd

