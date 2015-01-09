--
-- for the Feb deployment
--
USE [BSMS]
GO

/****** Object:  Table [wACom].[T1Errors]    Script Date: 01/14/2013 14:37:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--
-- the Error code tables follow
--
CREATE TABLE [wACom].[T1Errors](
	[t1plant] [int] NOT NULL,
	[t1id] [int] IDENTITY(1,1) NOT NULL,
	[t1desc] [nvarchar](255) NOT NULL,
	[t1active] [smallint] NOT NULL,
 CONSTRAINT [PK_T1Errors] PRIMARY KEY CLUSTERED 
(
	[t1id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [wACom].[T1Errors] ADD  CONSTRAINT [DF_T1Errors_t1active]  DEFAULT ((0)) FOR [t1active]
GO


/****** Object:  Table [wACom].[T2Errors]    Script Date: 01/14/2013 14:37:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [wACom].[T2Errors](
	[t1id] [int] NOT NULL,
	[t2id] [int] IDENTITY(1,1) NOT NULL,
	[t2desc] [nvarchar](255) NOT NULL,
	[t2active] [smallint] NOT NULL,
 CONSTRAINT [PK_T2Errors] PRIMARY KEY CLUSTERED 
(
	[t2id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [wACom].[T2Errors] ADD  CONSTRAINT [DF_T2Errors_t2active]  DEFAULT ((0)) FOR [t2active]
GO


/****** Object:  Table [wACom].[T3Errors]    Script Date: 01/14/2013 14:38:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [wACom].[T3Errors](
	[t2id] [int] NOT NULL,
	[t3id] [int] IDENTITY(1,1) NOT NULL,
	[t3desc] [nvarchar](255) NOT NULL,
	[t3active] [smallint] NOT NULL,
 CONSTRAINT [PK_T3Errors] PRIMARY KEY CLUSTERED 
(
	[t3id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [wACom].[T3Errors] ADD  CONSTRAINT [DF_T3Errors_t3active]  DEFAULT ((0)) FOR [t3active]
GO


/****** Object:  Table [WO].[workorderpriority]    Script Date: 01/14/2013 14:39:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [WO].[workorderpriority](
	[wopID] [int] IDENTITY(1,1) NOT NULL,
	[wopDesc] [varchar](255) NULL,
	[wopActive] [smallint] NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [WO].[workorderpriority] ADD  CONSTRAINT [DF_workorderpriority_wopActive]  DEFAULT ((0)) FOR [wopActive]
GO

