SELECT OHORNO, olline, ohdelt as "Dispatch Date", oldelt as "Disp date", oldlvd as "Del date", 
olpddt as "Promised dat", olrdvd as "Requested Del"
FROM VT2662AFtt.SROORSHE sheader
	left join VT2662AFtt.SROORSPL sline on sheader.ohorno = sline.olorno
 WHERE ohorno = 10058468;

--update VT2662AFtt.SROORSPL set olrdvd = 20150621 where olorno = 10058468 and olline =20;