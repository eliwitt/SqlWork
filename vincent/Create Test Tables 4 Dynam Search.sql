CREATE TABLE [train].[Customers]
    (
      CustID VARCHAR(20) NOT NULL
    , Customer_Name NVARCHAR(100) NOT NULL
    , Customer_Type CHAR(1) NOT NULL
                            CHECK ( Customer_Type IN ( 'A', 'R' ) )
    , PRIMARY KEY CLUSTERED ( CustID )
    );

CREATE TABLE [train].[Shipments]
    (
      Consignment_No VARCHAR(30) NOT NULL
    , ReferenceNo VARCHAR(30) NULL
    , CustID VARCHAR(20) NULL
                         FOREIGN KEY REFERENCES [train].[Customers] ( CustID )
    , Total_Pkgs INT NOT NULL
    , Last_Status VARCHAR(12) NULL
    , Last_Status_DT DATETIME NULL
    , PRIMARY KEY CLUSTERED ( Consignment_No )
    );

CREATE TABLE [train].[Shipment_History]
    (
      Consignment_No VARCHAR(30)
        NOT NULL
        FOREIGN KEY REFERENCES [train].[Shipments] ( Consignment_No )
    , Status_DT DATETIME NOT NULL
    , Status_Code VARCHAR(12) NOT NULL
    , Pkg_No INT NOT NULL
                 DEFAULT ( 0 )
    , PRIMARY KEY CLUSTERED ( Consignment_No, Status_Code, Status_DT, Pkg_No )
    ); 
GO