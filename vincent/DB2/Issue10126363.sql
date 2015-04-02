select * from vt2662afvp.sropix where pxplno = 2161602;
select olorno, olline, olordt,olprdc, olords, aya4nb, olplno, olplli
	from vt2662afvp.sroorspl Oline
	left join vt2662afvp.mfmohr MFG on Oline.olorno = MFG.aybmnb and Oline.olline = MFG.aywdnb
where olorno = 10126363;