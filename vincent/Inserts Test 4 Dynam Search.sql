-- Two regular and one premium (A) type customers 
INSERT INTO [train].Customers
    VALUES  ( 'ACME', 'ACME Building Supplies', 'R' )     ,
            ( 'ATLAS', 'Atlas Engineering Inc.', 'R' )     ,
            ( 'APPLE', 'Apple Computers', 'A' );
-- 8 consignments - two for each customer and 2 that have not been 
-- manifest data entered so have not yet been assigned a customer 
-- ReferenceNo refers to a customer's internal document ID number 
INSERT INTO [train].Shipments
        ( Consignment_No, ReferenceNo, CustID, Total_Pkgs )
    VALUES  ( '8033701', 'PO 12345', 'ACME', 1 )     ,
            ( '0152037', NULL, 'ACME', 1 )     ,
            ( '4292860', NULL, 'ATLAS', 1 )     ,
            ( '0806473', 'INV 43523', 'ATLAS', 1 )     ,
            ( '6289811', NULL, 'APPLE', 1 )     ,
            ( '0642191', 'SO 1111', 'APPLE', 1 )     ,
            ( '8363496', NULL, NULL, 1 )     ,
            ( '7271931', NULL, NULL, 1 );

-- Some history records that are complete, some that are in progress 
-- and some that are complete (POD) but missing some required events 
INSERT INTO [train].Shipment_History
        ( Consignment_No, Status_Code, Status_DT, Pkg_No )
    VALUES  ( '8033701', 'SIP', '2013-10-19 22:19', 1 )     ,
            ( '8033701', 'WGT', '2013-10-20 18:47', 1 )     ,
            ( '8033701', 'MDE', '2013-10-21 10:47', 0 )     ,
            ( '8033701', 'OPS', '2013-10-21 21:43', 0 )     ,
            ( '8033701', 'POD', '2013-10-22 02:44', 0 )     ,
            ( '0152037', 'SIP', '2013-10-23 00:31', 1 )     ,
            ( '0152037', 'WGT', '2013-10-23 17:03', 1 )     ,
            ( '0152037', 'MDE', '2013-10-23 20:12', 0 )     ,
            ( '4292860', 'SIP', '2013-10-23 21:00', 1 )     ,
            ( '4292860', 'MDE', '2013-10-23 22:06', 0 )     ,
            ( '4292860', 'POD', '2013-10-24 10:54', 0 )     ,
            ( '0806473', 'SIP', '2013-10-25 04:16', 1 )     ,
            ( '0806473', 'MDE', '2013-10-25 08:49', 0 )     ,
            ( '6289811', 'SIP', '2013-10-25 14:28', 1 )     ,
            ( '6289811', 'WGT', '2013-10-26 05:35', 1 )     ,
            ( '6289811', 'OPS', '2013-10-26 20:08', 0 )     ,
            ( '6289811', 'POD', '2013-10-27 14:45', 0 )     ,
            ( '0642191', 'SIP', '2013-10-28 06:06', 1 )     ,
            ( '0642191', 'MDE', '2013-10-28 13:11', 0 )     ,
            ( '8363496', 'SIP', '2013-10-29 00:36', 1 )     ,
            ( '7271931', 'SIP', '2013-10-29 04:01', 1 )     ,
            ( '7271931', 'WGT', '2013-10-29 11:37', 1 );
SELECT * FROM [train].Shipments;