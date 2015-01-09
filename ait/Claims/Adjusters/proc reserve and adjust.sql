USE [ClaimProdMar11]
GO
/****** Object:  StoredProcedure [dbo].[sp_claimreserves]    Script Date: 04/13/2011 13:33:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_claimreserves] 
      @CMastPtr int,
      @AccDt            datetime
AS

BEGIN

      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

declare @myVnu                int,
	  @ClaimNumber			  varchar(18),
      @myEnu                  int, 
      @myPer                  int,
	  @myOwner				  int,
      @myInjured        int

-- close any reserve for the claim
update CLM_Reserve 
      set ClosedOn = GetDate(), ReserveOpen = 0
      where ClaimNumber = @CMastPtr

-- The following statements could delete the unused rows from the old claim
delete from clm_reserve where id in (
      select id from clm_reserve where claimnumber = @CMastPtr and 
		(AmountPaid = 0 or AmountPaid is null) and
		forcedclosed = 0
)

-- the following is a collection of claim's vehicles

declare myVehcursor cursor for
select distinct cv.VehicleNumber, cv.Entitynumber 
      from clm_claimvehicle cv 
      where cv.claimmasterptr = @CMastPtr and disabled = 0

open myVehcursor
fetch next from myVehcursor into @myVnu, @myEnu
while (@@fetch_status = 0)
begin

      exec sp_bulkreserve @CMastPtr, @myVnu, @myEnu
      fetch next from myVehcursor into @myVnu, @myEnu

end

close myVehcursor
deallocate myVehcursor

-- the following is a collection of the claim's people

declare myPercursor cursor for
select ip.id, ip.injured
      from clm_vehiclepassenger vp
            join clm_involvedparty ip on vp.involvedpartyptr = ip.id
      where claimmasterptr = @CMastPtr and disabled = 0 and lossroleid in (1,2,3,4)

open myPercursor
fetch next from myPercursor into @myPer, @myInjured
while (@@fetch_status = 0)
begin

      if @myInjured = 1
            exec sp_personreserve @CMastPtr,@myPer, 2
      fetch next from myPercursor into @myPer, @myInjured

end

close myPercursor
deallocate myPercursor

-- the following is a collection of the owners and their properties
declare myPropcursor cursor for
select involvedpartyptr from clm_otherproperty where claimmasterptr = @CMastPtr and (disabled = 0 or disabled is null)
open myPropcursor
fetch next from myPropcursor into @myOwner
while (@@fetch_status = 0)
begin

      exec sp_propertyreserve @CMastPtr,@myOwner, 2
      fetch next from myPropcursor into @myOwner

end
close myPropcursor
deallocate myPropcursor


if exists(select id from clm_reserve where claimnumber = @CMastPtr and ReserveOpen = 1)
begin	
	update clm_claimmaster set ReservesClosed = 0 where id = @CMastPtr
end 
else
begin
	update clm_claimmaster set ReservesClosed = 1 where id = @CMastPtr
end
select @ClaimNumber = ClaimNumber from CLM_ClaimMaster where id = @CMastPtr
--
--  Now check if any reserves have been created do we need to insert a new assignment row
--
--  we have coverage of (1) LIPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 1 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 2))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 2, GETDATE())
--
--  we have coverage of (2) LIBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 2 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 4))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 4, GETDATE())
--
--  we have coverage of (3,4) Comp/Coll with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid in (3,4) and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 6))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 6, GETDATE())
--
--  we have coverage of (5) Towing with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 5 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 7))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 7, GETDATE())
--
--  we have coverage of (7) MED with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 7 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 8))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 8, GETDATE())
--
--  we have coverage of (8) UMBI with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 8 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 9))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 9, GETDATE())
--
--  we have coverage of (9) UMPD with no one assigned to it do not set the claimloaded
--
if exists(select * from clm_reserve where claimnumber = @CMastPtr and coverageid = 9 and reserveopen = 1 and not exists (
			select * from clm_adjusterassignments a where claimptr = @CMastPtr and
				a.adjusterskilltypeptr = 10))
	insert into CLM_AdjusterAssignments values(0, @ClaimNumber, @CMastPtr, 1, 10, GETDATE())

end