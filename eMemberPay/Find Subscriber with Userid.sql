SQL_ADVANTAGE11.1�^set ROWCOUNT  50
select * from ER_TB_SYST_EXPM_XPERMISSIONS where EXPM_DATA_ID='MEME_CK'  

select SBSB_ID from CMC_SBSB_SUBSC where SBSB_CK=(
select mm.SBSB_CK from ER_TB_SYST_EXPM_XPERMISSIONS xpm, CMC_MEME_MEMBER mm where xpm.EXTU_ID='3869971' 
and xpm.EXPM_DATA_ID='MEME_CK' 
and convert(int,xpm.EXPM_DATA)=mm.MEME_CK group by mm.SBSB_CK)
(0 rows affected)
                            <   <              �                �                         ����            �                           "    GOSYBASEj13155w	LAP044877,System   ��