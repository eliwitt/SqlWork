CREATE or replace PROCEDURE STEVEWORK.CHKHDRCNT ( 
	IN MONU DECIMAL(12, 0) , 
	OUT O_PARAM VARCHAR(200) ) 
	LANGUAGE SQL 
BEGIN 
/*  call chkhdrcnt(690272, ?)  */ 
/*  variables    */ 
DECLARE V_MO DECIMAL ( 12 , 0 ) DEFAULT 0 ; 
DECLARE V_oper DECIMAL ( 4 , 0 ) DEFAULT 0 ; 
DECLARE V_DEC DECIMAL ( 3 , 0 ) DEFAULT 0 ; 
DECLARE V_CHECK DECIMAL ( 3 , 0 ) DEFAULT 0 ; 
DECLARE V_INT INT DEFAULT 0 ; 
/* declare handlers  */ 
DECLARE EXIT HANDLER FOR NOT FOUND 
BEGIN 
	SET O_PARAM = 'Record not found' ; 
	RETURN - 1 ; 
END ; 
  
/* initialize  */ 
SET V_MO = MONU ; 
  
/* body of the procedure will check the count against what operation was passed 
    in and correct the count if needed  */ 
SELECT AYBRNB INTO V_DEC FROM VT2662AFVP.MFMOHR WHERE AYA4NB = V_MO ; 
SELECT AYBPNB INTO V_oper FROM VT2662AFVP.MFMOHR WHERE AYA4NB = V_MO ; 
  
CASE 
	WHEN V_oper = 10 AND V_DEC < 1 THEN 
		SET V_INT = 1 ; 
	WHEN V_oper = 15 AND V_DEC < 2 THEN 
		SET V_INT = 1 ; 
	WHEN V_oper = 18 AND V_DEC < 3 THEN 
		SET V_INT = 1 ; 
	WHEN V_oper = 20 AND V_DEC < 4 THEN 
		SET V_INT = 1 ; 
	WHEN V_oper = 30 AND V_DEC < 5 THEN 
		SET V_INT = 1 ; 
	ELSE 
		SET V_INT = 0 ; 
END CASE ; 
IF ( V_INT = 1 ) THEN 
	UPDATE VT2662AFVP.MFMOHR SET AYBRNB = AYBRNB + 1 WHERE AYA4NB = V_MO ; 
END IF ; 
  
/* check if the procedure changed the count  */ 
SELECT AYBRNB INTO V_CHECK FROM VT2662AFVP.MFMOHR WHERE AYA4NB = V_MO ; 
SET O_PARAM = V_MO || ' header count was ok.' ; 
IF ( V_CHECK <> V_DEC ) THEN 
	SET O_PARAM = V_MO || ' header count was adjusted from ' || V_DEC || ' to ' || V_CHECK || ' for ' || V_oper ; 
END IF ; 
  
/* fini */ 
END; 