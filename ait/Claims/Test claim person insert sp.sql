--
-- This script will insert accient loss claims
--
declare @Debug int, 
	@MyKey int, 
	@MasterPtr int,
	@VehPtr	int,
	@PartyPtr int,
	@PerPtr int,
	@VehPassPtr int, 
	@AddrPtr int,
	@Owner	int
-- define the table data fields for the claim
declare
	@PolicyNu nvarchar(16),
	@DOL	datetime,
	@LType	int,
	@VehNu	int, 
	@OurVeh	int, 
	@Towing tinyint, 
	@VehYr	nvarchar(4), 
	@Make	nvarchar(50), 
	@Model	nvarchar(50), 
	@OurDrv	int, 
	@DDesc	nvarchar(512),
	@DEstimate	money,
	@Lossid	int,
	@AccDesc	nvarchar(512),
	@Injured	int,
	@Severtyid	int,
	@InjDesc	nvarchar(512),
	@Rep	int,
	@Attid	int,
	@Treat	int,
	@Medid	int, 
	@Liability tinyint,
	@InsureCo	nvarchar(128),
	@InsurePolicyNu	nvarchar(60),
	@InsureContactInfo	nvarchar(512)
-- define the clm_person fields
declare
	@FNam	varchar(32),
	@MNam	varchar(32), 
	@LNam	Varchar(32),
	@SufID	int,
	@TileID	int,
	@DOB datetime,
	@Gender	int,
	@Married	int,
	@SSN	varchar(11), 
	@LiceNu	varchar(16),
	@LiceSt	char(2),
	@HomePh	varchar(16),
	@CellPh	varchar(16),
	@WrkPh	varchar(16),
	@Email	varchar(128),
	@Addr1	varchar(128),
	@Addr2	varchar(128),
@ClaimNumber	varchar(18),
	@ZipPtr	int
--  claim fields
set @PolicyNu = '10416'
set	@DOL = '5/10/2010'
set	@LType = 1
-- clm_claimvehicle
set	@VehNu = 2
set	@OurVeh = 0
set @Towing = 0
set	@VehYr = '2002'
set	@Make = 'Ford'
set	@Model = 'F150'
set	@OurDrv	= 0
set	@DDesc = 'Rear bumper'
set	@DEstimate = 342.32
set @Liability = 0
set @InsureCo = 'Our Veh'
set @InsurePolicyNu = 'GoAuto'
set @InsureContactInfo = '1800askauto'
-- clm_involvedparty
set @Lossid = 1
set @AccDesc = 'Body was thrown from the car'
set @Injured = 1
set @Severtyid = 0
set @InjDesc = 'Broken right leg, right arm, and right hip'
set @Rep = 0
set @Attid = 0
set @Treat = 0
set @Medid = 0
set @Owner = 0
--  clm_person fields
set @FNam='Sharon'
set	@MNam=''
set	@LNam='Brown'
set	@SufID=2
set	@TileID=7
set	@DOB = '1/18/1980'
set	@Gender	= 1
set	@Married = 1
set	@SSN = '231778812' 
set	@LiceNu	= 'wed1234to0123456'
set	@LiceSt	= 'OH'
set	@HomePh	= '5132347812'
set	@CellPh	= '9372315612'
set	@WrkPh='6804561278'
set	@Email='tthall@hotmail.com'
set @Addr1 = 'First Addr'
set @Addr2 = 'Second Addr'
-- hopfully this value is for zipcode 43009 Cable, OH
set @ZipPtr = 37584
/*  insert the claim data */
--exec sp_fileclaim @PolicyNu, 1234, @DOL, @LType, 0, null, null, null, null, null

/*  insert claim vehicle */
--exec sp_insertclaimveh 132, @VehNu, @OurVeh, @Liability, @Towing, @VehYr, @Make, @Model, @DDesc, @DEstimate, null,
--	@InsureCo, @InsurePolicyNu, @InsureContactInfo


/*  insert a normal claim person */
--exec sp_insertperson 132, @VehNu, @OurDrv, @Lossid, @Owner, @AccDesc, @Injured, @Severtyid, @InjDesc,
--	@Rep, @Attid, @Treat, @Medid, @FNam, @MNam, @LNam, @SufID, @TileID, @DOB, @Gender, @Married,
--	@SSN, @LiceNu, @LiceSt, @HomePh, @CellPh, @WrkPh, @Email, @Addr1, @Addr2, @ZipPtr
/* claimreserves goes through all of the vehicle, people, and properties for the given claim */
-- claim wide
--exec sp_claimreserves 132, '5/10/2010'
-- individual
--exec sp_nonreserves 131, 1, 1
--exec sp_propertyreserve 131, 194, 2


/*
exec sp_insertperson 11, @VehNu, @OurDrv, @Lossid, @Owner, @AccDesc, @Injured, @Severtyid, @InjDesc,
	@Rep, @Attid, @Treat, @Medid, @FNam, @MNam, @LNam, @SufID, @TileID, @DOB, @Gender, @Married,
	@SSN, @LiceNu, @LiceSt, @HomePh, @CellPh, @WrkPh, @Email, @Addr1, @Addr2, @ZipPtr
*/
--exec sp_IsPolicyActive '10025', 'Jul 29 2010  5:23PM'
--exec sp_personreserve 11, 191, 2


/* insert a property and it's owner claim 74 */
--exec sp_insertproperty 11, 'barn and the chicken house', 250.0, 'statefarm', 'sf-234-as-1235', '1-800-stefarm', 
--	@Injured, @Rep, @Attid, @FNam, @MNam, @LNam, @SufID, @TileID, @DOB, @Gender, @Married,
--	@SSN, @LiceNu, @LiceSt, @HomePh, @CellPh, @WrkPh, @Email, @Addr1, @Addr2, @ZipPtr
/*  insert the owner and property reserves */
--exec sp_propertyreserve 11, 192, 2

/* insert an excel claim */
--set @ClaimNumber = @PolicyNu + '2011-01-26'
--exec sp_insertexcelclaim @PolicyNu, @ClaimNumber, 1, '12/23/2011', '01/26/2011'

/* insert excel vehicle */
--exec sp_insertexcelVehicle 261, '2010', 'Chev', 'Camro', 0

/* insert the excel person */
--exec sp_insertexcelperson 261, 3, 1, 'Bill', 'Hamill'

/* insert the excel reserve */
-- insert a reserve lipd for our car 
--exec sp_insertexcelreserves 261, 2, 1, 1
-- insert a reserve lipd for our car 
--exec sp_insertexcelreserves 261, 2, 6, 1
-- insert a reserve med for a passenger 
--exec sp_insertexcelreserves 261, 5, 7, 1