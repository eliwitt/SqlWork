USE [myTempDB]
GO
/****** Object:  Table [dbo].[docpics]    Script Date: 12/08/2009 11:17:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[docpics](
	[imageID] [int] IDENTITY(1,1) NOT NULL,
	[imageDocID] [nchar](11) NOT NULL,
	[imagePic] [image] NOT NULL,
	[DateStamp] [datetime] NOT NULL CONSTRAINT [DF_docpics_DateStamp]  DEFAULT (getdate()),
 CONSTRAINT [PK_docpics] PRIMARY KEY CLUSTERED 
(
	[imageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
