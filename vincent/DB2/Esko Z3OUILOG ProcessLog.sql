--
--  the Log file for Order Tracking UI system
--
-- RPG PGM  codes
-- Z3DC020    AU, PP, PA
-- Z3DC026    OS, OC
--
select zlog.*, sline.olordt, sline.olprdc from vt2662afvp.z3ouilog zlog 
	left join vt2662afvp.sroorspl sline on zlog. ulorno = sline.olorno and zlog.ulline = sline.olline
where ulorno = 10211301
