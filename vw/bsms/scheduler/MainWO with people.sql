--
--  scheduler wo's
		SELECT * FROM wAppWorkOrder.wAppWorkOrderMain
		WHERE MLPlantID = 1 and DISRequestor = 56 
			--AND DISOpenDate BETWEEN DateAdd(Day,-@Days,GetDate()) AND GetDate() or (DISCloseDate IS NULL) -- AND DISCloseDate Is  Null
			AND DISCloseDate IS NULL -- AND DISCloseDate Is  Null

exec [wAppWorkOrder].[WOMainFetch] 1, 0