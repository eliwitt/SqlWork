select e_name, e_ina01, 
itmv02_e_name, i.itmv02_value
from chachaedmn1.chaedmn.dbo.element he
	inner join chachaedmn1.chaedmn.dbo.item_mv_custom02 i  
		on he.e_name = i.itmv02_e_name 
where he.e_ina01 like 'HOLDER,%' aND 
left(i.itmv02_value,3) = 'tva'

select itmv02_e_name, i.itmv02_value, e_ina15, e_name, e_ina01
from chachaedmn1.chaedmn.dbo.item_mv_custom02 i,
	chachaedmn1.chaedmn.dbo.element de
where de.e_ina01 in ('ENGINEERING DOCUMENTS,NUCLEAR','ENVIRONMENTAL QUALIFICATION BINDERS,NUCLEAR',
'FINAL SAFETY ANALYSIS REVIEW','PLANT SCALING/SETPOINT DOCUMENTS,NUCLEAR',
'PROCEDURES,NUCLEAR','RELAY SETTING SHEETS,NUCLEAR','TECHNICAL REQUIREMENT MANUAL',
'TECHNICAL SPECIFICATIONS','GENERAL SPECIFICATION,NUCLEAR','FORMS,NUCLEAR',
'ISPM,NUCLEAR','BECHTEL PROCEDURE, NUCLEAR','CLEANUP,NUCLEAR')