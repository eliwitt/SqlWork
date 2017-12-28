CREATE or replace PROCEDURE STEVEWORK.TESTOUTPARAM ( 
	IN MONU DECIMAL(12, 0) , 
	OUT O_PARAM VARCHAR(200) ) 
	LANGUAGE SQL 
BEGIN 
/*  call testoutparam(690272, ?)  */ 
/*  variables    */ 
  
CASE 
	WHEN MONU = 10 THEN 
		SET O_PARAM = MONU || ' this was handled.';
	ELSE 
		SET O_PARAM = MONU || ' this was not handled.';
END CASE ; 

/* fini */ 
END; 