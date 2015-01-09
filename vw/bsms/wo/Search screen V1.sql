--
--  build search for new screen
--
	SELECT * FROM EQP.ModelGroupOne
		WHERE MGOneActive = 1
declare @theShop int
set @theShop = 3
--select * from Team.wAPlants
; with theShopLevel1 as
(
	SELECT * FROM EQP.ModelGroupTwo ShopArea
		join EQP.ModelGroupOne theShop on theShop.MGOneID = ShopArea.MGTwoOneLink 
			AND theShop.MGOneActive = 1
		WHERE theShop.MGOneID = @theShop and MGTwoActive = 1 
)

select * from theShopLevel1