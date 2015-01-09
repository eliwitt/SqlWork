CREATE TABLE [dbo].[ScannedDocuments](
      [ImageID] [int] IDENTITY(1,1) NOT NULL,
      [EmployeePTR] [int] NOT NULL CONSTRAINT [DF_docpics_EmployeePTR]  DEFAULT ((0)),
      [OfficePTR] [int] NOT NULL CONSTRAINT [DF_docpics_OfficePTR]  DEFAULT ((0)),
      [ImageType] [smallint] NOT NULL CONSTRAINT [DF_docpics_ImageType]  DEFAULT ((0)),
      [ImageBarData] [varchar](11) NOT NULL,
      [ImagePic] [image] NOT NULL,
      [DateStamp] [datetime] NOT NULL CONSTRAINT [DF_docpics_DateStamp]  DEFAULT (getdate()),
      [DocType] [smallint] NOT NULL, /* 1 = AP, 2=DEC, 4=FC, 6=UM */
      [PolicyPTR] [int] NOT NULL,
	[DocDescription] [varchar] (50) not null
 CONSTRAINT [PK_ScannedDocuments] PRIMARY KEY CLUSTERED 
(
      [ImageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

