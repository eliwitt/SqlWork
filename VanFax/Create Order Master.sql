CREATE TABLE [Order_Master] (
	[Order_Number] [int] IDENTITY (1, 1) NOT NULL ,
	[PO_Number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Order_Total] [smallmoney] NULL CONSTRAINT [DF_Order_Master_Order_Total] DEFAULT (0),
	[Order_Items] [int] NULL CONSTRAINT [DF_Order_Master_Order_Items] DEFAULT (0),
	[Order_Date] [smalldatetime] NULL ,
	[OrderedBy] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Status] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Order_Master_Status] DEFAULT ('O'),
	[Notes] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


