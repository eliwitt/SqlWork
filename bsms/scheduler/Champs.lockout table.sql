/****** Object:  Table [Scheduler].[Lockout]    Script Date: 07/22/2013 08:43:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Scheduler].[Lockout](
	[schLockID] [int] IDENTITY(1,1) NOT NULL,
	[schLockPlant] [int] NOT NULL,
	[schLockName] [nvarchar](50) NOT NULL,
	[schLockCode] [nvarchar](50) NULL,
	[schLockComment] [nvarchar](255) NULL,
	[schLockDate] [date] NULL,
 CONSTRAINT [PK_Lockout] PRIMARY KEY CLUSTERED 
(
	[schLockID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [Scheduler].[Lockout] ADD  CONSTRAINT [DF_Lockout_schLockPlant]  DEFAULT ((0)) FOR [schLockPlant]
GO

