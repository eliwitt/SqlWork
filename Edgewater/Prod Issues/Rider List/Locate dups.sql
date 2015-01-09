declare @cust1pid uniqueidentifier,
	@custk1pid uniqueidentifier,
	@custk2pid uniqueidentifier,
	@cust2pid uniqueidentifier,
	@custnm	nvarchar(1000)
declare CustSrc scroll cursor for
select customization_key, product_key from prd_customization order by product_key
open CustSrc
fetch first from CustSrc into @custk1pid,@cust1pid
while @@fetch_status = 0
begin
	select @custk2pid = customization_key, @cust2pid = product_key, @custnm	= productdisplay_nm from prd_customization where product_key = @cust1pid
	if @@rowcount > 1
	begin
		select @custk1pid as original, @custk2pid as secondkey, @cust2pid as product_key, @custnm as ProductDisplay_nm
	end
	fetch next from CustSrc into @custk1pid,@cust1pid
end
close CustSrc
deallocate CustSrc