-- Query for consignments with MDE that have not been weighed
SELECT a.Consignment_No, a.ReferenceNo, a.CustID, a.Total_Pkgs
    ,a.Last_Status, a.Last_Status_DT
FROM [train].Shipments a
WHERE EXISTS
    (
        SELECT 1
        FROM [train].Shipment_History b
        WHERE a.consignment_no = b.consignment_no AND b.status_code = 'MDE'
    )
    AND NOT EXISTS
    (
        SELECT 1
        FROM [train].Shipment_History b
        WHERE a.consignment_no = b.consignment_no AND b.status_code = 'WGT'
    );
   
EXEC [train].Shipment_Tracking
    @StatusType = 2
    ,@Status_Code = 'MDE'
    ,@MissingStatus = 'WGT'
    ,@debug = 1;