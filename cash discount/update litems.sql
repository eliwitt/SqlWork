creaTE  PROCEDURE [dbo].[edg_sp_SetCashDiscount] 
@inv int
AS
declare @debug int
declare @ins int
declare @sub int
set @debug=0
--
--  is the invoice a no-insurance type
--
select @ins=InsuranceId, @sub=subscriberid from edg_tbl_invoice_master
where invoiceid = @inv
if @ins in (0,1000)
	goto not_insurance
--
--  it must be an insurance type of invoice which is not processed
--
select 'return'='INS'
return
--
--  continue to process
--
not_insurance:
if @debug = 1
	print 'You made It!'
--
--  lookup the part information
--
declare @line int
declare @partid nvarchar(20)
declare @lprice smallmoney
declare @lhrs nvarchar(15)
declare @part nvarchar(50)
declare @qual nvarchar(150)
declare @uType int
declare @f1 smallmoney
declare @lh smallmoney
declare @lf smallmoney
set @uType = 0
-- this cursor will handle the results of the query
declare lnItems scroll cursor for
select lineitemid, partid, list_price, labor_hours, part, qual
from edg_tbl_invoice_lineitem as LI
right outer join edg_tbl_invoice_opening as IO on
IO.OpeningId = LI.Openingid
where IO.InvoiceId = @inv
--  open the cursor and process all of the line items
open lnItems
fetch first from lnItems into @line, @partid, @lprice, @lhrs, @part, @qual
-- begin the process of setting the cash discount fields
while @@fetch_status = 0
	begin
	if @debug = 1
		print 'For ' + convert(nvarchar(4), @inv) + ' ' + @partid + ' ' + convert(nvarchar(12), @lprice) + ' ' + @lhrs + ' ' + @part + ' ' + @qual

	-- check for Domestic windsheld
	if Upper(Left(@partid, 2)) = 'DW'
		begin
		if @debug = 1
			print 'Domestic windsheld'
		set @uType = 1
		goto bottom_loop
	end
	-- check for foreign windsheld
	if Upper(Left(@partid, 2)) = 'FW'
		begin
		if @debug = 1
			print 'Foreign Windsheld'
		set @uType = 2
		goto bottom_loop
	end
	-- check for domestic tempered glass
	if Upper(Left(@partid, 1)) = 'D'
		begin
		if @debug = 1
			print 'Domestic Tempered'
		set @uType = 3
		goto bottom_loop
	end
	-- check for foreign tempered glass
	if Upper(Left(@partid, 1)) = 'F'
		begin
		if @debug = 1
			print 'Foreign Tempered'
		set @uType = 4
		goto bottom_loop
	end
	-- check for adhesives
	if Upper(@part) = 'ADHESIVE'
		begin
		if @debug = 1
			print 'Adhesives'
		if charindex('1.0',@qual) > 0
			begin
			set @uType = 5
			goto bottom_loop	
		end
		if charindex('1.5',@qual) > 0
			begin
			set @uType = 6
			goto bottom_loop	
		end
		if charindex('2.0',@qual) > 0
			begin
			set @uType = 7
			goto bottom_loop	
		end
		if charindex('2.5',@qual) > 0
			begin
			set @uType = 8
			goto bottom_loop	
		end
		if charindex('3.0',@qual) > 0
			begin
			set @uType = 9
			goto bottom_loop	
		end
		set @uType = 10
		goto bottom_loop
	end
	-- check for First repair
	if Upper(@part) = 'RP1'
		begin
		if @debug = 1
			print 'Uno Repair'
		set @uType = 11
		goto bottom_loop
	end
	-- check for Second Repair
	if Upper(@part) = 'RPA'
		begin
		if @debug = 1
			print 'Dous Repair'
		set @uType = 12
		goto bottom_loop
	end
	--  check labor hours
	if @lhrs > 0
		begin
		if @debug = 1
			print 'Hourly Process'
		set @uType = 13
		goto bottom_loop
	end
bottom_loop:
	--  based on the type field retrieve from the
	--  cash discount table the columns needed for 
	--  the update
	--
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
	if @debug = 1
		print 'Use ' + convert(nvarchar(10),@f1) + ' ' + convert(nvarchar(2),@uType)
	--  Now we are ready to update the line item with the cash
	--  discount values
	--  set the percentage types
	if @uType in (1,2,3,4)
		begin
		if @f1 = 0 
			begin
			update edg_tbl_invoice_lineitem
				set Discount = '',
				cash_prog = 1,
				net_price = @lprice
			where lineitemid = @line
		end
		else
			begin
			update edg_tbl_invoice_lineitem
				set Discount = ' ' + convert(nvarchar(10),@f1) + '%',
				cash_prog = 1,
				net_price = @lprice - (@lprice * @f1/100)
			where lineitemid = @line			
		end
	end
	--  set the flat types
	if @uType in (5,6,7,8,9,10,11,12)
		begin
		if @f1 > 0 
			begin
			update edg_tbl_invoice_lineitem
				set Discount = 'flat',
				cash_prog = 1,
				net_price = @f1
			where lineitemid = @line
		end
	end
	if @uType in (1,2,13)
		begin
		if @lhrs > 0
			begin
			if @lh > 0
				begin
				update edg_tbl_invoice_lineitem
					set labor_rate = @lh,
					labor_oaa = 1,
					labor_net = @lh * convert(smallmoney,@lhrs)
				where lineitemid = @line
			end		
			if @lf > 0
				begin
				declare @lr smallmoney
				select @lr = LaborRate from edg_tbl_subscribers where subscriberid = @sub
				update edg_tbl_invoice_lineitem
					set labor_Discount = 'flat',
					labor_rate = @lr,
					labor_oaa = 1,
					labor_net = @lf
				where lineitemid = @line
			end		
		end
	end
	--  read the next line item
	fetch next from lnItems into @line, @partid, @lprice, @lhrs, @part, @qual
end
if @debug = 1
	print 'End of module'
--  cleanup the cursor
close lnItems
deallocate lnItems
select 'return'='success'