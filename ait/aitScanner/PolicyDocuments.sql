USE [myTempDB]
GO
/****** Object:  Table [dbo].[PolicyDocuments]    Script Date: 12/08/2009 11:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PolicyDocuments](
	[PolicyPTR] [int] NULL,
	[PolicyHistoryPTR] [int] NULL,
	[DocTypeID] [tinyint] NULL,
	[DocLocationID] [tinyint] NULL,
	[DateStamp] [datetime] NULL,
	[DocFileName] [varchar](64) NULL,
	[DocStatusID] [tinyint] NULL,
	[DatedSubFolder] [tinyint] NULL,
	[ScannedBack] [tinyint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF