select Act.id as Actid, TrnDtl.id as trnid, sum(AccTrn.Amount) total, 
Act.AccountNumber, Act.[Desc],
co.[Desc] company, TrnDtl.DebitCredit
		from GL_Account Act
			left outer join GL_TranDetail TrnDtl on Act.ID = trnDtl.AccountPtr
			left outer join GL_Company Co on TrnDtl.CompanyPtr = Co.id
			left outer join GL_AccountingTrans AccTrn on trnDtl.id = AccTrn.TranDetailPTR
			left outer join CompleteTransaction CompTrn on AccTrn.CompletedTransactionPTR = CompTrn.id
		where comptrn.InsertedOn > '7/1/2009' and comptrn.InsertedOn < '7/31/2009'
		group by Act.id, TrnDtl.id, Act.AccountNumber, Act.[Desc], co.[Desc], TrnDtl.DebitCredit