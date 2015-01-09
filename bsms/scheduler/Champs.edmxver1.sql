
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 06/05/2013 11:18:51
-- Generated from EDMX file: c:\users\dvusc5w\documents\visual studio 2010\Projects\vwChampsSchedule\vwChampsSchedule\Champs.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [CHAMPS];
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
CREATE TABLE [Scheduler].[ChampsSchedules] (
    [schKey] int IDENTITY(1,1) NOT NULL,
    [schName] nvarchar(50)  NOT NULL,
    [schDescription] nvarchar(255)  NULL,
    [schActive] smallint  NOT NULL,
    [schShutdown] smallint  NOT NULL,
    [schLastScheduledDT] datetime  NULL,
    [schLastCompleteDT] datetime  NULL,
    [schSinceLastScheduledInd] smallint  NOT NULL,
    [schLastScheduledFreq] int  NOT NULL,
    [schSinceLastCompleteInd] smallint  NOT NULL,
    [schLocInd] smallint  NOT NULL,
    [schLocID] int  NOT NULL,
    [schProcInd] smallint  NOT NULL,
    [schProcID] int  NOT NULL,
    [schAssignedTo] int  NOT NULL,
    [schValidMon] smallint  NOT NULL,
    [schValidTue] smallint  NOT NULL,
    [schValidWed] smallint  NOT NULL,
    [schValidThru] smallint  NOT NULL,
    [schValidFri] smallint  NOT NULL,
    [schValidSat] smallint  NOT NULL,
    [schValidSun] smallint  NOT NULL
);
GO

-- Creating table 'ChampsSchPMGroups'
CREATE TABLE [Scheduler].[ChampsSchPMGroups] (
    [schPMGrpKey] int IDENTITY(1,1) NOT NULL,
    [schPMName] nvarchar(50)  NULL,
    [schPMDescription] nvarchar(255)  NULL,
    [ChampsSchedule_schKey] int  NOT NULL
);
GO

-- Creating table 'ChampsSchProcGroups'
CREATE TABLE [Scheduler].[ChampsSchProcGroups] (
    [schProcGrpKey] int IDENTITY(1,1) NOT NULL,
    [schProcName] nvarchar(50)  NOT NULL,
    [schProcDescription] nvarchar(255)  NULL,
    [ChampsSchedule_schKey] int  NOT NULL
);
GO

-- Creating table 'ChampsSchProcGrpHasProcs'
CREATE TABLE [Scheduler].[ChampsSchProcGrpHasProcs] (
    [ChampsSchProcGroups_schProcGrpKey] int  NOT NULL,
    [ProcNumbers_PROCID] int  NOT NULL
);
GO

-- Creating table 'ChampsSchPMGrpHasPMs'
CREATE TABLE [Scheduler].[ChampsSchPMGrpHasPMs] (
    [ChampsSchPMGroups_schPMGrpKey] int  NOT NULL,
    [TPMProcdures_TPMProcID] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [schKey] in table 'ChampsSchedules'
ALTER TABLE [Scheduler].[ChampsSchedules]
ADD CONSTRAINT [PK_ChampsSchedules]
    PRIMARY KEY CLUSTERED ([schKey] ASC);
GO

-- Creating primary key on [schPMGrpKey] in table 'ChampsSchPMGroups'
ALTER TABLE [Scheduler].[ChampsSchPMGroups]
ADD CONSTRAINT [PK_ChampsSchPMGroups]
    PRIMARY KEY CLUSTERED ([schPMGrpKey] ASC);
GO

-- Creating primary key on [schProcGrpKey] in table 'ChampsSchProcGroups'
ALTER TABLE [Scheduler].[ChampsSchProcGroups]
ADD CONSTRAINT [PK_ChampsSchProcGroups]
    PRIMARY KEY CLUSTERED ([schProcGrpKey] ASC);
GO

-- Creating primary key on [ChampsSchProcGroups_schProcGrpKey], [ProcNumbers_PROCID] in table 'ChampsSchProcGrpHasProcs'
ALTER TABLE [Scheduler].[ChampsSchProcGrpHasProcs]
ADD CONSTRAINT [PK_ChampsSchProcGrpHasProcs]
    PRIMARY KEY NONCLUSTERED ([ChampsSchProcGroups_schProcGrpKey], [ProcNumbers_PROCID] ASC);
GO

-- Creating primary key on [ChampsSchPMGroups_schPMGrpKey], [TPMProcdures_TPMProcID] in table 'ChampsSchPMGroupTPMProcdure'
ALTER TABLE [Scheduler].[ChampsSchPMGrpHasPMs]
ADD CONSTRAINT [PK_ChampsSchPMGroupTPMProcdure]
    PRIMARY KEY NONCLUSTERED ([ChampsSchPMGroups_schPMGrpKey], [TPMProcdures_TPMProcID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [ChampsSchedule_schKey] in table 'ChampsSchPMGroups'
ALTER TABLE [Scheduler].[ChampsSchPMGroups]
ADD CONSTRAINT [FK_ChampsScheduleChampsSchPMGroup]
    FOREIGN KEY ([ChampsSchedule_schKey])
    REFERENCES [Scheduler].[ChampsSchedules]
        ([schKey])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ChampsScheduleChampsSchPMGroup'
CREATE INDEX [IX_FK_ChampsScheduleChampsSchPMGroup]
ON [Scheduler].[ChampsSchPMGroups]
    ([ChampsSchedule_schKey]);
GO

-- Creating foreign key on [ChampsSchedule_schKey] in table 'ChampsSchProcGroups'
ALTER TABLE [Scheduler].[ChampsSchProcGroups]
ADD CONSTRAINT [FK_ChampsScheduleChampsSchProcGroup]
    FOREIGN KEY ([ChampsSchedule_schKey])
    REFERENCES [Scheduler].[ChampsSchedules]
        ([schKey])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ChampsScheduleChampsSchProcGroup'
CREATE INDEX [IX_FK_ChampsScheduleChampsSchProcGroup]
ON [Scheduler].[ChampsSchProcGroups]
    ([ChampsSchedule_schKey]);
GO

-- Creating foreign key on [ChampsSchProcGroups_schProcGrpKey] in table 'ChampsSchProcGrpHasProcs'
ALTER TABLE [Scheduler].[ChampsSchProcGrpHasProcs]
ADD CONSTRAINT [FK_ChampsSchProcGrpHasProcs_ChampsSchProcGroup]
    FOREIGN KEY ([ChampsSchProcGroups_schProcGrpKey])
    REFERENCES [Scheduler].[ChampsSchProcGroups]
        ([schProcGrpKey])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [ProcNumbers_PROCID] in table 'ChampsSchProcGrpHasProcs'
ALTER TABLE [Scheduler].[ChampsSchProcGrpHasProcs]
ADD CONSTRAINT [FK_ChampsSchProcGrpHasProcs_ProcNumber]
    FOREIGN KEY ([ProcNumbers_PROCID])
    REFERENCES [EQP].[ProcNumbers]
        ([PROCID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ChampsSchProcGrpHasProcs_ProcNumber'
CREATE INDEX [IX_FK_ChampsSchProcGrpHasProcs_ProcNumber]
ON [Scheduler].[ChampsSchProcGrpHasProcs]
    ([ProcNumbers_PROCID]);
GO

-- Creating foreign key on [ChampsSchPMGroups_schPMGrpKey] in table 'ChampsSchPMGrpHasPMs'
ALTER TABLE [Scheduler].[ChampsSchPMGrpHasPMs]
ADD CONSTRAINT [FK_ChampsSchPMGroupTPMProcdure_ChampsSchPMGroup]
    FOREIGN KEY ([ChampsSchPMGroups_schPMGrpKey])
    REFERENCES [Scheduler].[ChampsSchPMGroups]
        ([schPMGrpKey])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [TPMProcdures_TPMProcID] in table 'ChampsSchPMGrpHasPMs'
ALTER TABLE [Scheduler].[ChampsSchPMGrpHasPMs]
ADD CONSTRAINT [FK_ChampsSchPMGrpHasPMs_TPMProcdure]
    FOREIGN KEY ([TPMProcdures_TPMProcID])
    REFERENCES [TPM].[TPMProcdure]
        ([TPMProcID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ChampsSchPMGrpHasPMs_TPMProcdure'
CREATE INDEX [IX_FK_ChampsSchPMGrpHasPMs_TPMProcdure]
ON [Scheduler].[ChampsSchPMGrpHasPMs]
    ([TPMProcdures_TPMProcID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------