CREATE PROCEDURE [train].[Shipment_Tracking]
    (
      @StartDT DATETIME = NULL
    , @EndDT DATETIME = NULL
    , @Consignment_No VARCHAR(30) = NULL
    , @ReferenceNo VARCHAR(30) = NULL
    , @CustID VARCHAR(20) = NULL
    , @Customer_Type CHAR(1) = NULL
    , @Status_Code VARCHAR(12) = NULL
    , @StatusType TINYINT = NULL    
-- 0=NA, 1=Last in history, 2=In history
    , @MissingStatus VARCHAR(12) = NULL
    , @debug TINYINT = 0       
-- 1=Display debug results
)
AS
    BEGIN
        SET NOCOUNT ON;         
-- Truncate time component from start date     
        DECLARE @StartDate DATETIME = DATEADD(day, 0,
                                              DATEDIFF(day, 0, @StartDT))         
-- Truncate time component from end date and add 1         
          , @EndDate DATETIME = DATEADD(day, 1, DATEDIFF(day, 0, @EndDT))
          , @SQL NVARCHAR(MAX)
          , @SQLParms NVARCHAR(MAX) = N'             @StartDT           DATETIME             ,@EndDT            DATETIME             ,@Consignment_No   VARCHAR(30)             ,@ReferenceNo      VARCHAR(30)             ,@CustID           VARCHAR(20)             ,@Customer_Type    CHAR(1)             ,@Status_Code      VARCHAR(12)             ,@MissingStatus    VARCHAR(12)';         -- If @EndDate is NULL, then use @StartDT + 1        SELECT @EndDate        = ISNULL(@EndDate, DATEADD(day, 1, DATEDIFF(day, 0, @StartDT)))         ,@Consignment_No   = NULLIF(@Consignment_No, '')         ,@ReferenceNo      = NULLIF(@ReferenceNo, '')         ,@CustID           = NULLIF(@CustID, '')         ,@Customer_Type    = NULLIF(@Customer_Type, '')         ,@Status_Code      = NULLIF(@Status_Code, '')         ,@MissingStatus    = NULLIF(@MissingStatus, '')         ,@debug            = CASE WHEN @debug IS NULL THEN 0                                 WHEN @debug IN (0,1) THEN @debug                                 ELSE 0 END         -- If @StatusType NOT IN (1, 2) then @Status_Code will be ignored         ,@StatusType       = CASE WHEN NULLIF(@Status_Code, '') IS NULL THEN 0                                 WHEN @StatusType IN (0, 1, 2) THEN @StatusType                                 ELSE 0 END;
        IF @debug = 1
            BEGIN
                PRINT CONVERT(VARCHAR(20), @StartDate, 120);
                    PRINT CONVERT(VARCHAR(20), @EndDate, 120);
                END
        SELECT @SQL = N'         SELECT a.Consignment_No, a.ReferenceNo, a.CustID, a.Total_Pkgs             ,a.Last_Status, a.Last_Status_DT         FROM [train].Shipments a'
                + CHAR(10)
                + CASE WHEN @Customer_Type IS NOT NULL
                       THEN '        INNER JOIN [train].Customers b ON a.CustID = b.CustID'
                            + CHAR(10)
                       ELSE ''
                  END + '        WHERE 1=1' + CHAR(10)
                + CASE WHEN @StartDate IS NOT NULL
                       THEN '            AND a.Last_Status_DT >= @StartDT '
                            + CHAR(10)
                            + '            AND a.Last_Status_DT < @EndDT '
                            + CHAR(10)
                       ELSE ''
                  END
                + CASE WHEN @Consignment_No IS NOT NULL
                       THEN '            AND a.Consignment_No = @Consignment_No '
                            + CHAR(10)
                       ELSE ''
                  END
                + CASE WHEN @ReferenceNo IS NOT NULL
                       THEN '            AND a.ReferenceNo LIKE ''%'' + @ReferenceNo + ''%'''
                            + CHAR(10)
                       ELSE ''
                  END
                + CASE WHEN @CustID IS NOT NULL
                       THEN '            AND a.CustID = @CustID ' + CHAR(10)
                       ELSE ''
                  END
                + CASE WHEN @StatusType = 1
                            AND @Status_Code IS NOT NULL
                       THEN '            AND a.Last_Status = @Status_Code '
                            + CHAR(10)
                       ELSE ''
                  END
                + CASE WHEN @Customer_Type IS NOT NULL
                       THEN '            AND b.Customer_Type = @Customer_Type'
                            + CHAR(10)
                       ELSE ''
                  END
                + CASE WHEN @StatusType = 2
                            AND @Status_Code IS NOT NULL
                       THEN '            AND EXISTS ' + CHAR(10)
                            + '            (' + CHAR(10)
                            + '                SELECT 1' + CHAR(10)
                            + '                FROM [train].Shipment_History b'
                            + CHAR(10)
                            + '                WHERE a.consignment_no = b.consignment_no AND'
                            + CHAR(10)
                            + '                    b.status_code = @Status_Code'
                            + CHAR(10) + '            )' + CHAR(10)
                       ELSE ''
                  END
                + CASE WHEN @MissingStatus IS NOT NULL
                       THEN '            AND NOT EXISTS ' + CHAR(10)
                            + '            (' + CHAR(10)
                            + '                SELECT 1' + CHAR(10)
                            + '                FROM [train].Shipment_History b'
                            + CHAR(10)
                            + '                WHERE a.consignment_no = b.consignment_no AND'
                            + CHAR(10)
                            + '                    b.status_code = @MissingStatus'
                            + CHAR(10) + '            )' + CHAR(10)
                       ELSE ''
                  END;
        IF @debug = 1
            SELECT [LineNo] = RIGHT(10000 + ItemNumber, 4)
                  , [SQL] = Item
                FROM dbo.DelimitedSplit8K(@SQL, CHAR(10));
        EXEC sp_executesql @SQL, @SQLParms, @StartDT = @StartDate,
            @EndDT = @EndDate, @Consignment_No = @Consignment_No,
            @ReferenceNo = @ReferenceNo, @CustID = @CustID,
            @Customer_Type = @Customer_Type, @Status_Code = @Status_Code,
            @MissingStatus = @MissingStatus;         
    END