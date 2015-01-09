creATE   PROCEDURE [dbo].[edg_sp_CashLine] 
@Line int, @Value int
AS
-- declare @Line int, @Value int
declare @partid nvarchar(20),
	@lprice smallmoney,
	@lhrs nvarchar(15),
	@part nvarchar(50),
	@qual nvarchar(150),
	@sub int,
	@f1 smallmoney,
	@lh smallmoney,
	@lf smallmoney,
	@debug int,
	@uType int,
	@trapped int,
	@ErrorMsg varchar(255)
set @debug = 0
set @uType = 0
-- set @Line = 2882
-- set @Value = 11
-- process the four different request for individual line items in
-- the cash discount function.
--
if @debug = 1
	print 'Process line ' + convert(nvarchar(5), @line)

-- for lineset values of 11 and 21 set the individual 
-- line.  We will need to retrieve additional information
-- in order to set the line item.

-- retrieve the line item detail
select @partid = partid, @lprice = list_price, @lhrs = labor_hours, @part = part, @qual = qual
from edg_tbl_invoice_lineitem
where lineitemid = @Line
if (@@rowcount = 0) 
	begin
	set @trapped = 10
	set @ErrorMsg = 'Error retrieving line item ' + convert(varchar(4), @Line)
	goto Error_Handler
end

if @debug = 1
	print 'For ' + convert(nvarchar(4), @Line) + ' ' + @partid + ' ' + convert(nvarchar(12), @lprice) + ' ' + @lhrs + ' ' + @part + ' ' + @qual

if @Value in (10,20) 
	goto reset_the_item

	--  beginning of the process to determine what line type we are 
	--  processing.
	--

	-- check for Domestic windsheld
if Upper(Left(@partid, 2)) = 'DW'
	begin
	if @debug = 1
		print 'Domestic windsheld'
	set @uType = 1
	goto Lookup_Discount
end
	-- check for foreign windsheld
if Upper(Left(@partid, 2)) = 'FW'
	begin
	if @debug = 1
		print 'Foreign Windsheld'
	set @uType = 2
	goto Lookup_Discount
end
	-- check for domestic tempered glass
if Upper(Left(@partid, 1)) = 'D'
	begin
	if @debug = 1
		print 'Domestic Tempered'
	set @uType = 3
	goto Lookup_Discount
end
	-- check for foreign tempered glass
if Upper(Left(@partid, 1)) = 'F'
	begin
	if @debug = 1
		print 'Foreign Tempered'
	set @uType = 4
	goto Lookup_Discount
end
	-- check for adhesives
if Upper(@part) = 'ADHESIVE'
	begin
	if @debug = 1
		print 'Adhesives'
	if charindex('1.0',@qual) > 0
		begin
		set @uType = 5
		goto Lookup_Discount	
	end
	if charindex('1.5',@qual) > 0
		begin
		set @uType = 6
		goto Lookup_Discount	
	end
	if charindex('2.0',@qual) > 0
		begin
		set @uType = 7
		goto Lookup_Discount	
	end
	if charindex('2.5',@qual) > 0
		begin
		set @uType = 8
		goto Lookup_Discount	
	end
	if charindex('3.0',@qual) > 0
		begin
		set @uType = 9
		goto Lookup_Discount	
	end
	set @uType = 10
	goto Lookup_Discount
end
	-- check for First repair
if Upper(@part) = 'RP1'
	begin
	if @debug = 1
		print 'Uno Repair'
	set @uType = 11
	goto Lookup_Discount
end
-- check for Second Repair
if Upper(@part) = 'RPA'
	begin
	if @debug = 1
		print 'Dos Repair'
	set @uType = 12
	goto Lookup_Discount
end
	--  check labor hours
if @lhrs > 0
	begin
	if @debug = 1
		print 'Hourly Process'
	set @uType = 13
	goto Lookup_Discount
end


Lookup_Discount:

if @debug = 1
	print ' Type ' + convert(char(2), @uType)

--  find the subscriberid for the line item
if @debug = 1
	print 'Read the invoice master'
select @sub = mast.subscriberid 
from edg_tbl_invoice_lineitem as LI
left outer join edg_tbl_invoice_opening as IO on IO.OpeningId = LI.Openingid
left outer join edg_tbl_invoice_master as mast on IO.InvoiceId = mast.InvoiceId
where lineitemid = @Line
if (@@rowcount = 0) 
	begin
	set @trapped = 20
	set @ErrorMsg = 'Error retrieving the subscriberid for line item ' + convert(varchar(4), @Line)
	goto Error_Handler
end

--  based on the type field, retrieve from the
--  cash discount table the columns needed for 
--  the update
--
if @debug = 1
	print 'Read the cash discount'
select @f1 =
	case @uType
		when 1 then DomesticWindShield
		when 2 then ForeignWindShield
		when 3 then DomesticTempered
		when 4 then ForeignTempered
		when 5 then OnePointZeroKit
		when 6 then OnePointFiveKit
		when 7 then TwoPointZeroKit
		when 8 then TwoPointFiveKit
		when 9 then ThreePointZeroKit
		when 10 then OtherKit
		when 11 then FirstRepair
		when 12 then AdditionalRepair
	end,
	@lh = laborhourly, @lf = laborflat
from edg_tbl_oa_cash
where subscriberid = @sub
if (@@rowcount = 0) 
	begin
	set @trapped = 30
	set @ErrorMsg = 'Error retrieving cash values ' + convert(varchar(4), @sub)
	goto Error_Handler
end

if @debug = 1
	print 'Use ' + convert(nvarchar(10),@f1) + ' ' + convert(nvarchar(2),@uType)

--
--
declare @lr smallmoney
if (@Value = 21) AND (@lf > 0)
	select @lr = LaborRate from edg_tbl_subscribers where subscriberid = @sub

--  Now we are ready to update the line item with the cash
--  discount values

reset_the_item:
--
begin transaction

declare @cmd as varchar(8000)
set @cmd = 'UPDATE  edg_tbl_Invoice_LineItem set ' +
	case @Value
		when 10 then
			'cash_Prog = 0, discount = '''', net_price = ' + convert(varchar(8),@lprice)
		when 11 then
			case 
			--  set the percentage types
				when @uType < 5 then
					case @f1
						when 0 then
							'Discount = '''', cash_prog = 1, net_price = ' + convert(varchar(8),@lprice)
						else
							'Discount = ''' + convert(nvarchar(10),@f1) + '%'', cash_prog = 1, net_price = ' + convert(varchar(8),@lprice - (@lprice * @f1/100))
					end
				--  set the flat types
				when @uType > 4 then
					case 
						when @f1 > 0 then
							'Discount = ''flat'', cash_prog = 1, net_price = ' + convert(varchar(8), @f1)
					end
			end

		when 20 then
			'labor_oaa = 0'
		when 21 then
			case  
				when @lhrs > 0 then
					case 
						when @lh > 0 then
							'labor_rate = ' + convert(varchar(7), @lh) + ', labor_oaa = 1, labor_net = ' + convert(varchar(7),@lh * convert(smallmoney,@lhrs))
						when @lf > 0 then
							'labor_Discount = ''flat'', labor_rate = ' + convert(varchar(7), @lr) + ', labor_oaa = 1, labor_net = ' + convert(varchar(7), @lf)
					end
			end
	end
set @cmd = @cmd + ' WHERE     (LineItemId = ' + convert(varchar(5), @Line) + ')'
exec(@cmd)
set @trapped = @@error
if (@trapped <> 0)
	begin
	set @ErrorMsg = 'Error attempting to update line item ' + convert(varchar(4), @Line)
	goto Error_Handler
end

if @debug = 1
	Begin
	print @cmd
	print 'End of module'
end

commit
return
-- bottom of the script
Error_Handler:
if @debug = 1
	print 'Error Handler'

IF @ErrorMsg IS NOT NULL
     BEGIN
	SELECT @ErrorMsg = 'edg_sp_CashLine: ' + @ErrorMsg + '  ' + convert(varchar(10), @trapped)
	RAISERROR(@ErrorMsg, 11, 1) with log
	return 21
     END