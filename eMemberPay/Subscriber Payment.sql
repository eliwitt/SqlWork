select distinct BILL.BLEI_CK,
	BLEI.BLEI_NET_DUE, BILL.BLBL_BILLED_AMT, BILL.BLBL_RCVD_AMT, 
	max(BILL.BLBL_DUE_DT)
from CMC_SBSB_SUBSC SBSB
join CMC_BLEI_ENTY_INFO BLEI on BLEI.BLEI_BILL_LEVEL_CK = SBSB.SBSB_CK 
		and BLEI.BLEI_BILL_LEVEL = 'I'
join CMC_BLBL_BILL_SUMM BILL on BILL.BLEI_CK = BLEI.BLEI_CK
where SBSB_ID = '902232103'
group by BILL.BLEI_CK, BLEI.BLEI_NET_DUE, BILL.BLBL_BILLED_AMT, BILL.BLBL_RCVD_AMT