select 'update clm_reserve set reserveopen = 1, closedon = null where id  = ' + cast(r.id as nvarchar(10)) from clm_reserve r 
where r.ReserveOpen = 0 and r.ForcedClosed  = 0 
and not exists (
select * from CLM_PaymentParts q where q.ReservePTR = r.id and q.ClosesReserve = 1)
and r.ClosedOn >= '04/08/2011'
order by r.ClaimNumber, r.CoverageID asc, r.ClosedOn desc

select * from clm_coverage