SQL_ADVANTAGE11.1��select 'INSERT INTO ER_TB_SYST_EXPM_XPERMISSIONS (EXTU_ID,EXPM_DATA_ID,EXPM_DATA) VALUES(''m' + 
	convert(nvarchar,sbsb.SBSB_ID) + ''',''MEME_CK'',''' + convert(nvarchar,meme.MEME_CK) + ''')'
from CMC_SBSB_SUBSC sbsb
left join CMC_MEME_MEMBER meme on sbsb.SBSB_CK = meme.SBSB_CK
where sbsb.SBSB_ID in ('903563995','903521163','903239785',
		'902988591','902730565','902231648','902233536',
		'902233431','902353038','902232620')
(24 rows affected)
                            <   <              �                �                         ����            �                           "    GOSYBASEj13155w	LAP044877,System   ��