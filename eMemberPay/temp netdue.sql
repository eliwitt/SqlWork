SQL_ADVANTAGE11.1�;DECLARE @lnRetCd int
DECLARE @lnBLEI_CK int
DECLARE @lxGRGR_ID char(008)
DECLARE @lxSBSB_LAST_NAME char(035)
DECLARE @lxMEPE_ELIG_IND char(001)
DECLARE @lnRowCount int
declare @pSBSB_ID char(009)
declare @NetDue int
set @pSBSB_ID = '902232199'

select subdue.netdue, subelg.eligable
from
(SELECT BLEI.BLEI_NET_DUE as netdue
FROM CMC_SBSB_SUBSC SBSB, CMC_BLEI_ENTY_INFO BLEI
WHERE BLEI.BLEI_BILL_LEVEL_CK = SBSB.SBSB_CK 
		and BLEI.BLEI_BILL_LEVEL = 'I'
and SBSB.SBSB_ID = @pSBSB_ID) subdue,


/* SELECT @lnRowCount = count(*) */
(select count(*) as eligable
FROM 
           dbo.CMC_GRGR_GROUP A,
           dbo.CMC_SBSB_SUBSC B,
           dbo.CMC_MEME_MEMBER C,
           dbo.CMC_MEPE_PRCS_ELIG D
WHERE
	     A.GRGR_CK = B.GRGR_CK
   AND     B.GRGR_CK = C.GRGR_CK
   AND     B.SBSB_CK = C.SBSB_CK
   AND     C.MEME_CK = D.MEME_CK
   AND     C.GRGR_CK = D.GRGR_CK
   AND     C.MEME_REL = 'M'
   AND     D.MEPE_ELIG_IND = 'Y'
   AND     D.MEPE_EFF_DT <= getdate()
   AND     D.MEPE_TERM_DT > getdate()
   AND     B.SBSB_ID = @pSBSB_ID) subelg
$(1 row affected)
(1 row affected)
                            <   <              �                �                         ����            �                           "    GOSYBASEj13155w	LAP044877,System   ��  ��