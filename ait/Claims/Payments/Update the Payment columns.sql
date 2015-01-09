declare @myParts int, @myCNumber nvarchar(50), @myCheck nvarchar(50)
set @myParts = 51
set @myCNumber = '3529-04-28-2010'
set @myCheck = '9999999'
update clm_paymentparts set issued = 9 where id in (
select pp.id
	from clm_paymentparts pp
	join clm_payment pm on pp.paymentptr = pm.id
	join clm_claimmaster cm on pm.claimptr = cm.id
	where pp.id = @myParts
		and @myCNumber = cm.claimnumber)

update clm_payment set CheckNu = @myCheck where id in (
select pp.paymentptr
	from clm_paymentparts pp
	join clm_payment pm on pp.paymentptr = pm.id
	join clm_claimmaster cm on pm.claimptr = cm.id
	where pp.id = @myParts
		and @myCNumber = cm.claimnumber)

if not exists(select * from clm_paymentparts where paymentptr = (select paymentptr from clm_paymentparts where id = @myParts) and issued = 0)
   update clm_payment set issued = 10 where id in (
select pp.paymentptr
	from clm_paymentparts pp
	join clm_payment pm on pp.paymentptr = pm.id
	join clm_claimmaster cm on pm.claimptr = cm.id
	where pp.id = @myParts
		and @myCNumber = cm.claimnumber)

select cm.id, pm.id, pp.id, cm.claimnumber, pm.issued, pm.checknu, pp.issued
from clm_paymentparts pp
	join clm_payment pm on pp.paymentptr = pm.id
	join clm_claimmaster cm on pm.claimptr = cm.id
where pp.id = @myParts