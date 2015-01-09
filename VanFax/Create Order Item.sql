CREATE TABLE [Order_Item] (
	[Order_Number] [int] NOT NULL ,
	[ProdRef] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ProdDesc] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Waretype] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Storetype] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ItemQty] [int] NULL CONSTRAINT [DF_Order_Item_ItemQty] DEFAULT (0),
	[ItemPrice] [smallmoney] NULL CONSTRAINT [DF_Order_Item_ItemPrice] DEFAULT (0),
	[Status] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_Order_Item_Status] DEFAULT ('O')
) ON [PRIMARY]
GO


