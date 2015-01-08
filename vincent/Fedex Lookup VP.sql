--
--  look at the header and detail info
--
select thcstrcn, thz3pstc, thorno, thstat, thline, thz3shpr, evcstrcn, evz3pstc, evz3pstd
	from VT2662AFVP.s10a3a30.VT2662AFVP.Z3OPTRH
	left join VT2662AFVP.s10a3a30.VT2662AFVP.Z3OPTRD on thcstrcn = evcstrcn
where THORNO = 10117072;