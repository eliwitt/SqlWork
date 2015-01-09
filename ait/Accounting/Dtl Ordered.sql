select TrnDtl.id, AccTrn.Amount, comptrn.policyptr, 
	CompTrn.AccountingDate, CompTrn.InsertedOn 
from GL_TranDetail TrnDtl
	left outer join GL_AccountingTrans AccTrn on TrnDtl.id = AccTrn.TranDetailPTR
	left outer join CompleteTransaction CompTrn on AccTrn.CompletedTransactionPTR = CompTrn.id
where comptrn.InsertedOn > '7/1/2009' and comptrn.InsertedOn < '7/31/2009'
and trndtl.id = 10
order by CompTrn.AccountingDate