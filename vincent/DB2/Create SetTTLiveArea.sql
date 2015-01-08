 CREATE PROCEDURE vt2662ap.SetTTLiveArea
      (IN ORNO DECIMAL(12,0),
      IN ORLINE DECIMAL(5,0),
      in WIDTH CHAR(2),
     in HEIGHT CHAR(2))
      LANGUAGE SQL MODIFIES SQL DATA
BEGIN
/*  set the width of the area  */
update vt2662aftt.z3dr503a set TTFORV = WIDTH where TTORNO = ORNO and TTLINE = ORLINE and TTYTCD = 'TR15';
/* set the height of the area */
update vt2662aftt.z3dr503a set TTFORV = HEIGHT where TTORNO = ORNO and TTLINE = ORLINE and TTYTCD = 'TR25';
END