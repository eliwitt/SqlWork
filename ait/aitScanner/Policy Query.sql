--
--  looking at the policy in the goautoprod for the policy ptr
--
declare @myPtr int
set @myPtr = 72494
select * from policy where id = @myPtr

select PolicyNumber, QuoteNumber 
from Policy where id = @myPtr

select * from policydocuments 
where policyptr = @myPtr

select dbo.F_PolicyHasDocument(@myPtr,4) docvalid
