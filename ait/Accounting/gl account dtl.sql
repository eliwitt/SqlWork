select Act.id, Act.AccountNumber, Act.[Desc]account, co.[Desc] company, TrnDtl.id, TrnDtl.DebitCredit, AccTrn.Amount,
	comptrn.id, CompTrn.AccountingDate
from GL_Account Act
	left outer join GL_TranDetail TrnDtl on Act.ID = TrnDtl.AccountPtr
	left outer join GL_Company Co on TrnDtl.CompanyPtr = Co.id
	left outer join GL_AccountingTrans AccTrn on TrnDtl.id = AccTrn.TranDetailPTR
	left outer join CompleteTransaction CompTrn on AccTrn.CompletedTransactionPTR = CompTrn.id
where comptrn.accountingdate > '7/1/2009' and comptrn.accountingdate < '7/31/2009'
order by act.id, TrnDtl.id, comptrn.id