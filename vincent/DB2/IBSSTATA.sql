--  Generate SQL 
--  Version:                   	V7R1M0 100423 
--  Generated on:              	10/19/17 14:04:42 
--  Relational Database:       	S10A3A30 
--  Standards Option:          	DB2 for i 
CREATE VIEW VTCUSTOM.IBSSTATA ( 
--  SQL1506   30   Key or attribute for IBSSTATA in VTCUSTOM ignored. 
	AYA4NB , 
	AYAVST , 
	AYBMNB , 
	AYPRDC , 
	AYHATX , 
	AYQTY , 
	AYAZDT , 
	AYA0DT , 
	AYA3DT , 
	AYSIGN , 
	AYBKCD , 
	AYBPNB , 
	AYBRNB , 
	AYE1CE , 
	AYEDQT , 
	AYABTS , 
	A0A3CD , 
	A0A4NB , 
	A0AQNB , 
	A0A4ST , 
	A0UZCD , 
	A0BQQT , 
	A0ABTS , 
	A0A3DT , 
	A0AITM , 
	A0A1CD , 
	OHCOPE , 
	OHHAND , 
	OHCUNO , 
	OHDANO , 
	OHNAME , 
	OHTODC , 
	OHMOTC , 
	OHODAT , 
	OHORDT , 
	OHORDS , 
	OHORNO , 
	OLLINE , 
	OLSHPM , 
	OLMOTC , 
	OLTODC , 
	OLDELT , 
	OLDSDT , 
	OLRDDT , 
	OLHSOL , 
	OLORDS , 
	NANUM , 
	NAADR4 , 
	NASPCD , 
	NONUM , 
	NOSALE , 
	NOSHAN , 
	NAARHA , 
	OANAME , 
	OAADR1 , 
	OAADR2 , 
	OAADR3 , 
	OAADR4 , 
	OAPOCD , 
	OALINE , 
	ADNAME , 
	ADADR1 , 
	ADADR2 , 
	ADADR3 , 
	ADADR4 , 
	ADPOCD ) 
	AS 
	SELECT 
	Q02.AYA4NB , 
--  SQL150D   10   EDTCDE in column AYA4NB ignored. 
	Q02.AYAVST , 
	Q02.AYBMNB , 
--  SQL150D   10   EDTCDE in column AYBMNB ignored. 
	Q02.AYPRDC , 
	Q02.AYHATX , 
	Q02.AYQTY , 
--  SQL150D   10   EDTCDE in column AYQTY ignored. 
	Q02.AYAZDT , 
--  SQL150D   10   EDTCDE in column AYAZDT ignored. 
	Q02.AYA0DT , 
--  SQL150D   10   EDTCDE in column AYA0DT ignored. 
	Q02.AYA3DT , 
--  SQL150D   10   EDTCDE in column AYA3DT ignored. 
	Q02.AYSIGN , 
	Q02.AYBKCD , 
	Q02.AYBPNB , 
--  SQL150D   10   EDTCDE in column AYBPNB ignored. 
	Q02.AYBRNB , 
--  SQL150D   10   EDTCDE in column AYBRNB ignored. 
	Q02.AYE1CE , 
	Q02.AYEDQT , 
--  SQL150D   10   EDTCDE in column AYEDQT ignored. 
	Q02.AYABTS , 
	Q01.A0A3CD , 
	Q01.A0A4NB , 
--  SQL150D   10   EDTCDE in column A0A4NB ignored. 
	Q01.A0AQNB , 
--  SQL150D   10   EDTCDE in column A0AQNB ignored. 
	Q01.A0A4ST , 
	Q01.A0UZCD , 
	Q01.A0BQQT , 
--  SQL150D   10   EDTCDE in column A0BQQT ignored. 
	Q01.A0ABTS , 
	Q01.A0A3DT , 
--  SQL150D   10   EDTCDE in column A0A3DT ignored. 
	Q01.A0AITM , 
--  SQL150D   10   EDTWRD in column A0AITM ignored. 
	Q01.A0A1CD , 
	Q03.OHCOPE , 
	Q03.OHHAND , 
	Q03.OHCUNO , 
	Q03.OHDANO , 
--  SQL150D   10   EDTCDE in column OHDANO ignored. 
	Q03.OHNAME , 
	Q03.OHTODC , 
	Q03.OHMOTC , 
	Q03.OHODAT , 
--  SQL150D   10   EDTCDE in column OHODAT ignored. 
	Q03.OHORDT , 
	Q03.OHORDS , 
--  SQL150D   10   EDTCDE in column OHORDS ignored. 
	Q03.OHORNO , 
--  SQL150D   10   EDTCDE in column OHORNO ignored. 
	Q04.OLLINE , 
--  SQL150D   10   EDTCDE in column OLLINE ignored. 
	Q04.OLSHPM , 
	Q04.OLMOTC , 
	Q04.OLTODC , 
	Q04.OLDELT , 
--  SQL150D   10   EDTCDE in column OLDELT ignored. 
	Q04.OLDSDT , 
--  SQL150D   10   EDTCDE in column OLDSDT ignored. 
	Q04.OLRDDT , 
--  SQL150D   10   EDTCDE in column OLRDDT ignored. 
	Q04.OLHSOL , 
	Q04.OLORDS , 
--  SQL150D   10   EDTCDE in column OLORDS ignored. 
	Q05.NANUM , 
	Q05.NAADR4 , 
	Q05.NASPCD , 
	Q07.NONUM , 
	Q07.NOSALE , 
	Q07.NOSHAN , 
	Q05.NAARHA , 
	Q06.OANAME , 
	Q06.OAADR1 , 
	Q06.OAADR2 , 
	Q06.OAADR3 , 
	Q06.OAADR4 , 
	Q06.OAPOCD , 
	Q06.OALINE , 
--  SQL150D   10   EDTCDE in column OALINE ignored. 
	Q08.ADNAME , 
	Q08.ADADR1 , 
	Q08.ADADR2 , 
	Q08.ADADR3 , 
	Q08.ADADR4 , 
	Q08.ADPOCD   
	FROM VT2662AFVP.MFMOOP AS Q01 LEFT OUTER JOIN   
--  SQL150D   10   JDFTVAL in column *N ignored. 
	VT2662AFVP.MFMOHR AS Q02 ON ( Q01.A0A4NB = Q02.AYA4NB ) LEFT OUTER JOIN   
--  SQL150D   10   JDFTVAL in column *N ignored. 
	VT2662AFVP.SROORSHE AS Q03 ON ( Q02.AYBMNB = Q03.OHORNO ) LEFT OUTER JOIN   
--  SQL150D   10   JDFTVAL in column *N ignored. 
	VT2662AFVP.SROORSPL AS Q04 ON ( Q02.AYBMNB = Q04.OLORNO AND Q02.AYWDNB = Q04.OLLINE ) LEFT OUTER JOIN   
--  SQL150D   10   JDFTVAL in column *N ignored. 
	VT2662AFVP.SRONAM AS Q05 ON ( Q03.OHCUNO = Q05.NANUM ) LEFT OUTER JOIN   
--  SQL150D   10   JDFTVAL in column *N ignored. 
	VT2662AFVP.SROORSA AS Q06 ON ( Q04.OLORNO = Q06.OAORNO AND Q04.OLLINE = Q06.OALINE ) LEFT OUTER JOIN   
--  SQL150D   10   JDFTVAL in column *N ignored. 
	VT2662AFVP.SRONOI AS Q07 ON ( Q03.OHCUNO = Q07.NONUM ) LEFT OUTER JOIN   
--  SQL150D   10   JDFTVAL in column *N ignored. 
	VT2662AFVP.SRONAD AS Q08 ON ( Q04.OLCUNO = Q08.ADNUM AND Q04.OLDANO = Q08.ADADNO )   
	WHERE 
	( ( NOT Q02.AYA4NB = +0 ) OR Q02.AYA4NB IS NULL )   
	RCDFMT MFGSOH     ; 
  
LABEL ON TABLE VTCUSTOM.IBSSTATA 
	IS 'Join of Order, Mfg, BP' ; 
  
LABEL ON COLUMN VTCUSTOM.IBSSTATA 
( AYA4NB IS 'Order number' , 
	AYAVST IS 'Order               status' , 
	AYBMNB IS 'Reference customer o' , 
	AYPRDC IS 'Item' , 
	AYHATX IS 'Description' , 
	AYQTY IS 'Quantity' , 
	AYAZDT IS 'Start               date' , 
	AYA0DT IS 'Completion date.' , 
	AYA3DT IS 'Actual              completion date' , 
	AYSIGN IS 'Signature' , 
	AYBKCD IS 'Actual work center' , 
	AYBPNB IS 'Actual              operation' , 
	AYBRNB IS 'Number of finished o' , 
	AYE1CE IS 'M-order             type' , 
	AYEDQT IS 'Divergent quantity' , 
	AYABTS IS 'Timestamp' , 
	A0A3CD IS 'Work                centre' , 
	A0A4NB IS 'Order number' , 
	A0AQNB IS 'Op.no' , 
	A0A4ST IS 'Line                status' , 
	A0UZCD IS 'Tool' , 
	A0BQQT IS 'Quantity approved' , 
	A0ABTS IS 'Timestamp' , 
	A0A3DT IS 'Actual              completion date' , 
	A0AITM IS 'Actual              completion time' , 
	A0A1CD IS 'Department section' , 
	OHCOPE IS 'Customer reference' , 
	OHHAND IS 'Hand' , 
	OHCUNO IS 'Customer no' , 
	OHDANO IS 'Disp                addr                no' , 
	OHNAME IS 'Name' , 
	OHTODC IS 'T of                del' , 
	OHMOTC IS 'M of                trpt' , 
	OHODAT IS 'Ord dte' , 
	OHORDT IS 'Ord                 tpe' , 
	OHORDS IS 'Ord                 stat' , 
	OHORNO IS 'Ord no' , 
	OLLINE IS 'Ord                 line' , 
	OLSHPM IS 'Shipment marking' , 
	OLMOTC IS 'M of                trpt' , 
	OLTODC IS 'T of                del' , 
	OLDELT IS 'Disp                time' , 
	OLDSDT IS 'Despatch/           Shipped             date' , 
	OLRDDT IS 'Req                 disp                time' , 
	OLHSOL IS 'Hold                SO line             Y/N' , 
	OLORDS IS 'Ord                 stat' , 
	NANUM IS 'Cust/Supp no' , 
	NAADR4 IS 'Address 4' , 
	NASPCD IS 'State               Province            Code' , 
	NONUM IS 'Cust/Supp no' , 
	NOSALE IS 'Slsman' , 
	NOSHAN IS 'SVC                 ord                 hand' , 
	NAARHA IS 'A/R                 Main salesman/      handler' , 
	OANAME IS 'Name' , 
	OAADR1 IS 'Address 1' , 
	OAADR2 IS 'Address 2' , 
	OAADR3 IS 'Address 3' , 
	OAADR4 IS 'Address 4' , 
	OAPOCD IS 'Postal              code' , 
	OALINE IS 'Ord                 line' , 
	ADNAME IS 'Name' , 
	ADADR1 IS 'Address 1' , 
	ADADR2 IS 'Address 2' , 
	ADADR3 IS 'Address 3' , 
	ADADR4 IS 'Address 4' , 
	ADPOCD IS 'Postal              code' ) ; 
  
LABEL ON COLUMN VTCUSTOM.IBSSTATA 
( AYA4NB TEXT IS 'Manufacturing order no' , 
	AYAVST TEXT IS 'Order status' , 
	AYBMNB TEXT IS 'Reference customer order' , 
	AYPRDC TEXT IS 'Item' , 
	AYHATX TEXT IS 'Description' , 
	AYQTY TEXT IS 'Quantity' , 
	AYAZDT TEXT IS 'Start date' , 
	AYA0DT TEXT IS 'Completion date.' , 
	AYA3DT TEXT IS 'Actual completion date' , 
	AYSIGN TEXT IS 'Signature' , 
	AYBKCD TEXT IS 'Actual work center' , 
	AYBPNB TEXT IS 'Actual operation' , 
	AYBRNB TEXT IS 'Number of finished oper.' , 
	AYE1CE TEXT IS 'Manufacturing order type' , 
	AYEDQT TEXT IS 'Divergent quantity' , 
	AYABTS TEXT IS 'Timestamp' , 
	A0A3CD TEXT IS 'Work center' , 
	A0A4NB TEXT IS 'Manufacturing order no' , 
	A0AQNB TEXT IS 'Operation number' , 
	A0A4ST TEXT IS 'Line status' , 
	A0UZCD TEXT IS 'Tool' , 
	A0BQQT TEXT IS 'Quantity approved' , 
	A0ABTS TEXT IS 'Timestamp' , 
	A0A3DT TEXT IS 'Actual completion date' , 
	A0AITM TEXT IS 'Actual completion time' , 
	A0A1CD TEXT IS 'Department section' , 
	OHCOPE TEXT IS 'Customer reference' , 
	OHHAND TEXT IS 'Handler' , 
	OHCUNO TEXT IS 'Customer number' , 
	OHDANO TEXT IS 'Dispatch address number' , 
	OHNAME TEXT IS 'Name' , 
	OHTODC TEXT IS 'Terms of delivery' , 
	OHMOTC TEXT IS 'Manner of transport' , 
	OHODAT TEXT IS 'Order date' , 
	OHORDT TEXT IS 'Order type' , 
	OHORDS TEXT IS 'Order status' , 
	OHORNO TEXT IS 'Order number' , 
	OLLINE TEXT IS 'Order line number' , 
	OLSHPM TEXT IS 'Shipment marking' , 
	OLMOTC TEXT IS 'Manner of transport' , 
	OLTODC TEXT IS 'Terms of delivery' , 
	OLDELT TEXT IS 'Dispatch time' , 
	OLDSDT TEXT IS 'Despatch/Shipped date' , 
	OLRDDT TEXT IS 'Requested dispatch time' , 
	OLHSOL TEXT IS 'Hold sales order line Y/N' , 
	OLORDS TEXT IS 'Order status' , 
	NANUM TEXT IS 'Customer/Supplier number' , 
	NAADR4 TEXT IS 'Address line 4' , 
	NASPCD TEXT IS 'State/Province Code' , 
	NONUM TEXT IS 'Customer/Supplier number' , 
	NOSALE TEXT IS 'Salesman' , 
	NOSHAN TEXT IS 'Service order handler' , 
	NAARHA TEXT IS 'A/R Main Salesman/handler' , 
	OANAME TEXT IS 'Name' , 
	OAADR1 TEXT IS 'Address line 1' , 
	OAADR2 TEXT IS 'Address line 2' , 
	OAADR3 TEXT IS 'Address line 3' , 
	OAADR4 TEXT IS 'Address line 4' , 
	OAPOCD TEXT IS 'Postal code' , 
	OALINE TEXT IS 'Order line number' , 
	ADNAME TEXT IS 'Name' , 
	ADADR1 TEXT IS 'Address line 1' , 
	ADADR2 TEXT IS 'Address line 2' , 
	ADADR3 TEXT IS 'Address line 3' , 
	ADADR4 TEXT IS 'Address line 4' , 
	ADPOCD TEXT IS 'Postal code' ) ; 
  
GRANT ALTER , REFERENCES , SELECT   
ON VTCUSTOM.IBSSTATA TO PUBLIC WITH GRANT OPTION ; 
  
GRANT ALTER , REFERENCES , SELECT   
ON VTCUSTOM.IBSSTATA TO QPGMR WITH GRANT OPTION ;
