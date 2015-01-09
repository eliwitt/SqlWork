select prodid, prodref as theirs, li.lineitemid, li.openingid, li.mfg_part as ours from belron_products,
	 BelronEDG.dbo.edg_tbl_invoice_lineitem li
	where left(li.mfg_part,10) = LTRIM(prodref)