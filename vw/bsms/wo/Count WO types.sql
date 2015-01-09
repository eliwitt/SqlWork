--
-- count the different wo types in the table
--
select '0' distype, 'Null', COUNT(*) from wo.WorkOrderMain where DISType is null 
union
select distype, (SELECT WOCName FROM [WO].[WorkOrderCodes] where WOCID = DISType),
	COUNT(distype) [COUNT] 
	from wo.WorkOrderMain group by distype order by distype
select COUNT(*) from wo.WorkOrderMain