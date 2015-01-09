select Act.id, Act.AccountNumber, Act.[Desc], co.[Desc] company, TrnDtl.id, TrnDtl.DebitCredit, 
	AccTrn.Amount, comptrn.id, CompTrn.AccountingDate, totcnt.total
from GL_Account Act
	left outer join GL_TranDetail TrnDtl on Act.ID = TrnDtl.AccountPtr
	left outer join GL_Company Co on TrnDtl.CompanyPtr = Co.id
	left outer join GL_AccountingTrans AccTrn on TrnDtl.id = AccTrn.TranDetailPTR
	left outer join CompleteTransaction CompTrn on AccTrn.CompletedTransactionPTR = CompTrn.id
	join (
		select tAct.id as Actid, totDtl.id as dtlid, sum(tAccTrn.Amount) total
		from GL_Account tAct
			left outer join GL_TranDetail totDtl on tAct.ID = totDtl.AccountPtr
			left outer join GL_AccountingTrans tAccTrn on totDtl.id = tAccTrn.TranDetailPTR
			left outer join CompleteTransaction tCompTrn on tAccTrn.CompletedTransactionPTR = tCompTrn.id
		where tcomptrn.accountingdate > '7/1/2009' and tcomptrn.accountingdate < '7/31/2009'
		group by tAct.id, totDtl.id
	) totCnt on totCnt.Actid = Act.id and totcnt.dtlid = TrnDtl.id
where comptrn.accountingdate > '7/1/2009' and comptrn.accountingdate < '7/31/2009'
order by Act.id, TrnDtl.id, comptrn.id