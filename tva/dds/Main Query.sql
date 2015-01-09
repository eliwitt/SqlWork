--
-- the following is a series of DDS scripts that attempt to produce 
-- the Cancelled Documents with Distribution report
--
select de.e_icon_title, dv.v_ina37, dv.v_ina31, de.e_ina09, 
	de.e_ina49, i.itmv02_value, 
	de.e_ina07, de.e_ina08, de.e_ina26, dv.v_ina05 
from chachaedmn1.chaedmn.dbo.element he  
	inner join chachaedmn1.chaedmn.dbo.item_mv_custom02 i  
		on he.e_name = i.itmv02_e_name 
	inner join chachaedmn1.chaedmn.dbo.element de 
		on de.e_ina15 = left(i.itmv02_value, 29) 
	inner join chachaedmn1.chaedmn.dbo.version dv 
		on de.e_name = dv.v_e_name and de.e_curver_num = dv.v_name 
where he.e_ina01 like 'HOLDER,%' AND 
(de.e_ina01 in ('ENGINEERING DOCUMENTS,NUCLEAR','ENVIRONMENTAL QUALIFICATION BINDERS,NUCLEAR',
'FINAL SAFETY ANALYSIS REVIEW','PLANT SCALING/SETPOINT DOCUMENTS,NUCLEAR',
'PROCEDURES,NUCLEAR','RELAY SETTING SHEETS,NUCLEAR','TECHNICAL REQUIREMENT MANUAL',
'TECHNICAL SPECIFICATIONS','GENERAL SPECIFICATION,NUCLEAR','FORMS,NUCLEAR',
'ISPM,NUCLEAR','BECHTEL PROCEDURE, NUCLEAR','CLEANUP,NUCLEAR') 
OR 
(de.e_ina52 = 'DRAWING' AND de.e_ina27 = 'Y')) AND 
left(i.itmv02_value,3) = 'tva' and 
v_ina05 = 'CANCELED' 
UNION 
select de.e_icon_title, dv.v_ina37, dv.v_ina31, de.e_ina09, 
	de.e_ina49, i.itmv02_value, 
	de.e_ina07, de.e_ina08, de.e_ina26, dv.v_ina05 
from chachaedmn1.chaedmn.dbo.element he 
	inner join chachaedmn1.chaedmn.dbo.item_mv_custom02 i 
		on he.e_name = i.itmv02_e_name 
	inner join chachaedmn1.chaedmn.dbo.element de 
		on de.e_name = substring(i.itmv02_value,21,9) 
	inner join chachaedmn1.chaedmn.dbo.version dv 
		on de.e_name = dv.v_e_name and de.e_curver_num = dv.v_name 
where he.e_ina01 like 'HOLDER,%' AND 
(de.e_ina01 in ('ENGINEERING DOCUMENTS,NUCLEAR','ENVIRONMENTAL QUALIFICATION BINDERS,NUCLEAR',
'FINAL SAFETY ANALYSIS REVIEW','PLANT SCALING/SETPOINT DOCUMENTS,NUCLEAR',
'PROCEDURES,NUCLEAR','RELAY SETTING SHEETS,NUCLEAR','TECHNICAL REQUIREMENT MANUAL',
'TECHNICAL SPECIFICATIONS','GENERAL SPECIFICATION,NUCLEAR','FORMS,NUCLEAR',
'ISPM,NUCLEAR','BECHTEL PROCEDURE, NUCLEAR','CLEANUP,NUCLEAR') 
OR 
(de.e_ina52 = 'DRAWING' AND de.e_ina27 = 'Y')) AND 
left(i.itmv02_value,3) <> 'tva' and 
v_ina05 = 'CANCELED' 
order by de.e_ina49, de.e_ina07, de.e_icon_title
