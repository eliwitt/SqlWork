--  This procedure will examine the Market table and for any record with
--  a first week date older than the week this script is running in that 
--  record will have the weeks column data shifted and a new week added to 
--  the fifth week.

declare @WkChk as datetime
declare @rid as int
declare @rowIdc as int
--  Use the cursor to loop through
--  the marketing table to find any
--  record that needs to have the week
--  data shifted
declare MarkSht scroll cursor for
select MarketId, MkWk1
from 
edg_tbl_market

open MarkSht
fetch first from MarkSht into @rid, @WkChk
while @@fetch_status = 0
	begin
		print 'Is ' + cast(@rid as char(4)) + ' ready to be roled?'
		if (datediff(week,@WkChk,getdate()) > 0)
			begin
			print @rid + ' will be rolled ' + @WkChk
			--exec edg_sp_MarkColMove @rid
		end
		fetch next from MarkSht into @rid, @WkChk
end
close MarkSht
deallocate MarkSht
