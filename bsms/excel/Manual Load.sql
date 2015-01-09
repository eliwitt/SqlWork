--===============================================================================
-- this script can be used once you have imported the excel spreadsheet into a
-- table called [dbo].[testImport].  The script will read all of the rows from the 
-- imported table and update both the [sp].[SPMaster2] and the wACom.VendorList
--===============================================================================
declare @VWNu nvarchar(255),
	@mDesc nvarchar(255), 
	@MPN nvarchar(255), 
	@manufact nvarchar(255), 
	@mfgactual nvarchar(255), 
	@stock float, 
	@bun nvarchar(255), 
	@maxlevel float, 
	@reorder float,
	@Upct int = 0,
	@Inct int = 0,
	@vUpct  int = 0,
	@vInct int = 0

DECLARE sapCurs CURSOR FAST_FORWARD FOR
	SELECT material, [material description], mpn, [Manufact#],
	[Name 1], [Total Stock], Bun, [Max# level], [Reorder Point]
	 FROM [dbo].[testImport] order by material

OPEN sapCurs
FETCH NEXT FROM sapCurs INTO @VWNu, @mDesc, @MPN, @manufact, @mfgactual, @stock, @bun, @maxlevel, @reorder
WHILE @@FETCH_STATUS = 0
BEGIN
-- Do we hae an update or an insert
--
	if @MPN IS null
		set @MPN = ''
	if @manufact IS null
		set	@manufact = ''	
	if @mfgactual IS null
		set @mfgactual = ''
	if @mDesc IS null
		set @mDesc = ''
	if @stock IS null
		set	@stock = 0
	if @bun IS null
		set @bun = ''
	if @reorder IS null
		set @reorder = 0
	if @maxlevel IS null
		set	@maxlevel = 0

	if exists(select sp2id from sp.spmaster2 where SP2VWNumber = @VWNu)
		update [sp].[SPMaster2] set SP2SAPMFGPN = @MPN, SP2MFGID = @manufact, 
		SP2MFGActual = @mfgactual, SP2MFGGuess = @mfgactual,  
		SP2ShortSAPDescr = @mDesc, SP2RecQuantity = @stock, SP2IssueUOM = @bun, SP2Min = @reorder, 
		SP2Max = @maxlevel 
		where SP2VWNumber = @VWNu
	else
		insert into sp.SPMaster2 (SP2SAPMFGPN, SP2MFGID, SP2MFGActual, SP2MFGGuess,
		SP2ShortSAPDescr, SP2RecQuantity, SP2IssueUOM, SP2Min, 
		SP2Max, SP2VWNumber) values(@MPN, @manufact, @mfgactual, @mfgactual,
		@mDesc, @stock, @bun, @reorder, @maxlevel, @VWNu)
	if exists(select vlsapid from wACom.VendorList where vlsapid = @manufact)
		update wACom.VendorList set vlname = @mfgactual where vlsapid = @manufact
	else
		insert into wACom.VendorList (VLName, VLSAPID) values(@mfgactual, @manufact)
	--DELETE FROM @holdtable;
	FETCH NEXT FROM sapCurs INTO @VWNu, @mDesc, @MPN, @manufact, @mfgactual, @stock, @bun, @maxlevel, @reorder
END
CLOSE sapCurs
DEALLOCATE sapCurs

--select @Upct 'Update rows', @Inct 'Insert rows'
--select @vInct 'Inserted Vendoers', @vUpct 'Updated vendors'