USE [ClaimsSchema_0616]
GO
/****** Object:  Table [dbo].[clm_sysvalues]    Script Date: 09/02/2010 10:39:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clm_sysvalues](
	[id] [int] NOT NULL,
	[key] [nchar](10) NULL,
	[value] [nvarchar](50) NULL
) ON [PRIMARY]
