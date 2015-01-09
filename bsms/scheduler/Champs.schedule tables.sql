
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 06/05/2013 11:18:51
-- Generated from EDMX file: c:\users\dvusc5w\documents\visual studio 2010\Projects\vwChampsSchedule\vwChampsSchedule\Champs.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------
IF OBJECT_ID(N'[Scheduler].[FK_ChampsScheduleChampsSchPMGroup]', 'F') IS NOT NULL
    ALTER TABLE [Scheduler].[ChampsSchPMGroups] DROP CONSTRAINT [FK_ChampsScheduleChampsSchPMGroup];
GO
IF OBJECT_ID(N'[Scheduler].[FK_ChampsScheduleChampsSchProcGroup]', 'F') IS NOT NULL
    ALTER TABLE [Scheduler].[ChampsSchProcGroups] DROP CONSTRAINT [FK_ChampsScheduleChampsSchProcGroup];
GO
IF OBJECT_ID(N'[Scheduler].[FK_ChampsSchPMGroupTPMProcdure_ChampsSchPMGroup]', 'F') IS NOT NULL
    ALTER TABLE [Scheduler].[ChampsSchPMGrpHasPMs] DROP CONSTRAINT [FK_ChampsSchPMGroupTPMProcdure_ChampsSchPMGroup];
GO
IF OBJECT_ID(N'[Scheduler].[FK_ChampsSchPMGrpHasPMs_TPMProcdure]', 'F') IS NOT NULL
    ALTER TABLE [Scheduler].[ChampsSchPMGrpHasPMs] DROP CONSTRAINT [FK_ChampsSchPMGrpHasPMs_TPMProcdure];
GO
IF OBJECT_ID(N'[Scheduler].[FK_ChampsSchProcGrpHasProcs_ChampsSchProcGroup]', 'F') IS NOT NULL
    ALTER TABLE [Scheduler].[ChampsSchProcGrpHasProcs] DROP CONSTRAINT [FK_ChampsSchProcGrpHasProcs_ChampsSchProcGroup];
GO
IF OBJECT_ID(N'[Scheduler].[FK_ChampsSchProcGrpHasProcs_ProcNumber]', 'F') IS NOT NULL
    ALTER TABLE [Scheduler].[ChampsSchProcGrpHasProcs] DROP CONSTRAINT [FK_ChampsSchProcGrpHasProcs_ProcNumber];
GO

-- --------------------------------------------------
-- Cleanup the default constraints on the main table
-- --------------------------------------------------
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schPlant]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schPlant]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schLockType]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schLockType]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schSinceLastScheduledInd]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schSinceLastScheduledInd]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schLastScheduledFreq]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schLastScheduledFreq]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schSinceLastCompleteInd]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schSinceLastCompleteInd]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schLastCompletedFreq]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schLastCompletedFreq]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schEarlyDays]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schEarlyDays]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schAssignedTo]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schAssignedTo]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schValidMon]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schValidMon]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schValidTue]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schValidTue]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schValidWed]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schValidWed]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schValidThru]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schValidThru]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schValidFri]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schValidFri]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schValidSat]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schValidSat]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schValidSun]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schValidSun]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ChampsSchedules_schUptId]') AND type = 'D')
BEGIN
ALTER TABLE [Scheduler].[ChampsSchedules] DROP CONSTRAINT [DF_ChampsSchedules_schUptId]
END

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[Scheduler].[ChampsSchedules]', 'U') IS NOT NULL
    DROP TABLE [Scheduler].[ChampsSchedules];
GO
IF OBJECT_ID(N'[Scheduler].[ChampsSchPMGroups]', 'U') IS NOT NULL
    DROP TABLE [Scheduler].[ChampsSchPMGroups];
GO
IF OBJECT_ID(N'[Scheduler].[ChampsSchProcGroups]', 'U') IS NOT NULL
    DROP TABLE [Scheduler].[ChampsSchProcGroups];
GO
IF OBJECT_ID(N'[Scheduler].[ChampsSchProcGrpHasProcs]', 'U') IS NOT NULL
    DROP TABLE [Scheduler].[ChampsSchProcGrpHasProcs];
GO
IF OBJECT_ID(N'[Scheduler].[ChampsSchPMGrpHasPMs]', 'U') IS NOT NULL
    DROP TABLE [Scheduler].[ChampsSchPMGrpHasPMs];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'ChampsSchedules'
CREATE TABLE [Scheduler].[ChampsSchedules](
	[schKey] [int] IDENTITY(1,1) NOT NULL,
	[schName] [nvarchar](255) NOT NULL,
	[schDescription] [nvarchar](255) NULL,
	[schPlant] [int] NOT NULL,
	[schActive] [smallint] NOT NULL,
	[schShutdown] [smallint] NOT NULL,
	[schLockType] [smallint] NOT NULL,
	[schLastScheduledDT] [datetime] NULL,
	[schLastCompleteDT] [datetime] NULL,
	[schSinceLastScheduledInd] [smallint] NOT NULL,
	[schLastScheduledFreq] [int] NOT NULL,
	[schSinceLastCompleteInd] [smallint] NOT NULL,
	[schLastCompletedFreq] [int] NOT NULL,
	[schEarlyDays] [int] NOT NULL,
	[schAssignedTo] [int] NOT NULL,
	[schValidMon] [smallint] NOT NULL,
	[schValidTue] [smallint] NOT NULL,
	[schValidWed] [smallint] NOT NULL,
	[schValidThru] [smallint] NOT NULL,
	[schValidFri] [smallint] NOT NULL,
	[schValidSat] [smallint] NOT NULL,
	[schValidSun] [smallint] NOT NULL,
	[schUptId] [int] NOT NULL,
	[schUptDT] [datetime] NOT NULL,
 CONSTRAINT [PK_ChampsSchedules] PRIMARY KEY CLUSTERED 
(
	[schKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [Scheduler].[ChampsSchPMGroups](
	[schPMGrpKey] [int] IDENTITY(1,1) NOT NULL,
	[schPMName] [nvarchar](50) NULL,
	[schPMDescription] [nvarchar](255) NULL,
	[schPMUptId] [int] NOT NULL,
	[schPMUptDT] [datetime] NOT NULL,
	[ChampsSchedule_schKey] [int] NOT NULL,
 CONSTRAINT [PK_ChampsSchPMGroups] PRIMARY KEY CLUSTERED 
(
	[schPMGrpKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- Creating table 'ChampsSchPMGrpHasPMs'
CREATE TABLE [Scheduler].[ChampsSchPMGrpHasPMs](
	[ChampsSchPMGroups_schPMGrpKey] [int] NOT NULL,
	[TPMProcdures_TPMProcID] [int] NOT NULL,
 CONSTRAINT [PK_ChampsSchPMGroupTPMProcdure] PRIMARY KEY NONCLUSTERED 
(
	[ChampsSchPMGroups_schPMGrpKey] ASC,
	[TPMProcdures_TPMProcID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- Creating table 'ChampsSchProcGroups'
CREATE TABLE [Scheduler].[ChampsSchProcGroups](
	[schProcGrpKey] [int] IDENTITY(1,1) NOT NULL,
	[schProcName] [nvarchar](50) NOT NULL,
	[schProcDescription] [nvarchar](255) NULL,
	[schProcUptId] [int] NOT NULL,
	[schProcUptDT] [datetime] NOT NULL,
	[ChampsSchedule_schKey] [int] NOT NULL,
 CONSTRAINT [PK_ChampsSchProcGroups] PRIMARY KEY CLUSTERED 
(
	[schProcGrpKey] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- Creating table 'ChampsSchProcGrpHasProcs'
CREATE TABLE [Scheduler].[ChampsSchProcGrpHasProcs](
	[ChampsSchProcGroups_schProcGrpKey] [int] NOT NULL,
	[ProcNumbers_PROCID] [int] NOT NULL,
 CONSTRAINT [PK_ChampsSchProcGrpHasProcs] PRIMARY KEY NONCLUSTERED 
(
	[ChampsSchProcGroups_schProcGrpKey] ASC,
	[ProcNumbers_PROCID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- --------------------------------------------------
-- Add the constraints for the defaults on the main table
-- --------------------------------------------------
ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schPlant]  DEFAULT ((0)) FOR [schPlant]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schLockType]  DEFAULT ((0)) FOR [schLockType]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schSinceLastScheduledInd]  DEFAULT ((0)) FOR [schSinceLastScheduledInd]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schLastScheduledFreq]  DEFAULT ((0)) FOR [schLastScheduledFreq]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schSinceLastCompleteInd]  DEFAULT ((0)) FOR [schSinceLastCompleteInd]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schLastCompletedFreq]  DEFAULT ((0)) FOR [schLastCompletedFreq]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schEarlyDays]  DEFAULT ((0)) FOR [schEarlyDays]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schAssignedTo]  DEFAULT ((0)) FOR [schAssignedTo]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schValidMon]  DEFAULT ((0)) FOR [schValidMon]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schValidTue]  DEFAULT ((0)) FOR [schValidTue]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schValidWed]  DEFAULT ((0)) FOR [schValidWed]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schValidThru]  DEFAULT ((0)) FOR [schValidThru]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schValidFri]  DEFAULT ((0)) FOR [schValidFri]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schValidSat]  DEFAULT ((0)) FOR [schValidSat]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schValidSun]  DEFAULT ((0)) FOR [schValidSun]
GO

ALTER TABLE [Scheduler].[ChampsSchedules] ADD  CONSTRAINT [DF_ChampsSchedules_schUptId]  DEFAULT ((0)) FOR [schUptId]
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------
--
-- ChampsSchPMGroups--ChampsSchPMGrpHasPMs--TPMProcdure
--
-- Creating foreign key on [ChampsSchedule_schKey] in table 'ChampsSchPMGroups'
--
ALTER TABLE [Scheduler].[ChampsSchPMGroups]  WITH CHECK 
ADD  CONSTRAINT [FK_ChampsScheduleChampsSchPMGroup] 
	FOREIGN KEY([ChampsSchedule_schKey])
	REFERENCES [Scheduler].[ChampsSchedules] ([schKey])
	ON UPDATE CASCADE
	ON DELETE CASCADE;
GO
-- Creating foreign key on [ChampsSchPMGroups_schPMGrpKey] in table 'ChampsSchPMGrpHasPMs'
ALTER TABLE [Scheduler].[ChampsSchPMGrpHasPMs]  WITH CHECK 
ADD  CONSTRAINT [FK_ChampsSchPMGroupTPMProcdure_ChampsSchPMGroup] 
	FOREIGN KEY([ChampsSchPMGroups_schPMGrpKey])
	REFERENCES [Scheduler].[ChampsSchPMGroups] ([schPMGrpKey])
	ON UPDATE CASCADE
	ON DELETE CASCADE;
GO
-- Creating foreign key on [TPMProcdures_TPMProcID] in table 'ChampsSchPMGrpHasPMs'
ALTER TABLE [Scheduler].[ChampsSchPMGrpHasPMs]
ADD CONSTRAINT [FK_ChampsSchPMGrpHasPMs_TPMProcdure]
    FOREIGN KEY ([TPMProcdures_TPMProcID])
    REFERENCES [TPM].[TPMProcdure]
        ([TPMProcID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
--
-- ChampsSchProcGroups--ChampsSchProcGrpHasProcs--ProcNumbers
--
-- Creating foreign key on [ChampsSchedule_schKey] in table 'ChampsSchProcGroups'
ALTER TABLE [Scheduler].[ChampsSchProcGroups]
ADD CONSTRAINT [FK_ChampsScheduleChampsSchProcGroup]
    FOREIGN KEY ([ChampsSchedule_schKey])
    REFERENCES [Scheduler].[ChampsSchedules]
        ([schKey])
	ON UPDATE CASCADE
	ON DELETE CASCADE;
GO
-- Creating foreign key on [ChampsSchProcGroups_schProcGrpKey] in table 'ChampsSchProcGrpHasProcs'
ALTER TABLE [Scheduler].[ChampsSchProcGrpHasProcs]
ADD CONSTRAINT [FK_ChampsSchProcGrpHasProcs_ChampsSchProcGroup]
    FOREIGN KEY ([ChampsSchProcGroups_schProcGrpKey])
    REFERENCES [Scheduler].[ChampsSchProcGroups]
        ([schProcGrpKey])
	ON UPDATE CASCADE
	ON DELETE CASCADE;
GO
-- Creating foreign key on [ProcNumbers_PROCID] in table 'ChampsSchProcGrpHasProcs'
ALTER TABLE [Scheduler].[ChampsSchProcGrpHasProcs]
ADD CONSTRAINT [FK_ChampsSchProcGrpHasProcs_ProcNumber]
    FOREIGN KEY ([ProcNumbers_PROCID])
    REFERENCES [EQP].[ProcNumbers]
        ([PROCID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
-- Creating non-clustered index for FOREIGN KEY 'FK_ChampsSchPMGrpHasPMs_TPMProcdure'
CREATE INDEX [IX_FK_ChampsSchPMGrpHasPMs_TPMProcdure]
ON [Scheduler].[ChampsSchPMGrpHasPMs]
    ([TPMProcdures_TPMProcID]);
GO
-- Creating non-clustered index for FOREIGN KEY 'FK_ChampsScheduleChampsSchPMGroup'
CREATE INDEX [IX_FK_ChampsScheduleChampsSchPMGroup]
ON [Scheduler].[ChampsSchPMGroups]
    ([ChampsSchedule_schKey]);
GO
-- Creating non-clustered index for FOREIGN KEY 'FK_ChampsScheduleChampsSchProcGroup'
CREATE INDEX [IX_FK_ChampsScheduleChampsSchProcGroup]
ON [Scheduler].[ChampsSchProcGroups]
    ([ChampsSchedule_schKey]);
GO
-- Creating non-clustered index for FOREIGN KEY 'FK_ChampsSchProcGrpHasProcs_ProcNumber'
CREATE INDEX [IX_FK_ChampsSchProcGrpHasProcs_ProcNumber]
ON [Scheduler].[ChampsSchProcGrpHasProcs]
    ([ProcNumbers_PROCID]);
GO
-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------