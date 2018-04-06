select a0a4nb, a0aqnb, a0a2dt, a0a3dt, a0a4st 
from VT2662AFVP.mfmoop where a0a4nb = 572655 order by a0aqnb;
--  ayavst = 10  aya2dt = 0 aybpnb = 0 aybkcd = ''  aybrnb = 0 
select * from vt2662afvp.mfmohr where aya4nb = 572655
union
select * from vt2662afvp.mfmohr where ayavst < 20;

-- adjust the reported operstions
--
update VT2662AFVP.mfmooy set a4a1qt = .75, a4a2qt = .38, a4bqqt = 1 where (A4A4NB = 600170 and a4aqnb = 20) 

--
--
update VT2662AFVP.mfmoop set a0bjpr = 21.84, a0bmqt = .75, a0boqt = .38, a0bqqt = 1 where (a0a4nb = 600170 and a0aqnb = 20) 