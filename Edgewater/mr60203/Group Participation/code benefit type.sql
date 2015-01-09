-- select from the code for benefit type
SELECT * from grp_groupTableValue 
WHERE	grouptabletype_key IN (select grouptabletype_key from grp_grouptabletype
where tabletype_vv = 'BENEFITTYPE'
and group_key = '{eb23735d-336c-42cb-a26e-bcefc35534cc}')
AND Obsolete_flg = 'N'
	ORDER BY value_seq