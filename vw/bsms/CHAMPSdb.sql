USE [master]
GO
/****** Object:  Database [CHAMPSTest]    Script Date: 10/26/2012 10:34:56 ******/
CREATE DATABASE [CHAMPSTest] ON  PRIMARY 
( NAME = N'BSMS', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\BSMS.mdf' , SIZE = 243712KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BSMS_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\BSMS_1.ldf' , SIZE = 2816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CHAMPSTest] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CHAMPSTest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CHAMPSTest] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [CHAMPSTest] SET ANSI_NULLS OFF
GO
ALTER DATABASE [CHAMPSTest] SET ANSI_PADDING OFF
GO
ALTER DATABASE [CHAMPSTest] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [CHAMPSTest] SET ARITHABORT OFF
GO
ALTER DATABASE [CHAMPSTest] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [CHAMPSTest] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [CHAMPSTest] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [CHAMPSTest] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [CHAMPSTest] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [CHAMPSTest] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [CHAMPSTest] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [CHAMPSTest] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [CHAMPSTest] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [CHAMPSTest] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [CHAMPSTest] SET  DISABLE_BROKER
GO
ALTER DATABASE [CHAMPSTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [CHAMPSTest] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [CHAMPSTest] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [CHAMPSTest] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [CHAMPSTest] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [CHAMPSTest] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [CHAMPSTest] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [CHAMPSTest] SET  READ_WRITE
GO
ALTER DATABASE [CHAMPSTest] SET RECOVERY FULL
GO
ALTER DATABASE [CHAMPSTest] SET  MULTI_USER
GO
ALTER DATABASE [CHAMPSTest] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [CHAMPSTest] SET DB_CHAINING OFF
GO
USE [CHAMPSTest]
GO
/****** Object:  User [NA\dvusc5w]    Script Date: 10/26/2012 10:34:56 ******/
CREATE USER [NA\dvusc5w] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [BSMSUser]    Script Date: 10/26/2012 10:34:56 ******/
CREATE USER [BSMSUser] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Schema [WO]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [WO] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Weld]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [Weld] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [wAppWorkOrder]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [wAppWorkOrder] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [wAppTPM]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [wAppTPM] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [wAppTeam]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [wAppTeam] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [wAppParts]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [wAppParts] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [wAppEQP]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [wAppEQP] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [wAppDT]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [wAppDT] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [wAppDoc]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [wAppDoc] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [wACom]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [wACom] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [TPM]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [TPM] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Team]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [Team] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [TabletApp]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [TabletApp] AUTHORIZATION [BSMSUser]
GO
/****** Object:  Schema [SP]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [SP] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [SEC]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [SEC] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Scheduler]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [Scheduler] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Production]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [Production] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [OI]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [OI] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [EQP]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [EQP] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [DT]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [DT] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Documentation]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [Documentation] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Development]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [Development] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [DELETED]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [DELETED] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [COM]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [COM] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Backups]    Script Date: 10/26/2012 10:34:56 ******/
CREATE SCHEMA [Backups] AUTHORIZATION [dbo]
GO
/****** Object:  Table [DT].[T2Code]    Script Date: 10/26/2012 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DT].[T2Code](
	[T2CodeName] [nvarchar](255) NOT NULL,
	[T2T1CodeLink] [int] NOT NULL,
	[T2Designation] [nvarchar](255) NOT NULL,
	[T2ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_T2Code] PRIMARY KEY CLUSTERED 
(
	[T2ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [EQP].[ProcNumbers]    Script Date: 10/26/2012 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[ProcNumbers](
	[PROCNAME] [nvarchar](255) NULL,
	[PROCNUMBER] [nvarchar](255) NULL,
	[PROCASSET] [int] NULL,
	[PROCARG] [int] NULL,
	[PROCMODEL] [int] NULL,
	[PROCQUARTGROUP] [int] NULL,
	[PROCSEMIGROUP] [int] NULL,
	[PROCANUALGROUP] [int] NULL,
	[PROCMONTHGROUP] [int] NULL,
	[PROCWEEKGROUP] [int] NULL,
	[PROCID] [int] IDENTITY(1,1) NOT NULL,
	[PROCBIMONTHGROUP] [int] NULL,
	[PROCTWOYRGRUP] [int] NULL,
	[PROCTHREEYRGROUP] [int] NULL,
	[PROCFOURYRGROUP] [int] NULL,
	[PROCEIGHTYRGROUP] [int] NULL,
	[PROCASSIGNTO] [int] NULL,
	[PROCIPLINK] [int] NULL,
	[PROCACTIVE] [bit] NOT NULL,
	[PROCASSETASSIGNABLE] [bit] NOT NULL,
 CONSTRAINT [PK_ProcNumbers] PRIMARY KEY CLUSTERED 
(
	[PROCID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DT].[DTMainTable]    Script Date: 10/26/2012 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DT].[DTMainTable](
	[DTLine] [int] NULL,
	[DTRobot] [int] NULL,
	[DTSolution] [nvarchar](max) NULL,
	[DTResponsibility] [int] NULL,
	[DTTimeDown] [date] NULL,
	[DTTimeUp] [timestamp] NULL,
	[DTMinutes] [int] NULL,
	[DTMalfunction] [nvarchar](max) NULL,
	[DTLongTerm] [nvarchar](max) NULL,
	[DTTimeDown1] [datetime] NULL,
	[DTTimeUp2] [datetime] NULL,
	[DTT3Code] [int] NULL,
	[DTID] [int] IDENTITY(1,1) NOT NULL,
	[TotalMinutes]  AS (datediff(minute,CONVERT([datetime],CONVERT([date],[DTNDateDown],(0)),(0))+CONVERT([time],[DTNTimeDown],(0)),CONVERT([datetime],CONVERT([date],[DTNDateUp],(0)),(0))+CONVERT([time],[DTNTimeUp],(0)))),
	[DTNoTime] [float] NULL,
	[DTOriginator] [int] NULL,
	[DTNDateDown] [date] NULL,
	[DTNTimeDown] [time](0) NULL,
	[DTNDateUp] [date] NULL,
	[DTNTimeUp] [time](0) NULL,
	[DTNCDown]  AS (CONVERT([datetime],CONVERT([date],[DTNDateDown],(0)),(0))+CONVERT([time],[DTNTimeDown],(0))),
	[DTNCUp]  AS (CONVERT([datetime],CONVERT([date],[DTNDateUp],(0)),(0))+CONVERT([time],[DTNTimeUp],(0))),
	[DTAsset] [int] NULL,
	[DTLostProduction] [bit] NULL,
 CONSTRAINT [PK_DTMainTable_3] PRIMARY KEY CLUSTERED 
(
	[DTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [wACom].[Areas]    Script Date: 10/26/2012 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [wACom].[Areas](
	[AAareaname] [nvarchar](255) NULL,
	[AAarealocation] [nvarchar](255) NULL,
	[AAareaphone] [nvarchar](255) NULL,
	[AAID] [int] IDENTITY(1,1) NOT NULL,
	[AAPlant] [int] NULL,
	[AAActive] [bit] NOT NULL,
 CONSTRAINT [PK_Areas] PRIMARY KEY CLUSTERED 
(
	[AAID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [wACom].[Lines]    Script Date: 10/26/2012 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [wACom].[Lines](
	[LILineName] [nvarchar](255) NULL,
	[LISatellite] [int] NULL,
	[LIPlannerGroup] [int] NULL,
	[LIID] [int] IDENTITY(1,1) NOT NULL,
	[LIPlant] [int] NULL,
	[LIActive] [bit] NOT NULL,
 CONSTRAINT [PK_Lines_1] PRIMARY KEY CLUSTERED 
(
	[LIID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [wACom].[MachineList]    Script Date: 10/26/2012 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [wACom].[MachineList](
	[MLCELLNAME] [nvarchar](50) NULL,
	[MLLINEID] [int] NULL,
	[MLID] [int] IDENTITY(1,1) NOT NULL,
	[MLPlantID] [int] NULL,
	[MLActive] [bit] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [COM].[ResponsibleParty]    Script Date: 10/26/2012 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [COM].[ResponsibleParty](
	[RPName] [nvarchar](255) NULL,
	[RPID] [int] IDENTITY(1,1) NOT NULL,
	[RPPlantID] [int] NULL,
	[RPActive] [bit] NULL,
 CONSTRAINT [PK_ResponsibleParty_1] PRIMARY KEY CLUSTERED 
(
	[RPID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DT].[T3Code]    Script Date: 10/26/2012 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DT].[T3Code](
	[T3ID] [int] IDENTITY(1,1) NOT NULL,
	[T3CodeName] [nvarchar](255) NULL,
	[T2CodeLink] [int] NULL,
	[T3Designation] [nvarchar](255) NULL,
 CONSTRAINT [PK_T3Code] PRIMARY KEY CLUSTERED 
(
	[T3ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [DT].[T1Code]    Script Date: 10/26/2012 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DT].[T1Code](
	[T1CodeName] [nvarchar](255) NOT NULL,
	[T1Designation] [nvarchar](255) NOT NULL,
	[T1ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_T1Code] PRIMARY KEY CLUSTERED 
(
	[T1ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Team].[teammembers]    Script Date: 10/26/2012 10:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Team].[teammembers](
	[TMFirstName] [nvarchar](255) NULL,
	[TMLastName] [nvarchar](255) NULL,
	[TMShift] [nvarchar](255) NULL,
	[TMPhone] [nvarchar](255) NULL,
	[TMRadioNumber] [nvarchar](255) NULL,
	[TMImage] [varbinary](max) NULL,
	[TMArea] [int] NULL,
	[TMUserName] [nvarchar](255) NULL,
	[TMSecurityLevel] [int] NULL,
	[TMLastThree] [int] NULL,
	[TMHireDate] [datetime] NULL,
	[TMID] [int] IDENTITY(1,1) NOT NULL,
	[TMGROUPLINK] [int] NULL,
	[TMEmpNumber] [int] NULL,
	[TMNShift] [int] NULL,
	[TMDEPARTMENTLINK] [int] NULL,
	[TMPLANTLINK] [int] NULL,
	[TMEmail] [nvarchar](50) NULL,
	[TMPayStatus] [int] NULL,
	[wATMGroupLink] [int] NULL,
	[wATMDeptLink] [int] NULL,
	[wATMPlantLink] [int] NULL,
	[TMProdUID] [nvarchar](50) NULL,
	[TMWorkAssignment] [int] NOT NULL,
	[TMTeamLink] [int] NOT NULL,
	[TMTitleLink] [int] NOT NULL,
 CONSTRAINT [PK_teammembers] PRIMARY KEY CLUSTERED 
(
	[TMID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [Team].[BSMaintHourlyAllOne]    Script Date: 10/26/2012 10:35:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Team].[BSMaintHourlyAllOne]
AS
SELECT     TOP (100) PERCENT TMID, TMFirstName + ' ' + TMLastName AS MyName
FROM         Team.teammembers
ORDER BY MyName
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[51] 4[20] 2[4] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -960
         Left = 0
      End
      Begin Tables = 
         Begin Table = "teammembers (Team)"
            Begin Extent = 
               Top = 0
               Left = 23
               Bottom = 258
               Right = 184
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 2835
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2010
         Alias = 1485
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'VIEW',@level1name=N'BSMaintHourlyAllOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'VIEW',@level1name=N'BSMaintHourlyAllOne'
GO
/****** Object:  View [wAppDT].[Downtime_MainFormView]    Script Date: 10/26/2012 10:35:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppDT].[Downtime_MainFormView]
AS
SELECT        TOP (100) PERCENT COM.ResponsibleParty.RPID, COM.ResponsibleParty.RPName, DT.T3Code.T3CodeName, EQP.ProcNumbers.PROCNUMBER, 
                         DT.DTMainTable.DTLine, DT.DTMainTable.DTRobot, DT.DTMainTable.DTSolution, DT.DTMainTable.DTResponsibility, DT.DTMainTable.DTMalfunction, 
                         DT.DTMainTable.DTLongTerm, DT.DTMainTable.DTT3Code, DT.DTMainTable.DTNoTime, DT.DTMainTable.DTOriginator, DT.DTMainTable.DTID, 
                         DT.T2Code.T2CodeName, DT.T1Code.T1CodeName, DT.T2Code.T2ID, DT.T1Code.T1ID, DT.T3Code.T3ID, Team.BSMaintHourlyAllOne.MyName, 
                         Team.BSMaintHourlyAllOne.TMID, DT.DTMainTable.DTNDateDown, DT.DTMainTable.DTNTimeDown, DT.DTMainTable.DTNDateUp, DT.DTMainTable.DTNTimeUp, 
                         DT.DTMainTable.DTNCDown, DT.DTMainTable.DTNCUp, DATEDIFF(minute, DT.DTMainTable.DTNCDown, DT.DTMainTable.DTNCUp) AS TotalTime, 
                         wACom.MachineList.MLCELLNAME, wACom.MachineList.MLLINEID, wACom.MachineList.MLID, wACom.MachineList.MLPlantID, wACom.Lines.LILineName, 
                         wACom.Lines.LIID, wACom.Areas.AAareaname, wACom.Areas.AAID, wACom.Areas.AAPlant, wACom.Lines.LISatellite, DT.DTMainTable.DTLostProduction
FROM            Team.BSMaintHourlyAllOne RIGHT OUTER JOIN
                         DT.DTMainTable LEFT OUTER JOIN
                         wACom.Areas RIGHT OUTER JOIN
                         wACom.Lines ON wACom.Areas.AAID = wACom.Lines.LISatellite RIGHT OUTER JOIN
                         wACom.MachineList ON wACom.Lines.LIID = wACom.MachineList.MLLINEID ON DT.DTMainTable.DTLine = wACom.MachineList.MLID ON 
                         Team.BSMaintHourlyAllOne.TMID = DT.DTMainTable.DTOriginator LEFT OUTER JOIN
                         DT.T3Code LEFT OUTER JOIN
                         DT.T2Code ON DT.T3Code.T2CodeLink = DT.T2Code.T2ID ON DT.DTMainTable.DTT3Code = DT.T3Code.T3ID LEFT OUTER JOIN
                         EQP.ProcNumbers ON DT.DTMainTable.DTRobot = EQP.ProcNumbers.PROCID LEFT OUTER JOIN
                         COM.ResponsibleParty ON DT.DTMainTable.DTResponsibility = COM.ResponsibleParty.RPID LEFT OUTER JOIN
                         DT.T1Code ON DT.T2Code.T2T1CodeLink = DT.T1Code.T1ID AND DT.T2Code.T2T1CodeLink = DT.T1Code.T1ID AND DT.T2Code.T2T1CodeLink = DT.T1Code.T1ID AND 
                         DT.T2Code.T2T1CodeLink = DT.T1Code.T1ID AND DT.T2Code.T2T1CodeLink = DT.T1Code.T1ID AND DT.T2Code.T2T1CodeLink = DT.T1Code.T1ID
ORDER BY DT.DTMainTable.DTID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 12
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "BSMaintHourlyAllOne (Team)"
            Begin Extent = 
               Top = 2
               Left = 411
               Bottom = 87
               Right = 563
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "DTMainTable (DT)"
            Begin Extent = 
               Top = 13
               Left = 6
               Bottom = 494
               Right = 165
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Areas (wACom)"
            Begin Extent = 
               Top = 250
               Left = 809
               Bottom = 358
               Right = 962
            End
            DisplayFlags = 344
            TopColumn = 1
         End
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 249
               Left = 592
               Bottom = 372
               Right = 747
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 249
               Left = 390
               Bottom = 364
               Right = 542
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "T3Code (DT)"
            Begin Extent = 
               Top = 56
               Left = 693
               Bottom = 171
               Right = 845
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "T2Code (DT)"
            Begin Extent = 
               Top = 55
               Left = 912
               Bottom = 170
               R' , @level0type=N'SCHEMA',@level0name=N'wAppDT', @level1type=N'VIEW',@level1name=N'Downtime_MainFormView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'ight = 1064
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 5
               Left = 213
               Bottom = 120
               Right = 403
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ResponsibleParty (COM)"
            Begin Extent = 
               Top = 4
               Left = 574
               Bottom = 119
               Right = 726
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "T1Code (DT)"
            Begin Extent = 
               Top = 26
               Left = 1119
               Bottom = 126
               Right = 1271
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppDT', @level1type=N'VIEW',@level1name=N'Downtime_MainFormView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppDT', @level1type=N'VIEW',@level1name=N'Downtime_MainFormView'
GO
/****** Object:  StoredProcedure [DT].[ftdTest]    Script Date: 10/26/2012 10:35:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[ftdTest]

	@EarlyDate datetime = '5/10/2012 05:01:00',
	@LateDate datetime = '5/10/2012 17:00:00',
	@StartTime nVarChar(100) = '5/10/2012 05:00:00',
	@EndTime nVarChar(100) = '5/10/2012 15:00:00'

AS
/*
Returns the downtime values per shift.

Feed the early date as the start of the shift and the late as the end.

Shift times for 3/1/2011

****  PRODUCTION SHIFTS *****
1st
03/1/2011 05:01:00 - 03/15/2011 17:00:00

2nd
03/01/2011 17:01:00 - 03/16/2011 05:00:00



*/


SET @EarlyDate = (CONVERT(datetime,CONVERT(date,@EarlyDate,(0)),(0))+CONVERT(time,@StartTime,(0)))
SET @LateDate =  (CONVERT(datetime,CONVERT(date,@LateDate,(0)),(0))+CONVERT(time,@EndTime,(0)))

		SELECT
			MLLINEID,
			DTResponsibility,
			TotalTime,
			DTNDateDown,
			DTNTimeDown
		FROM
		    wAppDT.Downtime_MainFormView 
        WHERE
			NOT (MLLINEID IS NULL)
			AND DTNDateDown BETWEEN Convert(Date,@EarlyDate) and Convert(Date,@LateDate)
			AND DatePart(Hour,DTNTimeDown) BETWEEN DatePart(Hour,Convert(DateTime,@StartTime)) AND DatePart(Hour,Convert(DateTime,@EndTime))







	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[DTMPNew]    Script Date: 10/26/2012 10:35:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[DTMPNew]
@Plant as Integer
AS

	SELECT * From wAppDT.Downtime_MainFormView 
	WHERE MLPlantID = @Plant and DTNDateDown > DateAdd(Day,-90,GetDate())

	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[DowntimeFetchFilterTest]    Script Date: 10/26/2012 10:35:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[DowntimeFetchFilterTest]
	(
		@toplevel int = 99999,
		@Line int = 1,
		@TimeFrame int = 12
	)


AS	


DECLARE			@combStart DateTime;
DECLARE			@combEnd DateTime;

	SET @combStart = GetDate();
	SET @combEnd = DateAdd(Hour,-@TimeFrame,@combStart);
			
			SELECT TOP (@toplevel) * FROM wAppDT.Downtime_MainFormView
				WHERE (
						(Convert(DATETIME,Convert(date,DTNDateDown,(0)),(0)) + Convert(time,DTNTimeDown,(0))) BETWEEN @combEnd and @combStart
						AND LISatellite = @Line
					  )
				ORDER BY MLCELLNAME, TotalTime Desc

	RETURN
GO
/****** Object:  View [DT].[AlarmCodeCombined]    Script Date: 10/26/2012 10:35:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [DT].[AlarmCodeCombined]
AS
SELECT     DT.T1Code.*, DT.T2Code.*, DT.T3Code.*
FROM         DT.T1Code INNER JOIN
                      DT.T2Code ON DT.T1Code.T1ID = DT.T2Code.T2T1CodeLink INNER JOIN
                      DT.T3Code ON DT.T2Code.T2ID = DT.T3Code.T2CodeLink
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "T1Code (DT)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 106
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T2Code (DT)"
            Begin Extent = 
               Top = 6
               Left = 228
               Bottom = 180
               Right = 380
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T3Code (DT)"
            Begin Extent = 
               Top = 6
               Left = 418
               Bottom = 121
               Right = 570
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'DT', @level1type=N'VIEW',@level1name=N'AlarmCodeCombined'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'DT', @level1type=N'VIEW',@level1name=N'AlarmCodeCombined'
GO
/****** Object:  View [DT].[Downtime_MainFormView]    Script Date: 10/26/2012 10:35:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [DT].[Downtime_MainFormView]
AS
SELECT     TOP (100) PERCENT COM.ResponsibleParty.RPID, COM.ResponsibleParty.RPName, EQP.ProcNumbers.PROCNUMBER, DT.DTMainTable.DTLine, 
                      DT.DTMainTable.DTRobot, DT.DTMainTable.DTSolution, DT.DTMainTable.DTResponsibility, DT.DTMainTable.DTMalfunction, 
                      DT.DTMainTable.DTLongTerm, DT.DTMainTable.DTT3Code, DT.DTMainTable.DTNoTime, DT.DTMainTable.DTOriginator, DT.DTMainTable.DTID, 
                      Team.BSMaintHourlyAllOne.MyName, Team.BSMaintHourlyAllOne.TMID, DT.DTMainTable.DTNDateDown, DT.DTMainTable.DTNTimeDown, 
                      DT.DTMainTable.DTNDateUp, DT.DTMainTable.DTNTimeUp, DT.DTMainTable.DTNCDown, DT.DTMainTable.DTNCUp, DATEDIFF(minute, 
                      DT.DTMainTable.DTNCDown, DT.DTMainTable.DTNCUp) AS TotalTime, wACom.MachineList.MLCELLNAME, wACom.MachineList.MLLINEID, 
                      wACom.MachineList.MLID, wACom.MachineList.MLPlantID, DT.DTMainTable.DTLostProduction, DT.AlarmCodeCombined.T1CodeName AS Expr1, 
                      DT.AlarmCodeCombined.T1ID AS Expr2, DT.AlarmCodeCombined.T2CodeName AS Expr3, DT.AlarmCodeCombined.T2ID AS Expr4, 
                      DT.AlarmCodeCombined.T3ID AS Expr5, DT.AlarmCodeCombined.T3CodeName AS Expr6
FROM         DT.AlarmCodeCombined RIGHT OUTER JOIN
                      DT.DTMainTable ON DT.AlarmCodeCombined.T3ID = DT.DTMainTable.DTT3Code LEFT OUTER JOIN
                      wACom.MachineList ON DT.DTMainTable.DTLine = wACom.MachineList.MLID LEFT OUTER JOIN
                      Team.BSMaintHourlyAllOne ON DT.DTMainTable.DTOriginator = Team.BSMaintHourlyAllOne.TMID LEFT OUTER JOIN
                      EQP.ProcNumbers ON DT.DTMainTable.DTRobot = EQP.ProcNumbers.PROCID LEFT OUTER JOIN
                      COM.ResponsibleParty ON DT.DTMainTable.DTResponsibility = COM.ResponsibleParty.RPID
ORDER BY DT.DTMainTable.DTID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[50] 4[12] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[71] 4[4] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 66
               Left = 1057
               Bottom = 199
               Right = 1208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DTMainTable (DT)"
            Begin Extent = 
               Top = 3
               Left = 0
               Bottom = 568
               Right = 276
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BSMaintHourlyAllOne (Team)"
            Begin Extent = 
               Top = 266
               Left = 476
               Bottom = 351
               Right = 628
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 22
               Left = 689
               Bottom = 137
               Right = 879
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ResponsibleParty (COM)"
            Begin Extent = 
               Top = 128
               Left = 473
               Bottom = 213
               Right = 625
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "AlarmCodeCombined (DT)"
            Begin Extent = 
               Top = 203
               Left = 476
               Bottom = 430
               Right = 626
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
  ' , @level0type=N'SCHEMA',@level0name=N'DT', @level1type=N'VIEW',@level1name=N'Downtime_MainFormView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2400
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'DT', @level1type=N'VIEW',@level1name=N'Downtime_MainFormView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'DT', @level1type=N'VIEW',@level1name=N'Downtime_MainFormView'
GO
/****** Object:  StoredProcedure [DT].[DTMP]    Script Date: 10/26/2012 10:35:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [DT].[DTMP]
@Plant as Integer
AS

	SELECT * From DT.Downtime_MainFormView 
	WHERE MLPlantID = @Plant

	RETURN
GO
/****** Object:  StoredProcedure [TabletApp].[DowntimeMainFetch]    Script Date: 10/26/2012 10:35:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TabletApp].[DowntimeMainFetch]
@Plant as Integer
AS

	SELECT * From DT.Downtime_MainFormView 
	WHERE MLPlantID = @Plant AND DTNDateDown > DateAdd(Day,-3,GetDate())


	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[DowntimeFetch]    Script Date: 10/26/2012 10:35:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[DowntimeFetch]
@Plant as Integer
AS

	SELECT * From DT.Downtime_MainFormView 
	WHERE MLPlantID = @Plant

	RETURN
GO
/****** Object:  Table [TPM].[TPMTaskList]    Script Date: 10/26/2012 10:35:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TPM].[TPMTaskList](
	[TPMTLID] [int] IDENTITY(5000,1) NOT NULL,
	[TPMTLTitle] [nvarchar](255) NOT NULL,
	[TPMTLTask] [nvarchar](max) NOT NULL,
	[TPMTLNumTM] [int] NOT NULL,
	[TPMTLMin] [int] NOT NULL,
	[TPMTLCategory] [int] NOT NULL,
	[TPMTLShare] [bit] NOT NULL,
	[TPMTLPlant] [int] NOT NULL,
 CONSTRAINT [PK_TPMTaskList] PRIMARY KEY CLUSTERED 
(
	[TPMTLID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [TPM].[TPMTaskAssembly]    Script Date: 10/26/2012 10:35:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TPM].[TPMTaskAssembly](
	[TPMTAID] [int] IDENTITY(1,1) NOT NULL,
	[TPMTAProcedureID] [int] NOT NULL,
	[TPMTATaskID] [int] NOT NULL,
	[TPMTAOrder] [int] NULL,
 CONSTRAINT [PK_TPMTaskAssembly] PRIMARY KEY CLUSTERED 
(
	[TPMTAID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [wAppTPM].[RetrieveProcString]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [wAppTPM].[RetrieveProcString]
	(
		@ProcedureNumber int
	)

RETURNS nVarChar(max)

AS
BEGIN
/*   Change log

J. Steve Witt 10/24/2012 
			The order the task appearing was not appearing in an ordered list so I added TPMTAOrder
			to the select that creates CWTable table.

*/


DECLARE @resultString nVarChar(max) = (char(13) + char(10));
DECLARE @taskNumber int;
DECLARE @taskText nVarChar(max);

DECLARE @CWTable TABLE
(
	taskNumber INTEGER,
	task	nVarChar(max)
);


INSERT INTO @CWTable 
	SELECT TPMTLID, TPMTLTask
		FROM TPM.TPMTaskList as TL
			LEFT JOIN TPM.TPMTaskAssembly AS TA ON TA.TPMTATaskID = TL.TPMTLID
		WHERE TA.TPMTAProcedureID = @ProcedureNumber order by ta.TPMTAOrder


DECLARE cwTable CURSOR FAST_FORWARD FOR
	SELECT * FROM @CWTable

OPEN cwTable


FETCH NEXT FROM cwTable INTO @taskNumber, @taskText

WHILE @@FETCH_STATUS = 0

BEGIN

	 -- cycle through all of the tasks and assemble them into the final string


	SET @resultString = ISNULL(@resultString,(char(13) + char(10))) + ISNULL(@taskText, '') +  (char(13) + char(10))
FETCH NEXT FROM cwTable INTO @taskNumber, @taskText
END


CLOSE cwTable
DEALLOCATE cwTable




RETURN @resultString;

	END
GO
/****** Object:  Table [TPM].[TPMProcdure]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TPM].[TPMProcdure](
	[TPMProcID] [int] IDENTITY(1,1) NOT NULL,
	[TPMProcTitle] [nvarchar](255) NULL,
	[TPMProcFreq] [int] NULL,
	[TPMProcType] [int] NULL,
	[TPMProcProcedure] [nvarchar](max) NULL,
	[TMPProcModelLink] [int] NULL,
	[TPMProcContDocNum] [int] NULL,
	[TPMPRocNumTM] [decimal](18, 0) NULL,
	[TPMProcEstMin] [decimal](18, 0) NULL,
	[TPMProcLineStatus] [int] NULL,
	[TPMProcPriority] [int] NULL,
	[TPMProcPlantAssign] [int] NOT NULL,
 CONSTRAINT [PK_TPMProcdure] PRIMARY KEY CLUSTERED 
(
	[TPMProcID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TPMProcdure] ON [TPM].[TPMProcdure] 
(
	[TPMProcType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [Team].[ShiftTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[ShiftTable](
	[STID] [int] IDENTITY(1,1) NOT NULL,
	[STShiftName] [nvarchar](max) NULL,
	[STTimeStart] [time](0) NULL,
	[STTimeEnd] [time](0) NULL,
	[STRotation] [bit] NULL,
	[STColor] [nvarchar](50) NULL,
	[STDept] [int] NULL,
 CONSTRAINT [PK_ShiftTable] PRIMARY KEY CLUSTERED 
(
	[STID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [WO].[WorkOrderMain]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WO].[WorkOrderMain](
	[DISOpenDate] [datetime] NULL,
	[DISCloseDate] [datetime] NULL,
	[DISWorkRequired] [nvarchar](max) NULL,
	[DISNumberAss] [int] NULL,
	[DISManHours] [int] NULL,
	[DISWorkAccomp] [nvarchar](max) NULL,
	[DISLineNumber] [int] NULL,
	[DISEquip] [int] NULL,
	[DISDueDate] [datetime] NULL,
	[DISOriginator] [int] NULL,
	[DISResponsible] [int] NULL,
	[DISType] [int] NULL,
	[DISRequestor] [int] NULL,
	[DISOpenItemNumber] [int] NULL,
	[DISTPMNumber] [int] NULL,
	[DISID] [int] IDENTITY(1,1) NOT NULL,
	[DISIntHold] [int] NULL,
	[DISCharHold] [nvarchar](max) NULL,
	[DISAsset] [int] NULL,
	[DISSchedDate] [date] NULL,
	[DISSchedShift] [int] NULL,
	[DISClosedIncomplete] [datetime] NULL,
 CONSTRAINT [PK_WorkOrderMain] PRIMARY KEY CLUSTERED 
(
	[DISID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This column is now for the assigned work.' , @level0type=N'SCHEMA',@level0name=N'WO', @level1type=N'TABLE',@level1name=N'WorkOrderMain', @level2type=N'COLUMN',@level2name=N'DISRequestor'
GO
/****** Object:  Table [TPM].[TPMFrequency]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [TPM].[TPMFrequency](
	[TPMFreqID] [int] IDENTITY(1,1) NOT NULL,
	[TPMFreqFrequency] [nvarchar](255) NULL,
	[TPMFreqNotes] [nvarchar](max) NULL,
	[TPMFreqPeriod] [int] NULL,
	[TPMFreqDueModifier] [int] NULL,
	[TPMInProduction] [bit] NOT NULL,
	[TPMProcGroupName] [nvarchar](255) NULL,
	[TPMBulkDigital] [bit] NOT NULL,
	[RightCol] [varchar](23) NULL,
 CONSTRAINT [PK_TPMFrequency] PRIMARY KEY CLUSTERED 
(
	[TPMFreqID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=1680 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqNotes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqNotes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqNotes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=2145 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqNotes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqNotes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqDueModifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqDueModifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqDueModifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqDueModifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMFreqDueModifier'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMInProduction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMInProduction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMInProduction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMInProduction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMInProduction'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMProcGroupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMProcGroupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMProcGroupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMProcGroupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMProcGroupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMBulkDigital'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMBulkDigital'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMBulkDigital'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMBulkDigital'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'TPMBulkDigital'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'RightCol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'RightCol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'RightCol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'RightCol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency', @level2type=N'COLUMN',@level2name=N'RightCol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=N'[TPMFrequency].[TPMFreqID]' , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'TABLE',@level1name=N'TPMFrequency'
GO
/****** Object:  Table [Team].[wAPlants]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[wAPlants](
	[PNID] [int] IDENTITY(1,1) NOT NULL,
	[PNName] [nvarchar](50) NULL,
	[PNCode] [nchar](10) NULL,
 CONSTRAINT [PK_wAPlants] PRIMARY KEY CLUSTERED 
(
	[PNID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [wACom].[TeamListDrop]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wACom].[TeamListDrop]
AS
SELECT     Team.teammembers.TMLastName + N',  ' + Team.teammembers.TMFirstName AS Myname, Team.teammembers.TMLastName, 
                      Team.teammembers.TMID, Team.wAPlants.PNID
FROM         Team.wAPlants RIGHT OUTER JOIN
                      Team.teammembers ON Team.wAPlants.PNID = Team.teammembers.TMPLANTLINK
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "wAPlants (Team)"
            Begin Extent = 
               Top = 135
               Left = 503
               Bottom = 235
               Right = 655
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "teammembers (Team)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 248
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 6390
         Alias = 4800
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'TeamListDrop'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'TeamListDrop'
GO
/****** Object:  View [wAppWorkOrder].[OpenTPMReport]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppWorkOrder].[OpenTPMReport]
AS
SELECT        wACom.Lines.LILineName, wACom.Lines.LIID, wACom.MachineList.MLCELLNAME, EQP.ProcNumbers.PROCNAME, EQP.ProcNumbers.PROCNUMBER, 
                         WO.WorkOrderMain.DISType, WO.WorkOrderMain.DISTPMNumber, WO.WorkOrderMain.DISID, TPM.TPMProcdure.TPMProcTitle, 
                         TPM.TPMProcdure.TPMProcProcedure, TPM.TPMProcdure.TMPProcModelLink, TPM.TPMProcdure.TPMProcContDocNum, TPM.TPMProcdure.TPMPRocNumTM, 
                         TPM.TPMProcdure.TPMProcEstMin, TPM.TPMFrequency.TPMFreqFrequency, wACom.MachineList.MLID, WO.WorkOrderMain.DISWorkAccomp, 
                         WO.WorkOrderMain.DISNumberAss, WO.WorkOrderMain.DISManHours, WO.WorkOrderMain.DISCloseDate, WO.WorkOrderMain.DISRequestor, 
                         WO.WorkOrderMain.DISDueDate, wACom.TeamListDrop.Myname, WO.WorkOrderMain.DISLineNumber, WO.WorkOrderMain.DISEquip, 
                         WO.WorkOrderMain.DISOriginator, WO.WorkOrderMain.DISResponsible, WO.WorkOrderMain.DISOpenItemNumber, WO.WorkOrderMain.DISIntHold, 
                         WO.WorkOrderMain.DISCharHold, WO.WorkOrderMain.DISAsset, WO.WorkOrderMain.DISWorkRequired, WO.WorkOrderMain.DISOpenDate, Team.wAPlants.PNID, 
                         Team.wAPlants.PNName, WO.WorkOrderMain.DISSchedDate, WO.WorkOrderMain.DISSchedShift, Team.ShiftTable.STShiftName, Team.ShiftTable.STID, 
                         Team.ShiftTable.STColor, COM.ResponsibleParty.RPName, COM.ResponsibleParty.RPID
FROM            EQP.ProcNumbers RIGHT OUTER JOIN
                         COM.ResponsibleParty RIGHT OUTER JOIN
                         WO.WorkOrderMain ON COM.ResponsibleParty.RPID = WO.WorkOrderMain.DISResponsible LEFT OUTER JOIN
                         Team.ShiftTable ON WO.WorkOrderMain.DISSchedShift = Team.ShiftTable.STID LEFT OUTER JOIN
                         wACom.TeamListDrop ON WO.WorkOrderMain.DISRequestor = wACom.TeamListDrop.TMID LEFT OUTER JOIN
                         TPM.TPMFrequency RIGHT OUTER JOIN
                         TPM.TPMProcdure ON TPM.TPMFrequency.TPMFreqID = TPM.TPMProcdure.TPMProcFreq ON 
                         WO.WorkOrderMain.DISTPMNumber = TPM.TPMProcdure.TPMProcID ON EQP.ProcNumbers.PROCID = WO.WorkOrderMain.DISEquip LEFT OUTER JOIN
                         wACom.MachineList ON WO.WorkOrderMain.DISLineNumber = wACom.MachineList.MLID LEFT OUTER JOIN
                         Team.wAPlants RIGHT OUTER JOIN
                         wACom.Lines ON Team.wAPlants.PNID = wACom.Lines.LIPlant ON wACom.MachineList.MLLINEID = wACom.Lines.LIID
WHERE        (WO.WorkOrderMain.DISType = 3)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 6
               Left = 832
               Bottom = 255
               Right = 1022
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ResponsibleParty (COM)"
            Begin Extent = 
               Top = 150
               Left = 517
               Bottom = 279
               Right = 687
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WorkOrderMain (WO)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 257
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "ShiftTable (Team)"
            Begin Extent = 
               Top = 113
               Left = 926
               Bottom = 221
               Right = 1077
            End
            DisplayFlags = 344
            TopColumn = 2
         End
         Begin Table = "TeamListDrop (wACom)"
            Begin Extent = 
               Top = 6
               Left = 1060
               Bottom = 179
               Right = 1212
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TPMFrequency (TPM)"
            Begin Extent = 
               Top = 69
               Left = 703
               Bottom = 184
               Right = 883
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TPMProcdure (TPM)"
            Begin Extent = 
               Top = 21
               Left = 295
               Bottom =' , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'OpenTPMReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 210
               Right = 479
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 259
               Bottom = 121
               Right = 411
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "wAPlants (Team)"
            Begin Extent = 
               Top = 1
               Left = 646
               Bottom = 94
               Right = 797
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 0
               Left = 411
               Bottom = 150
               Right = 566
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 23
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1890
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2595
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'OpenTPMReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'OpenTPMReport'
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[CoRpt1Fetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[CoRpt1Fetch]
@Plant as Integer
AS

	SELECT * FROM wAppWorkOrder.OpenTPMReport
	WHERE PNID = @Plant AND (DISWorkAccomp IS NOT NULL) AND DISCloseDate > '1/30/2012'

	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[OpenTPMFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[OpenTPMFetch]
@Plant as Integer,
@Line as Integer
AS
	if @Line > 0
	BEGIN
	SELECT * FROM wAppWorkOrder.OpenTPMReport
	WHERE PNID = @Plant AND MLID = @Line AND (DISCloseDate IS NULL)
	END

	if @Line = -1
	BEGIN
	SELECT * FROM wAppWorkOrder.OpenTPMReport
	WHERE PNID = @Plant AND (DISCloseDate IS NULL)
	END

	RETURN
GO
/****** Object:  Table [Team].[NOvertimeHours]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[NOvertimeHours](
	[OTID] [int] IDENTITY(1,1) NOT NULL,
	[OTDate] [date] NULL,
	[OTTeamMember] [int] NULL,
	[OTPayPeriod] [date] NOT NULL,
	[OTHMon1Reg] [decimal](18, 2) NOT NULL,
	[OTHTue1Reg] [decimal](18, 2) NOT NULL,
	[OTHWed1Reg] [decimal](18, 2) NOT NULL,
	[OTHThu1Reg] [decimal](18, 2) NOT NULL,
	[OTHFri1Reg] [decimal](18, 2) NOT NULL,
	[OTHSat1Reg] [decimal](18, 2) NOT NULL,
	[OTHSun1Reg] [decimal](18, 2) NULL,
	[OTSat1Vol] [bit] NULL,
	[OTSun1Vol] [bit] NULL,
	[OTLastChange] [datetime] NOT NULL,
	[OTLastEdit] [int] NOT NULL,
	[OTTCodeMon] [int] NULL,
	[OTTCodeTue] [int] NULL,
	[OTTCodeWed] [int] NULL,
	[OTTCodeThur] [int] NULL,
	[OTTCodeFri] [int] NULL,
	[OTTCodeSat] [int] NULL,
	[OTTCodeSun] [int] NULL,
 CONSTRAINT [PK_NOvertimeHours] PRIMARY KEY CLUSTERED 
(
	[OTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Team].[TimeCodes]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[TimeCodes](
	[TCID] [int] IDENTITY(1,1) NOT NULL,
	[TCName] [nvarchar](max) NULL,
	[TCCode] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  View [wAppTeam].[OvertimeOneView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTeam].[OvertimeOneView]
AS
SELECT     Team.teammembers.TMFirstName, Team.teammembers.TMLastName, Team.teammembers.TMShift, Team.teammembers.TMPhone, 
                      Team.teammembers.TMRadioNumber, Team.teammembers.TMImage, Team.teammembers.TMArea, Team.teammembers.TMUserName, 
                      Team.teammembers.TMSecurityLevel, Team.teammembers.TMLastThree, Team.teammembers.TMHireDate, Team.teammembers.TMID, 
                      Team.teammembers.TMGROUPLINK, Team.teammembers.TMEmpNumber, Team.teammembers.TMNShift, Team.teammembers.TMDEPARTMENTLINK, 
                      Team.teammembers.TMPLANTLINK, Team.NOvertimeHours.OTID, Team.NOvertimeHours.OTDate, Team.NOvertimeHours.OTTeamMember, 
                      Team.NOvertimeHours.OTPayPeriod, Team.NOvertimeHours.OTHMon1Reg, Team.NOvertimeHours.OTHTue1Reg, 
                      Team.NOvertimeHours.OTHWed1Reg, Team.NOvertimeHours.OTHThu1Reg, Team.NOvertimeHours.OTHFri1Reg, Team.NOvertimeHours.OTHSat1Reg, 
                      Team.NOvertimeHours.OTHSun1Reg, Team.NOvertimeHours.OTSat1Vol, Team.NOvertimeHours.OTSun1Vol, Team.NOvertimeHours.OTLastChange, 
                      Team.NOvertimeHours.OTLastEdit, Team.NOvertimeHours.OTTCodeMon, Team.NOvertimeHours.OTTCodeTue, Team.NOvertimeHours.OTTCodeWed, 
                      Team.NOvertimeHours.OTTCodeThur, Team.NOvertimeHours.OTTCodeFri, Team.NOvertimeHours.OTTCodeSat, Team.NOvertimeHours.OTTCodeSun, 
                      Team.TimeCodes.TCID AS TCMonID, Team.TimeCodes.TCName AS TCMonName, Team.TimeCodes.TCCode AS TCMonCode, 
                      TimeCodes_1.TCID AS TCTueID, TimeCodes_1.TCName AS TCTueName, TimeCodes_1.TCCode AS TCTueCode, TimeCodes_2.TCID AS TCWedID, 
                      TimeCodes_2.TCName AS TCWedName, TimeCodes_2.TCCode AS TCWedCode, TimeCodes_3.TCID AS TCThurID, 
                      TimeCodes_3.TCName AS TCThurName, TimeCodes_3.TCCode AS TCThurCode, TimeCodes_5.TCID AS TCFriID, TimeCodes_5.TCName AS TCFriName, 
                      TimeCodes_5.TCCode AS TCFriCode, TimeCodes_6.TCID AS TCSatID, TimeCodes_6.TCName AS TCSatName, TimeCodes_6.TCCode AS TCSatCode, 
                      TimeCodes_4.TCID AS TCSunID, TimeCodes_4.TCName AS TCSunName, TimeCodes_4.TCCode AS TCSunCode
FROM         Team.TimeCodes RIGHT OUTER JOIN
                      Team.NOvertimeHours ON Team.TimeCodes.TCID = Team.NOvertimeHours.OTTCodeMon LEFT OUTER JOIN
                      Team.teammembers ON Team.NOvertimeHours.OTTeamMember = Team.teammembers.TMID LEFT OUTER JOIN
                      Team.TimeCodes AS TimeCodes_1 ON Team.NOvertimeHours.OTTCodeTue = TimeCodes_1.TCID LEFT OUTER JOIN
                      Team.TimeCodes AS TimeCodes_2 ON Team.NOvertimeHours.OTTCodeWed = TimeCodes_2.TCID LEFT OUTER JOIN
                      Team.TimeCodes AS TimeCodes_5 ON Team.NOvertimeHours.OTTCodeFri = TimeCodes_5.TCID LEFT OUTER JOIN
                      Team.TimeCodes AS TimeCodes_3 ON Team.NOvertimeHours.OTTCodeThur = TimeCodes_3.TCID LEFT OUTER JOIN
                      Team.TimeCodes AS TimeCodes_6 ON Team.NOvertimeHours.OTTCodeSat = TimeCodes_6.TCID LEFT OUTER JOIN
                      Team.TimeCodes AS TimeCodes_4 ON Team.NOvertimeHours.OTTCodeSun = TimeCodes_4.TCID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[40] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TimeCodes (Team)"
            Begin Extent = 
               Top = 13
               Left = 552
               Bottom = 113
               Right = 812
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "NOvertimeHours (Team)"
            Begin Extent = 
               Top = 0
               Left = 259
               Bottom = 257
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "teammembers (Team)"
            Begin Extent = 
               Top = 0
               Left = 38
               Bottom = 257
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TimeCodes_1"
            Begin Extent = 
               Top = 19
               Left = 1223
               Bottom = 119
               Right = 1375
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TimeCodes_2"
            Begin Extent = 
               Top = 61
               Left = 1225
               Bottom = 161
               Right = 1377
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TimeCodes_5"
            Begin Extent = 
               Top = 103
               Left = 1223
               Bottom = 203
               Right = 1375
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TimeCodes_3"
            Begin Extent = 
               Top = 142
               Left = 1221
               Bottom = 242
               Right ' , @level0type=N'SCHEMA',@level0name=N'wAppTeam', @level1type=N'VIEW',@level1name=N'OvertimeOneView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'= 1373
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TimeCodes_6"
            Begin Extent = 
               Top = 183
               Left = 1223
               Bottom = 283
               Right = 1375
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TimeCodes_4"
            Begin Extent = 
               Top = 221
               Left = 1225
               Bottom = 321
               Right = 1377
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 61
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 3195
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTeam', @level1type=N'VIEW',@level1name=N'OvertimeOneView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppTeam', @level1type=N'VIEW',@level1name=N'OvertimeOneView'
GO
/****** Object:  StoredProcedure [wAppTeam].[OvertimeOneFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[OvertimeOneFetch]
@Userid as Integer,
@PayPeriod as Date
AS


	SELECT * FROM wAppTeam.OverTimeOneView
	WHERE OTTeamMember = @Userid AND OTPayPeriod = @PayPeriod


	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[OTVolFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[OTVolFetch]
	
	(
		@Plant integer,
		@Shift Integer,
		@Date Date
	)
	
AS
	
		SELECT TMFirstName, TMLastName, TMShift, TMPlantLink, OTSat1Vol, OTSun1Vol, OTPayPeriod
		FROM wAppTeam.OvertimeOneView
		WHERE TMPlantLink = @Plant AND TMShift = @Shift AND OTPayPeriod = @Date

	RETURN
GO
/****** Object:  Table [EQP].[IPTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[IPTable](
	[IPTID] [int] IDENTITY(1,1) NOT NULL,
	[IPTFirstOct] [int] NULL,
	[IPTSecOct] [int] NULL,
	[IPTThirdOct] [int] NULL,
	[IPTFourthOct] [int] NULL,
	[IPTDescription] [nvarchar](255) NULL,
	[IPTLocation] [int] NULL,
	[IPTIPText] [nvarchar](255) NULL,
	[IPTHostName] [nvarchar](255) NULL,
	[IPTSubNet] [nvarchar](255) NULL,
	[IPEQPTYPELINK] [int] NULL,
	[IPVENDORLINK] [int] NULL,
	[IPWakeUpGroup] [int] NULL,
	[IPTDGLink] [int] NULL,
	[IPTempHost] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [EQP].[EquipmentModelNumber]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[EquipmentModelNumber](
	[EQModID] [int] IDENTITY(1,1) NOT NULL,
	[EQModModelNumber] [nvarchar](255) NULL,
	[EQModManID] [int] NULL,
	[EQModDescription] [nvarchar](255) NULL,
	[EQModVendorID] [int] NULL,
	[EQModOrderNumber] [nvarchar](255) NULL,
	[EQModImageOne] [image] NULL,
	[EQModGroupLink] [int] NULL,
	[EQModGroupTier] [int] NULL,
	[EQAddressable] [bit] NULL,
 CONSTRAINT [PK_EquipmentModelNumber] PRIMARY KEY CLUSTERED 
(
	[EQModID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [EQP].[Equipment]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[Equipment](
	[EQNote] [nvarchar](max) NULL,
	[EQTModelLink] [int] NULL,
	[EQTID] [int] IDENTITY(1,1) NOT NULL,
	[EQTPrintNumber] [nvarchar](255) NULL,
	[EQInService] [bit] NULL,
	[EQServiceDate] [date] NULL,
	[EQSerialNumber] [nvarchar](100) NULL,
	[EQPlant] [int] NULL,
	[EQTIDold] [int] NULL,
	[EQTDescription] [nvarchar](max) NULL,
	[EQTIdleLocation] [int] NULL,
 CONSTRAINT [PK_Equipment] PRIMARY KEY CLUSTERED 
(
	[EQTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [wAppEQP].[ProcView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppEQP].[ProcView]
AS
SELECT     wACom.MachineList.MLCELLNAME, wACom.MachineList.MLPlantID, wACom.MachineList.MLLINEID, EquipmentModelNumber_1.EQModModelNumber, 
                      EquipmentModelNumber_1.EQModManID, EquipmentModelNumber_1.EQModDescription, EquipmentModelNumber_1.EQModVendorID, 
                      EquipmentModelNumber_1.EQModOrderNumber, EquipmentModelNumber_1.EQModImageOne, EquipmentModelNumber_1.EQModID, 
                      wACom.MachineList.MLID, EQP.ProcNumbers.PROCNUMBER, EQP.ProcNumbers.PROCNAME, EQP.ProcNumbers.PROCASSET, 
                      EQP.ProcNumbers.PROCARG, EQP.ProcNumbers.PROCMODEL, EQP.ProcNumbers.PROCQUARTGROUP, EQP.ProcNumbers.PROCSEMIGROUP, 
                      EQP.ProcNumbers.PROCANUALGROUP, EQP.ProcNumbers.PROCMONTHGROUP, EQP.ProcNumbers.PROCWEEKGROUP, EQP.ProcNumbers.PROCID, 
                      EQP.ProcNumbers.PROCBIMONTHGROUP, EQP.ProcNumbers.PROCTWOYRGRUP, EQP.ProcNumbers.PROCEIGHTYRGROUP, 
                      EQP.ProcNumbers.PROCFOURYRGROUP, EQP.ProcNumbers.PROCTHREEYRGROUP, EQP.ProcNumbers.PROCASSIGNTO, 
                      wACom.TeamListDrop.Myname, EQP.ProcNumbers.PROCIPLINK, wACom.Lines.LILineName, wACom.Lines.LISatellite, wACom.Lines.LIID, 
                      wACom.Areas.AAareaname, wACom.Areas.AAID, wACom.Areas.AAPlant, EQP.ProcNumbers.PROCACTIVE, EQP.Equipment.EQNote, 
                      EQP.Equipment.EQTID, EQP.Equipment.EQTPrintNumber, EQP.Equipment.EQInService, EQP.Equipment.EQServiceDate, 
                      EQP.Equipment.EQSerialNumber, EQP.Equipment.EQTModelLink, EQP.EquipmentModelNumber.EQModModelNumber AS AssetModNumber, 
                      EQP.EquipmentModelNumber.EQModDescription AS AssetDescription, EQP.ProcNumbers.PROCASSETASSIGNABLE, EQP.IPTable.IPTIPText
FROM         EQP.Equipment LEFT OUTER JOIN
                      EQP.EquipmentModelNumber ON EQP.Equipment.EQTModelLink = EQP.EquipmentModelNumber.EQModID RIGHT OUTER JOIN
                      EQP.IPTable RIGHT OUTER JOIN
                      EQP.ProcNumbers ON EQP.IPTable.IPTID = EQP.ProcNumbers.PROCIPLINK ON 
                      EQP.Equipment.EQTID = EQP.ProcNumbers.PROCASSET LEFT OUTER JOIN
                      wACom.TeamListDrop ON EQP.ProcNumbers.PROCASSIGNTO = wACom.TeamListDrop.TMID LEFT OUTER JOIN
                      EQP.EquipmentModelNumber AS EquipmentModelNumber_1 ON 
                      EQP.ProcNumbers.PROCMODEL = EquipmentModelNumber_1.EQModID LEFT OUTER JOIN
                      wACom.Lines LEFT OUTER JOIN
                      wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID RIGHT OUTER JOIN
                      wACom.MachineList ON wACom.Lines.LIID = wACom.MachineList.MLLINEID ON EQP.ProcNumbers.PROCARG = wACom.MachineList.MLID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[42] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 9
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -96
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Equipment (EQP)"
            Begin Extent = 
               Top = 63
               Left = 560
               Bottom = 292
               Right = 740
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "EquipmentModelNumber (EQP)"
            Begin Extent = 
               Top = 63
               Left = 797
               Bottom = 192
               Right = 1004
            End
            DisplayFlags = 344
            TopColumn = 1
         End
         Begin Table = "IPTable (EQP)"
            Begin Extent = 
               Top = 120
               Left = 700
               Bottom = 318
               Right = 889
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 33
               Left = 41
               Bottom = 336
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "TeamListDrop (wACom)"
            Begin Extent = 
               Top = 267
               Left = 350
               Bottom = 396
               Right = 520
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "EquipmentModelNumber_1"
            Begin Extent = 
               Top = 5
               Left = 285
               Bottom = 134
               Right = 492
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 4
               Left = 697
               Bottom = 133' , @level0type=N'SCHEMA',@level0name=N'wAppEQP', @level1type=N'VIEW',@level1name=N'ProcView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
               Right = 868
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Areas (wACom)"
            Begin Extent = 
               Top = 1
               Left = 914
               Bottom = 166
               Right = 1084
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 5
               Left = 496
               Bottom = 134
               Right = 666
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2250
         Alias = 3690
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppEQP', @level1type=N'VIEW',@level1name=N'ProcView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppEQP', @level1type=N'VIEW',@level1name=N'ProcView'
GO
/****** Object:  StoredProcedure [wAppEQP].[ProcNumberFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ProcNumberFetch]



AS
	SELECT * FROM wAppEQP.PROCVIEW
	WHERE PROCACTIVE = 1
	RETURN

	-- Forms Using
	-- Scheduling System in Champs Program
	-- Robot Control in Network Program
GO
/****** Object:  StoredProcedure [DT].[sprocTopFiveDowntimesSecond]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[sprocTopFiveDowntimesSecond]
	@SatAssign Integer= 0,
	@EarlyDate datetime = '3/1/2012',
	@LateDate datetime = '3/30/2012' ,
	@StartTime nVarChar(100) = '3/1/2012 18:00:00',
	@EndTime nVarChar(100) = '3/1/2012 05:00:00'
	

AS
DECLARE @StartDate Datetime;
DECLARE @EndDate Datetime;



SELECT TOP 5
	DTLine,
	DTMalfunction,
	DTsolution,
	TotalTime,
	DTNDateDown,
	DTNTimeDown,
	MLCellName

FROM
	wAppDT.Downtime_MainFormView 
WHERE
	AAID = @SatAssign
	AND DTNDateDown BETWEEN @EarlyDate and @LateDate
	AND (
			DatePart(Hour,DTNTimeDown) BETWEEN DatePart(Hour,Convert(DateTime,@StartTime)) AND 23 
			OR
			DATEPart(Hour,DTNTimeDown) BETWEEN 0 AND DatePart(Hour,Convert(DateTime,@EndTime)))
	


Order By TotalTime DESC


RETURN
GO
/****** Object:  StoredProcedure [DT].[sprocTopFiveDowntimes]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[sprocTopFiveDowntimes]

	@SatAssign Integer= 0,
	@EarlyDate datetime = '3/1/2012',
	@LateDate datetime = '3/30/2012' ,
	@StartTime nVarChar(100) = '3/1/2012 05:00:00',
	@EndTime nVarChar(100) = '3/1/2012 15:00:00'
	

AS




SELECT TOP 5
	DTLine,
	DTMalfunction,
	DTsolution,
	TotalTime,
	DTNDateDown,
	DTNTimeDown,
	MLCellName

FROM
	wAppDT.Downtime_MainFormView 
WHERE
	AAID = @SatAssign
	AND DTNDateDown BETWEEN @EarlyDate and @LateDate
	AND DatePart(Hour,DTNTimeDown) BETWEEN DatePart(Hour,Convert(DateTime,@StartTime)) AND DatePart(Hour,Convert(DateTime,@EndTime))
	


Order By TotalTime DESC


RETURN
GO
/****** Object:  StoredProcedure [DT].[sprocForteenDayTrackSecond]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[sprocForteenDayTrackSecond]

	@EarlyDate datetime = '5/2/2012 05:01:00',
	@LateDate datetime = '5/2/2012 17:00:00',
	@StartTime nVarChar(100) = '5/10/2012 18:00:00',
	@EndTime nVarChar(100) = '5/10/2012 05:00:00'

AS
/*
Returns the downtime values per shift.

Feed the early date as the start of the shift and the late as the end.

Shift times for 3/1/2011

****  PRODUCTION SHIFTS *****
1st
03/1/2011 05:01:00 - 03/15/2011 17:00:00

2nd
03/01/2011 17:01:00 - 03/16/2011 05:00:00



*/


SET @EarlyDate = (CONVERT(datetime,	CONVERT(date,@EarlyDate,(0)),(0)) + CONVERT(time,@StartTime,(0)))
SET @LateDate =  (CONVERT(datetime, CONVERT(date,DateAdd(Day,1,@LateDate), (0)),(0)) + CONVERT(time,@EndTime,(0)))

SELECT
     MLLINEID[LineID],
	 [1],
	 [2],
	 [3],
	 [4],
	 [5],
	 [6],
	 [7],
	 [8],
	 [9],
	 [10],
	 [11],
	 [12],
	 [15],
	 [16],
	 [17],
	 [18],
	 [19]

FROM 
    (
		SELECT
			MLLINEID,
			DTResponsibility,
			TotalTime

		FROM
		    wAppDT.Downtime_MainFormView 
        WHERE
			NOT (MLLINEID IS NULL)
			AND (Convert(DATETIME,Convert(date,DTNDateDown,(0)),(0)) + Convert(time,DTNTimeDown,(0))) BETWEEN Convert(Date,@EarlyDate) and Convert(Date,@LateDate) AND MLPlantID = 1

	 ) AS D 
PIVOT	(
			SUM
				(TotalTime) 
			FOR
				DTResponsibility IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [15], [16], [17], [18], [19])
		) AS SomeTable;





	RETURN
GO
/****** Object:  StoredProcedure [DT].[sprocForteenDayTrack]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[sprocForteenDayTrack]
 
	@EarlyDate datetime = '5/10/2012 05:01:00',
	@LateDate datetime = '5/10/2012 17:00:00',
	@StartTime nVarChar(100) = '5/10/2012 05:00:00',
	@EndTime nVarChar(100) = '5/10/2012 15:00:00'

AS
/*
Returns the downtime values per shift.

Feed the early date as the start of the shift and the late as the end.

Shift times for 3/1/2011

****  PRODUCTION SHIFTS *****
1st
03/1/2011 05:01:00 - 03/15/2011 17:00:00

2nd
03/01/2011 17:01:00 - 03/16/2011 05:00:00



*/


SELECT
     MLLINEID[LineID],
	 [1],
	 [2],
	 [3],
	 [4],
	 [5],
	 [6],
	 [7],
	 [8],
	 [9],
	 [10],
	 [11],
	 [12],
	 [15],
	 [16],
	 [17],
	 [18],
	 [19]

FROM 
    (
		SELECT
			MLLINEID,
			DTResponsibility,
			TotalTime

		FROM
		    wAppDT.Downtime_MainFormView 
        WHERE
			NOT (MLLINEID IS NULL)
			AND DTNDateDown BETWEEN Convert(Date,@EarlyDate) and Convert(Date,@LateDate)
			AND DatePart(Hour,DTNTimeDown) BETWEEN DatePart(Hour,Convert(DateTime,@StartTime)) AND DatePart(Hour,Convert(DateTime,@EndTime))  AND MLPlantID = 1
	 ) AS D 
PIVOT	(
			SUM
				(TotalTime) 
			FOR
				DTResponsibility IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [15], [16], [17], [18], [19])
		) AS SomeTable;





	RETURN
GO
/****** Object:  Table [WO].[WorkOrderUtilization]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WO].[WorkOrderUtilization](
	[WOUTID] [int] IDENTITY(1,1) NOT NULL,
	[WOUTMID] [int] NOT NULL,
	[WOUMin] [int] NOT NULL,
	[WODISID] [int] NOT NULL,
 CONSTRAINT [PK_WorkOrderUtilization] PRIMARY KEY CLUSTERED 
(
	[WOUTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [wAppWorkOrder].[WorkOrderUtilizationView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppWorkOrder].[WorkOrderUtilizationView]
AS
SELECT     Team.teammembers.TMFirstName, Team.teammembers.TMLastName, WO.WorkOrderUtilization.WOUMin, WO.WorkOrderUtilization.WOUTMID, 
                      WO.WorkOrderUtilization.WOUTID, WO.WorkOrderUtilization.WODISID, WO.WorkOrderMain.DISID, WO.WorkOrderMain.DISOpenDate, 
                      WO.WorkOrderMain.DISCloseDate, WO.WorkOrderMain.DISWorkRequired, WO.WorkOrderMain.DISNumberAss, WO.WorkOrderMain.DISManHours, 
                      WO.WorkOrderMain.DISWorkAccomp, WO.WorkOrderMain.DISLineNumber, WO.WorkOrderMain.DISEquip, WO.WorkOrderMain.DISDueDate, 
                      WO.WorkOrderMain.DISOriginator, WO.WorkOrderMain.DISResponsible, WO.WorkOrderMain.DISType, WO.WorkOrderMain.DISRequestor, 
                      WO.WorkOrderMain.DISOpenItemNumber, WO.WorkOrderMain.DISTPMNumber, wACom.MachineList.MLCELLNAME, wACom.MachineList.MLPlantID, 
                      wACom.MachineList.MLLINEID, wACom.Lines.LILineName, wACom.Lines.LIPlant, Team.wAPlants.PNID
FROM         wACom.Lines LEFT OUTER JOIN
                      Team.wAPlants ON wACom.Lines.LIPlant = Team.wAPlants.PNID RIGHT OUTER JOIN
                      wACom.MachineList ON wACom.Lines.LIID = wACom.MachineList.MLLINEID RIGHT OUTER JOIN
                      WO.WorkOrderMain ON wACom.MachineList.MLID = WO.WorkOrderMain.DISLineNumber RIGHT OUTER JOIN
                      WO.WorkOrderUtilization ON WO.WorkOrderMain.DISID = WO.WorkOrderUtilization.WODISID RIGHT OUTER JOIN
                      Team.teammembers ON WO.WorkOrderUtilization.WOUTMID = Team.teammembers.TMID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[45] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 128
               Left = 613
               Bottom = 340
               Right = 767
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 128
               Left = 383
               Bottom = 325
               Right = 534
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "WorkOrderMain (WO)"
            Begin Extent = 
               Top = 0
               Left = 24
               Bottom = 254
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WorkOrderUtilization (WO)"
            Begin Extent = 
               Top = 242
               Left = 586
               Bottom = 453
               Right = 738
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "teammembers (Team)"
            Begin Extent = 
               Top = 243
               Left = 881
               Bottom = 494
               Right = 1064
            End
            DisplayFlags = 344
            TopColumn = 9
         End
         Begin Table = "wAPlants (Team)"
            Begin Extent = 
               Top = 128
               Left = 823
               Bottom = 221
               Right = 974
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin C' , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'WorkOrderUtilizationView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'olumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'WorkOrderUtilizationView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'WorkOrderUtilizationView'
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[woUtilizationView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[woUtilizationView]
	
	(
		@Start Date,
		@Finish Date,
		@Plant Integer

	)
	
AS
	SELECT * FROM wAppWorkOrder.WorkOrderUtilizationView
		WHERE PNID = @Plant AND DISCloseDate BETWEEN @Start and @Finish


	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[WorkOrderUtilizationFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[WorkOrderUtilizationFetch]

	@woNum Integer
	
AS
	
		SELECT * FROM wAppWorkOrder.WorkOrderUtilizationView
				WHERE WODISID = @woNum

	RETURN
GO
/****** Object:  Table [SEC].[AccessTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SEC].[AccessTable](
	[ATID] [int] IDENTITY(1,1) NOT NULL,
	[ATUID] [int] NOT NULL,
	[ATTeamAccess] [bit] NULL,
	[ATTeamManage] [bit] NULL,
	[ATTeamSecLevel] [bit] NULL,
	[ATTTeamAccessForm] [bit] NULL,
	[ATTTpmRibbonButton] [bit] NULL,
	[ATOpenItemRibbonButton] [bit] NULL,
	[ATDowntime] [bit] NULL,
	[ATDocumentation] [bit] NULL,
	[ATWorkOrders] [bit] NULL,
	[ATPartTracking] [bit] NULL,
	[ATDown_Add] [bit] NULL,
	[ATDown_OpenItem] [bit] NULL,
	[ATDown_WorkOrder] [bit] NULL,
	[ATDown_Delete] [bit] NULL,
	[ATOvertimeEdit] [bit] NULL,
	[ATDocEdit] [bit] NULL,
	[ATTeamReports] [bit] NULL,
	[ATTeamBuildButton] [bit] NULL,
	[ATOvertimeManage] [bit] NULL,
	[ATTeamBuildSuper] [bit] NULL,
	[wATPMMenu] [bit] NULL,
	[wAOIMenu] [bit] NULL,
	[wATeamMenu] [bit] NULL,
	[wAWOMenu] [bit] NULL,
	[wADocMenu] [bit] NULL,
	[wADTMenu] [bit] NULL,
	[wAEcoMenu] [bit] NULL,
	[wAPartsMenu] [bit] NULL,
	[wATeam_Builder] [bit] NULL,
	[wATeam_Builder_Supervisor] [bit] NULL,
	[wATeam_Overtime] [bit] NULL,
	[wATeam_Overtime_Supervisor] [bit] NULL,
	[wATeam_Security] [bit] NULL,
	[wATeam_Security_Supervisor] [bit] NULL,
	[wATeam_Reports] [bit] NULL,
	[wATPM_OpenWO_Editor] [bit] NULL,
	[wABeta] [bit] NULL,
	[wADocAdd] [bit] NULL,
	[waWeld_Menu] [bit] NULL,
	[waWeld_Edit] [bit] NULL,
	[waWeld_Supervisor] [bit] NULL,
 CONSTRAINT [PK_AccessTable] PRIMARY KEY CLUSTERED 
(
	[ATID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Used for the team builder page, this will allow supervisors to edit any users in thier plant. No security edits on these pages.' , @level0type=N'SCHEMA',@level0name=N'SEC', @level1type=N'TABLE',@level1name=N'AccessTable', @level2type=N'COLUMN',@level2name=N'ATTeamBuildSuper'
GO
/****** Object:  StoredProcedure [Team].[winAppTeamUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Team].[winAppTeamUpdate]
@TMID						integer,
@wATPMMenu					bit,
@wAOIMenu					bit,
@wATeamMenu					bit,
@wAWOMenu					bit,
@wADocMenu					bit,
@wADTMenu					bit,
@wAEcoMenu					bit,
@wAPartsMenu				bit,
@wATeam_Builder				bit,
@wATeam_Builder_Supervisor	bit,
@wATeam_Overtime			bit,
@wATeam_Overtime_Supervisor	bit,
@wATeam_Security			bit,
@wATeam_Security_Supervisor	bit,
@wATeam_Reports				bit,
@waOpenWO					bit,
@waDocAdd					bit







AS


	Update Sec.AccessTable
	SET 
	wATPMMenu					=		@wATPMMenu,
	wAOIMenu					=		@wAOIMenu,
	wATeamMenu					=		@wATeamMenu ,
	wAWOMenu					=		@wAWOMenu ,
	wADocMenu					=		@wADocMenu ,
	wADTMenu					=		@wADTMenu ,
	wAEcoMenu					=		@wAEcoMenu ,
	wAPartsMenu					=		@wAPartsMenu ,
	wATeam_Builder				=		@wATeam_Builder ,
	wATeam_Builder_Supervisor	=		@wATeam_Builder_Supervisor ,
	wATeam_Overtime				=		@wATeam_Overtime ,
	wATeam_Overtime_Supervisor	=		@wATeam_Overtime_Supervisor ,
	wATeam_Security				=		@wATeam_Security,
	wATeam_Security_Supervisor	=		@wATeam_Security_Supervisor ,
	wATeam_Reports				=		@wATeam_Reports	 ,
	wATPM_OpenWO_Editor			=		@waOpenWO,
	wADocAdd					=		@waDocAdd

	WHERE ATUID = @TMID;



	RETURN
GO
/****** Object:  Table [WO].[WorkOrderCodes]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WO].[WorkOrderCodes](
	[WOCName] [nvarchar](255) NULL,
	[WOCID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_WorkOrderCodes] PRIMARY KEY CLUSTERED 
(
	[WOCID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [wACom].[TeamListDropMirror]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wACom].[TeamListDropMirror]
AS
SELECT     Team.teammembers.TMFirstName + N' ' + Team.teammembers.TMLastName AS Myname, Team.teammembers.TMLastName, 
                      Team.teammembers.TMID, Team.wAPlants.PNID
FROM         Team.teammembers LEFT OUTER JOIN
                      Team.wAPlants ON Team.teammembers.TMPLANTLINK = Team.wAPlants.PNID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 12
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "teammembers (Team)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 240
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "wAPlants (Team)"
            Begin Extent = 
               Top = 93
               Left = 355
               Bottom = 271
               Right = 506
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'TeamListDropMirror'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'TeamListDropMirror'
GO
/****** Object:  View [WO].[winAppMainWOView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [WO].[winAppMainWOView]
AS
SELECT     WO.WorkOrderMain.DISOpenDate, WO.WorkOrderMain.DISCloseDate, WO.WorkOrderMain.DISWorkRequired, WO.WorkOrderMain.DISNumberAss, 
                      WO.WorkOrderMain.DISManHours, WO.WorkOrderMain.DISWorkAccomp, WO.WorkOrderMain.DISLineNumber, WO.WorkOrderMain.DISEquip, 
                      WO.WorkOrderMain.DISDueDate, WO.WorkOrderMain.DISOriginator, WO.WorkOrderMain.DISResponsible, WO.WorkOrderMain.DISType, 
                      WO.WorkOrderMain.DISRequestor, WO.WorkOrderMain.DISOpenItemNumber, WO.WorkOrderMain.DISTPMNumber, WO.WorkOrderMain.DISID, 
                      WO.WorkOrderMain.DISIntHold, WO.WorkOrderMain.DISCharHold, wACom.MachineList.MLCELLNAME, wACom.MachineList.MLLINEID, 
                      wACom.MachineList.MLID, wACom.MachineList.MLPlantID, wACom.Lines.LILineName, wACom.Lines.LISatellite, wACom.Lines.LIPlannerGroup, 
                      wACom.Lines.LIID, wACom.Lines.LIPlant, wACom.TeamListDrop.Myname, wACom.TeamListDrop.TMID, 
                      wACom.TeamListDropMirror.Myname AS RespName, wACom.TeamListDropMirror.TMID AS RespID, WO.WorkOrderCodes.WOCName, 
                      WO.WorkOrderCodes.WOCID, EQP.ProcNumbers.PROCID, EQP.ProcNumbers.PROCNUMBER, COM.ResponsibleParty.RPName, 
                      COM.ResponsibleParty.RPID
FROM         WO.WorkOrderMain INNER JOIN
                      wACom.MachineList ON WO.WorkOrderMain.DISLineNumber = wACom.MachineList.MLID INNER JOIN
                      wACom.Lines ON wACom.MachineList.MLLINEID = wACom.Lines.LIID LEFT OUTER JOIN
                      COM.ResponsibleParty ON WO.WorkOrderMain.DISResponsible = COM.ResponsibleParty.RPID LEFT OUTER JOIN
                      WO.WorkOrderCodes ON WO.WorkOrderMain.DISType = WO.WorkOrderCodes.WOCID LEFT OUTER JOIN
                      EQP.ProcNumbers ON WO.WorkOrderMain.DISEquip = EQP.ProcNumbers.PROCID LEFT OUTER JOIN
                      wACom.TeamListDropMirror ON WO.WorkOrderMain.DISRequestor = wACom.TeamListDropMirror.TMID LEFT OUTER JOIN
                      wACom.TeamListDrop ON WO.WorkOrderMain.DISOriginator = wACom.TeamListDrop.TMID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[55] 4[12] 2[26] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WorkOrderMain (WO)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 353
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 265
               Bottom = 231
               Right = 436
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 12
               Left = 467
               Bottom = 238
               Right = 622
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ResponsibleParty (COM)"
            Begin Extent = 
               Top = 328
               Left = 507
               Bottom = 460
               Right = 659
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "WorkOrderCodes (WO)"
            Begin Extent = 
               Top = 190
               Left = 787
               Bottom = 323
               Right = 939
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 84
               Left = 442
               Bottom = 275
               Right = 632
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TeamListDropMirror (wACom)"
            Begin Extent = 
               Top = 4
               Left = 938
               Bottom ' , @level0type=N'SCHEMA',@level0name=N'WO', @level1type=N'VIEW',@level1name=N'winAppMainWOView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'= 180
               Right = 1200
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TeamListDrop (wACom)"
            Begin Extent = 
               Top = 9
               Left = 675
               Bottom = 186
               Right = 852
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 38
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1965
         Table = 2910
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'WO', @level1type=N'VIEW',@level1name=N'winAppMainWOView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'WO', @level1type=N'VIEW',@level1name=N'winAppMainWOView'
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[WOMainFetchSingle]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [wAppWorkOrder].[WOMainFetchSingle]
@PlantID as Integer,
@DISID as Integer
AS

	Select * FROM WO.winAppMainWOView
	WHERE MLPlantID = @PlantID AND DISID = @DISID


	RETURN
GO
/****** Object:  StoredProcedure [WO].[winAppSPWOMainSingle]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[winAppSPWOMainSingle]
@PlantID as Integer,
@DISID as Integer
AS

	Select * FROM WO.winAppMainWOView
	WHERE MLPlantID = @PlantID AND DISID = @DISID


	RETURN
GO
/****** Object:  StoredProcedure [WO].[winAppSPWOMain]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[winAppSPWOMain]
@PlantID as Integer
AS

	Select * FROM WO.winAppMainWOView
	WHERE MLPlantID = @PlantID
	ORDER BY DISID


	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[topSomethingReport]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[topSomethingReport]
	
	(
		@toplevel int = 5,
		@DateStart date = '5/10/2012',
		@DateEnd date = '5/10/2012',
		@Line integer = 0,
		@Cell Integer = 0,
		@Plant Integer = 0,
		@nameFilter nVarChar(max) = '%',
		@genFilter nVarChar(max) = '%',
		@TimeStart nVarChar(50) = '06:00:00',
		@TimeEnd nVarChar(50) = '18:00:00'
	)
	
AS
	DECLARE @combStart DateTime;
	DECLARE @combEnd DateTime;

	SET @combStart = (CONVERT(datetime,CONVERT(date,@DateStart,(0)),(0)) +	CONVERT(time,@TimeStart,(0)))
	
    SET @combEnd =   (CONVERT(datetime, CONVERT(date,@DateEnd ,(0)),(0)) +  CONVERT(time,@TimeEnd,(0)))

	--SET @combStart = CAST(CAST(@DateStart AS DATE) AS DATETIME) + CAST(@TimeStart as TIME);
	--SET @combEnd = CAST(CAST(@DateEnd AS DATE) AS DATETIME) + CAST(@TimeEnd as TIME);

	--CAST(CAST(your_date_column AS DATE) AS DATETIME) +     CAST(your_time_column AS TIME) 


	IF (@Line > 0) AND (@Cell > 0 or @Plant > 0)  RETURN;

	IF (@Cell > 0) AND (@Line > 0 or @Plant > 0) RETURN;

	IF (@Plant > 0) AND (@Cell > 0 or @Line > 0) RETURN;

	

	IF @Line > 0
		BEGIN
			
			SELECT TOP (@toplevel) * FROM wAppDT.Downtime_MainFormView
				WHERE (
						(Convert(DATETIME,Convert(date,DTNDateDown,(0)),(0)) + Convert(time,DTNTimeDown,(0))) BETWEEN @combStart and @combEnd
						AND LIID = @Line
						AND MyName Like @nameFilter
						AND (DTMalfunction Like @genFilter OR DTSolution Like @genFilter or DTlongTerm Like @GenFilter)
					  )
				ORDER BY TotalTime Desc

		END
	IF @Cell > 0
		BEGIN
			
			SELECT TOP (@toplevel) * FROM wAppDT.Downtime_MainFormView
				WHERE (
						(Convert(DATETIME,Convert(date,DTNDateDown,(0)),(0)) + Convert(time,DTNTimeDown,(0))) BETWEEN @combStart and @combEnd
						AND DTLine = @Cell  AND MyName Like @nameFilter AND (DTMalfunction Like @genFilter OR DTSolution Like @genFilter or DTlongTerm Like @GenFilter)
				      )
				ORDER BY TotalTime Desc

		END
	IF @Plant > 0
		BEGIN
			
			SELECT TOP (@toplevel) * FROM wAppDT.Downtime_MainFormView
				WHERE (
						(Convert(DATETIME,Convert(date,DTNDateDown,(0)),(0)) + Convert(time,DTNTimeDown,(0))) BETWEEN @combStart and @combEnd
				        AND MLPlantID = @Plant  AND MyName Like @nameFilter AND (DTMalfunction Like @genFilter OR DTSolution Like @genFilter or DTlongTerm Like @GenFilter)
					   )
				Order By TotalTime Desc

		END

	RETURN
GO
/****** Object:  View [wAppTPM].[TPMReport2]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTPM].[TPMReport2]
AS
SELECT     WO.WorkOrderMain.DISOpenDate, WO.WorkOrderMain.DISCloseDate, WO.WorkOrderMain.DISWorkRequired, WO.WorkOrderMain.DISNumberAss, 
                      WO.WorkOrderMain.DISManHours, WO.WorkOrderMain.DISWorkAccomp, WO.WorkOrderMain.DISLineNumber, WO.WorkOrderMain.DISEquip, 
                      WO.WorkOrderMain.DISDueDate, WO.WorkOrderMain.DISOriginator, WO.WorkOrderMain.DISResponsible, WO.WorkOrderMain.DISType, 
                      WO.WorkOrderMain.DISRequestor, WO.WorkOrderMain.DISOpenItemNumber, WO.WorkOrderMain.DISTPMNumber, WO.WorkOrderMain.DISID, 
                      WO.WorkOrderMain.DISIntHold, WO.WorkOrderMain.DISCharHold, WO.WorkOrderMain.DISAsset, wACom.TeamListDrop.Myname, 
                      wACom.TeamListDrop.TMID, wACom.MachineList.MLPlantID, wACom.MachineList.MLCELLNAME, EQP.ProcNumbers.PROCNUMBER, 
                      TPM.TPMProcdure.TPMProcTitle, TPM.TPMProcdure.TPMProcEstMin, TPM.TPMProcdure.TPMPRocNumTM, TPM.TPMProcdure.TPMProcID
FROM         WO.WorkOrderMain LEFT OUTER JOIN
                      TPM.TPMProcdure ON WO.WorkOrderMain.DISTPMNumber = TPM.TPMProcdure.TPMProcID LEFT OUTER JOIN
                      EQP.ProcNumbers ON WO.WorkOrderMain.DISEquip = EQP.ProcNumbers.PROCID LEFT OUTER JOIN
                      wACom.MachineList ON WO.WorkOrderMain.DISLineNumber = wACom.MachineList.MLID LEFT OUTER JOIN
                      wACom.TeamListDrop ON WO.WorkOrderMain.DISRequestor = wACom.TeamListDrop.TMID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WorkOrderMain (WO)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 257
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "TPMProcdure (TPM)"
            Begin Extent = 
               Top = 6
               Left = 778
               Bottom = 245
               Right = 962
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 4
               Left = 550
               Bottom = 254
               Right = 740
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 322
               Bottom = 210
               Right = 474
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TeamListDrop (wACom)"
            Begin Extent = 
               Top = 43
               Left = 296
               Bottom = 264
               Right = 448
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
     ' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'TPMReport2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'TPMReport2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'TPMReport2'
GO
/****** Object:  StoredProcedure [TPM].[ManpowerEstCurrent]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TPM].[ManpowerEstCurrent]



--@RecCount Integer OUTPUT

AS

SELECT * FROM wAppTPM.TPMReport2
WHERE DISType = 3
	AND DISCloseDate IS NULL



		return
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMReport1Fetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMReport1Fetch]

@Plant Integer,
@DateStart Date,
@DateStop Date
AS
	SELECT * FROM wAppTPM.TPMReport2
	WHERE MLPlantID = @Plant AND DISCloseDate BETWEEN @DateStart AND @DateStop AND DISType = 3

	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[TPMScheduleFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[TPMScheduleFetch]
	@plant int,
	@start date,
	@end	date,
	@shift int

AS

	if(@shift > 0)
	BEGIN
	
	SELECT * FROM wAppWorkOrder.OpenTPMReport
		WHERE PNID = @plant AND DISSchedDate BETWEEN @start AND @end AND DISSchedShift = @shift
	END

	ELSE
	BEGIN
		SELECT * FROM wAppWorkOrder.OpenTPMReport
		WHERE PNID = @plant AND DISSchedDate BETWEEN @start AND @end 

	END

	RETURN
GO
/****** Object:  Table [Team].[wAGroupNames]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[wAGroupNames](
	[GNID] [int] IDENTITY(1,1) NOT NULL,
	[GNNames] [nvarchar](50) NULL,
	[GNCode] [nchar](10) NULL,
	[GNDNCode] [int] NULL,
	[GNPlant] [int] NULL,
 CONSTRAINT [PK_wAGroupNames] PRIMARY KEY CLUSTERED 
(
	[GNID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Team].[waDepartments]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[waDepartments](
	[DNID] [int] IDENTITY(1,1) NOT NULL,
	[DNName] [nvarchar](50) NULL,
	[DNCode] [nchar](10) NULL,
	[DNPNLink] [int] NULL,
	[DNPlant] [int] NULL,
 CONSTRAINT [PK_waDepartments] PRIMARY KEY CLUSTERED 
(
	[DNID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Team].[WinAppTeamSecView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Team].[WinAppTeamSecView]
AS
SELECT     TOP (100) PERCENT Team.teammembers.TMFirstName, Team.teammembers.TMLastName, Team.teammembers.TMShift, Team.teammembers.TMPhone, 
                      Team.teammembers.TMRadioNumber, Team.teammembers.TMImage, Team.teammembers.TMArea, Team.teammembers.TMUserName, 
                      Team.teammembers.TMSecurityLevel, Team.teammembers.TMLastThree, Team.teammembers.TMHireDate, Team.teammembers.TMID, 
                      Team.teammembers.TMGROUPLINK, Team.teammembers.TMEmpNumber, Team.teammembers.TMNShift, SEC.AccessTable.ATID, SEC.AccessTable.ATUID, 
                      SEC.AccessTable.ATTeamAccess, SEC.AccessTable.ATTeamManage, SEC.AccessTable.ATTeamSecLevel, SEC.AccessTable.ATTTeamAccessForm, 
                      SEC.AccessTable.ATTTpmRibbonButton, SEC.AccessTable.ATOpenItemRibbonButton, SEC.AccessTable.ATDowntime, SEC.AccessTable.ATDocumentation, 
                      SEC.AccessTable.ATWorkOrders, SEC.AccessTable.ATPartTracking, SEC.AccessTable.ATDown_Add, SEC.AccessTable.ATDown_OpenItem, 
                      SEC.AccessTable.ATDown_WorkOrder, SEC.AccessTable.ATDown_Delete, SEC.AccessTable.ATOvertimeEdit, SEC.AccessTable.ATDocEdit, 
                      SEC.AccessTable.ATTeamReports, SEC.AccessTable.ATTeamBuildButton, Team.ShiftTable.STID, Team.ShiftTable.STShiftName, Team.ShiftTable.STTimeStart, 
                      Team.ShiftTable.STTimeEnd, Team.ShiftTable.STRotation, Team.teammembers.TMDEPARTMENTLINK, Team.teammembers.TMPLANTLINK, 
                      SEC.AccessTable.ATOvertimeManage, SEC.AccessTable.ATTeamBuildSuper, SEC.AccessTable.wATeam_Reports, SEC.AccessTable.wATeam_Security_Supervisor, 
                      SEC.AccessTable.wATeam_Security, SEC.AccessTable.wATeam_Overtime_Supervisor, SEC.AccessTable.wATeam_Overtime, 
                      SEC.AccessTable.wATeam_Builder_Supervisor, SEC.AccessTable.wATeam_Builder, SEC.AccessTable.wAPartsMenu, SEC.AccessTable.wAEcoMenu, 
                      SEC.AccessTable.wADTMenu, SEC.AccessTable.wADocMenu, SEC.AccessTable.wAWOMenu, SEC.AccessTable.wATeamMenu, SEC.AccessTable.wAOIMenu, 
                      SEC.AccessTable.wATPMMenu, Team.teammembers.TMFirstName + N' ' + Team.teammembers.TMLastName AS displayname, 
                      SEC.AccessTable.wATPM_OpenWO_Editor, Team.waDepartments.DNID, Team.waDepartments.DNName, Team.waDepartments.DNCode, 
                      Team.waDepartments.DNPNLink, Team.wAPlants.PNID, Team.wAPlants.PNName, Team.wAPlants.PNCode, wACom.Areas.AAareaname, wACom.Areas.AAID, 
                      wACom.Areas.AAPlant, wACom.Areas.AAareaphone, wACom.Areas.AAarealocation, Team.wAGroupNames.GNDNCode, Team.wAGroupNames.GNCode, 
                      Team.wAGroupNames.GNPlant, Team.wAGroupNames.GNID, Team.wAGroupNames.GNNames, SEC.AccessTable.wABeta, SEC.AccessTable.wADocAdd, 
                      Team.teammembers.TMWorkAssignment, Team.teammembers.TMEmail, Team.teammembers.TMPayStatus, Team.teammembers.TMProdUID, 
                      Team.teammembers.TMTitleLink
FROM         Team.wAGroupNames RIGHT OUTER JOIN
                      Team.teammembers ON Team.wAGroupNames.GNID = Team.teammembers.TMGROUPLINK LEFT OUTER JOIN
                      wACom.Areas ON Team.teammembers.TMArea = wACom.Areas.AAID LEFT OUTER JOIN
                      Team.wAPlants ON Team.teammembers.TMPLANTLINK = Team.wAPlants.PNID LEFT OUTER JOIN
                      Team.waDepartments ON Team.teammembers.TMDEPARTMENTLINK = Team.waDepartments.DNID LEFT OUTER JOIN
                      Team.ShiftTable ON Team.teammembers.TMNShift = Team.ShiftTable.STID LEFT OUTER JOIN
                      SEC.AccessTable ON Team.teammembers.TMID = SEC.AccessTable.ATUID
ORDER BY Team.teammembers.TMLastName
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[54] 4[27] 2[3] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "wAGroupNames (Team)"
            Begin Extent = 
               Top = 17
               Left = 989
               Bottom = 125
               Right = 1213
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "teammembers (Team)"
            Begin Extent = 
               Top = 0
               Left = 337
               Bottom = 444
               Right = 520
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Areas (wACom)"
            Begin Extent = 
               Top = 6
               Left = 691
               Bottom = 184
               Right = 910
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "wAPlants (Team)"
            Begin Extent = 
               Top = 119
               Left = 691
               Bottom = 219
               Right = 912
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "waDepartments (Team)"
            Begin Extent = 
               Top = 84
               Left = 690
               Bottom = 199
               Right = 908
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ShiftTable (Team)"
            Begin Extent = 
               Top = 155
               Left = 692
               Bottom = 270
               Right = 913
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "AccessTable (SEC)"
            Begin Extent = 
               Top = 40
               Left = 0
               Bottom = 430
        ' , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'VIEW',@level1name=N'WinAppTeamSecView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'       Right = 223
            End
            DisplayFlags = 280
            TopColumn = 21
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 55
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5955
         Alias = 2490
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'VIEW',@level1name=N'WinAppTeamSecView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'VIEW',@level1name=N'WinAppTeamSecView'
GO
/****** Object:  StoredProcedure [wAppTeam].[SecurityFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[SecurityFetch]

	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM TEAM.WinAppTeamSecView
	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[tempTopSomething]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[tempTopSomething]

	
	(
		@toplevel int = 5,
		@DateStart date = '1/1/1976',
		@DateEnd date = '1/1/1976',
		@Line integer = 0,
		@Cell Integer = 0,
		@Plant Integer = 0,
		@nameFilter nVarChar(max) = '%',
		@genFilter nVarChar(max) = '%',
		@TimeStart nVarChar(50),
		@TimeEnd nVarChar(50)
	)
	
AS
	DECLARE @combStart DateTime;
	DECLARE @combEnd DateTime;

	SET @combStart = CAST(CAST(@DateStart AS DATE) AS DATETIME) + CAST(@TimeStart as TIME);
	SET @combEnd = CAST(CAST(@DateEnd AS DATE) AS DATETIME) + CAST(@TimeEnd as TIME);

	--CAST(CAST(your_date_column AS DATE) AS DATETIME) +     CAST(your_time_column AS TIME) 


	IF (@Line > 0) AND (@Cell > 0 or @Plant > 0)  RETURN;

	IF (@Cell > 0) AND (@Line > 0 or @Plant > 0) RETURN;

	IF (@Plant > 0) AND (@Cell > 0 or @Line > 0) RETURN;

	

	IF @Line > 0
		BEGIN
			
			SELECT TOP (@toplevel) * FROM wAppDT.Downtime_MainFormView
				WHERE (
					(CAST(CAST(DTNDateDown AS DATE) AS DATETIME) + CAST(DTNTimeDown AS TIME)) BETWEEN @combStart and @combEnd)
					AND LIID = @Line
					AND MyName Like @nameFilter
					AND (DTMalfunction Like @genFilter OR DTSolution Like @genFilter or DTlongTerm Like @GenFilter)
				ORDER BY TotalTime Desc

		END
	IF @Cell > 0
		BEGIN
			
			SELECT TOP (@toplevel) * FROM wAppDT.Downtime_MainFormView
				WHERE ((CAST(CAST(DTNDateDown AS DATE) AS DATETIME) + CAST(DTNTimeDown AS TIME)) BETWEEN @combStart and @combEnd) AND DTLine = @Cell  AND MyName Like @nameFilter AND (DTMalfunction Like @genFilter OR DTSolution Like @genFilter or DTlongTerm Like @GenFilter)
				ORDER BY TotalTime Desc

		END
	IF @Plant > 0
		BEGIN
			
			SELECT TOP (@toplevel) * FROM wAppDT.Downtime_MainFormView
				WHERE ((CAST(CAST(DTNDateDown AS DATE) AS DATETIME) + CAST(DTNTimeDown AS TIME)) BETWEEN @combStart and @combEnd) AND MLPlantID = @Plant  AND MyName Like @nameFilter AND (DTMalfunction Like @genFilter OR DTSolution Like @genFilter or DTlongTerm Like @GenFilter)
				Order By TotalTime Desc

		END

	RETURN
GO
/****** Object:  StoredProcedure [Team].[TeamEditUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Team].[TeamEditUpdate]
@FirstName as nvarchar(50) = 'First',
@LastName as nvarchar(50) = 'Last',
@Phone as nvarchar(50),
@Radio as nvarchar(50),
@Area as integer,
@UserName as nvarchar(50),
@SecLevel as nvarchar(50),
@LastThree as nvarchar(50),
@HireDate as nvarchar(50),
@ID as Integer,
@Group as integer,
@Email as nVarChar(50),
@Dept as Integer,
@Plant as Integer,
@Shift as Integer,
@PayGroup as Integer = 2,
@EmpNumber as Integer = 0

AS

	UPDATE Team.TeamMembers
	Set
		TMFirstName = @FirstName,
		TMLastName = @LastName,
		TMPhone = @Phone,
		TMRadioNumber = @Radio,
		TMArea = @Area,
		TMUserName = @UserName,
		TMSecurityLevel = @SecLevel,
		TMLastThree = @LastThree,
		TMHireDate = @HireDate,
		TMGROUPLINK = @Group,
		TMEmail = @Email,
		TMDEPARTMENTLINK = @Dept,
		TMPLANTLINK = @Plant,
		TMNShift = @Shift,
		TMPayStatus = @PayGroup,
		TMEmpNumber = @EmpNumber

	WHERE TMID = @ID
	RETURN
GO
/****** Object:  StoredProcedure [Team].[TeamEditNew]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Team].[TeamEditNew]
@FirstName as nvarchar(50) = 'First',
@LastName as nvarchar(50) = 'Last',
@Phone as nvarchar(50),
@Radio as nvarchar(50),
@Area as integer,
@UserName as nvarchar(50),
@SecLevel as nvarchar(50),
@LastThree as nvarchar(50),
@HireDate as nvarchar(50),
@ID as Integer,
@Group as integer,
@EmpNumber as integer,
@Shift as integer,
@Email as nVarChar(50),
@Dept as integer,
@Plant as integer,
@PayGroup as Integer = 0

AS

INSERT INTO Team.teammembers
(
	TMFirstName,
	TMLastName,
	TMNShift,
	TMPhone,
	TMRadioNumber,
	TMArea,
	TMUserName,
	TMSecurityLevel,
	TMLastThree,
	TMHireDate,
	TMGroupLink,
	TMEmpNumber,
	TMEmail,
	TMDEPARTMENTLINK,
	TMPLANTLINK,
	TMPayStatus

)
VALUES
(
@FirstName,
@LastName,
@Shift,
@Phone,
@Radio,
@Area,
@UserName,
@SecLevel,
@LastThree,
@HireDate,
@Group,
@EmpNumber,
@Email,
@Dept,
@Plant,
@PayGroup


)

RETURN
GO
/****** Object:  View [Team].[BSMaintHourlyAllTwo]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Team].[BSMaintHourlyAllTwo]
AS
SELECT     TOP (100) PERCENT TMID, TMFirstName + ' ' + TMLastName AS MyName2
FROM         Team.teammembers
ORDER BY MyName2
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "teammembers (Team)"
            Begin Extent = 
               Top = 0
               Left = 0
               Bottom = 115
               Right = 183
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'VIEW',@level1name=N'BSMaintHourlyAllTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'VIEW',@level1name=N'BSMaintHourlyAllTwo'
GO
/****** Object:  Table [Team].[TeamAssignments]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[TeamAssignments](
	[ASGID] [int] IDENTITY(1,1) NOT NULL,
	[ASGName] [nvarchar](50) NOT NULL,
	[ASGPlant] [int] NOT NULL,
	[ASGLeaderGroup] [int] NOT NULL,
	[ASGDeptLink] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [Team].[TeamMemberEditView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Team].[TeamMemberEditView]
AS
SELECT     TOP (100) PERCENT Team.teammembers.TMFirstName, Team.teammembers.TMLastName, Team.teammembers.TMShift, 
                      Team.teammembers.TMPhone, Team.teammembers.TMRadioNumber, Team.teammembers.TMArea, Team.teammembers.TMImage, 
                      Team.teammembers.TMUserName, Team.teammembers.TMSecurityLevel, Team.teammembers.TMLastThree, Team.teammembers.TMHireDate, 
                      Team.teammembers.TMID, Team.teammembers.TMGROUPLINK, Team.teammembers.TMEmpNumber, Team.teammembers.TMNShift, 
                      Team.teammembers.TMDEPARTMENTLINK, Team.teammembers.TMPLANTLINK, Team.ShiftTable.STShiftName, Team.ShiftTable.STTimeStart, 
                      Team.ShiftTable.STTimeEnd, Team.ShiftTable.STRotation, Team.teammembers.TMFirstName + N' ' + Team.teammembers.TMLastName AS ShowName,
                       Team.TeamAssignments.ASGName, Team.TeamAssignments.ASGID, Team.teammembers.TMEmail, Team.teammembers.TMPayStatus, 
                      Team.waDepartments.DNID, Team.waDepartments.DNName, Team.waDepartments.DNCode, Team.waDepartments.DNPNLink, 
                      Team.wAPlants.PNName, Team.wAPlants.PNCode, Team.wAPlants.PNID, Team.wAGroupNames.GNNames, Team.wAGroupNames.GNCode, 
                      Team.wAGroupNames.GNDNCode, Team.ShiftTable.STColor, Team.wAGroupNames.GNID, Team.teammembers.TMTeamLink
FROM         Team.wAGroupNames RIGHT OUTER JOIN
                      Team.teammembers ON Team.wAGroupNames.GNID = Team.teammembers.TMGROUPLINK LEFT OUTER JOIN
                      Team.wAPlants ON Team.teammembers.TMPLANTLINK = Team.wAPlants.PNID LEFT OUTER JOIN
                      Team.waDepartments ON Team.teammembers.TMDEPARTMENTLINK = Team.waDepartments.DNID LEFT OUTER JOIN
                      Team.TeamAssignments ON Team.teammembers.TMArea = Team.TeamAssignments.ASGID LEFT OUTER JOIN
                      Team.ShiftTable ON Team.teammembers.TMNShift = Team.ShiftTable.STID
ORDER BY Team.teammembers.TMLastName
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[31] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "wAGroupNames (Team)"
            Begin Extent = 
               Top = 6
               Left = 461
               Bottom = 121
               Right = 613
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "teammembers (Team)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 254
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "wAPlants (Team)"
            Begin Extent = 
               Top = 134
               Left = 682
               Bottom = 234
               Right = 940
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "waDepartments (Team)"
            Begin Extent = 
               Top = 6
               Left = 687
               Bottom = 121
               Right = 839
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TeamAssignments (Team)"
            Begin Extent = 
               Top = 2
               Left = 1040
               Bottom = 119
               Right = 1192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ShiftTable (Team)"
            Begin Extent = 
               Top = 2
               Left = 855
               Bottom = 117
               Right = 1007
            End
            DisplayFlags = 344
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
     ' , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'VIEW',@level1name=N'TeamMemberEditView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4605
         Alias = 5925
         Table = 1170
         Output = 1965
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'VIEW',@level1name=N'TeamMemberEditView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'VIEW',@level1name=N'TeamMemberEditView'
GO
/****** Object:  StoredProcedure [Team].[TeamEditFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Team].[TeamEditFetch]
@Plant as Integer,
@TMID as Integer
AS

	if @TMID > 0 
		BEGIN
			SELECT * FROM Team.TeamMemberEditView
			WHERE PNID = @Plant and TMID = @TMID
			ORDER BY TMLastName
		END
	ELSE
		BEGIN
	
			SELECT * FROM Team.TeamMemberEditView
		    --WHERE PNID = @Plant 
			ORDER BY TMLastName
		END
	

	RETURN
GO
/****** Object:  StoredProcedure [Scheduler].[LeftPanelScheduler]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Scheduler].[LeftPanelScheduler]
	-- Add the parameters for the stored procedure here
	@Plant Integer = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 -- DISResposible in WO.WorkOrdermain is the link back to the assigned TM.

 -- List all the team members


 DECLARE @peopleTable TABLE
 (
	lastName nVarChar(100),
	firstName nVarChar(100),
	longName nVarChar (200),
	memberID Integer,
	shift Integer,
	shiftName nVarChar(50),
	areaNumber Integer,
	areaName nVarChar(50),
	groupName nVarChar(50),
	deptName nVarChar(50),
	deptNumber Integer,
	shiftColor nVarChar(50),
	groupID Integer

 )

 Insert Into @peopleTable
	(
		lastName,
		firstName,
		longName,
		memberID,
		shift,
		shiftName,
		areaNumber,
		areaName,
		groupName,
		deptName,
		deptNumber,
		shiftColor,
		groupID
		
	)
	SELECT	
		TMLastName,
		TMFirstName,
		TMLastName + '  ' + TMFirstName,
		TMID,
	    TMNShift,
		STShiftName,
		ASGID,
		ASGName,
		GNNames,
		DNName,
		DNID,
		STColor,
		ISNULL(GNID, 1) as GNID

	    FROM Team.TeamMemberEditView
		WHERE PNID = @plant AND DNID = 2


SELECT * FROM @peopleTable
Order by shift, lastname

END
GO
/****** Object:  StoredProcedure [wAppTeam].[TeamManagerUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[TeamManagerUpdate]

@TMFirstName as nvarchar(50) = 'First',
@TMLastName as nvarchar(50) = 'Last',
@TMShift as integer,
@TMPhone as nVarChar(50),
@TMRadioNumber as nvarchar(50),
@TMImage as varbinary(max),
@TMArea as integer,
@TMUserName as nvarchar(50),
@TMSecurityLevel as nvarchar(50),
@TMLastThree as nvarchar(50),
@TMHireDate as nvarchar(50),
@TMID as Integer,
@TMGroupLink as integer,
@TMEmpNumber as integer,
@TMNShift as integer,
@TMEmail as nVarChar(50),
@TMDEPARTMENTLINK as integer,
@TMPlantLink as integer,
@TMPayStatus as nVarChar(50),
@TMProdUID as nVarChar(50),
@TMWorkAssignment as integer,
@TMTeamLink int,
@wATPMMenu bit,
@wAOIMenu bit,
@wATeamMenu bit,
@wAWOMenu bit, 
@wADocmenu bit,
@wADTMenu bit,
@wAEcoMenu bit,
@wAPartsMenu bit,
@wATeam_Builder bit,
@wATeam_Builder_Supervisor bit,
@wATeam_Overtime bit,
@wATeam_Overtime_Supervisor bit,
@wATeam_Security bit, 
@wATeam_Security_Supervisor bit,
@wATeam_Reports bit,
@wATPM_OpenWO_Editor bit,
@wABeta bit,
@wADocAdd bit,
@waWeld_Menu bit,
@waWeld_Edit bit,
@waWeld_Supervisor bit,
@TMTitleLink int

AS

UPDATE Team.teammembers

	SET 
	
			TMFirstName			=	@TMFirstName,
			TMLastName			=	@TMLastName,
			TMShift				=	@TMShift,
			TMPhone				=	@TMPhone,
			TMRadioNumber		=	@TMRadioNumber,
			TMImage				=	@TMImage,
			TMArea				=	@TMArea,
			TMUserName			=	@TMUserName,
			TMSecurityLevel		=	@TMSecurityLevel ,
			TMLastThree			=	@TMLastThree  ,
			TMHireDate			=	@TMHireDate,
			TMGroupLink			=	@TMGroupLink,
			TMEmpNumber			=	@TMEmpNumber,
			TMNShift			=	@TMNShift,
			TMEmail				=	@TMEmail,
			TMDEPARTMENTLINK	=	@TMDEPARTMENTLINK,
			TMPlantLink			=	@TMPlantLink,
			TMPayStatus			=	@TMPayStatus,
			TMProdUID			=	@TMProdUID ,
			TMWorkassignment	=	@TMWorkAssignment ,
			TMTeamlink			=	@TMTeamLink,
			TMTitleLink			=	@TMTitleLink
	WHERE
		TMID = @TMID



	UPDATE SEC.AccessTable
		SET
			wATPMMenu					=	@wATPMMenu ,
			wAOIMenu					=	@wAOIMenu ,
			wATeamMenu					=	@wATeamMenu ,
			wAWOMenu					=	@wAWOMenu , 
			wADocmenu					=	@wADocmenu ,
			wADTMenu					=	@wADTMenu ,
			wAEcoMenu 					=	@wAEcoMenu ,
			wAPartsMenu					=	@wAPartsMenu ,
			wATeam_Builder				=	@wATeam_Builder ,
			wATeam_Builder_Supervisor	=	@wATeam_Builder_Supervisor ,
			wATeam_Overtime				=	@wATeam_Overtime ,
			wATeam_Overtime_Supervisor	=	@wATeam_Overtime_Supervisor ,
			wATeam_Security				=	@wATeam_Security , 
			wATeam_Security_Supervisor	=	@wATeam_Security_Supervisor ,
			wATeam_Reports 			    =	@wATeam_Reports ,
			wATPM_OpenWO_Editor			=	@wATPM_OpenWO_Editor ,
			wABeta						=	@wABeta ,
			wADocAdd 					=	@wADocAdd ,
			waWeld_Menu					=	@waWeld_Menu,
			waWeld_Edit					=	@waWeld_Edit,
			waWeld_Supervisor			=	@waWeld_Supervisor
		WHERE 
			ATUID = @TMID
GO
/****** Object:  StoredProcedure [wAppTeam].[TeamManagerInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[TeamManagerInsert]

@TMFirstName as nvarchar(50) = 'First',
@TMLastName as nvarchar(50) = 'Last',
--@TMShift as integer,
@TMPhone as nVarChar(50),
@TMRadioNumber as nvarchar(50),
@TMImage as varbinary(max),
@TMArea as integer,
@TMUserName as nvarchar(50),
@TMSecurityLevel as int,
@TMLastThree as int,
@TMHireDate as date,
@TMGroupLink as integer,
@TMEmpNumber as integer,
@TMNShift as integer,
@TMEmail as nVarChar(50),
@TMDEPARTMENTLINK as integer,
@TMPlantLink as integer,
@TMPayStatus as nVarChar(50),
@TMProdUID as nVarChar(50),
@TMWorkAssignment as integer,
@TMTeamlink as integer,
@RETURN_VALUE INT = 0 OUTPUT 

AS

INSERT INTO Team.teammembers
(
	TMFirstName  ,
	TMLastName  ,
--	TMShift  ,
	TMPhone  ,
	TMRadioNumber  ,
	TMImage  ,
	TMArea  ,
	TMUserName ,
	TMSecurityLevel  ,
	TMLastThree  ,
	TMHireDate  ,
	TMGroupLink,
	TMEmpNumber,
	TMNShift,
	TMEmail,
	TMDEPARTMENTLINK,
	TMPlantLink,
	TMPayStatus,
	TMProdUID  ,
	TMWorkassignment,
	TMTeamLink

)
VALUES
(

	@TMFirstName ,
	@TMLastName ,
--	@TMShift ,
	@TMPhone ,
	@TMRadioNumber  ,
	@TMImage  ,
	@TMArea  ,
	@TMUserName  ,
	@TMSecurityLevel  ,
	@TMLastThree  ,
	@TMHireDate  ,
	@TMGroupLink  ,
	@TMEmpNumber  ,
	@TMNShift  ,
	@TMEmail  ,
	@TMDEPARTMENTLINK  ,
	@TMPlantLink ,
	@TMPayStatus ,
	@TMProdUID  ,
	@TMWorkAssignment  ,
	@TMTeamLink

)

	SELECT TMID FROM Team.teammembers WHERE (TMID = SCOPE_IDENTITY())
	return;
GO
/****** Object:  Table [Team].[MyChamps]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Team].[MyChamps](
	[MCID] [int] IDENTITY(1,1) NOT NULL,
	[MCUID] [int] NOT NULL,
	[MCINT1] [int] NULL,
	[MCINT2] [int] NULL,
	[MCINT3] [int] NULL,
	[MCINT4] [int] NULL,
	[MCINT5] [int] NULL,
	[MCINT6] [int] NULL,
	[MCINT7] [int] NULL,
	[MCINT8] [int] NULL,
	[MCINT9] [int] NULL,
	[MCINT10] [int] NULL,
	[MCBOOL1] [bit] NULL,
	[MCBOOL2] [bit] NULL,
	[MCBOOL3] [bit] NULL,
	[MCBOOL4] [bit] NULL,
	[MCBOOL5] [bit] NULL,
	[MCTEXT1] [nvarchar](max) NULL,
	[MCTEXT2] [nvarchar](max) NULL,
	[MCTEXT3] [nvarchar](max) NULL,
	[MCTEXT4] [nvarchar](max) NULL,
	[MCTEXT5] [nvarchar](max) NULL,
	[MCTEXT6] [nvarchar](max) NULL,
	[MCTEXT7] [nvarchar](max) NULL,
	[MCTEXT8] [nvarchar](max) NULL,
	[MCTEXT9] [nvarchar](max) NULL,
	[MCTEXT10] [nvarchar](max) NULL,
	[MCDEC1] [float] NULL,
	[MCDEC2] [float] NULL,
	[MCDEC3] [float] NULL,
	[MCDEC4] [float] NULL,
	[MCDEC5] [float] NULL,
	[MCDATE1] [date] NULL,
	[MCDATE2] [date] NULL,
	[MCDATE3] [date] NULL,
	[MCDATE4] [date] NULL,
	[MCDATE5] [date] NULL,
	[MCTIME1] [time](7) NULL,
	[MCTIME2] [time](7) NULL,
	[MCTIME3] [time](7) NULL,
	[MCTIME4] [time](7) NULL,
	[MCTIME5] [time](7) NULL,
	[MCIMAGE1] [varbinary](max) NULL,
	[MCIMAGE2] [varbinary](max) NULL,
 CONSTRAINT [PK_MyChamps] PRIMARY KEY CLUSTERED 
(
	[MCID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [Team].[PaySequence]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[PaySequence](
	[PSID] [int] IDENTITY(1,1) NOT NULL,
	[PSName] [nchar](25) NOT NULL,
	[PSCode] [nchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [wAppTeam].[TeamManagerView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTeam].[TeamManagerView]
AS
SELECT     Team.teammembers.TMFirstName, Team.teammembers.TMLastName, Team.teammembers.TMShift, Team.teammembers.TMPhone, 
                      Team.teammembers.TMRadioNumber, Team.teammembers.TMImage, Team.teammembers.TMArea, Team.teammembers.TMUserName, 
                      Team.teammembers.TMSecurityLevel, Team.teammembers.TMLastThree, Team.teammembers.TMHireDate, Team.teammembers.TMID, 
                      Team.teammembers.TMGROUPLINK, Team.teammembers.TMEmpNumber, Team.teammembers.TMNShift, Team.teammembers.TMDEPARTMENTLINK, 
                      Team.teammembers.TMPLANTLINK, Team.teammembers.TMEmail, Team.teammembers.TMPayStatus, Team.wAGroupNames.GNNames, 
                      Team.wAGroupNames.GNID, Team.waDepartments.DNID, Team.waDepartments.DNName, Team.wAPlants.PNID, Team.wAPlants.PNName, 
                      wACom.Areas.AAID, wACom.Areas.AAareaname, Team.PaySequence.PSName, Team.PaySequence.PSID, Team.ShiftTable.STShiftName, 
                      Team.ShiftTable.STID, SEC.AccessTable.ATID, SEC.AccessTable.ATUID, SEC.AccessTable.ATTeamAccess, SEC.AccessTable.ATTeamManage, 
                      SEC.AccessTable.ATTeamSecLevel, SEC.AccessTable.ATTTeamAccessForm, SEC.AccessTable.ATTTpmRibbonButton, 
                      SEC.AccessTable.ATOpenItemRibbonButton, SEC.AccessTable.ATDowntime, SEC.AccessTable.ATDocumentation, SEC.AccessTable.ATWorkOrders, 
                      SEC.AccessTable.ATPartTracking, SEC.AccessTable.ATDown_Add, SEC.AccessTable.ATDown_OpenItem, SEC.AccessTable.ATDown_WorkOrder, 
                      SEC.AccessTable.ATDown_Delete, SEC.AccessTable.ATOvertimeEdit, SEC.AccessTable.ATDocEdit, SEC.AccessTable.ATTeamReports, 
                      SEC.AccessTable.ATTeamBuildButton, SEC.AccessTable.ATOvertimeManage, SEC.AccessTable.ATTeamBuildSuper, SEC.AccessTable.wATPMMenu, 
                      SEC.AccessTable.wAOIMenu, SEC.AccessTable.wATeamMenu, SEC.AccessTable.wAWOMenu, SEC.AccessTable.wADocMenu, 
                      SEC.AccessTable.wADTMenu, SEC.AccessTable.wAEcoMenu, SEC.AccessTable.wAPartsMenu, SEC.AccessTable.wATeam_Builder, 
                      SEC.AccessTable.wATeam_Builder_Supervisor, SEC.AccessTable.wATeam_Overtime, SEC.AccessTable.wATeam_Overtime_Supervisor, 
                      SEC.AccessTable.wATeam_Security, SEC.AccessTable.wATeam_Security_Supervisor, SEC.AccessTable.wATeam_Reports, 
                      SEC.AccessTable.wATPM_OpenWO_Editor, SEC.AccessTable.wABeta, SEC.AccessTable.wADocAdd, Team.MyChamps.MCID, Team.MyChamps.MCUID, 
                      Team.MyChamps.MCINT1, Team.MyChamps.MCINT2, Team.MyChamps.MCINT3, Team.MyChamps.MCINT4, Team.MyChamps.MCINT5, 
                      Team.MyChamps.MCINT6, Team.MyChamps.MCINT7, Team.MyChamps.MCINT8, Team.MyChamps.MCINT9, Team.MyChamps.MCINT10, 
                      Team.MyChamps.MCBOOL1, Team.MyChamps.MCBOOL2, Team.MyChamps.MCBOOL3, Team.MyChamps.MCBOOL4, Team.MyChamps.MCBOOL5, 
                      Team.MyChamps.MCTEXT1, Team.MyChamps.MCTEXT2, Team.MyChamps.MCTEXT3, Team.MyChamps.MCTEXT4, Team.MyChamps.MCTEXT5, 
                      Team.MyChamps.MCTEXT6, Team.MyChamps.MCTEXT7, Team.MyChamps.MCTEXT8, Team.MyChamps.MCTEXT9, Team.MyChamps.MCTEXT10, 
                      Team.MyChamps.MCDEC1, Team.MyChamps.MCDEC2, Team.MyChamps.MCDEC3, Team.MyChamps.MCDEC4, Team.MyChamps.MCDEC5, 
                      Team.MyChamps.MCDATE1, Team.MyChamps.MCDATE2, Team.MyChamps.MCDATE3, Team.MyChamps.MCDATE4, Team.MyChamps.MCDATE5, 
                      Team.MyChamps.MCTIME1, Team.MyChamps.MCTIME2, Team.MyChamps.MCTIME3, Team.MyChamps.MCTIME4, Team.MyChamps.MCTIME5, 
                      Team.MyChamps.MCIMAGE1, Team.MyChamps.MCIMAGE2, Team.teammembers.TMProdUID, Team.teammembers.TMWorkAssignment, 
                      Team.teammembers.TMTeamLink, Team.teammembers.TMLastName + N', ' + Team.teammembers.TMFirstName AS MyName, 
                      SEC.AccessTable.waWeld_Edit, SEC.AccessTable.waWeld_Menu, SEC.AccessTable.waWeld_Supervisor, Team.teammembers.TMTitleLink
FROM         Team.teammembers LEFT OUTER JOIN
                      SEC.AccessTable ON Team.teammembers.TMID = SEC.AccessTable.ATUID LEFT OUTER JOIN
                      Team.MyChamps ON Team.teammembers.TMID = Team.MyChamps.MCUID LEFT OUTER JOIN
                      Team.ShiftTable ON Team.teammembers.TMNShift = Team.ShiftTable.STID LEFT OUTER JOIN
                      wACom.Areas ON Team.teammembers.TMArea = wACom.Areas.AAID LEFT OUTER JOIN
                      Team.PaySequence ON Team.teammembers.TMPayStatus = Team.PaySequence.PSID LEFT OUTER JOIN
                      Team.wAPlants ON Team.teammembers.TMPLANTLINK = Team.wAPlants.PNID LEFT OUTER JOIN
                      Team.waDepartments ON Team.teammembers.TMDEPARTMENTLINK = Team.waDepartments.DNID LEFT OUTER JOIN
                      Team.wAGroupNames ON Team.teammembers.TMGROUPLINK = Team.wAGroupNames.GNID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[55] 4[25] 2[4] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "teammembers (Team)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 334
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "AccessTable (SEC)"
            Begin Extent = 
               Top = 93
               Left = 903
               Bottom = 222
               Right = 1153
            End
            DisplayFlags = 280
            TopColumn = 38
         End
         Begin Table = "MyChamps (Team)"
            Begin Extent = 
               Top = 168
               Left = 636
               Bottom = 297
               Right = 806
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ShiftTable (Team)"
            Begin Extent = 
               Top = 48
               Left = 1002
               Bottom = 156
               Right = 1153
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Areas (wACom)"
            Begin Extent = 
               Top = 6
               Left = 1014
               Bottom = 114
               Right = 1167
            End
            DisplayFlags = 344
            TopColumn = 1
         End
         Begin Table = "PaySequence (Team)"
            Begin Extent = 
               Top = 6
               Left = 825
               Bottom = 119
               Right = 976
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "wAPlants (Team)"
            Begin Extent = 
               Top = 6
               Left = 636
               Bottom = 164
           ' , @level0type=N'SCHEMA',@level0name=N'wAppTeam', @level1type=N'VIEW',@level1name=N'TeamManagerView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'    Right = 787
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "waDepartments (Team)"
            Begin Extent = 
               Top = 163
               Left = 326
               Bottom = 392
               Right = 477
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "wAGroupNames (Team)"
            Begin Extent = 
               Top = 6
               Left = 258
               Bottom = 179
               Right = 409
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 120
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3570
         Alias = 3330
         Table = 1170
         Output = 720
         Append ' , @level0type=N'SCHEMA',@level0name=N'wAppTeam', @level1type=N'VIEW',@level1name=N'TeamManagerView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane3', @value=N'= 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTeam', @level1type=N'VIEW',@level1name=N'TeamManagerView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=3 , @level0type=N'SCHEMA',@level0name=N'wAppTeam', @level1type=N'VIEW',@level1name=N'TeamManagerView'
GO
/****** Object:  StoredProcedure [wAppTeam].[TeamManagerFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[TeamManagerFetch]
@Plant int
AS
	IF @Plant > 0
	BEGIN
		SELECT * FROM wAppTeam.TeamManagerView
		WHERE PNID = @Plant
	END
	ELSE
	BEGIN
		SELECT * FROM wAppTeam.TeamManagerView
	END


	RETURN
GO
/****** Object:  StoredProcedure [wACom].[TeamList2]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[TeamList2]
@Plant as Integer
AS


SELECT * FROM TeamListDrop 
WHERE PNID = @Plant
ORDER BY TMLastName
	RETURN
GO
/****** Object:  StoredProcedure [wACom].[TeamList]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[TeamList]
@Plant as Integer
AS


SELECT * FROM TeamListDrop 
WHERE PNID = @Plant
ORDER BY TMLastName
	RETURN
GO
/****** Object:  View [wAppWorkOrder].[wAppWorkOrderMainClosed]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppWorkOrder].[wAppWorkOrderMainClosed]
AS
SELECT     WO.WorkOrderMain.DISOpenDate, WO.WorkOrderMain.DISCloseDate, WO.WorkOrderMain.DISWorkRequired, WO.WorkOrderMain.DISNumberAss, 
                      WO.WorkOrderMain.DISManHours, WO.WorkOrderMain.DISWorkAccomp, WO.WorkOrderMain.DISLineNumber, WO.WorkOrderMain.DISEquip, 
                      WO.WorkOrderMain.DISDueDate, WO.WorkOrderMain.DISOriginator, WO.WorkOrderMain.DISResponsible, WO.WorkOrderMain.DISType, 
                      WO.WorkOrderMain.DISRequestor, WO.WorkOrderMain.DISOpenItemNumber, WO.WorkOrderMain.DISTPMNumber, WO.WorkOrderMain.DISID, 
                      WO.WorkOrderMain.DISIntHold, WO.WorkOrderMain.DISCharHold, wACom.MachineList.MLCELLNAME, wACom.MachineList.MLLINEID, 
                      wACom.MachineList.MLID, wACom.MachineList.MLPlantID, wACom.Lines.LILineName, wACom.Lines.LISatellite, wACom.Lines.LIPlannerGroup, 
                      wACom.Lines.LIID, wACom.Lines.LIPlant, wACom.TeamListDrop.Myname, wACom.TeamListDrop.TMID, 
                      wACom.TeamListDropMirror.Myname AS RespName, wACom.TeamListDropMirror.TMID AS RespID, WO.WorkOrderCodes.WOCName, 
                      WO.WorkOrderCodes.WOCID, EQP.ProcNumbers.PROCID, EQP.ProcNumbers.PROCNUMBER, COM.ResponsibleParty.RPName, 
                      COM.ResponsibleParty.RPID
FROM         WO.WorkOrderMain INNER JOIN
                      wACom.MachineList ON WO.WorkOrderMain.DISLineNumber = wACom.MachineList.MLID INNER JOIN
                      wACom.Lines ON wACom.MachineList.MLLINEID = wACom.Lines.LIID LEFT OUTER JOIN
                      COM.ResponsibleParty ON WO.WorkOrderMain.DISResponsible = COM.ResponsibleParty.RPID LEFT OUTER JOIN
                      WO.WorkOrderCodes ON WO.WorkOrderMain.DISType = WO.WorkOrderCodes.WOCID LEFT OUTER JOIN
                      EQP.ProcNumbers ON WO.WorkOrderMain.DISEquip = EQP.ProcNumbers.PROCID LEFT OUTER JOIN
                      wACom.TeamListDropMirror ON WO.WorkOrderMain.DISRequestor = wACom.TeamListDropMirror.TMID LEFT OUTER JOIN
                      wACom.TeamListDrop ON WO.WorkOrderMain.DISOriginator = wACom.TeamListDrop.TMID
WHERE     (WO.WorkOrderMain.DISCloseDate IS NOT NULL)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WorkOrderMain (WO)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 257
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 259
               Bottom = 121
               Right = 411
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 6
               Left = 449
               Bottom = 121
               Right = 604
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ResponsibleParty (COM)"
            Begin Extent = 
               Top = 6
               Left = 642
               Bottom = 106
               Right = 794
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WorkOrderCodes (WO)"
            Begin Extent = 
               Top = 6
               Left = 832
               Bottom = 91
               Right = 984
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 6
               Left = 1022
               Bottom = 121
               Right = 1212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TeamListDropMirror (wACom)"
            Begin Extent = 
               Top = 6
               Left = 1250
               Bottom = 12' , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'wAppWorkOrderMainClosed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'1
               Right = 1402
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TeamListDrop (wACom)"
            Begin Extent = 
               Top = 96
               Left = 832
               Bottom = 211
               Right = 984
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'wAppWorkOrderMainClosed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'wAppWorkOrderMainClosed'
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[WOCompletionReport]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[WOCompletionReport]
	
@Plant Integer,
@DateStart Date,
@DateStop Date
AS
	SELECT * FROM wAppWorkOrder.wAppWorkOrderMainClosed
	WHERE MLPlantID = @Plant AND DISCloseDate BETWEEN @DateStart AND @DateStop AND DISType <> 3
	RETURN
GO
/****** Object:  View [wAppWorkOrder].[wAppWorkOrderMain]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppWorkOrder].[wAppWorkOrderMain]
AS
SELECT        WO.WorkOrderMain.DISOpenDate, WO.WorkOrderMain.DISCloseDate, WO.WorkOrderMain.DISWorkRequired, WO.WorkOrderMain.DISNumberAss, 
                         WO.WorkOrderMain.DISManHours, WO.WorkOrderMain.DISWorkAccomp, WO.WorkOrderMain.DISLineNumber, WO.WorkOrderMain.DISEquip, 
                         WO.WorkOrderMain.DISDueDate, WO.WorkOrderMain.DISOriginator, WO.WorkOrderMain.DISResponsible, WO.WorkOrderMain.DISType, 
                         WO.WorkOrderMain.DISRequestor, WO.WorkOrderMain.DISOpenItemNumber, WO.WorkOrderMain.DISTPMNumber, WO.WorkOrderMain.DISID, 
                         WO.WorkOrderMain.DISIntHold, WO.WorkOrderMain.DISCharHold, wACom.MachineList.MLCELLNAME, wACom.MachineList.MLLINEID, wACom.MachineList.MLID, 
                         wACom.MachineList.MLPlantID, wACom.Lines.LILineName, wACom.Lines.LISatellite, wACom.Lines.LIPlannerGroup, wACom.Lines.LIID, wACom.Lines.LIPlant, 
                         wACom.TeamListDrop.Myname, wACom.TeamListDrop.TMID, wACom.TeamListDropMirror.Myname AS RespName, wACom.TeamListDropMirror.TMID AS RespID, 
                         WO.WorkOrderCodes.WOCName, WO.WorkOrderCodes.WOCID, EQP.ProcNumbers.PROCID, EQP.ProcNumbers.PROCNUMBER, COM.ResponsibleParty.RPName, 
                         COM.ResponsibleParty.RPID, WO.WorkOrderMain.DISSchedDate, WO.WorkOrderMain.DISSchedShift, Team.ShiftTable.STShiftName, Team.ShiftTable.STID, 
                         TPM.TPMProcdure.TPMProcTitle, TPM.TPMProcdure.TPMProcEstMin, TPM.TPMProcdure.TPMPRocNumTM, wACom.Areas.AAID, wACom.Areas.AAPlant, 
                         wACom.Areas.AAActive, wACom.Areas.AAareaname
FROM            WO.WorkOrderMain INNER JOIN
                         wACom.MachineList ON WO.WorkOrderMain.DISLineNumber = wACom.MachineList.MLID INNER JOIN
                         wACom.Lines ON wACom.MachineList.MLLINEID = wACom.Lines.LIID LEFT OUTER JOIN
                         wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID LEFT OUTER JOIN
                         TPM.TPMProcdure ON WO.WorkOrderMain.DISTPMNumber = TPM.TPMProcdure.TPMProcID LEFT OUTER JOIN
                         Team.ShiftTable ON WO.WorkOrderMain.DISSchedShift = Team.ShiftTable.STID LEFT OUTER JOIN
                         COM.ResponsibleParty ON WO.WorkOrderMain.DISResponsible = COM.ResponsibleParty.RPID LEFT OUTER JOIN
                         WO.WorkOrderCodes ON WO.WorkOrderMain.DISType = WO.WorkOrderCodes.WOCID LEFT OUTER JOIN
                         EQP.ProcNumbers ON WO.WorkOrderMain.DISEquip = EQP.ProcNumbers.PROCID LEFT OUTER JOIN
                         wACom.TeamListDropMirror ON WO.WorkOrderMain.DISRequestor = wACom.TeamListDropMirror.TMID LEFT OUTER JOIN
                         wACom.TeamListDrop ON WO.WorkOrderMain.DISOriginator = wACom.TeamListDrop.TMID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[55] 4[6] 2[22] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WorkOrderMain (WO)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 341
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 259
               Bottom = 196
               Right = 456
            End
            DisplayFlags = 344
            TopColumn = 3
         End
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 173
               Left = 849
               Bottom = 288
               Right = 1004
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "TPMProcdure (TPM)"
            Begin Extent = 
               Top = 131
               Left = 600
               Bottom = 260
               Right = 812
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "ShiftTable (Team)"
            Begin Extent = 
               Top = 308
               Left = 873
               Bottom = 416
               Right = 1024
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ResponsibleParty (COM)"
            Begin Extent = 
               Top = 6
               Left = 646
               Bottom = 106
               Right = 835
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "WorkOrderCodes (WO)"
            Begin Extent = 
               Top = 6
               Left = 836
               Bottom = 91
 ' , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'wAppWorkOrderMain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'              Right = 1024
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 6
               Left = 1026
               Bottom = 121
               Right = 1216
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TeamListDropMirror (wACom)"
            Begin Extent = 
               Top = 48
               Left = 1026
               Bottom = 163
               Right = 1276
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TeamListDrop (wACom)"
            Begin Extent = 
               Top = 89
               Left = 1024
               Bottom = 204
               Right = 1224
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Areas (wACom)"
            Begin Extent = 
               Top = 139
               Left = 1104
               Bottom = 268
               Right = 1274
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2415
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'wAppWorkOrderMain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'wAppWorkOrderMain'
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[WOPrintFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[WOPrintFetch]
@Plant as Integer


AS

	SELECT * FROM wAppWorkOrder.wAppWorkOrderMain
	WHERE MLPlantID = @Plant AND DISCloseDate Is Null
	ORDER BY DISID
	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[WOMainFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Used only in the Scheduing Page for work orders.

CREATE PROCEDURE [wAppWorkOrder].[WOMainFetch]
@Plant as Integer,
@User as Integer = 0

AS
	IF @User = 0
	BEGIN
		SELECT * FROM wAppWorkOrder.wAppWorkOrderMain
		WHERE MLPlantID = @Plant 
			--AND DISOpenDate BETWEEN DateAdd(Day,-@Days,GetDate()) AND GetDate() or (DISCloseDate IS NULL) -- AND DISCloseDate Is  Null
			AND DISCloseDate IS NULL -- AND DISCloseDate Is  Null
	END
	ELSE
	BEGIN
		SELECT * FROM wAppWorkOrder.wAppWorkOrderMain
		WHERE MLPlantID = @Plant AND DISCloseDate IS NULL AND DISRequestor = @User

	END




	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[SchedulingCIListFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[SchedulingCIListFetch]
	
	(
		@Plant int,
		@Start Date,
		@end Date,
		@Shift int

	)
	
AS
	if(@shift > 0)
	BEGIN
	
	SELECT * FROM wAppWorkOrder.wAppWorkOrderMain
		WHERE LIPlant = @plant AND DISSchedDate BETWEEN @start AND @end AND DISSchedShift = @shift AND DISType <> 3
	END

	ELSE
	BEGIN
		SELECT * FROM wAppWorkOrder.wAppWorkOrderMain
		WHERE LIPlant = @plant AND DISSchedDate BETWEEN @start AND @end AND DISType <> 3

	END
	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[SchedulingCIList]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[SchedulingCIList]
	
	(
		@Plant int,
		@Start Date,
		@end Date,
		@Shift int
	)
	
AS
	if(@shift > 0)
	BEGIN
	
	SELECT * FROM wAppWorkOrder.wAppWorkOrderMain
		WHERE LIPlant = @plant AND DISSchedDate BETWEEN @start AND @end AND DISSchedShift = @shift
	END

	ELSE
	BEGIN
		SELECT * FROM wAppWorkOrder.wAppWorkOrderMain
		WHERE LIPlant = @plant AND DISSchedDate BETWEEN @start AND @end 

	END
	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[SchedulerOneFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[SchedulerOneFetch]
@Plant int
AS
	SELECT * FROM wAppWorkOrder.wAppWorkOrderMain
		WHERE LIPlant = @Plant
	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[Report1Fetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[Report1Fetch]
@Plant as Integer


AS

	SELECT * FROM wAppWorkOrder.wAppWorkOrderMain
	WHERE MLPlantID = @Plant AND DISType <> 3 AND DISCloseDate Is Null
	ORDER BY DISID
	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[CloseWOFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[CloseWOFetch]
(

	@WoNum integer

	)
AS
-- Used in 
	-- Schedulers Closed Work Order Find
	SELECT * FROM wAppWorkOrder.wAppWorkOrderMain
	WHERE DISID = @WoNum



	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[ClosedWOEdit]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [wAppWorkOrder].[ClosedWOEdit]
@Plant as Integer


AS

	SELECT * FROM wAppWorkOrder.wAppWorkOrderMain
	WHERE MLPlantID = @Plant AND DISType <> 3 AND DISCloseDate Is Not Null
	ORDER BY DISID
	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[WeekendSummaryFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[WeekendSummaryFetch]
	
	(
			@Start DATE,
			@Finish Date,
			@Plant Integer
	)
	
AS

DECLARE @holdTable TABLE
(

	Name nVarChar(100),
	Userid Integer,
	HoursWorked Integer,
	HoursRecorded Integer

);

INSERT INTO @holdTable (Userid) SELECT TMID From Team.TeamMemberEditView WHERE DNPNLink = @Plant AND TMPayStatus = 1;

UPDATE @holdTable
	SET Name = (SELECT TMFirstName FROM Team.TeamMemberEditView WHERE TMID = Userid);





SELECT * FROM @holdTable;

	RETURN
GO
/****** Object:  Table [wACom].[VendorList]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [wACom].[VendorList](
	[VLName] [nvarchar](255) NULL,
	[VLAddressStreet] [nvarchar](255) NULL,
	[VLAdderssCity] [nvarchar](255) NULL,
	[VLAddressState] [nvarchar](255) NULL,
	[VLAddressZip] [nvarchar](255) NULL,
	[VLAddressPhone1] [nvarchar](255) NULL,
	[VLAddressPhone2] [nvarchar](255) NULL,
	[VLID] [int] IDENTITY(1,1) NOT NULL,
	[VLContact] [nvarchar](150) NULL,
	[VLEmail] [nvarchar](50) NULL,
	[VLFax] [nvarchar](50) NULL,
	[VLWebSite] [nvarchar](50) NULL,
	[VLSAPID] [bigint] NOT NULL,
	[VLContactCell] [nvarchar](50) NULL,
 CONSTRAINT [PK_VendorList_1] PRIMARY KEY CLUSTERED 
(
	[VLSAPID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [wACom].[VendorListView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wACom].[VendorListView]
AS
SELECT     wACom.VendorList.*
FROM         wACom.VendorList
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "VendorList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 232
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'VendorListView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'VendorListView'
GO
/****** Object:  View [wACom].[ManufacturerListView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wACom].[ManufacturerListView]
AS
SELECT     wACom.VendorList.*
FROM         wACom.VendorList
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "VendorList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 205
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'ManufacturerListView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'ManufacturerListView'
GO
/****** Object:  View [wAppTPM].[wAppModelNumbers]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTPM].[wAppModelNumbers]
AS
SELECT        EQP.EquipmentModelNumber.EQModID, EQP.EquipmentModelNumber.EQModModelNumber, EQP.EquipmentModelNumber.EQModManID, 
                         EQP.EquipmentModelNumber.EQModDescription, EQP.EquipmentModelNumber.EQModVendorID, EQP.EquipmentModelNumber.EQModOrderNumber, 
                         EQP.EquipmentModelNumber.EQModImageOne, wACom.ManufacturerListView.VLName AS ManufName, 
                         wACom.ManufacturerListView.VLAddressStreet AS ManufStreet, wACom.ManufacturerListView.VLAdderssCity AS ManufCity, 
                         wACom.ManufacturerListView.VLAddressState AS ManufState, wACom.ManufacturerListView.VLAddressZip AS ManufZip, 
                         wACom.ManufacturerListView.VLAddressPhone1 AS ManufPhone, wACom.ManufacturerListView.VLAddressPhone2 AS ManufPhone2, 
                         wACom.ManufacturerListView.VLID AS ManufID, wACom.VendorListView.VLName AS VendorName, wACom.VendorListView.VLAddressStreet AS VendorStreet, 
                         wACom.VendorListView.VLAdderssCity AS VendorCity, wACom.VendorListView.VLAddressState AS VendorState, wACom.VendorListView.VLAddressZip AS VendorZip, 
                         wACom.VendorListView.VLAddressPhone1 AS VendorPhone, wACom.VendorListView.VLAddressPhone2 AS VendorPhone2, wACom.VendorListView.VLID AS VendorID, 
                         EQP.EquipmentModelNumber.EQModModelNumber + N' -' + EQP.EquipmentModelNumber.EQModDescription AS TreeDisplay
FROM            EQP.EquipmentModelNumber LEFT OUTER JOIN
                         wACom.VendorListView ON EQP.EquipmentModelNumber.EQModVendorID = wACom.VendorListView.VLID LEFT OUTER JOIN
                         wACom.ManufacturerListView ON EQP.EquipmentModelNumber.EQModManID = wACom.ManufacturerListView.VLID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[35] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[39] 4[24] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[46] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EquipmentModelNumber (EQP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 261
               Right = 336
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VendorListView (wACom)"
            Begin Extent = 
               Top = 6
               Left = 461
               Bottom = 165
               Right = 712
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "ManufacturerListView (wACom)"
            Begin Extent = 
               Top = 106
               Left = 446
               Bottom = 276
               Right = 774
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 25
         Width = 284
         Width = 1500
         Width = 2760
         Width = 1500
         Width = 3180
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5010
         Alias = 3015
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         Sort' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppModelNumbers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'Type = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppModelNumbers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppModelNumbers'
GO
/****** Object:  View [wAppTPM].[wAppProcNumbers]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTPM].[wAppProcNumbers]
AS
SELECT     wACom.MachineList.MLCELLNAME, wACom.MachineList.MLPlantID, wACom.MachineList.MLLINEID, EQP.Equipment.EQTID, 
                      EquipmentModelNumber_1.EQModModelNumber, EquipmentModelNumber_1.EQModManID, EquipmentModelNumber_1.EQModDescription, 
                      EquipmentModelNumber_1.EQModVendorID, EquipmentModelNumber_1.EQModOrderNumber, EquipmentModelNumber_1.EQModImageOne, 
                      EquipmentModelNumber_1.EQModID, wACom.MachineList.MLID, EQP.ProcNumbers.PROCNUMBER, EQP.ProcNumbers.PROCNAME, EQP.ProcNumbers.PROCASSET, 
                      EQP.ProcNumbers.PROCARG, EQP.ProcNumbers.PROCMODEL, EQP.ProcNumbers.PROCQUARTGROUP, EQP.ProcNumbers.PROCSEMIGROUP, 
                      EQP.ProcNumbers.PROCANUALGROUP, EQP.ProcNumbers.PROCMONTHGROUP, EQP.ProcNumbers.PROCWEEKGROUP, EQP.ProcNumbers.PROCID, 
                      EQP.ProcNumbers.PROCBIMONTHGROUP, EQP.ProcNumbers.PROCTWOYRGRUP, EQP.ProcNumbers.PROCEIGHTYRGROUP, 
                      EQP.ProcNumbers.PROCFOURYRGROUP, EQP.ProcNumbers.PROCTHREEYRGROUP, EQP.Equipment.EQSerialNumber, EQP.Equipment.EQTModelLink, 
                      EQP.Equipment.EQTPrintNumber, wAppTPM.wAppModelNumbers.EQModModelNumber AS EQP_ModelNumber, 
                      wAppTPM.wAppModelNumbers.EQModDescription AS EQP_Description, wAppTPM.wAppModelNumbers.EQModID AS EQP_AssetNumber, 
                      EQP.ProcNumbers.PROCASSIGNTO, wACom.TeamListDrop.Myname
FROM         wACom.TeamListDrop RIGHT OUTER JOIN
                      EQP.ProcNumbers ON wACom.TeamListDrop.TMID = EQP.ProcNumbers.PROCASSIGNTO LEFT OUTER JOIN
                      EQP.EquipmentModelNumber AS EquipmentModelNumber_1 ON EQP.ProcNumbers.PROCMODEL = EquipmentModelNumber_1.EQModID LEFT OUTER JOIN
                      EQP.Equipment LEFT OUTER JOIN
                      wAppTPM.wAppModelNumbers ON EQP.Equipment.EQTModelLink = wAppTPM.wAppModelNumbers.EQModID ON 
                      EQP.ProcNumbers.PROCASSET = EQP.Equipment.EQTID LEFT OUTER JOIN
                      wACom.MachineList ON EQP.ProcNumbers.PROCARG = wACom.MachineList.MLID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[33] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Equipment (EQP)"
            Begin Extent = 
               Top = 25
               Left = 932
               Bottom = 251
               Right = 1113
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "wAppModelNumbers (wAppTPM)"
            Begin Extent = 
               Top = 34
               Left = 1167
               Bottom = 291
               Right = 1347
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 327
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "EquipmentModelNumber_1"
            Begin Extent = 
               Top = 70
               Left = 337
               Bottom = 185
               Right = 590
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 682
               Bottom = 121
               Right = 880
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TeamListDrop (wACom)"
            Begin Extent = 
               Top = 191
               Left = 423
               Bottom = 310
               Right = 583
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
     ' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppProcNumbers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' Begin ColumnWidths = 35
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3150
         Alias = 2895
         Table = 3945
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppProcNumbers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppProcNumbers'
GO
/****** Object:  StoredProcedure [wAppTPM].[ProcNumberFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[ProcNumberFetch]
@Plant as Integer
AS

	SELECT * FROM wAppTPM.wAppProcNumbers
	WHERE MLPlantID = @Plant
	ORDER BY PROCNUMBER

	RETURN
GO
/****** Object:  Table [COM].[VendorList]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [COM].[VendorList](
	[VLName] [nvarchar](255) NULL,
	[VLAddressStreet] [nvarchar](255) NULL,
	[VLAdderssCity] [nvarchar](255) NULL,
	[VLAddressState] [nvarchar](255) NULL,
	[VLAddressZip] [nvarchar](255) NULL,
	[VLAddressPhone1] [nvarchar](255) NULL,
	[VLAddressPhone2] [nvarchar](255) NULL,
	[VLID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_VendorList] PRIMARY KEY CLUSTERED 
(
	[VLID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SEC].[VersionControlTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SEC].[VersionControlTable](
	[VCID] [int] NOT NULL,
	[VCProgName] [nvarchar](255) NULL,
	[VCProgVersion] [nvarchar](255) NULL,
	[VCSourcePath] [nvarchar](255) NULL,
	[VCDestination] [nvarchar](255) NULL,
	[VCDate] [datetime] NULL,
 CONSTRAINT [PK_VersionControlTable] PRIMARY KEY CLUSTERED 
(
	[VCID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SP].[UsageTypes]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[UsageTypes](
	[UTID] [int] IDENTITY(1,1) NOT NULL,
	[UTName] [nvarchar](50) NULL,
	[UTDisplay] [nvarchar](50) NULL,
 CONSTRAINT [PK_UsageTypes] PRIMARY KEY CLUSTERED 
(
	[UTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SP].[UsageList]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[UsageList](
	[ULID] [int] IDENTITY(1,1) NOT NULL,
	[ULListType] [int] NOT NULL,
	[ULTableLink] [int] NULL,
	[ULSPLink] [int] NOT NULL,
	[ULSPQtyUsed] [int] NOT NULL,
	[ULSPQtyNeeded] [int] NULL,
	[ULSPNotes] [nvarchar](max) NULL,
	[USWearType] [int] NULL,
	[ULDate] [date] NULL,
 CONSTRAINT [PK_UsageList] PRIMARY KEY CLUSTERED 
(
	[ULID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Link to the table source such as Work Orders or Downtime' , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'UsageList', @level2type=N'COLUMN',@level2name=N'ULListType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Link to the source table for the link. IE. Work Orders, Downtime.' , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'UsageList', @level2type=N'COLUMN',@level2name=N'ULTableLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Link to the SPMaster2 table.' , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'UsageList', @level2type=N'COLUMN',@level2name=N'ULSPLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Type of wear, link to the wear table.' , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'UsageList', @level2type=N'COLUMN',@level2name=N'USWearType'
GO
/****** Object:  View [Documentation].[TurnDrop]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Documentation].[TurnDrop]
AS
SELECT     TOId, TODate
FROM         Documentation.TurnOverLog
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TurnOverLog (Documentation)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 218
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Documentation', @level1type=N'VIEW',@level1name=N'TurnDrop'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'Documentation', @level1type=N'VIEW',@level1name=N'TurnDrop'
GO
/****** Object:  StoredProcedure [TPM].[TPMWeeklyCalcOne]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TPM].[TPMWeeklyCalcOne]
@DatePass date


AS

DECLARE @strSQL nVarChar(max);
DECLARE @strSQLOne nVarChar(max);
DECLARE @strParam nVarChar(max);


SET @strParam = '
	@DatePass1 Date
	';

SET @strSQL = 
	'	SELECT PN.PROCID,PN.PROCNUMBER,PN.PROCARG,PN.PROCMODEL,EQP.EquipmentModelNumber.EQModID As ModNum, TPM.TPMProcdure.TPMProcID,TPM.TPMProcdure.TPMProcFreq
		FROM EQP.ProcNumbers as PN
		LEFT JOIN EQP.EquipmentModelNumber ON PN.PROCMODEL =  EQP.EquipmentModelNumber.EQModID
		JOIN TPM.TPMProcdure ON EQP.EquipmentModelNumber.EQModID = TPM.TPMProcdure.TPMProcID
		WHERE PN.PROCWEEKGROUP = (1) AND TPM.TPMProcdure.TPMProcFreq = 4

		ORDER BY PN.PROCID';



 EXEC sp_executesql
 @strSql,
 @strParam,
 @DatePass1 = @DatePass
 ;



	RETURN
GO
/****** Object:  Table [TPM].[TPMType]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TPM].[TPMType](
	[TPMTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TPMTypeName] [nvarchar](255) NULL,
 CONSTRAINT [PK_TPMType_1] PRIMARY KEY CLUSTERED 
(
	[TPMTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [TPM].[TPMTaskPartsUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TPM].[TPMTaskPartsUpdate]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  Table [SP].[TPMTaskPartsTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[TPMTaskPartsTable](
	[TTPID] [int] IDENTITY(1,1) NOT NULL,
	[TTPTaskLink] [int] NOT NULL,
	[TTPPartLink] [int] NOT NULL,
	[TTPPartCount] [decimal](2, 0) NOT NULL,
 CONSTRAINT [PK_TPMTaskPartsTable] PRIMARY KEY CLUSTERED 
(
	[TTPID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [TPM].[TPMTaskPartsInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TPM].[TPMTaskPartsInsert]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  StoredProcedure [wAppParts].[TPMTaskPartListUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [wAppParts].[TPMTaskPartListUpdate]
	/*(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  StoredProcedure [wAppParts].[TPMTaskPartListInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [wAppParts].[TPMTaskPartListInsert]
	/*(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  StoredProcedure [wAppParts].[TPMTaskPartListFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [wAppParts].[TPMTaskPartListFetch]
	/*(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  StoredProcedure [wAppParts].[TPMTaskPartListDelete]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [wAppParts].[TPMTaskPartListDelete]
	/*(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  StoredProcedure [wAppParts].[TPMTaskPartList]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppParts].[TPMTaskPartList]
	/*(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[waPlantUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waPlantUpdate]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  View [wAppTeam].[SignatureSheetView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTeam].[SignatureSheetView]
AS
SELECT     Team.teammembers.TMFirstName, Team.teammembers.TMLastName, Team.teammembers.TMShift, Team.teammembers.TMPhone, 
                      Team.teammembers.TMRadioNumber, Team.teammembers.TMImage, Team.teammembers.TMArea, Team.teammembers.TMUserName, 
                      Team.teammembers.TMSecurityLevel, Team.teammembers.TMLastThree, Team.teammembers.TMHireDate, Team.teammembers.TMID, 
                      Team.teammembers.TMGROUPLINK, Team.teammembers.TMEmpNumber, Team.teammembers.TMNShift, Team.teammembers.TMDEPARTMENTLINK, 
                      Team.teammembers.TMPLANTLINK, Team.teammembers.TMEmail, Team.teammembers.TMPayStatus, Team.wAPlants.PNID
FROM         Team.teammembers LEFT OUTER JOIN
                      Team.wAPlants ON Team.teammembers.TMPLANTLINK = Team.wAPlants.PNID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "teammembers (Team)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 253
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "wAPlants (Team)"
            Begin Extent = 
               Top = 141
               Left = 461
               Bottom = 234
               Right = 612
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTeam', @level1type=N'VIEW',@level1name=N'SignatureSheetView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppTeam', @level1type=N'VIEW',@level1name=N'SignatureSheetView'
GO
/****** Object:  StoredProcedure [wAppTeam].[waPlantInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waPlantInsert]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  Table [SP].[WearTypes]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[WearTypes](
	[WTID] [int] IDENTITY(1,1) NOT NULL,
	[WTDescription] [nvarchar](50) NULL,
	[WTDisplay] [nchar](10) NULL,
 CONSTRAINT [PK_WearTypes] PRIMARY KEY CLUSTERED 
(
	[WTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Team].[waTeam]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[waTeam](
	[TEID] [int] IDENTITY(1,1) NOT NULL,
	[TEName] [nvarchar](50) NOT NULL,
	[TEGNLink] [int] NOT NULL,
 CONSTRAINT [PK_waTeam] PRIMARY KEY CLUSTERED 
(
	[TEID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [Weld].[WeldMoveUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[WeldMoveUpdate]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  Table [Weld].[WeldMoves]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Weld].[WeldMoves](
	[WMID] [int] IDENTITY(1,1) NOT NULL,
	[WMReason] [nvarchar](max) NOT NULL,
	[WMTM] [int] NOT NULL,
	[WMMoveDate] [date] NOT NULL,
	[WMSourceRobot] [int] NOT NULL,
	[WMDestRobot] [int] NOT NULL,
	[WMWeldNumber] [int] NOT NULL,
 CONSTRAINT [PK_WeldMoves] PRIMARY KEY CLUSTERED 
(
	[WMID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Team].[TeamLeaderGroups]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[TeamLeaderGroups](
	[TLGID] [int] IDENTITY(1,1) NOT NULL,
	[TLGName] [nvarchar](max) NOT NULL,
	[TLGPlant] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [DT].[TechReportArchive]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DT].[TechReportArchive](
	[TRAID] [int] NOT NULL,
	[TRACW] [int] NOT NULL,
	[TRATECH] [int] NOT NULL,
	[TRAMonDate] [date] NOT NULL,
	[TRAMin] [int] NOT NULL,
	[TRACell] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [wAppDoc].[tierOneUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[tierOneUpdate]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  StoredProcedure [Production].[testproc]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Production].[testproc]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	INSERT INTO Production.test
	(
	textCol1
	)
	VALUES
	(
	'this is a test'
	)
	RETURN
GO
/****** Object:  Table [Weld].[TearDownGroupI]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Weld].[TearDownGroupI](
	[TDGIID] [int] IDENTITY(1,1) NOT NULL,
	[TDGIName] [nvarchar](50) NOT NULL,
	[TDGIShortName] [nchar](10) NOT NULL,
 CONSTRAINT [PK_TearDownGroupI] PRIMARY KEY CLUSTERED 
(
	[TDGIID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Team].[TeamMemberTitles]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[TeamMemberTitles](
	[TMTID] [int] IDENTITY(1,1) NOT NULL,
	[TMTName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TeamMemberTitles] PRIMARY KEY CLUSTERED 
(
	[TMTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Backups].[SecTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Backups].[SecTable](
	[ATID] [int] IDENTITY(1,1) NOT NULL,
	[ATUID] [int] NOT NULL,
	[ATTeamAccess] [bit] NULL,
	[ATTeamManage] [bit] NULL,
	[ATTeamSecLevel] [bit] NULL,
	[ATTTeamAccessForm] [bit] NULL,
	[ATTTpmRibbonButton] [bit] NULL,
	[ATOpenItemRibbonButton] [bit] NULL,
	[ATDowntime] [bit] NULL,
	[ATDocumentation] [bit] NULL,
	[ATWorkOrders] [bit] NULL,
	[ATPartTracking] [bit] NULL,
	[ATDown_Add] [bit] NULL,
	[ATDown_OpenItem] [bit] NULL,
	[ATDown_WorkOrder] [bit] NULL,
	[ATDown_Delete] [bit] NULL,
	[ATOvertimeEdit] [bit] NULL,
	[ATDocEdit] [bit] NULL,
	[ATTeamReports] [bit] NULL,
	[ATTeamBuildButton] [bit] NULL,
	[ATOvertimeManage] [bit] NULL,
	[ATTeamBuildSuper] [bit] NULL,
	[wATPMMenu] [bit] NULL,
	[wAOIMenu] [bit] NULL,
	[wATeamMenu] [bit] NULL,
	[wAWOMenu] [bit] NULL,
	[wADocMenu] [bit] NULL,
	[wADTMenu] [bit] NULL,
	[wAEcoMenu] [bit] NULL,
	[wAPartsMenu] [bit] NULL,
	[wATeam_Builder] [bit] NULL,
	[wATeam_Builder_Supervisor] [bit] NULL,
	[wATeam_Overtime] [bit] NULL,
	[wATeam_Overtime_Supervisor] [bit] NULL,
	[wATeam_Security] [bit] NULL,
	[wATeam_Security_Supervisor] [bit] NULL,
	[wATeam_Reports] [bit] NULL,
	[wATPM_OpenWO_Editor] [bit] NULL,
	[wABeta] [bit] NULL,
	[wADocAdd] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [SP].[ShelfFrame]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[ShelfFrame](
	[SFID] [int] IDENTITY(1,1) NOT NULL,
	[SFName] [nvarchar](255) NULL,
	[SFCabinet] [int] NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame', @level2type=N'COLUMN',@level2name=N'SFCabinet'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ShelfFrame'
GO
/****** Object:  Table [Weld].[TearDownGroupTwo]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Weld].[TearDownGroupTwo](
	[TDGTwoID] [int] IDENTITY(1,1) NOT NULL,
	[TDGTwoName] [nvarchar](50) NOT NULL,
	[TDGTwoShortName] [nvarchar](50) NOT NULL,
	[TDGTwoOneLink] [int] NOT NULL,
 CONSTRAINT [PK_TearDownGroupTwo] PRIMARY KEY CLUSTERED 
(
	[TDGTwoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [TPM].[TPMPriority]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TPM].[TPMPriority](
	[TPMPRID] [int] IDENTITY(1,1) NOT NULL,
	[TPMPRText] [nvarchar](50) NULL,
 CONSTRAINT [PK_TPMPriority] PRIMARY KEY CLUSTERED 
(
	[TPMPRID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Backups].[TPMProcedures]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Backups].[TPMProcedures](
	[TPMProcID] [int] IDENTITY(1,1) NOT NULL,
	[TPMProcTitle] [nvarchar](255) NULL,
	[TPMProcFreq] [int] NULL,
	[TPMProcType] [int] NULL,
	[TPMProcProcedure] [nvarchar](max) NULL,
	[TMPProcModelLink] [int] NULL,
	[TPMProcContDocNum] [int] NULL,
	[TPMPRocNumTM] [decimal](18, 0) NULL,
	[TPMProcEstMin] [decimal](18, 0) NULL,
	[TPMProcLineStatus] [int] NULL,
	[TPMProcPriority] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [TPM].[TPMProcedureAvailability]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TPM].[TPMProcedureAvailability](
	[TPMAvID] [int] IDENTITY(1,1) NOT NULL,
	[TPMAvText] [nvarchar](50) NULL,
 CONSTRAINT [PK_TPMProcedureAvailability] PRIMARY KEY CLUSTERED 
(
	[TPMAvID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [TPM].[TPMDocumentControl]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TPM].[TPMDocumentControl](
	[TPMDocControlID] [int] IDENTITY(1,1) NOT NULL,
	[TPMDoccontrolName] [nvarchar](255) NULL,
 CONSTRAINT [PK_TPMDocumentControl] PRIMARY KEY CLUSTERED 
(
	[TPMDocControlID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SP].[TPMPartLink]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[TPMPartLink](
	[TSPID] [int] IDENTITY(1,1) NOT NULL,
	[TPSPartLink] [int] NULL,
	[TPSQty] [int] NULL,
	[TPSTPMProcedure] [int] NULL,
 CONSTRAINT [PK_TPMPartLink] PRIMARY KEY CLUSTERED 
(
	[TSPID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [WO].[WorkOrderUtilizationView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [WO].[WorkOrderUtilizationView]
AS
SELECT     Team.teammembers.TMFirstName, Team.teammembers.TMLastName, Team.teammembers.TMShift, WO.WorkOrderUtilization.WOUTID, 
                      WO.WorkOrderUtilization.WOUTMID, WO.WorkOrderUtilization.WOUMin, WO.WorkOrderUtilization.WODISID
FROM         WO.WorkOrderUtilization LEFT OUTER JOIN
                      Team.teammembers ON WO.WorkOrderUtilization.WOUTMID = Team.teammembers.TMID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WorkOrderUtilization (WO)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 195
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "teammembers (Team)"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 260
               Right = 409
            End
            DisplayFlags = 280
            TopColumn = 9
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'WO', @level1type=N'VIEW',@level1name=N'WorkOrderUtilizationView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'WO', @level1type=N'VIEW',@level1name=N'WorkOrderUtilizationView'
GO
/****** Object:  View [wAppWorkOrder].[woUtilizationCombined]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppWorkOrder].[woUtilizationCombined]
AS
SELECT     WO.WorkOrderUtilization.WODISID, WO.WorkOrderUtilization.WOUTMID, WO.WorkOrderUtilization.WOUMin, WO.WorkOrderMain.DISCloseDate, 
                      WO.WorkOrderMain.DISWorkRequired, WO.WorkOrderMain.DISWorkAccomp, Team.teammembers.TMFirstName, Team.teammembers.TMLastName, 
                      Team.teammembers.TMShift, Team.teammembers.TMGROUPLINK, Team.teammembers.TMDEPARTMENTLINK, Team.teammembers.TMPLANTLINK, 
                      Team.teammembers.TMNShift, WO.WorkOrderMain.DISID
FROM         Team.teammembers RIGHT OUTER JOIN
                      WO.WorkOrderUtilization ON Team.teammembers.TMID = WO.WorkOrderUtilization.WOUTMID LEFT OUTER JOIN
                      WO.WorkOrderMain ON WO.WorkOrderUtilization.WODISID = WO.WorkOrderMain.DISID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WorkOrderMain (WO)"
            Begin Extent = 
               Top = 6
               Left = 272
               Bottom = 260
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "WorkOrderUtilization (WO)"
            Begin Extent = 
               Top = 4
               Left = 72
               Bottom = 258
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "teammembers (Team)"
            Begin Extent = 
               Top = 6
               Left = 492
               Bottom = 260
               Right = 674
            End
            DisplayFlags = 280
            TopColumn = 9
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2640
         Width = 2325
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'woUtilizationCombined'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'woUtilizationCombined'
GO
/****** Object:  Table [Development].[WorkOrderMain]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Development].[WorkOrderMain](
	[DISOpenDate] [datetime] NULL,
	[DISCloseDate] [datetime] NULL,
	[DISWorkRequired] [nvarchar](max) NULL,
	[DISNumberAss] [int] NULL,
	[DISManHours] [int] NULL,
	[DISWorkAccomp] [nvarchar](max) NULL,
	[DISLineNumber] [int] NULL,
	[DISEquip] [int] NULL,
	[DISDueDate] [datetime] NULL,
	[DISOriginator] [int] NULL,
	[DISResponsible] [int] NULL,
	[DISType] [int] NULL,
	[DISRequestor] [int] NULL,
	[DISOpenItemNumber] [int] NULL,
	[DISTPMNumber] [int] NULL,
	[DISID] [int] IDENTITY(1,1) NOT NULL,
	[DISIntHold] [int] NULL,
	[DISCharHold] [nvarchar](max) NULL,
	[DISAsset] [int] NULL,
	[DISSchedDate] [date] NULL,
	[DISSchedShift] [int] NULL,
	[DISClosedIncomplete] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Weld].[WeldTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Weld].[WeldTable](
	[Timer] [nvarchar](255) NULL,
	[SIDProgramNumber] [int] NOT NULL,
	[SIDRobotCallNumber] [nvarchar](50) NOT NULL,
	[SIDWeldIDNumber] [nvarchar](255) NOT NULL,
	[SIDRobotSequence] [int] NOT NULL,
	[SIDTearDownID] [int] NOT NULL,
	[WeldGunID] [nvarchar](255) NULL,
	[SIDMaxForce] [float] NOT NULL,
	[SIDElectrodeFace] [nvarchar](255) NOT NULL,
	[SIDSealerPresent] [bit] NOT NULL,
	[SIDMatOneThick] [float] NOT NULL,
	[SIDMatTwoThick] [float] NOT NULL,
	[SIDMatThreeThick] [float] NOT NULL,
	[SIDMatFourThick] [float] NOT NULL,
	[SIDNuggetSize] [nvarchar](255) NOT NULL,
	[SIDID] [int] IDENTITY(1,1) NOT NULL,
	[SIDTimerLink] [int] NOT NULL,
	[SIDRobotLink] [int] NOT NULL,
	[SIDWeldGunType] [int] NOT NULL,
	[SIDMatOneLink] [int] NOT NULL,
	[SIDMatTwoLink] [int] NOT NULL,
	[SIDMatThreeLink] [int] NOT NULL,
	[SIDMatFourLink] [int] NOT NULL,
	[SIDWeldGunTypeLink] [int] NOT NULL,
	[SIDTearDownGroup] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [Weld].[WeldTableDelete]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[WeldTableDelete]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  StoredProcedure [Weld].[WeldMoveDelete]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[WeldMoveDelete]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  StoredProcedure [Weld].[WeldMatDataAdd]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[WeldMatDataAdd]

	@MatName nVarChar(max),
	@MatYield integer,
	@Return Integer OUTPUT


AS


	DECLARE @strInsert nvarchar(max);
	DECLARE @strParam nvarchar(max);
	DECLARE @Return3 integer;

	SET @strInsert = ' Insert Into Weld.MaterialData (MDName,MDYieldStrength) VALUES(@MatName1,@MatYield1); Select @Return1 = Scope_Identity();';
	SET @strParam = '@MatName1 nVarChar(max), @MatYield1 integer, @Return1 integer OUTPUT';



	
EXEC sp_executesql
 @strInsert,
 @strParam,
 @MatYield1 = @MatYield,
 @MatName1 = @MatName,
 @Return1 = @Return3 OUTPUT;

 Set @Return = @Return3;

	RETURN
GO
/****** Object:  Table [Weld].[WeldFaults]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Weld].[WeldFaults](
	[WFID] [int] IDENTITY(1,1) NOT NULL,
	[WFText] [nvarchar](50) NOT NULL,
	[WFLink] [int] NOT NULL,
 CONSTRAINT [PK_WeldFaults] PRIMARY KEY CLUSTERED 
(
	[WFLink] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [Weld].[WeldTableInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[WeldTableInsert]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  Table [EQP].[SpotID]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[SpotID](
	[Timer] [nvarchar](255) NULL,
	[SIDProgramNumber] [int] NOT NULL,
	[SIDRobotCallNumber] [nvarchar](50) NOT NULL,
	[SIDWeldIDNumber] [nvarchar](255) NOT NULL,
	[SIDRobotSequence] [int] NOT NULL,
	[SIDTearDownID] [int] NOT NULL,
	[WeldGunID] [nvarchar](255) NULL,
	[SIDMaxForce] [float] NOT NULL,
	[SIDElectrodeFace] [nvarchar](255) NOT NULL,
	[SIDSealerPresent] [bit] NOT NULL,
	[SIDMatOneThick] [float] NOT NULL,
	[SIDMatTwoThick] [float] NOT NULL,
	[SIDMatThreeThick] [float] NOT NULL,
	[SIDMatFourThick] [float] NOT NULL,
	[SIDNuggetSize] [nvarchar](255) NOT NULL,
	[SIDID] [int] IDENTITY(1,1) NOT NULL,
	[SIDTimerLink] [int] NOT NULL,
	[SIDRobotLink] [int] NOT NULL,
	[SIDWeldGunType] [int] NOT NULL,
	[SIDMatOneLink] [int] NOT NULL,
	[SIDMatTwoLink] [int] NOT NULL,
	[SIDMatThreeLink] [int] NOT NULL,
	[SIDMatFourLink] [int] NOT NULL,
	[SIDWeldGunTypeLink] [int] NOT NULL,
 CONSTRAINT [PK_SpotID] PRIMARY KEY CLUSTERED 
(
	[SIDID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SP].[spmaster2_test]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[spmaster2_test](
	[SP2ExcelRef] [bigint] NULL,
	[SP2VWNumber] [nvarchar](max) NULL,
	[SP2Specification] [nvarchar](max) NULL,
	[SP2SupplierPN] [nvarchar](max) NULL,
	[SP2MFGPN] [nvarchar](max) NULL,
	[SP2SAPMFGPN] [nvarchar](max) NULL,
	[SP2MFGID] [bigint] NULL,
	[SP2MFGGuess] [nvarchar](max) NULL,
	[SP2MFGActual] [nvarchar](max) NOT NULL,
	[SP2ShortDescr] [nvarchar](max) NULL,
	[SP2ShortSAPDescr] [nvarchar](max) NULL,
	[SP2ShortCount] [int] NULL,
	[SP2EClass] [bigint] NULL,
	[SP2ValuationClass] [bigint] NULL,
	[SP2LongDesc] [nvarchar](max) NULL,
	[SP2ShopUsed] [nvarchar](max) NULL,
	[SP2UnitPrice] [money] NULL,
	[SP2RecQuantity] [int] NULL,
	[SP2Priority] [nvarchar](max) NULL,
	[SP2EstLife] [nvarchar](max) NULL,
	[SP2Leadtime] [nvarchar](max) NULL,
	[SP2PurchUOM] [nvarchar](max) NULL,
	[SP2IssueUOM] [nvarchar](max) NULL,
	[SP2SpareType] [nvarchar](max) NULL,
	[SP2DrawingNumber] [nvarchar](max) NULL,
	[SP2StoresItem] [nvarchar](max) NULL,
	[SP2ShopCartNum] [nvarchar](max) NULL,
	[SP2SPLNumber] [nvarchar](max) NULL,
	[SP2Notes] [nvarchar](max) NULL,
	[SP2LineBuilder] [nvarchar](max) NULL,
	[SP2EnvRelv] [nvarchar](max) NULL,
	[SP2GSRec] [nvarchar](max) NULL,
	[SP2Date] [date] NULL,
	[SP2Min] [int] NULL,
	[SP2Max] [int] NULL,
	[SP2BinLocation] [nvarchar](max) NULL,
	[SP2QtyIssue] [int] NULL,
	[SP2BOH] [int] NULL,
	[SP2DateIssued] [date] NULL,
	[SP2SPUploadDate] [date] NULL,
	[SP2InStock] [nvarchar](max) NULL,
	[SP2SAPOnHand] [int] NULL,
	[SP2SAPBinLoc] [nvarchar](max) NULL,
	[SP2ProvToPurch] [date] NULL,
	[SP2SourcedTo] [nvarchar](max) NULL,
	[SP2SourcePrice] [float] NULL,
	[SP2SourcingStatus] [nvarchar](max) NULL,
	[SP2ID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [SP].[spmaster2_backup]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[spmaster2_backup](
	[SP2ExcelRef] [bigint] NULL,
	[SP2VWNumber] [nvarchar](max) NULL,
	[SP2Specification] [nvarchar](max) NULL,
	[SP2SupplierPN] [nvarchar](max) NULL,
	[SP2MFGPN] [nvarchar](max) NULL,
	[SP2SAPMFGPN] [nvarchar](max) NULL,
	[SP2MFGID] [bigint] NULL,
	[SP2MFGGuess] [nvarchar](max) NULL,
	[SP2MFGActual] [nvarchar](max) NOT NULL,
	[SP2ShortDescr] [nvarchar](max) NULL,
	[SP2ShortSAPDescr] [nvarchar](max) NULL,
	[SP2ShortCount] [int] NULL,
	[SP2EClass] [bigint] NULL,
	[SP2ValuationClass] [bigint] NULL,
	[SP2LongDesc] [nvarchar](max) NULL,
	[SP2ShopUsed] [nvarchar](max) NULL,
	[SP2UnitPrice] [money] NULL,
	[SP2RecQuantity] [int] NULL,
	[SP2Priority] [nvarchar](max) NULL,
	[SP2EstLife] [nvarchar](max) NULL,
	[SP2Leadtime] [nvarchar](max) NULL,
	[SP2PurchUOM] [nvarchar](max) NULL,
	[SP2IssueUOM] [nvarchar](max) NULL,
	[SP2SpareType] [nvarchar](max) NULL,
	[SP2DrawingNumber] [nvarchar](max) NULL,
	[SP2StoresItem] [nvarchar](max) NULL,
	[SP2ShopCartNum] [nvarchar](max) NULL,
	[SP2SPLNumber] [nvarchar](max) NULL,
	[SP2Notes] [nvarchar](max) NULL,
	[SP2LineBuilder] [nvarchar](max) NULL,
	[SP2EnvRelv] [nvarchar](max) NULL,
	[SP2GSRec] [nvarchar](max) NULL,
	[SP2Date] [date] NULL,
	[SP2Min] [int] NULL,
	[SP2Max] [int] NULL,
	[SP2BinLocation] [nvarchar](max) NULL,
	[SP2QtyIssue] [int] NULL,
	[SP2BOH] [int] NULL,
	[SP2DateIssued] [date] NULL,
	[SP2SPUploadDate] [date] NULL,
	[SP2InStock] [nvarchar](max) NULL,
	[SP2SAPOnHand] [int] NULL,
	[SP2SAPBinLoc] [nvarchar](max) NULL,
	[SP2ProvToPurch] [date] NULL,
	[SP2SourcedTo] [nvarchar](max) NULL,
	[SP2SourcePrice] [float] NULL,
	[SP2SourcingStatus] [nvarchar](max) NULL,
	[SP2ID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [SP].[SPMaster2]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[SPMaster2](
	[SP2ExcelRef] [bigint] NULL,
	[SP2VWNumber] [nvarchar](max) NULL,
	[SP2Specification] [nvarchar](max) NULL,
	[SP2SupplierPN] [nvarchar](max) NULL,
	[SP2MFGPN] [nvarchar](max) NULL,
	[SP2SAPMFGPN] [nvarchar](max) NULL,
	[SP2MFGID] [bigint] NULL,
	[SP2MFGGuess] [nvarchar](max) NULL,
	[SP2MFGActual] [nvarchar](max) NOT NULL,
	[SP2ShortDescr] [nvarchar](max) NULL,
	[SP2ShortSAPDescr] [nvarchar](max) NULL,
	[SP2ShortCount] [int] NULL,
	[SP2EClass] [bigint] NULL,
	[SP2ValuationClass] [bigint] NULL,
	[SP2LongDesc] [nvarchar](max) NULL,
	[SP2ShopUsed] [nvarchar](max) NULL,
	[SP2UnitPrice] [money] NULL,
	[SP2RecQuantity] [int] NULL,
	[SP2Priority] [nvarchar](max) NULL,
	[SP2EstLife] [nvarchar](max) NULL,
	[SP2Leadtime] [nvarchar](max) NULL,
	[SP2PurchUOM] [nvarchar](max) NULL,
	[SP2IssueUOM] [nvarchar](max) NULL,
	[SP2SpareType] [nvarchar](max) NULL,
	[SP2DrawingNumber] [nvarchar](max) NULL,
	[SP2StoresItem] [nvarchar](max) NULL,
	[SP2ShopCartNum] [nvarchar](max) NULL,
	[SP2SPLNumber] [nvarchar](max) NULL,
	[SP2Notes] [nvarchar](max) NULL,
	[SP2LineBuilder] [nvarchar](max) NULL,
	[SP2EnvRelv] [nvarchar](max) NULL,
	[SP2GSRec] [nvarchar](max) NULL,
	[SP2Date] [date] NULL,
	[SP2Min] [int] NULL,
	[SP2Max] [int] NULL,
	[SP2BinLocation] [nvarchar](max) NULL,
	[SP2QtyIssue] [int] NULL,
	[SP2BOH] [int] NULL,
	[SP2DateIssued] [date] NULL,
	[SP2SPUploadDate] [date] NULL,
	[SP2InStock] [nvarchar](max) NULL,
	[SP2SAPOnHand] [int] NULL,
	[SP2SAPBinLoc] [nvarchar](max) NULL,
	[SP2ProvToPurch] [date] NULL,
	[SP2SourcedTo] [nvarchar](max) NULL,
	[SP2SourcePrice] [float] NULL,
	[SP2SourcingStatus] [nvarchar](max) NULL,
	[SP2ID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [wACom].[Split]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [wACom].[Split]

(
      @RowData nvarchar(2000),
      @SplitOn nvarchar(5)
)  
RETURNS @RtnValue table 
(
      Id int identity(1,1),
      Data nvarchar(100)
) 
AS  
BEGIN 
      Declare @Cnt int
      Set @Cnt = 1

      While (Charindex(@SplitOn,@RowData)>0)
      Begin
            Insert Into @RtnValue (data)
            Select 
                  Data = ltrim(rtrim(Substring(@RowData,1,Charindex(@SplitOn,@RowData)-1)))

            Set @RowData = Substring(@RowData,Charindex(@SplitOn,@RowData)+1,len(@RowData))
            Set @Cnt = @Cnt + 1
      End
      
      Insert Into @RtnValue (data)
      Select Data = ltrim(rtrim(@RowData))

      Return
END
GO
/****** Object:  StoredProcedure [wAppDT].[DowntimeFetchFilter]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[DowntimeFetchFilter]
	
	(
		@toplevel int = 99999,
		@DateStart date = '5/10/2012',
		@DateEnd date = '5/20/2012',
		@Line nVarChar(max) = '1,2,3,4,5,6,7,8,9',
		@Cell Integer = 0,
		@Plant Integer = 0,
		@nameFilter nVarChar(max) = '%',
		@genFilter nVarChar(max) = '%',
		@TimeStart nVarChar(50) = '06:00:00',
		@TimeEnd nVarChar(50) = '18:00:00'
	)
	
AS
	DECLARE @combStart DateTime;
	DECLARE @combEnd DateTime;

	SET @combStart = (CONVERT(datetime,CONVERT(date,@DateStart,(0)),(0)) +	CONVERT(time,@TimeStart,(0)))
	
    SET @combEnd =   (CONVERT(datetime, CONVERT(date,@DateEnd ,(0)),(0)) +  CONVERT(time,@TimeEnd,(0)))


			
			SELECT TOP (@toplevel) * FROM wAppDT.Downtime_MainFormView
				WHERE (
						(Convert(DATETIME,Convert(date,DTNDateDown,(0)),(0)) + Convert(time,DTNTimeDown,(0))) BETWEEN @combStart and @combEnd
						AND LIID IN (SELECT DATA FROM waCom.Split(@line,','))
						AND MyName Like @nameFilter
						AND (DTMalfunction Like @genFilter OR DTSolution Like @genFilter or DTlongTerm Like @GenFilter)
					  )
				ORDER BY TotalTime Desc


	RETURN
GO
/****** Object:  Table [OI].[Specifications]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [OI].[Specifications](
	[ID] [int] NOT NULL,
	[SpecNumber] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [WO].[ScheduleTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WO].[ScheduleTable](
	[STID] [int] IDENTITY(1,1) NOT NULL,
	[STDate] [date] NOT NULL,
	[STMaintShiftOne] [int] NOT NULL,
	[STMaintShiftTwo] [int] NOT NULL,
	[STMaintShiftThree] [int] NOT NULL,
	[STProdShiftOne] [int] NOT NULL,
	[STProdShiftTwo] [int] NOT NULL,
	[STProdShiftThree] [int] NOT NULL,
	[STlive] [bit] NULL,
 CONSTRAINT [PK_ScheduleTable] PRIMARY KEY CLUSTERED 
(
	[STID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [SP].[ScheduledUsageList]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[ScheduledUsageList](
	[SULID] [int] NOT NULL,
	[SULListType] [int] NOT NULL,
	[SULTableLink] [int] NOT NULL,
	[SULSPLink] [int] NOT NULL,
	[SULQtyRequired] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [OI].[SubjectList]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [OI].[SubjectList](
	[ID] [int] NOT NULL,
	[Subject] [nvarchar](255) NULL,
	[Group] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [OI].[StatusLevels]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [OI].[StatusLevels](
	[STtitle] [nvarchar](255) NULL,
	[STImage] [image] NULL,
	[STID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_StatusLevels] PRIMARY KEY CLUSTERED 
(
	[STID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [TPM].[TaskListType]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TPM].[TaskListType](
	[TLTID] [int] IDENTITY(1,1) NOT NULL,
	[TLTName] [nvarchar](50) NOT NULL,
	[TLTTextCode] [nchar](10) NOT NULL,
 CONSTRAINT [PK_TaskListType] PRIMARY KEY CLUSTERED 
(
	[TLTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [TPM].[TaskListSubTypeOne]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TPM].[TaskListSubTypeOne](
	[TLTSIID] [int] IDENTITY(1,1) NOT NULL,
	[TLTSIName] [nvarchar](50) NOT NULL,
	[TLTSITextCode] [nchar](10) NOT NULL,
	[TLTSITypeLink] [int] NOT NULL,
 CONSTRAINT [PK_TaskListSubTypeOne] PRIMARY KEY CLUSTERED 
(
	[TLTSIID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [TPM].[TaskCatagoryLevelI]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TPM].[TaskCatagoryLevelI](
	[TCLIID] [int] IDENTITY(1,1) NOT NULL,
	[TCLIText] [nvarchar](50) NULL,
	[TCLICode] [nchar](10) NULL,
	[TCLIParent] [int] NULL,
 CONSTRAINT [PK_TaskCatagoryLevelI] PRIMARY KEY CLUSTERED 
(
	[TCLIID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [wAppEQP].[ProcNumberEdit]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ProcNumberEdit]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  UserDefinedFunction [Backups].[ProcTrans]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Backups].[ProcTrans]

	(
		@ProcNumber nVarChar(50)
	)
RETURNS nVarChar(50)
AS
	BEGIN
	DECLARE @returnString nVarChar(50);
	
	IF LEFT(@ProcNumber, 2) = '1B'
		BEGIN

			SET @returnString = LEFT(@ProcNumber, 4) + '-' +  SUBSTRING(@ProcNumber, 5, 4) + '-' +  SUBSTRING(@ProcNumber, 9, LEN(@ProcNumber))

		END
	ELSE
		BEGIN

			SET @returnString = @ProcNumber

		END


	RETURN @returnString
	END
GO
/****** Object:  Table [Development].[RecursiveTest]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Development].[RecursiveTest](
	[IDCol] [int] IDENTITY(1,1) NOT NULL,
	[NameCol] [nvarchar](50) NULL,
	[Parent] [int] NULL,
 CONSTRAINT [PK_RecursiveTest] PRIMARY KEY CLUSTERED 
(
	[IDCol] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Weld].[ResistanceWeldErrorLog]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Weld].[ResistanceWeldErrorLog](
	[RWELID] [int] IDENTITY(1,1) NOT NULL,
	[RWELIDNum] [int] NOT NULL,
	[RWELDate] [datetime2](7) NOT NULL,
	[RWELProgramNumber] [int] NOT NULL,
	[RWELFaultNumber] [int] NOT NULL,
	[RWELFaultText] [nvarchar](max) NOT NULL,
	[RWELProgramedValue] [decimal](18, 4) NOT NULL,
	[RWELActualValue] [decimal](18, 4) NOT NULL,
	[RWELProgrammedTime] [decimal](18, 4) NOT NULL,
	[RWELActualTime] [decimal](18, 4) NOT NULL,
	[RWELSpotName] [nvarchar](max) NOT NULL,
	[RWELWear] [decimal](18, 4) NOT NULL,
	[RWELTimerName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_ResistanceWeldErrorLog] PRIMARY KEY CLUSTERED 
(
	[RWELID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [OI].[RequiredDocs]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [OI].[RequiredDocs](
	[id] [int] NOT NULL,
	[subject] [int] NULL,
	[document] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [EQP].[RobotList]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[RobotList](
	[fnumber] [nvarchar](255) NULL,
	[btnumber] [nvarchar](255) NULL,
	[model] [nvarchar](255) NULL,
	[model_length] [nvarchar](255) NULL,
	[dress pack style] [nvarchar](255) NULL,
	[id] [int] NOT NULL,
	[robotnumber] [nvarchar](255) NULL,
	[RLIPNum] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [wAppEQP].[ProcNumberDelete]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ProcNumberDelete]

	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  Table [OI].[PLType]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [OI].[PLType](
	[PLTID] [int] IDENTITY(1,1) NOT NULL,
	[PLTType] [nvarchar](255) NULL,
 CONSTRAINT [PK_PLType] PRIMARY KEY CLUSTERED 
(
	[PLTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [TPM].[ProcedureArchive]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TPM].[ProcedureArchive](
	[TPMProcID] [int] NULL,
	[TPMProcTitle] [nvarchar](255) NULL,
	[TPMProcFreq] [int] NULL,
	[TPMProcType] [int] NULL,
	[TPMProcProcedure] [nvarchar](max) NULL,
	[TMPProcModelLink] [int] NULL,
	[TPMProcContDocNum] [int] NULL,
	[TPMPRocNumTM] [decimal](18, 0) NULL,
	[TPMProcEstMin] [decimal](18, 0) NULL,
	[TPMProcLineStatus] [int] NULL,
	[TPMProcPriority] [int] NULL,
	[ArchiveID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [OI].[PLCategory]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [OI].[PLCategory](
	[PLCategory] [nvarchar](255) NULL,
	[PLCATID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_PLCategory] PRIMARY KEY CLUSTERED 
(
	[PLCATID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PingSchedule]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PingSchedule](
	[SCID] [int] IDENTITY(1,1) NOT NULL,
	[SCIPLink] [int] NULL,
	[SCTime] [datetime] NULL,
	[SCMin] [int] NULL,
	[SCHour] [int] NULL,
	[SCMon] [bit] NULL,
	[SCTue] [bit] NULL,
	[SCWed] [bit] NULL,
	[SCThur] [bit] NULL,
	[SCFri] [bit] NULL,
	[SCSat] [bit] NULL,
	[SCSun] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [wAppTeam].[OTHourCalc]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [wAppTeam].[OTHourCalc]
(
	@TMID Integer,
	@PayPeriod Date,
	@Day int,
	@Hours Decimal(6,2)
)

RETURNS Decimal(6,2)
AS


	BEGIN
	DECLARE @intHold Decimal(6,2);
		
		IF @Day < 6
			BEGIN
				
				SET @intHold = (ISNULL(@Hours,0.0) + 8.0)

			END
		ELSE
			BEGIN

				SET @intHold = (ISNULL(@Hours,0.0))

			END
	


	RETURN @intHold
	END
GO
/****** Object:  StoredProcedure [TPM].[OpenTPMWeekCalc]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TPM].[OpenTPMWeekCalc]

	@DatePass Date = '9/2/2011',
	@LineNumber Integer,
	@TPMProcNumber Integer,
	@PastDueWOReturn Integer OUTPUT,
	@OpenWOReturn Integer OUTPUT,
	@ClosedPrevWeek Integer OUTPUT

AS

	DECLARE @strSQL nVarChar(max);
	DECLARE @strSQL0 nVarChar(max);
	DECLARE @strParam nVarChar(max);
	DECLARE @strWhereOpenGood nVarChar(max);
	DECLARE @strWhereOpenPastDue nVarChar(max);
	DECLARE @strWhereClosedForPrevWeek nVarChar(max);


	SET @strParam = '
			@DatePass1 Date ,
			@LineNumber1 Integer
			';


	SET @strSQL0 = '
	SELECT 
		WO.WorkOrderMain.DISID,
		WO.WorkOrderMain.DISOpenDate,
		WO.WorkOrderMain.DISTPMNumber,
		WO.WorkOrderMain.DISCloseDate,
		WO.WorkOrderMain.DISNumberASS,
		WO.WorkOrderMain.DISLineNumber,
		WO.WorkOrderMain.DISDueDate,
		WO.WorkOrderMain.DISManHours,
		WO.WorkOrderMain.DISType,
		TPM.TPMProcdure.TPMProcFreq,
		COM.MachineList.MLSATASSIGN,
		COM.areaassignments.AAareaname
		
		FROM 
				WO.WorkOrderMain 
				LEFT JOIN TPM.TPMProcdure ON WO.WorkOrderMain.DISTPMNumber =  TPM.TPMProcdure.TPMProcID
				LEFT JOIN COM.MachineList ON WO.WorkOrderMain.DISLineNumber = COM.MachineList.MLID 
				LEFT JOIN COM.areaassignments ON COM.MachineList.MLSATASSIGN = COM.areaassignments.AAID

        WHERE 
		     	WO.WorkOrderMain.DISType = 3 
					AND
				WO.WorkOrderMain.DISLineNumber = @LineNumber1 
					AND ';


SET @strWhereOpenGood = '
			    WO.WorkOrderMain.DISCloseDate Is Null
					AND
				WO.WorkOrderMain.DISOpenDate < @DatePass1
					AND
			    WO.WorkOrderMain.DISDueDate > @DatePass1';


SET @strWhereOpenPastDue = '  
				WO.WorkOrderMain.DISCloseDate Is Null
					AND
				WO.WorkOrderMain.DISOpenDate < @DatePass1
					AND
				WO.WorkOrderMain.DISDueDate > @DatePass1';

SET @strWhereClosedForPrevWeek = '  
				WO.WorkOrderMain.DISCloseDate Is Null
					AND
				WO.WorkOrderMain.DISOpenDate BETWEEN DATEADD(DAY,-7,@DatePass1) AND @DatePass1
';


SET @strSQL = @StrSQL0 + @strWhereOpenGood

EXEC sp_executesql
 @strSql,
 @strParam,
 @DatePass1 = @DatePass,
 @LineNumber1 = @LineNumber
 ;

 SET @OpenWOReturn = @@RowCount;


 SET @strSQL = @StrSql0 + @strWhereOpenPastDue;
 EXEC sp_executesql
 @strSql,
 @strParam,
 @DatePass1 = @DatePass,
 @LineNumber1 = @LineNumber
 ;

 SET @PastDueWOReturn = @@RowCount;

 SET @strSQL = @StrSql0 + @strWhereClosedForPrevWeek
  EXEC sp_executesql
 @strSql,
 @strParam,
 @DatePass1 = @DatePass,
 @LineNumber1 = @LineNumber

 SET @ClosedPrevWeek = @@RowCount;

	RETURN
GO
/****** Object:  Table [Team].[OvertimeHours]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[OvertimeHours](
	[OTID] [int] IDENTITY(1,1) NOT NULL,
	[OTDate] [datetime] NULL,
	[OTTeamMember] [int] NULL,
	[OTPayPeriod] [date] NULL,
	[OTHMon1Reg] [float] NULL,
	[OTHTue1Reg] [float] NULL,
	[OTHWed1Reg] [float] NULL,
	[OTHThu1Reg] [float] NULL,
	[OTHFri1Reg] [float] NULL,
	[OTHSat1Reg] [float] NULL,
	[OTHSun1Reg] [float] NULL,
	[OTHMon2Reg] [float] NULL,
	[OTHTue2Reg] [float] NULL,
	[OTHWed2Reg] [float] NULL,
	[OTHThu2Reg] [float] NULL,
	[OTHFri2Reg] [float] NULL,
	[OTHSat2Reg] [float] NULL,
	[OTHSun2Reg] [float] NULL,
	[OTSat1vol] [bit] NULL,
	[OTSun1vol] [bit] NULL,
	[OTSat2vol] [bit] NULL,
	[OTSun2vol] [bit] NULL,
 CONSTRAINT [PK_OvertimeHours] PRIMARY KEY CLUSTERED 
(
	[OTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ShowDatePicker', @value=1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTTeamMember'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ShowDatePicker', @value=1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTPayPeriod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun1Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHMon2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHTue2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHWed2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHThu2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHFri2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSat2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTHSun2Reg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun1vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSat2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours', @level2type=N'COLUMN',@level2name=N'OTSun2vol'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'TABLE',@level1name=N'OvertimeHours'
GO
/****** Object:  Table [Team].[PayPeriods]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Team].[PayPeriods](
	[PPID] [int] IDENTITY(1,1) NOT NULL,
	[PayPeriod] [date] NOT NULL,
 CONSTRAINT [PK_PayPeriods] PRIMARY KEY CLUSTERED 
(
	[PPID] ASC,
	[PayPeriod] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelGroupOneDelete]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelGroupOneDelete]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  Table [EQP].[ModelGroupOne]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[ModelGroupOne](
	[MGOneID] [int] IDENTITY(1,1) NOT NULL,
	[MGOneName] [nvarchar](max) NOT NULL,
	[MGOneActive] [bit] NOT NULL,
 CONSTRAINT [PK_ModelGroupOne] PRIMARY KEY CLUSTERED 
(
	[MGOneID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [wAppTeam].[PopulateTimeTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[PopulateTimeTable]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS

DECLARE @dateIn as Date;

Set @dateIn = GetDate();
--SET @dateIn = '4/9/2012';


DECLARE cwTable CURSOR FAST_FORWARD FOR
	SELECT TMID FROM Team.teammembers
	WHERE TMPayStatus = 1;

DECLARE @Userid Int;

OPEN cwTable

WHILE @@FETCH_STATUS = 0
BEGIN
FETCH NEXT FROM cwTable INTO @Userid
IF (SELECT COUNT(*) FROM TEAM.NOvertimeHours WHERE OTTeamMember =  @Userid  AND OTPayPeriod = @dateIn) = 0
	     Insert Into Team.NOvertimeHours
		  (
			OTTeamMember,
		    OTPayPeriod,
		    OTLastChange,
			OTHMon1Reg,
			OTHTue1Reg,
			OTHWed1Reg,
			OTHThu1Reg,
			OTHFri1Reg,
			OTHSat1Reg,
			OTHSun1Reg,
			OTTCodeMon,
			OTTCodeTue,
			OTTCodeWed,
			OTTCodeThur,
			OTTCodeFri,
			OTTCodeSat,
			OTTCodeSun,
			OTLastEdit,
			OTSat1Vol,
			OTSun1Vol

		  )
		  VALUES
		  (
			@Userid,
			@dateIn,
			GETDATE(),
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			19,
			19,
			19,
			19,
			19,
			19,
			19,
			22,
			0,
			0


		  );

END
	RETURN
GO
/****** Object:  Table [dbo].[NewWeldTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewWeldTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AREA] [nvarchar](255) NULL,
	[AFFO] [float] NULL,
	[TIMER] [nvarchar](255) NULL,
	[PROGRAM] [float] NULL,
	[WELDINGiNDEX] [nvarchar](255) NULL,
	[WELDid] [nvarchar](255) NULL,
	[ROBOtss] [float] NULL,
	[ROBOT] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Development].[myTestTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Development].[myTestTable](
	[Text1] [nvarchar](max) NULL,
	[text2] [nvarchar](max) NULL,
	[Date1] [date] NULL,
	[date2] [date] NULL,
	[time] [time](7) NULL,
	[number1] [int] NULL,
	[number2] [int] NULL,
	[myID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [OI].[OpenItemsMaster]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [OI].[OpenItemsMaster](
	[OILID] [int] IDENTITY(1,1) NOT NULL,
	[OILPriority] [nvarchar](50) NULL,
	[OILPunchItem] [nvarchar](max) NULL,
	[OILEquipmentNumber] [int] NULL,
	[OILKBLineNumber] [int] NULL,
	[OILDateEntered] [date] NULL,
	[OILDateRequired] [date] NULL,
	[OILDateClosed] [date] NULL,
	[OILARGNumber] [int] NULL,
	[OILManagedBy] [int] NULL,
	[OILtype] [int] NULL,
	[OILCategory] [int] NULL,
	[OILResponsible] [int] NULL,
	[OILOptionOne] [bit] NULL,
	[OILOriginator] [int] NULL,
 CONSTRAINT [PK_OpenItemsMaster] PRIMARY KEY CLUSTERED 
(
	[OILID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Backups].[MachineListBackup]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Backups].[MachineListBackup](
	[MLCELLNAME] [nvarchar](50) NULL,
	[MLLINEID] [int] NULL,
	[MLID] [int] IDENTITY(1,1) NOT NULL,
	[MLPlantID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [SP].[Locations]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[Locations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[LOCLocationName] [nvarchar](255) NULL,
	[LOCBayNumber] [nvarchar](255) NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCLocationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations', @level2type=N'COLUMN',@level2name=N'LOCBayNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Locations'
GO
/****** Object:  Table [Weld].[MaterialData]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Weld].[MaterialData](
	[MDName] [nvarchar](max) NULL,
	[MDYieldStrength] [int] NULL,
	[MDID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [SP].[ItemFrame]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[ItemFrame](
	[IFrameID] [int] IDENTITY(1,1) NOT NULL,
	[IFrameSPMasterLink] [int] NULL,
	[IFrameMin] [int] NULL,
	[IFrameMax] [int] NULL,
	[IFrameOnHand] [int] NULL,
	[IFrameKanBanNum] [int] NULL,
	[IFrameNote] [nvarchar](255) NULL,
	[IFShelfName] [int] NULL,
	[IFrameDrawer] [int] NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameSPMasterLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameMax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameOnHand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameKanBanNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameNote'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFShelfName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame', @level2type=N'COLUMN',@level2name=N'IFrameDrawer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'ItemFrame'
GO
/****** Object:  Table [SP].[Manufacturers]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[Manufacturers](
	[Address] [nvarchar](255) NULL,
	[Manufacturer] [nvarchar](255) NULL,
	[ContactPerson] [nvarchar](255) NULL,
	[Cell] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[EMail] [nvarchar](255) NULL,
	[Fax] [nvarchar](255) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WebSite] [nvarchar](255) NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Manufacturer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Cell'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'EMail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers', @level2type=N'COLUMN',@level2name=N'WebSite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'Manufacturers'
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelGroupThreeDelete]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelGroupThreeDelete]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  Table [EQP].[ModelGroupThree]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[ModelGroupThree](
	[MGThreeID] [int] IDENTITY(1,1) NOT NULL,
	[MGThreeName] [nvarchar](max) NOT NULL,
	[MGThreeTwoLink] [int] NOT NULL,
	[MGThreeActive] [bit] NOT NULL,
 CONSTRAINT [PK_ModelGroupThree] PRIMARY KEY CLUSTERED 
(
	[MGThreeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelGroupOneUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelGroupOneUpdate]
	



AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelGroupTwoDelete]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelGroupTwoDelete]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  Table [EQP].[ModelGroupTwo]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[ModelGroupTwo](
	[MGTwoID] [int] IDENTITY(1,1) NOT NULL,
	[MGTwoName] [nvarchar](max) NOT NULL,
	[MGTwoOneLink] [int] NOT NULL,
	[MGTwoActive] [bit] NOT NULL,
 CONSTRAINT [PK_ModelGroupTwo] PRIMARY KEY CLUSTERED 
(
	[MGTwoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [WO].[Archive]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [WO].[Archive](
	[DISOpenDate] [datetime] NULL,
	[DISCloseDate] [datetime] NULL,
	[DISWorkRequired] [nvarchar](max) NULL,
	[DISNumberAss] [int] NULL,
	[DISManHours] [int] NULL,
	[DISWorkAccomp] [nvarchar](max) NULL,
	[DISLineNumber] [int] NULL,
	[DISEquip] [int] NULL,
	[DISDueDate] [datetime] NULL,
	[DISOriginator] [int] NULL,
	[DISResponsible] [int] NULL,
	[DISType] [int] NULL,
	[DISRequestor] [int] NULL,
	[DISOpenItemNumber] [int] NULL,
	[DISTPMNumber] [int] NULL,
	[DISID] [int] IDENTITY(1,1) NOT NULL,
	[DISIntHold] [int] NULL,
	[DISCharHold] [nvarchar](max) NULL,
	[DISAsset] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [EQP].[AssetAssignmentHistory]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[AssetAssignmentHistory](
	[AAHID] [int] IDENTITY(1,1) NOT NULL,
	[AAHDate] [date] NOT NULL,
	[AAHCause] [nvarchar](max) NOT NULL,
	[AAHUserID] [int] NOT NULL,
	[AAHFromIdle] [int] NOT NULL,
	[AAHFromProc] [int] NOT NULL,
	[AAHToIdle] [int] NOT NULL,
	[AAHToProc] [int] NOT NULL,
	[AAHAssetID] [int] NOT NULL,
 CONSTRAINT [PK_AssetAssignmentHistory] PRIMARY KEY CLUSTERED 
(
	[AAHID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [WO].[AddWorkOrderNew]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[AddWorkOrderNew]

	@Date date,
	@Due date,
	@WorkRequired nVarChar(4000),
	@TPMNumber Integer,
	@Responsible Integer,
	@Originator Integer,
	@LineNumber Integer,
	@Type Integer,
	@OpenItemNum Integer,
	@Return Integer OUTPUT


AS

	SET NOCOUNT ON
		
	DECLARE @sqlString nVarChar(4000);
	DECLARE @ParamString nVarChar(1000);
	Declare @Return2 Integer;


	Set @ParamString = '
        @Return1 Integer OUTPUT,
	    @Date1 Date,
		@WorkRequired1 nVarChar(4000),
		@LineNumber1 Integer,
		@TPMNumber1 Integer,
		@Due1 Date,
		@Originator1 Integer,
		@Responsible1 Integer,
		@Type1 Integer,
		@OpenItemNum1 Integer
		';

	Set @sqlString = ' INSERT INTO WO.WorkOrderMain(
		DISOpenDate,
		DISWorkRequired,
		DISLineNumber,
		DISEquip,
		DISDueDate,
		DISOriginator,
		DISResponsible,
		DISType,
		DISOpenItemNumber
		)
		VALUES
		(
		@Date1,
		@WorkRequired1,
		@LineNumber1,
		@TPMNumber1,
		@Due1,
		@Originator1,
		@Responsible1,
		@Type1,
		@OpenItemNum1
		);

		Select @Return1 = Scope_Identity();';
		
		

		EXEC sp_executesql
        @sqlString,
        @ParamString,
		@Date1 = @Date,
		@WorkRequired1 = @WorkRequired,
		@LineNumber1 = @LineNumber,
		@TPMNumber1 = @TPMNumber,
		@Due1 = @Due,
		@Originator1 = @Originator,
		@Responsible1 = @Responsible,
		@Type1  = @Type,
		@OpenItemNum1 = @OpenItemNum,
        @Return1 = @Return2 OUTPUT
        ;

 Set @Return = @Return2

 RETURN @Return
	
	
	
	
	
	
	
	
	
	
	
	
	RETURN
GO
/****** Object:  StoredProcedure [Team].[AddNewTeamMember]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Team].[AddNewTeamMember]


@MemberFirstName nVarChar(Max),
@MemberLastName nVarChar(Max)

AS

DECLARE @strInsert nVarChar (4000);
DECLARE @ParamString nVarChar (4000);

Set @ParamString = '
@MemberFirstName1 nVarChar(Max),
@MemberLastName1 nVarChar(Max)
'
Set @strInsert = '
INSERT INTO TEAM.Teammembers(
TMFirstName,
TMLastName
)

VALUES(
@MemberFirstName1,
@MemberLastName1
)
;'

EXEC sp_executesql
 @strInsert,
 @ParamString,
 @MemberFirstName1 = @MemberFirstName,
 @MemberLastName1 = @MemberLastName
GO
/****** Object:  StoredProcedure [Team].[AddNewOTRecord]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Team].[AddNewOTRecord]
 
	@TeamMember integer,
	@PayPeriod Date

AS


DECLARE @strInsert nVarChar (4000);
DECLARE @ParamString nVarChar (4000);

Set @ParamString = '
@TeamMember1 int,
@PayDate1 Date
'
Set @strInsert = '
INSERT INTO TEAM.OvertimeHours(
OTTeamMember,
OTPayPeriod
)

VALUES(
@TeamMember1,
@PayDate1
)
;'

EXEC sp_executesql
 @strInsert,
 @ParamString,
 @TeamMember1 = @TeamMember,
 @PayDate1 = @PayPeriod




	RETURN
GO
/****** Object:  StoredProcedure [wACom].[CombinedFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[CombinedFetch]
@Plant as Integer

AS
	SELECT * FROM wACom.CombinedLocation
	WHERE PNID = @Plant
	RETURN
GO
/****** Object:  Table [dbo].[CollectionMaster]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CollectionMaster](
	[COLid] [int] IDENTITY(1,1) NOT NULL,
	[COLName] [nvarchar](255) NULL,
	[COLGroupid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [Documentation].[CollectionDrop1]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Documentation].[CollectionDrop1]
AS
SELECT     TOP (100) PERCENT COLid, COLName
FROM         Documentation.CollectionMaster
ORDER BY COLName
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CollectionMaster (Documentation)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 106
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Documentation', @level1type=N'VIEW',@level1name=N'CollectionDrop1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'Documentation', @level1type=N'VIEW',@level1name=N'CollectionDrop1'
GO
/****** Object:  Table [SP].[CMChangeLog]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[CMChangeLog](
	[CMLogID] [int] IDENTITY(1,1) NOT NULL,
	[CMLogDate] [datetime] NULL,
	[CMLogFieldOne] [ntext] NULL,
	[CMLogFieldTwo] [ntext] NULL,
	[CmLogFieldThree] [ntext] NULL,
	[CMLogExcelRef] [int] NULL,
	[CMLogIDLink] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ShowDatePicker', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextFormat', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextFormat', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogFieldTwo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextFormat', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CmLogFieldThree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogExcelRef'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog', @level2type=N'COLUMN',@level2name=N'CMLogIDLink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CMChangeLog'
GO
/****** Object:  StoredProcedure [WO].[CloseWorkOrder]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[CloseWorkOrder]
	@DateClosed Date,
	@WorkAccomp nVarChar(4000),
	@TMS Integer,
	@Minutes Integer,
	@WhereField nVarChar(100),
	@WhereValue Integer

	
AS
SET NOCOUNT ON 

	DECLARE @sqlString nVarChar(4000);
	DECLARE @ParamString nVarChar(1000);


	Set @sqlString  = 'UPDATE WO.WorkOrderMain Set
	 DISCloseDate = @DateClosed1,
	 DISNumberASS = @TMS1,
	 DISManHours = @Minutes1,
	 DISWorkAccomp = @WorkAccomp1
	 WHERE ' + @WhereField + ' =  @WhereValue1 ;';

	Set @ParamString = '
	@DateClosed1 date,
	@TMS1 Integer,
	@Minutes1 Integer,
	@WorkAccomp1 nVarChar(4000),
	@WhereValue1 Integer';

	EXEC sp_executesql
      @sqlString,
      @ParamString,
	  @DateClosed1 = @DateClosed,
	  @TMS1 = @TMS,
	  @Minutes1 = @Minutes,
	  @WorkAccomp1 = @WorkAccomp,
	  @WhereValue1 = @WhereValue;


	RETURN
GO
/****** Object:  StoredProcedure [WO].[CalculatedWorkOrders]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[CalculatedWorkOrders]

	@RETURN Integer OUTPUT,
	@TPMFREQ Integer, 
	@SatAss Integer,
	@DueDate Date

AS


    DECLARE @ParamString nVarChar(4000);
    DECLARE @sqlString nVarChar(4000);
    DECLARE @Return2 Integer;


Set @ParamString = '
  @TPMFREQ1 Integer,
  @SatAss1 Integer,
  @DueDate1 Date,
  @Return1 Integer OUTPUT';

  Set @sqlString =  'SELECT 
  WO.WorkOrderMain.DISID,
  WO.WorkOrderMain.DISOpenDate,
  WO.WorkOrderMain.DISCloseDate,
  WO.WorkOrderMain.DISLineNumber,
  WO.WorkOrderMain.DISDueDate,
  WO.WorkOrderMain.DISType,
  TPM.TPMProcdure.TPMProcFreq,
  COM.MachineList.MLSATASSIGN,
  COM.areaassignments.AAareaname
  FROM
  WO.WorkOrderMain 
  LEFT JOIN TPM.TPMProcdure ON WO.WorkOrderMain.DISTPMNumber = TPM.TPMProcdure.TPMProcID
  LEFT JOIN COM.MachineList ON WO.WorkOrderMain.DISLineNumber = COM.MachineList.MLID
  LEFT JOIN COM.areaassignments ON COM.MachineList.MLSATASSIGN = COM.areaassignments.AAID
  WHERE 
       WO.WorkOrderMain.DISType = 3
            AND
       (WO.WorkOrderMain.DIScloseDate IS NULL)
			AND
	   TPM.TPMProcdure.TPMProcFreq = @TPMFREQ1
	        AND
	   WO.WorkOrderMain.DISDueDate < @DueDate1
		    AND 
	   COM.areaassignments.AAID = @SatAss1
		
		;

  Select @Return1 = @@RowCount;';
  

   		EXEC sp_executesql
        @sqlString,
        @ParamString,
        @Return1 = @Return2 OUTPUT,
        @TPMFREQ1 = @TPMFREQ,
		@DueDate1 = @DueDate,
		@SatAss1 = @SatAss;

		SET @Return = @Return2;
  
  RETURN @Return
GO
/****** Object:  Table [SP].[CribMaster]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[CribMaster](
	[CMID] [int] IDENTITY(1,1) NOT NULL,
	[CMVWPARTNUM] [nvarchar](255) NULL,
	[CMSUPPLIERPARTNUM] [nvarchar](255) NULL,
	[CMMFGPARTNUM] [nvarchar](255) NULL,
	[CMMFGID] [nvarchar](255) NULL,
	[CMMFG] [nvarchar](255) NULL,
	[CMSHORTD] [nvarchar](255) NULL,
	[CMLONGD] [ntext] NULL,
	[CMBINLOC] [nvarchar](255) NULL,
	[CMBOH] [int] NULL,
	[CMREF] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMVWPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSUPPLIERPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGPARTNUM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFGID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMMFG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMSHORTD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextFormat', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMLONGD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBINLOC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMBOH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster', @level2type=N'COLUMN',@level2name=N'CMREF'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CribMaster'
GO
/****** Object:  Table [Documentation].[DocBindingModels]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Documentation].[DocBindingModels](
	[DCBID] [int] IDENTITY(1,1) NOT NULL,
	[DCBDocLink] [int] NOT NULL,
	[DCBModLink] [int] NOT NULL,
 CONSTRAINT [PK_DocBindingModels] PRIMARY KEY CLUSTERED 
(
	[DCBID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Documentation].[DocumentMaster]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Documentation].[DocumentMaster](
	[DMid] [int] IDENTITY(1,1) NOT NULL,
	[DMTitle] [nvarchar](255) NOT NULL,
	[DMTierThreeLink] [int] NOT NULL,
	[DMDocWebURL] [nvarchar](200) NOT NULL,
	[DMSearchTags] [nvarchar](max) NULL,
	[DMNotes] [nvarchar](max) NULL,
 CONSTRAINT [PK_DocumentMaster] PRIMARY KEY CLUSTERED 
(
	[DMid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentMaster]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentMaster](
	[DMid] [int] IDENTITY(1,1) NOT NULL,
	[DMTitle] [nvarchar](255) NULL,
	[DMCollectionID] [int] NULL,
	[DMHyperlink] [nvarchar](200) NULL,
	[DMTextField2] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Documentation].[DocTierTwo]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Documentation].[DocTierTwo](
	[DTTwID] [int] IDENTITY(1,1) NOT NULL,
	[DTTwTierOneLink] [int] NOT NULL,
	[DTTwName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DocTierTwo] PRIMARY KEY CLUSTERED 
(
	[DTTwID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Documentation].[DocTierThree]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Documentation].[DocTierThree](
	[DTThID] [int] IDENTITY(1,1) NOT NULL,
	[DTThTierTwoLink] [int] NOT NULL,
	[DTThName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DocTierThree] PRIMARY KEY CLUSTERED 
(
	[DTThID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Documentation].[DocTierOne]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Documentation].[DocTierOne](
	[DTOID] [int] IDENTITY(1,1) NOT NULL,
	[DTOName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DocTierOne] PRIMARY KEY CLUSTERED 
(
	[DTOID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Development].[DTMainTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Development].[DTMainTable](
	[DTLine] [int] NULL,
	[DTRobot] [int] NULL,
	[DTSolution] [nvarchar](max) NULL,
	[DTResponsibility] [int] NULL,
	[DTTimeDown] [date] NULL,
	[DTTimeUp] [timestamp] NULL,
	[DTMinutes] [int] NULL,
	[DTMalfunction] [nvarchar](max) NULL,
	[DTLongTerm] [nvarchar](max) NULL,
	[DTTimeDown1] [datetime] NULL,
	[DTTimeUp2] [datetime] NULL,
	[DTT3Code] [int] NULL,
	[DTID] [int] IDENTITY(1,1) NOT NULL,
	[TotalMinutes] [int] NULL,
	[DTNoTime] [float] NULL,
	[DTOriginator] [int] NULL,
	[DTNDateDown] [date] NULL,
	[DTNTimeDown] [time](0) NULL,
	[DTNDateUp] [date] NULL,
	[DTNTimeUp] [time](0) NULL,
	[DTNCDown] [datetime] NULL,
	[DTNCUp] [datetime] NULL,
	[DTAsset] [int] NULL,
	[DTLostProduction] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [wAppDT].[DowntimeDelete]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[DowntimeDelete]

	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	/* SET NOCOUNT ON */
	RETURN
GO
/****** Object:  Table [dbo].[dtproperties]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dtproperties](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[objectid] [int] NULL,
	[property] [varchar](64) NOT NULL,
	[value] [varchar](255) NULL,
	[uvalue] [nvarchar](255) NULL,
	[lvalue] [image] NULL,
	[version] [int] NOT NULL,
 CONSTRAINT [pk_dtproperties] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[property] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[dt_verstamp007]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	This procedure returns the version number of the stored
**    procedures used by the the Microsoft Visual Database Tools.
**	Version is 7.0.05.
*/
create procedure [dbo].[dt_verstamp007]
as
	select 7005
GO
/****** Object:  StoredProcedure [dbo].[dt_verstamp006]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	This procedure returns the version number of the stored
**    procedures used by legacy versions of the Microsoft
**	Visual Database Tools.  Version is 7.0.00.
*/
create procedure [dbo].[dt_verstamp006]
as
	select 7000
GO
/****** Object:  Table [dbo].[ECOEmosData]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ECOEmosData](
	[ECOID] [int] NULL,
	[ECOBegin] [datetime] NULL,
	[ECOEnd] [datetime] NULL,
	[ECOShift] [int] NULL,
	[ECOText] [nvarchar](max) NULL,
	[ECOTextArea] [nvarchar](50) NULL,
	[ECOArea] [int] NULL,
	[ECOTag] [nvarchar](max) NULL,
	[ECOPrior] [nvarchar](max) NULL,
	[ECOType] [nvarchar](50) NULL,
	[ECOComment] [nvarchar](max) NULL,
	[ECODuration] [nvarchar](50) NULL,
	[ECOEdit] [nvarchar](max) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [DT].[EcoFaultCodes]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DT].[EcoFaultCodes](
	[EFCText] [nvarchar](400) NULL,
	[EFCPriority] [int] NULL,
	[EFCID] [int] IDENTITY(1,1) NOT NULL,
	[EFCComment] [nvarchar](400) NULL,
	[EFCFaultTag] [nvarchar](400) NULL,
	[EFCBegin] [datetime] NULL,
	[EFCEnd] [datetime] NULL,
	[EFCShift] [int] NULL,
	[EFCArea] [nvarchar](50) NULL,
	[EFCDuration] [time](7) NULL,
	[EFCTotalTime]  AS (datediff(minute,[EFCBegin],[EFCEnd])),
 CONSTRAINT [PK_EcoFaultCodes] PRIMARY KEY CLUSTERED 
(
	[EFCID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [OI].[EventTableCloseEvent]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [OI].[EventTableCloseEvent]


@DateEntered Date,
@ETID Integer

	
AS
DECLARE @strInsert nVarChar (4000);
DECLARE @ParamString nVarChar (4000);

Set @ParamString = '
@DateEntered1 Date,
@ETID1 Integer'

Set @strInsert = '
UPDATE OI.EventTable
SET ETDateResolved = @DateEntered1
WHERE ETID = @ETID1
;'

EXEC sp_executesql
 @strInsert,
 @ParamString,
 @DateEntered1 = @DateEntered,
 @ETID1 = @ETID;



	RETURN
GO
/****** Object:  Table [OI].[EventTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [OI].[EventTable](
	[ETDateEntered] [datetime] NULL,
	[ETID] [int] IDENTITY(1,1) NOT NULL,
	[ETPLID] [int] NULL,
	[ETEventType] [nvarchar](255) NULL,
	[ETReponsibility] [int] NULL,
	[ETDueDate] [datetime] NULL,
	[ETDateResolved] [datetime] NULL,
	[ETStatus] [int] NULL,
	[ETEvent] [nvarchar](255) NULL,
 CONSTRAINT [PK_EventTable] PRIMARY KEY CLUSTERED 
(
	[ETID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [OI].[EvenTableAddNew]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [OI].[EvenTableAddNew]

@Event VarChar(5000),
@DateEntered Date,
@DateRequired Date,
@Responsible Integer, 
@WhereValue Integer
AS

DECLARE @strInsert nVarChar (4000);
DECLARE @ParamString nVarChar (4000);

Set @ParamString = '
@Event1 VarChar(5000),
@DateEntered1 Date,
@DateRequired1 Date,
@Responsible1 Integer,
@WhereValue1 Integer
'
Set @strInsert = '
INSERT INTO OI.EventTable(
ETDateEntered,
ETPLID,
ETEvent,
ETDueDate,
ETReponsibility
)

VALUES(
@DateEntered1,
@WhereValue1,
@Event1,
@DateRequired1,
@Responsible1
)
;'

EXEC sp_executesql
 @strInsert,
 @ParamString,
 @Event1 = @Event,
 @DateEntered1 = @DateEntered,
 @Responsible1 = @Responsible,
 @WhereValue1 = @WhereValue,
 @DateRequired1 = @DateRequired;





	RETURN
GO
/****** Object:  Table [SP].[CABFrame]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SP].[CABFrame](
	[CAB5sName] [nvarchar](255) NULL,
	[CABLocation] [int] NULL,
	[id] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AllowZeroLength', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentenceMode', @value=0x03 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_UnicodeCompression', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CAB5sName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'CABLocation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_AggregateType', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Caption', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnHidden', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnOrder', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ColumnWidth', @value=-1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=0xFF , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultValue', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=109 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Format', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_InputMask', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Required', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SmartTags', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TextAlign', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=0x02 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Filter', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_FilterOnLoad', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_HideNewField', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderBy', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOnLoad', @value=1 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=0x00 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TableMaxRecords', @value=10000 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_TotalsRow', @value=0 , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationRule', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_ValidationText', @value=NULL , @level0type=N'SCHEMA',@level0name=N'SP', @level1type=N'TABLE',@level1name=N'CABFrame'
GO
/****** Object:  Table [EQP].[IdleAssetLocations]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[IdleAssetLocations](
	[IALID] [int] IDENTITY(1,1) NOT NULL,
	[IALName] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [wAppEQP].[IdleAssetUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[IdleAssetUpdate]
	
	(
		@IALID int,
		@IALName nVarChar(50)
	)
	
AS

	UPDATE EQP.IdleAssetLocation
		SET IALName = @IALName
	WHERE IALID = @IALID

	RETURN
GO
/****** Object:  View [Documentation].[ColectionDrop2]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Documentation].[ColectionDrop2]
AS
SELECT     Documentation.CollectionMaster.COLid, Documentation.GroupMaster.GLName + N' -  ' + Documentation.CollectionMaster.COLName AS MyName
FROM         Documentation.CollectionMaster INNER JOIN
                      Documentation.GroupMaster ON Documentation.CollectionMaster.COLGroupid = Documentation.GroupMaster.GLid
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CollectionMaster (Documentation)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 144
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GroupMaster (Documentation)"
            Begin Extent = 
               Top = 6
               Left = 228
               Bottom = 128
               Right = 380
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 3705
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 7995
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Documentation', @level1type=N'VIEW',@level1name=N'ColectionDrop2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'Documentation', @level1type=N'VIEW',@level1name=N'ColectionDrop2'
GO
/****** Object:  Table [dbo].[GroupMaster]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupMaster](
	[GLid] [int] IDENTITY(1,1) NOT NULL,
	[GLName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [OI].[Group List]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [OI].[Group List](
	[ID] [int] NOT NULL,
	[GroupName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [EQP].[IPDefaultGateway]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[IPDefaultGateway](
	[IPGID] [int] IDENTITY(1,1) NOT NULL,
	[IPGIP] [nvarchar](50) NOT NULL,
	[IPGName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IPTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IPTable](
	[IPTID] [int] IDENTITY(1,1) NOT NULL,
	[IPTFirstOct] [int] NULL,
	[IPTSecOct] [int] NULL,
	[IPTThirdOct] [int] NULL,
	[IPTFourthOct] [int] NULL,
	[IPTDescription] [nvarchar](255) NULL,
	[IPTLocation] [int] NULL,
	[IPTIPText] [nvarchar](255) NULL,
	[IPTDefaultGateway] [nvarchar](255) NULL,
	[IPTHostName] [nvarchar](255) NULL,
	[IPTSubNet] [nvarchar](255) NULL,
	[IPEQPTYPELINK] [int] NULL,
	[IPVENDORLINK] [int] NULL,
	[IPWakeUpGroup] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [wACom].[GenericNumberByTwo]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [wACom].[GenericNumberByTwo](
	[Number] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [wACom].[GenericNumberByOne]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [wACom].[GenericNumberByOne](
	[Number] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [wACom].[GenericMonths]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [wACom].[GenericMonths](
	[month] [nchar](10) NULL,
	[monthnum] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [wACom].[GenericDays]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [wACom].[GenericDays](
	[dow] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [wACom].[GenericDateTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [wACom].[GenericDateTable](
	[GDTDate] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [SEC].[FileTracker]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [SEC].[FileTracker](
	[FTID] [int] NOT NULL,
	[FTPath] [nvarchar](255) NULL,
	[FTFileName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [EQP].[EquipmentType]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[EquipmentType](
	[EQTID3] [int] NOT NULL,
	[EQTIDName] [nvarchar](255) NULL,
	[EQTID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_EquipmentType] PRIMARY KEY CLUSTERED 
(
	[EQTID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [EQP].[EquipmentSubTableType]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [EQP].[EquipmentSubTableType](
	[ESTID] [int] NOT NULL,
	[ESTName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [TPM].[GrandSchedule]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [TPM].[GrandSchedule](
	[GSID] [int] IDENTITY(1,1) NOT NULL,
	[GSCW] [int] NOT NULL,
	[GSBiMonthGroup] [int] NOT NULL,
	[GSMonthGroup] [int] NOT NULL,
	[GSQuarterlyGroup] [int] NOT NULL,
	[GSCWMonDate] [date] NOT NULL,
	[GSSemiAnGroup] [int] NOT NULL,
	[GSAnGroup] [int] NOT NULL,
	[GSTwoYearGroup] [int] NOT NULL,
	[GSThreeYearGroup] [int] NOT NULL,
	[GSFourYearGroup] [int] NOT NULL,
	[GSEightYearGroup] [int] NOT NULL,
 CONSTRAINT [PK_GrandSchedule] PRIMARY KEY CLUSTERED 
(
	[GSID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [DT].[GetCWMonDates]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [DT].[GetCWMonDates]
(@CW Integer,
@Year Integer)
RETURNS DATE
AS
BEGIN
--declare @Return Date


return (SELECT GSCWMonDate FROM TPM.GrandSchedule WHERE GSCW = @CW AND DATEPART(Year,GSCWMonDate) = @Year)

end
GO
/****** Object:  UserDefinedFunction [dbo].[GetCWMonDates]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetCWMonDates]
(@CW Integer,
@Year Integer)
RETURNS DATE
AS
BEGIN
--declare @Return Date


return (SELECT GSCWMonDate FROM TPM.GrandSchedule WHERE GSCW = @CW AND DATEPART(Year,GSCWMonDate) = @Year)

end
GO
/****** Object:  UserDefinedFunction [wACom].[GetCWMonDate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [wACom].[GetCWMonDate]
(
@CW Integer,
@Year Integer
)
RETURNS DATE
AS
BEGIN
--declare @Return Date


return (SELECT GSCWMonDate FROM TPM.GrandSchedule WHERE GSCW = @CW AND DATEPART(Year,GSCWMonDate) = @Year)



end
GO
/****** Object:  UserDefinedFunction [wACom].[GetCWFromDate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [wACom].[GetCWFromDate]
	
	(@inDate as Date  )
	RETURNS INT
	

AS

	BEGIN
	RETURN (SELECT GSCW FROM TPM.GrandSchedule
	WHERE @inDate Between GSCWMonDate and DateAdd(Day,6,GSCWMonDate))



	
	END
GO
/****** Object:  StoredProcedure [wAppTeam].[utilizationOne]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[utilizationOne]
(
	@DateStart Date = '1/1/2000'




)
AS
	--Declare @monDate Date = '3/12/2012';
	
	DECLARE @holdDate1 Date;
	DECLARE @cwHold Integer;
	DECLARE @yearHold Integer;

	SET @cwHold = wACom.GetCWFromDate(@DateStart);
	SET @yearHold = DatePart(Year,@DateStart);



	
	DECLARE @monDate Date = wACom.GetCWMonDate(@cwHold,@yearHold);
	


	
	DECLARE @results TABLE
	(
		TMID Integer,
		MyName nVarChar(100),
		MonWoHrs Integer,
		MonOTHrs Decimal,
		TueWoHrs Integer,
		TueOTHrs Decimal,
		WedWoHrs Integer,
		WedOTHrs Decimal,
		ThuWoHrs Integer,
		ThuOTHrs Decimal,
		FriWoHrs Integer,
		FriOTHrs Decimal,
		SatWoHrs Integer,
		SatOTHrs Decimal,
		SunWoHrs Integer,
		SunOTHrs Decimal,
		Shift nVarChar(25),
		MonDate Date
	);


	Insert Into @results (TMID, MyName,Shift,MonDate)
		SELECT TMID, TMFirstName + ' ' + TMLastName AS MyName, STShiftName, @monDate
			FROM Team.teammembers INNER JOIN
				Team.ShiftTable ON teammembers.TMNShift = STID
			WHERE TMPlantLink = 1 AND TMTitleLink IN(14,10) AND TMNShift IN(1,2,3,4,12)


	UPDATE @results
		SET 
			MonOTHrs = (60 * (8 + ISNULL((SELECT OTHMon1Reg FROM Team.NOvertimeHours WHERE TMID = OTTeamMember AND OTPayPeriod = @monDate),0))),
			TueOTHrs = (60 * (8 + ISNULL((SELECT OTHTue1Reg FROM Team.NOvertimeHours WHERE TMID = OTTeamMember AND OTPayPeriod = @monDate),0))),
			WedOTHrs = (60 * (8 + ISNULL((SELECT OTHWed1Reg FROM Team.NOvertimeHours WHERE TMID = OTTeamMember AND OTPayPeriod = @monDate),0))),
			ThuOTHrs = (60 * (8 + ISNULL((SELECT OTHThu1Reg FROM Team.NOvertimeHours WHERE TMID = OTTeamMember AND OTPayPeriod = @monDate),0))),
			FriOTHrs = (60 * (8 + ISNULL((SELECT OTHFri1Reg FROM Team.NOvertimeHours WHERE TMID = OTTeamMember AND OTPayPeriod = @monDate),0))),
			SatOTHrs = (60 * ISNULL((SELECT OTHSat1Reg FROM Team.NOvertimeHours WHERE TMID = OTTeamMember AND OTPayPeriod = @monDate),0)),
			SunOTHrs = (60 * ISNULL((SELECT OTHSun1Reg FROM Team.NOvertimeHours WHERE TMID = OTTeamMember AND OTPayPeriod = @monDate),0)),
			MonWoHrs = ISNULL((SELECT SUM(WOUMin) FROM wAppWorkOrder.woUtilizationCombined WHERE WOUTMID = TMID AND DISCloseDate = @monDate),0),
			TueWoHrs = ISNULL((SELECT SUM(WOUMin) FROM wAppWorkOrder.woUtilizationCombined WHERE WOUTMID = TMID AND DISCloseDate = DATEADD(Day,1,@monDate)),0),	
			WedWoHrs = ISNULL((SELECT SUM(WOUMin) FROM wAppWorkOrder.woUtilizationCombined WHERE WOUTMID = TMID AND DISCloseDate = DATEADD(Day,2,@monDate)),0),	
     		ThuWoHrs = ISNULL((SELECT SUM(WOUMin) FROM wAppWorkOrder.woUtilizationCombined WHERE WOUTMID = TMID AND DISCloseDate = DATEADD(Day,3,@monDate)),0),	
     		FriWoHrs = ISNULL((SELECT SUM(WOUMin) FROM wAppWorkOrder.woUtilizationCombined WHERE WOUTMID = TMID AND DISCloseDate = DATEADD(Day,4,@monDate)),0),	
     		SatWoHrs = ISNULL((SELECT SUM(WOUMin) FROM wAppWorkOrder.woUtilizationCombined WHERE WOUTMID = TMID AND DISCloseDate = DATEADD(Day,5,@monDate)),0),	
     		SunWoHrs = ISNULL((SELECT SUM(WOUMin) FROM wAppWorkOrder.woUtilizationCombined WHERE WOUTMID = TMID AND DISCloseDate = DATEADD(Day,6,@monDate)),0)	


	SELECT * FROM @results
	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[EquipmentModelUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[EquipmentModelUpdate]
@ModID as Integer,
@ModelNumber as nVarChar(max),
@ManID as Integer,
@Description as nVarChar(max),
@VendorID as Integer,
@OrderNumber as nVarChar(max)

AS
	
	UPDATE EQP.EquipmentMOdelNumber
	SET
		EQModModelNumber = @ModelNumber,
		EQModManID = @ManID,
		EQModDescription = 		@Description,
		EQModVendorID = 		@VendorID,
		EQModOrderNumber = 		@OrderNumber
	WHERE EQModID = @ModID


	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[FrequencyUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[FrequencyUpdate]
@TPMFreqFrequency as nVarChar(max), -- frequency title
@TPMFreqNotes as nVarChar(max),
@TPMFreqPeriod as Integer, -- how many days between cycles
@TPMFreqDueModifier as Integer,
@TPMInProduction as Bit,
@TPMBulkDigital as Bit,
@TPMFreqID as Integer
AS
	
	UPDATE TPM.TPMFrequency
	SET
	TPMFreqFrequency = @TPMFreqFrequency,
	TPMFreqNotes = @TPMFreqNotes,
	TPMFreqPeriod = @TPMFreqperiod,
	TPMFreqDueModifier = @TPMFreqDueModifier,
	TPMInProduction = @TPMInProduction,
	TPMBulkDigital = @TPMBulkDigital
	WHERE TPMFreqID = @TPMFreqID


	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[FrequencyInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[FrequencyInsert]
@TPMFreqFrequency as nVarChar(max), -- frequency title
@TPMFreqNotes as nVarChar(max),
@TPMFreqPeriod as Integer, -- how many days between cycles
@TPMFreqDueModifier as Integer,
@TPMInProduction as Bit,
@TPMBulkDigital as Bit,
@TPMFreqID as Integer
AS
	
	INSERT INTO  TPM.TPMFrequency
	(
    TPMFreqFrequency ,
	TPMFreqNotes,
	TPMFreqPeriod ,
	TPMFreqDueModifier ,
	TPMInProduction,
	TPMBulkDigital 
	)
	VALUES
	(
	@TPMFreqFrequency,
	@TPMFreqNotes,
	@TPMFreqperiod,
	@TPMFreqDueModifier,
	@TPMInProduction,
	@TPMBulkDigital
	)




	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[IPDefaultGatewayFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[IPDefaultGatewayFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM EQP.IPDefaultGateway
	RETURN
GO
/****** Object:  View [wAppEQP].[IdleAssetView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppEQP].[IdleAssetView]
AS
SELECT        IALID, IALName
FROM            EQP.IdleAssetLocations
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "IdleAssetLocations (EQP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 152
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppEQP', @level1type=N'VIEW',@level1name=N'IdleAssetView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppEQP', @level1type=N'VIEW',@level1name=N'IdleAssetView'
GO
/****** Object:  StoredProcedure [wAppTPM].[GrandScheduleFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[GrandScheduleFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM TPM.GrandSchedule
	ORDER BY GSCWMonDate
	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[IdleAssetInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[IdleAssetInsert]
	
	@IALName nVarChar(50)

AS
	
	Insert Into EQP.IdleAssetLocations (IALName) VALUES (@IALName)

	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[EquipmentModelInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[EquipmentModelInsert]
@ModelNumber as nVarChar(max),
@ManID as Integer,
@Description as nVarChar(max),
@VendorID as Integer,
@OrderNumber as nVarChar(max)

AS
	
	INSERT INTO EQP.EquipmentMOdelNumber
	(
		EQModModelNumber,
		EQModManID,
		EQModDescription,
		EQModVendorID,
		EQModOrderNumber
 	)
	VALUES
	(
		@ModelNumber,
		@ManID,
		@Description,
		@VendorID,
		@OrderNumber
	)


	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[EquipmentModelDelete]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[EquipmentModelDelete]
@ModID as Integer

AS
	DELETE FROM EQP.EquipmentModelNumber
	WHERE EQModID = @ModID
	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[EqpEditUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[EqpEditUpdate]
@EQNote as nVarChar(max),
@EQTmodelLink as Integer,
@EQTPrintNumber as nVarChar(100),
@EQInService as bit,
@EQTID as Integer,
@EQServiceDate as Date,
@EQSerialNumber as nVarChar(100),
@EQTDescription as nVarChar(max),
@EQTIdleLocation as Integer

AS

	-- Before modifying some of the information on this table there are checks that have to be done.
	-- Most importantly if the ModelLink is being changed it has to be checked against the 
	-- Model LInk on the TPM Equipment Number before it can be modified. They have to be the same.
	-- this check should be done on the front end but still needs to be checked here.

	-- the inservice and out of service have to write to the service table.

	UPDATE EQP.Equipment
	SET
		EQNote = @EQNote,
		EQTModelLink = @EQTmodelLink,
		EQTPrintNumber = @EQTPrintNumber,
		EQInService = @EQInService,
		EQServiceDate = @EQServiceDate,
		EQSerialNumber = @EQSerialNumber,
		EQTDescription = @EQTDescription,
		EQTIdleLocation = @EQTIdleLocation
		
	WHERE EQTID = @EQTID


	RETURN
GO
/****** Object:  View [wACom].[EquipListing]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wACom].[EquipListing]
AS
SELECT     EQP.EquipmentModelNumber.*, COM.VendorList.*
FROM         EQP.EquipmentModelNumber LEFT OUTER JOIN
                      COM.VendorList ON EQP.EquipmentModelNumber.EQModVendorID = COM.VendorList.VLID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EquipmentModelNumber (EQP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 181
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "VendorList (COM)"
            Begin Extent = 
               Top = 6
               Left = 256
               Bottom = 227
               Right = 423
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'EquipListing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'EquipListing'
GO
/****** Object:  StoredProcedure [DT].[EcoEmosXfer]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[EcoEmosXfer]

	@Begin datetime,
	@End	datetime,
	@Shift Integer,
	@Text nvarchar(max),
	@Area nvarchar(max),
	@AlarmTag nvarchar(max),
	@Priority integer,
	@MessageType integer,
	@Comment nvarchar(max)


AS
	
	Insert Into DT.EcoFaultCodes (
									EFCText,
									EFCPriority,
									EFCComment,
									EFCFaultTag,
									EFCBegin,
									EFCEnd,
									EFCShift,
									EFCArea)
							Values
								(
									@Text,
									@Priority,
									@Comment,
									@AlarmTag,
									@Begin,
									@End,
									@Shift,
									@Area
									);



	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[EqpEditInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[EqpEditInsert]
@EQNote as nVarChar(max),
@EQTmodelLink as Integer,
@EQTPrintNumber as nVarChar(100),
@EQInService as bit,
@EQServiceDate as Date,
@EQSerialNumber as nVarChar(100),
@EQPlant as Integer,
@EQTDescription as nVarChar(max),
	@RETURN_VALUE INT = 0 OUTPUT 
AS

	INSERT INTO Eqp.Equipment
	(
		EQNote,
		EQTModelLink,
		EQTPrintNumber,
		EQInservice,
		EQServiceDate,
		EQSerialNumber,
		EQPlant,
		EQTDescription
		
	)
	VALUES
	(
		@EQNote,
		@EQTModelLink,
		@EQTPrintNumber,
		@EQInService,
		@EQServiceDate,
		@EQSerialNumber,
		@EQPlant,
		@EQTDescription
	)

	SELECT EQTID FROM EQP.Equipment WHERE (EQTID = SCOPE_IDENTITY())

	RETURN
GO
/****** Object:  StoredProcedure [dbo].[EcoEmosAlarmAdd]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EcoEmosAlarmAdd]
	
	@Area VarChar(5000),
	@Begin Datetime,
	@End Datetime,
	@Shift VarChar(50) = " ",
	@Text VarChar(5000) = " ",
	@Tag VarChar(5000) = " ",
	@Prior VarChar(100) = " ",
	@Type VarChar(100) = " ",
	@Duration VarChar(50) = " ",
	@Comment VarChar(5000) = " ",
	@Edit VarChar(100) = " "
	

AS
	
		IF (SELECT COUNT(*) FROM ECOEmosData WHERE ECOBegin =  @Begin  AND ECOEnd = @End AND ECOText = @Text) = 0
			Insert Into ECOEmosData (
							ECOTextArea,
							ECOBegin,
							ECOEnd,
							ECOShift,
							ECOText,
							ECOTag,
							ECOPrior,
							ECOType,
							ECODuration,
							ECOComment,
							ECOEdit
							
							)
							 
				Values		(
							@Area,
							@Begin,
							@End,
							@Shift,
							@Text,
							@Tag,
							@Prior,
							@Type,
							@Duration,
							@Comment,
							@Edit

							);


	RETURN
GO
/****** Object:  StoredProcedure [dbo].[dt_setpropertybyid]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	If the property already exists, reset the value; otherwise add property
**		id -- the id in sysobjects of the object
**		property -- the name of the property
**		value -- the text value of the property
**		lvalue -- the binary value of the property (image)
*/
create procedure [dbo].[dt_setpropertybyid]
	@id int,
	@property varchar(64),
	@value varchar(255),
	@lvalue image
as
	set nocount on
	declare @uvalue nvarchar(255) 
	set @uvalue = convert(nvarchar(255), @value) 
	if exists (select * from dbo.dtproperties 
			where objectid=@id and property=@property)
	begin
		--
		-- bump the version count for this row as we update it
		--
		update dbo.dtproperties set value=@value, uvalue=@uvalue, lvalue=@lvalue, version=version+1
			where objectid=@id and property=@property
	end
	else
	begin
		--
		-- version count is auto-set to 0 on initial insert
		--
		insert dbo.dtproperties (property, objectid, value, uvalue, lvalue)
			values (@property, @id, @value, @uvalue, @lvalue)
	end
GO
/****** Object:  View [DT].[DT_REP_14Day]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [DT].[DT_REP_14Day]
AS
SELECT     DTLine, DTRobot, DTSolution, DTResponsibility, DTTimeDown, DTTimeUp, DTMinutes, DTMalfunction, DTLongTerm, DTTimeDown1, DTTimeUp2, 
                      DTT3Code, DTID, TotalMinutes, DTNoTime, DTOriginator, DTNDateDown, DTNTimeDown, DTNDateUp, DTNTimeUp, DTNCDown, DTNCUp
FROM         DT.DTMainTable
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[51] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DTMainTable (DT)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 2010
         Width = 855
         Width = 1500
         Width = 705
         Width = 1245
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 3195
         Alias = 900
         Table = 2565
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'DT', @level1type=N'VIEW',@level1name=N'DT_REP_14Day'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'DT', @level1type=N'VIEW',@level1name=N'DT_REP_14Day'
GO
/****** Object:  StoredProcedure [dbo].[dt_getpropertiesbyid_u]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Retrieve properties by id's
**
**	dt_getproperties objid, null or '' -- retrieve all properties of the object itself
**	dt_getproperties objid, property -- retrieve the property specified
*/
create procedure [dbo].[dt_getpropertiesbyid_u]
	@id int,
	@property varchar(64)
as
	set nocount on

	if (@property is null) or (@property = '')
		select property, version, uvalue, lvalue
			from dbo.dtproperties
			where  @id=objectid
	else
		select property, version, uvalue, lvalue
			from dbo.dtproperties
			where  @id=objectid and @property=property
GO
/****** Object:  StoredProcedure [dbo].[dt_getpropertiesbyid]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Retrieve properties by id's
**
**	dt_getproperties objid, null or '' -- retrieve all properties of the object itself
**	dt_getproperties objid, property -- retrieve the property specified
*/
create procedure [dbo].[dt_getpropertiesbyid]
	@id int,
	@property varchar(64)
as
	set nocount on

	if (@property is null) or (@property = '')
		select property, version, value, lvalue
			from dbo.dtproperties
			where  @id=objectid
	else
		select property, version, value, lvalue
			from dbo.dtproperties
			where  @id=objectid and @property=property
GO
/****** Object:  StoredProcedure [dbo].[dt_getobjwithprop_u]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Retrieve the owner object(s) of a given property
*/
create procedure [dbo].[dt_getobjwithprop_u]
	@property varchar(30),
	@uvalue nvarchar(255)
as
	set nocount on

	if (@property is null) or (@property = '')
	begin
		raiserror('Must specify a property name.',-1,-1)
		return (1)
	end

	if (@uvalue is null)
		select objectid id from dbo.dtproperties
			where property=@property

	else
		select objectid id from dbo.dtproperties
			where property=@property and uvalue=@uvalue
GO
/****** Object:  StoredProcedure [dbo].[dt_getobjwithprop]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Retrieve the owner object(s) of a given property
*/
create procedure [dbo].[dt_getobjwithprop]
	@property varchar(30),
	@value varchar(255)
as
	set nocount on

	if (@property is null) or (@property = '')
	begin
		raiserror('Must specify a property name.',-1,-1)
		return (1)
	end

	if (@value is null)
		select objectid id from dbo.dtproperties
			where property=@property

	else
		select objectid id from dbo.dtproperties
			where property=@property and value=@value
GO
/****** Object:  StoredProcedure [dbo].[dt_generateansiname]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
**	Generate an ansi name that is unique in the dtproperties.value column 
*/ 
create procedure [dbo].[dt_generateansiname](@name varchar(255) output) 
as 
	declare @prologue varchar(20) 
	declare @indexstring varchar(20) 
	declare @index integer 
 
	set @prologue = 'MSDT-A-' 
	set @index = 1 
 
	while 1 = 1 
	begin 
		set @indexstring = cast(@index as varchar(20)) 
		set @name = @prologue + @indexstring 
		if not exists (select value from dtproperties where value = @name) 
			break 
		 
		set @index = @index + 1 
 
		if (@index = 10000) 
			goto TooMany 
	end 
 
Leave: 
 
	return 
 
TooMany: 
 
	set @name = 'DIAGRAM' 
	goto Leave
GO
/****** Object:  StoredProcedure [dbo].[dt_dropuserobjectbyid]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Drop an object from the dbo.dtproperties table
*/
create procedure [dbo].[dt_dropuserobjectbyid]
	@id int
as
	set nocount on
	delete from dbo.dtproperties where objectid=@id
GO
/****** Object:  StoredProcedure [dbo].[dt_droppropertiesbyid]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Drop one or all the associated properties of an object or an attribute 
**
**	dt_dropproperties objid, null or '' -- drop all properties of the object itself
**	dt_dropproperties objid, property -- drop the property
*/
create procedure [dbo].[dt_droppropertiesbyid]
	@id int,
	@property varchar(64)
as
	set nocount on

	if (@property is null) or (@property = '')
		delete from dbo.dtproperties where objectid=@id
	else
		delete from dbo.dtproperties 
			where objectid=@id and property=@property
GO
/****** Object:  StoredProcedure [dbo].[dt_adduserobject]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	Add an object to the dtproperties table
*/
create procedure [dbo].[dt_adduserobject]
as
	set nocount on
	/*
	** Create the user object if it does not exist already
	*/
	begin transaction
		insert dbo.dtproperties (property) VALUES ('DtgSchemaOBJECT')
		update dbo.dtproperties set objectid=@@identity 
			where id=@@identity and property='DtgSchemaOBJECT'
	commit
	return @@identity
GO
/****** Object:  StoredProcedure [wAppDT].[DowntimeWebUpdate1]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[DowntimeWebUpdate1]
	
	(
		@DTID int,
		@DTLongTerm nVarChar(max)
	)
	
AS
	UPDATE DT.DTMainTable SET DTLongTerm = @DTLongTerm
	WHERE DTID = @DTID
	RETURN
GO
/****** Object:  View [DT].[DowntimeReportingMain]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [DT].[DowntimeReportingMain]
AS
SELECT     DT.DTMainTable.DTLine, DT.DTMainTable.DTRobot, DT.DTMainTable.DTSolution, DT.DTMainTable.DTResponsibility, DT.DTMainTable.DTTimeDown, 
                      DT.DTMainTable.DTTimeUp, DT.DTMainTable.DTMinutes, DT.DTMainTable.DTLongTerm, DT.DTMainTable.DTMalfunction, 
                      DT.DTMainTable.DTTimeDown1, DT.DTMainTable.DTTimeUp2, DT.DTMainTable.DTT3Code, DT.DTMainTable.DTID, DT.DTMainTable.TotalMinutes, 
                      DT.DTMainTable.DTNoTime, DT.DTMainTable.DTOriginator, DT.DTMainTable.DTNDateDown, DT.DTMainTable.DTNTimeDown, 
                      DT.DTMainTable.DTNDateUp, DT.DTMainTable.DTNCDown, DT.DTMainTable.DTNCUp, DT.DTMainTable.DTNTimeUp, wACom.Lines.LILineName, 
                      wACom.Lines.LISatellite, wACom.Lines.LIPlannerGroup, wACom.Lines.LIID, wACom.Lines.LIPlant, wACom.Areas.AAareaname, 
                      wACom.Areas.AAarealocation, wACom.Areas.AAareaphone, wACom.Areas.AAID, wACom.Areas.AAPlant, wACom.MachineList.MLCELLNAME, 
                      wACom.MachineList.MLLINEID, wACom.MachineList.MLPlantID
FROM         wACom.Areas RIGHT OUTER JOIN
                      DT.DTMainTable LEFT OUTER JOIN
                      wACom.MachineList LEFT OUTER JOIN
                      wACom.Lines ON wACom.MachineList.MLLINEID = wACom.Lines.LIID ON DT.DTMainTable.DTLine = wACom.MachineList.MLID ON 
                      wACom.Areas.AAID = wACom.Lines.LISatellite
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[36] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[46] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 45
               Left = 520
               Bottom = 160
               Right = 675
            End
            DisplayFlags = 344
            TopColumn = 1
         End
         Begin Table = "Areas (wACom)"
            Begin Extent = 
               Top = 46
               Left = 787
               Bottom = 220
               Right = 941
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "DTMainTable (DT)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 257
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 44
               Left = 297
               Bottom = 152
               Right = 448
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 5250
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
' , @level0type=N'SCHEMA',@level0name=N'DT', @level1type=N'VIEW',@level1name=N'DowntimeReportingMain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'DT', @level1type=N'VIEW',@level1name=N'DowntimeReportingMain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'DT', @level1type=N'VIEW',@level1name=N'DowntimeReportingMain'
GO
/****** Object:  StoredProcedure [wAppDoc].[DocListDelete]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[DocListDelete]
(
	@ID int
	)
AS
	DELETE FROM Documentation.DocumentMaster WHERE DMid = @ID
	RETURN
GO
/****** Object:  View [Documentation].[DocDrop1]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Documentation].[DocDrop1]
AS
SELECT     DMid, DMTitle
FROM         Documentation.DocumentMaster
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DocumentMaster (Documentation)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 191
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Documentation', @level1type=N'VIEW',@level1name=N'DocDrop1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'Documentation', @level1type=N'VIEW',@level1name=N'DocDrop1'
GO
/****** Object:  View [wAppDoc].[DocTierIIView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppDoc].[DocTierIIView]
AS
SELECT     Documentation.DocTierTwo.*
FROM         Documentation.DocTierTwo
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DocTierTwo (Documentation)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppDoc', @level1type=N'VIEW',@level1name=N'DocTierIIView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppDoc', @level1type=N'VIEW',@level1name=N'DocTierIIView'
GO
/****** Object:  View [wAppDoc].[DocTierIIIView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppDoc].[DocTierIIIView]
AS
SELECT     Documentation.DocTierThree.*
FROM         Documentation.DocTierThree
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DocTierThree (Documentation)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 199
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppDoc', @level1type=N'VIEW',@level1name=N'DocTierIIIView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppDoc', @level1type=N'VIEW',@level1name=N'DocTierIIIView'
GO
/****** Object:  View [wAppDoc].[DocTier1View]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppDoc].[DocTier1View]
AS
SELECT     Documentation.DocTierOne.*
FROM         Documentation.DocTierOne
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DocTierOne (Documentation)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 84
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppDoc', @level1type=N'VIEW',@level1name=N'DocTier1View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppDoc', @level1type=N'VIEW',@level1name=N'DocTier1View'
GO
/****** Object:  View [wAppDoc].[DocModelBindingView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppDoc].[DocModelBindingView]
AS
SELECT        Documentation.DocBindingModels.DCBDocLink, Documentation.DocBindingModels.DCBModLink, Documentation.DocBindingModels.DCBID, 
                         EQP.EquipmentModelNumber.EQModModelNumber
FROM            Documentation.DocBindingModels LEFT OUTER JOIN
                         EQP.EquipmentModelNumber ON Documentation.DocBindingModels.DCBModLink = EQP.EquipmentModelNumber.EQModID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DocBindingModels (Documentation)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 227
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EquipmentModelNumber (EQP)"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 197
               Right = 453
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppDoc', @level1type=N'VIEW',@level1name=N'DocModelBindingView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppDoc', @level1type=N'VIEW',@level1name=N'DocModelBindingView'
GO
/****** Object:  View [Documentation].[DocmasterView1]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Documentation].[DocmasterView1]
AS
SELECT     DocumentMaster_1.*, CollectionMaster_1.*, Documentation.GroupMaster.*
FROM         Documentation.DocumentMaster AS DocumentMaster_1 FULL OUTER JOIN
                      Documentation.CollectionMaster AS CollectionMaster_1 FULL OUTER JOIN
                      Documentation.GroupMaster ON CollectionMaster_1.COLGroupid = Documentation.GroupMaster.GLid AND 
                      CollectionMaster_1.COLGroupid = Documentation.GroupMaster.GLid AND CollectionMaster_1.COLGroupid = Documentation.GroupMaster.GLid ON 
                      DocumentMaster_1.DMCollectionID = CollectionMaster_1.COLid
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[5] 2[5] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CollectionMaster_1"
            Begin Extent = 
               Top = 16
               Left = 366
               Bottom = 194
               Right = 518
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GroupMaster (Documentation)"
            Begin Extent = 
               Top = 25
               Left = 705
               Bottom = 193
               Right = 857
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DocumentMaster_1"
            Begin Extent = 
               Top = 15
               Left = 34
               Bottom = 182
               Right = 187
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 2625
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Documentation', @level1type=N'VIEW',@level1name=N'DocmasterView1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'Documentation', @level1type=N'VIEW',@level1name=N'DocmasterView1'
GO
/****** Object:  StoredProcedure [wAppDoc].[DocListUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[DocListUpdate]

	@ID int,
	@Title nVarChar(100),
	@SearchTag nVarChar(max),
	@Notes nVarChar(max),
	@TIIILink int

AS
	
	UPDATE Documentation.DocumentMaster
		SET
			DMTitle = @Title,
			DMSearchTags = @SearchTag,
			DMNotes = @Notes,
			DMTierThreeLink = @TIIILink
		WHERE 
			DMid = @ID

	RETURN
GO
/****** Object:  StoredProcedure [wAppDoc].[DocListInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[DocListInsert]
	
	(
		@Title nVarChar(100),
		@Tier3Link int,
		@URL nVarChar(300)
	)
	
AS
	
	INSERT INTO Documentation.DocumentMaster (DMTitle,DMTierThreeLink,DMDocWebURL) VALUES (@Title, @Tier3Link,@URL)


	RETURN
GO
/****** Object:  StoredProcedure [wACom].[DateFill]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[DateFill]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
DECLARE @ctrx as Integer;
DECLARE @startDate as Date;

SET @StartDate = '1/1/2011';
SET @ctrx = 0;
	
	delete from wAcom.GenericDateTable


	WHILE @ctrx < 10000
	BEGIN

	INSERT INTO wACom.GenericDateTable
	(
		GDTDate
	)
	VALUES
	(
		DateAdd(Day,@ctrx,@startdate)
	)

	SET @ctrx = @ctrx + 1
	END



	RETURN
GO
/****** Object:  StoredProcedure [WO].[CreateScheduleTable]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[CreateScheduleTable]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	
	DECLARE @date date;
	DECLARE @ctr int;
	SET @ctr = 1;

	DELETE FROM WO.ScheduleTable;

	WHILE @ctr < 2000
	BEGIN
		
		INSERT INTO WO.ScheduleTable
		 (
			STDate,
			STMaintShiftOne,
			STMaintShiftTwo,
			STMaintShiftThree,
			STProdShiftOne,
			STProdShiftTwo,
			STProdShiftThree
			
		 )
			VALUES
		 ( 
				 DATEADD(DAY,@ctr,GetDate()),
				 1,
				 1,
				 1,
				 1,
				 1,
				 1
		 )











		SET @ctr = @ctr + 1
	END




	RETURN
GO
/****** Object:  StoredProcedure [TPM].[ClosedTPMARGPCW]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TPM].[ClosedTPMARGPCW]
	@DatePass Date = '9/2/2011',
	@LineNumber Integer = 1,
	@TPMProc Integer,
	@TPMFreq Integer,
	@WeekNumber Integer,
	@ReturnDate Date OUTPUT


AS
	DECLARE @DateHold1 Date;
	DECLARE @DateHold2 Date;
	DECLARE @DateHold3 Date;


		
	-- Find the monday for the Calander week sent over with @DatePass
	Set @DateHold1 = (SELECT TOP 1 GSCWMonDate FROM TPM.GrandSchedule
									WHERE GSCWMonDate <= @DatePass
									ORDER BY GSCWMonDate DESC)

    -- Find the first monday of the calander month from the monday date in the previous step. This should be the beginning of the month
	SET @DateHold2 = (SELECT TOP 1 GSCWMonDate FROM TPM.GrandSchedule
									WHERE DATEPART(YEAR,GSCWMonDate) = DATEPART(YEAR,@DateHold1)
									AND
									DATEPART(MONTH,GSCWMonDate) = DATEPART(MONTH,@DateHold1)
									ORDER BY GSCWMonDate ASC)
	
	SET @DateHold3 = DATEADD(DAY,(@WeekNumber * 7),@DateHold2);
	SET @ReturnDate = @DateHold3;



	SELECT count(DISID) AS Total
	FROM WO.WorkOrderMain
	WHERE	DISTPMNumber = @TPMProc
			AND
			DISCloseDate BETWEEN @DateHold3 AND DATEADD(DAY,7,@DateHold3)
			AND
			DISLineNumber = @LineNumber;





	RETURN
GO
/****** Object:  StoredProcedure [WO].[ClosedTPM]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[ClosedTPM]
	@SearchDate Date,
	@Type integer,
	@Return integer OUTPUT

AS

SELECT DISID
	FROM WO.WorkOrderMain
	WHERE DISCloseDate = @SearchDate AND DISType = 3;


	Set @Return = @@Rowcount;

	RETURN
GO
/****** Object:  StoredProcedure [WO].[CalculateClosed]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[CalculateClosed]

	@SearchDate Date,
	@Type integer,
	@Return integer OUTPUT

AS
If @Type = 3 
Begin
	SELECT DISID FROM WO.WorkOrderMain WHERE DISCloseDate = @SearchDate AND DISType = 3
		Set @Return = @@Rowcount
End
Else
Begin
	SELECT DISID FROM WO.WorkOrderMain WHERE DISCloseDate = @SearchDate AND DISType <> 3
	Set @Return = @@Rowcount;
End

	RETURN
GO
/****** Object:  StoredProcedure [TPM].[CalanderWeekCalc]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TPM].[CalanderWeekCalc]
	@DatePass Date = '9/2/2011',
	@ReturnDate Date OUTPUT



AS
	DECLARE @DateHold1 Date;
	DECLARE @DateHold2 Date;
	DECLARE @DateHold3 Date;


		
	-- Find the monday for the Calander week sent over with @DatePass
	Set @DateHold1 = (SELECT TOP 1 GSCWMonDate FROM TPM.GrandSchedule
									WHERE GSCWMonDate <= @DatePass
									ORDER BY GSCWMonDate DESC)

    -- Find the first monday of the calander month from the monday date in the previous step. This should be the beginning of the month
	SET @DateHold2 = (SELECT TOP 1 GSCWMonDate FROM TPM.GrandSchedule
									WHERE DATEPART(YEAR,GSCWMonDate) = DATEPART(YEAR,@DateHold1)
									AND
									DATEPART(MONTH,GSCWMonDate) = DATEPART(MONTH,@DateHold1)
									ORDER BY GSCWMonDate ASC)
	
	SET @ReturnDate = @DateHold2;
	RETURN
GO
/****** Object:  StoredProcedure [wACom].[AreaDropUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[AreaDropUpdate]

	@AAID int,
	@AAareaName nVarChar(max),
	@AAActive bit


AS
	
	UPDATE wACom.Areas
	SET
		AAareaname = @AAareaName,
		AAActive = @AAActive
	WHERE
		AAID = @AAID

	RETURN
GO
/****** Object:  StoredProcedure [wACom].[AreaDropInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[AreaDropInsert]

	@AAareaname nVarChar(max),
	@AAPlant int = 0,
	@RETURN_VALUE INT = 0 OUTPUT 
	

AS
	
	INSERT INTO wACom.Areas
		(
			AAareaName,
			AAPlant,
			AAActive
		)
	Values
		(
			@AAareaname,
			@AAPlant,
			1
		)


	SELECT AAID FROM wACom.Areas WHERE (AAID = SCOPE_IDENTITY())
	
	
	RETURN @RETURN_VALUE
GO
/****** Object:  StoredProcedure [wACom].[AreaDropDelete]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[AreaDropDelete]
	
	@AAID int

AS
	
	DELETE FROM wACom.Areas
	WHERE AAID = @AAID

	RETURN
GO
/****** Object:  StoredProcedure [wACom].[AreaDrop]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[AreaDrop]
	
	(
		@Plant AS Integer
	)
	
AS

	SELECT * FROM wACom.Areas WHERE AAPLant = @Plant AND AAActive = 1

	RETURN
GO
/****** Object:  StoredProcedure [EQP].[AssetUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [EQP].[AssetUpdate]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	 UPDATE EQP.Equipment
	 SET EQTID = EQTIDold


	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[AssetAssignmentInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[AssetAssignmentInsert]


	 @AAHdate Date,
	 @AAHCause nVarChar(max),
	 @AAHUserID int,
	 @AAHFromIdle int,
	 @AAHFromProc int,
	 @AAHToIdle	int,
	 @AAHToProc int,
	 @AAHAssetID int,
	@RETURN_VALUE INT = 0 OUTPUT 

AS
	Insert Into EQP.AssetAssignmentHistory
		(
			AAHDate,
			AAHCause,
			AAHUserID,
			AAHFromIdle,
			AAHFromProc,
			AAHToIdle,
			AAHToProc,
			AAHAssetID
		)
		VALUES
		(
			@AAHDate,
			@AAHCause,
			@AAHUserID,
			@AAHFromIdle,
			@AAHFromProc,
			@AAHToIdle,
			@AAHToProc,
			@AAHAssetID
		)



	SELECT AAHID FROM EQP.AssetAssignmentHistory WHERE (AAHID = SCOPE_IDENTITY())
	RETURN @RETURN_VALUE
GO
/****** Object:  StoredProcedure [wAppEQP].[AssetAssignmentFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[AssetAssignmentFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM EQP.AssetAssignmentHistory

	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelGroupThreeUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelGroupThreeUpdate]

	@MGThreeID Int,
	@MGThreeName nVarChar(max),
	@MGThreeTwoLink Int,
	@MGThreeActive bit

AS
	
	UPDATE EQP.ModelGroupThree
		SET
			MGTHreeName = @MGThreename,
			MGThreeTwoLink = @MGThreeTwoLink,
			MGThreeActive = @MGThreeActive
		WHERE
			MGThreeID = @MGThreeID


	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelGroupThreeInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelGroupThreeInsert]
	@MGThreeName nVarChar(max),
	@MGThreeTwoLink int,
	@RETURN_VALUE INT = 0 OUTPUT 

AS
	
	INSERT INTO EQP.ModelGroupThree(MGThreeName,MGThreeTwoLink) VALUES (@MGThreeName,@MGThreeTwoLink)




	SELECT MGThreeID FROM EQP.ModelGroupThree WHERE (MGThreeID = SCOPE_IDENTITY())

	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelGroupThreeFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelGroupThreeFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM EQP.ModelGroupThree
		WHERE MGThreeActive = 1
	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelGroupOneInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelGroupOneInsert]

	@MGOneName nVarChar(max),
	@RETURN_VALUE INT = 0 OUTPUT 

AS
	
	INSERT INTO EQP.ModelGroupOne (MGOneName) VALUES (@MGOneName)




	SELECT MGOneID FROM EQP.ModelGroupOne WHERE (MGOneID = SCOPE_IDENTITY())

	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelGroupOneFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelGroupOneFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM EQP.ModelGroupOne
		WHERE MGOneActive = 1
	RETURN
GO
/****** Object:  View [wAppEQP].[IPTableView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppEQP].[IPTableView]
AS
SELECT     IPTID, IPTFirstOct, IPTSecOct, IPTThirdOct, IPTFourthOct, IPTDescription, IPTLocation, IPTIPText, IPTHostName, IPTSubNet, IPEQPTYPELINK, 
                      IPVENDORLINK, IPWakeUpGroup, IPTDGLink
FROM         EQP.IPTable
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "IPTable (EQP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 336
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppEQP', @level1type=N'VIEW',@level1name=N'IPTableView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppEQP', @level1type=N'VIEW',@level1name=N'IPTableView'
GO
/****** Object:  View [Weld].[MaterialDropDown2]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Weld].[MaterialDropDown2]
AS
SELECT     MDID, MDName
FROM         Weld.MaterialData
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "MaterialData (Weld)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 106
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Weld', @level1type=N'VIEW',@level1name=N'MaterialDropDown2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'Weld', @level1type=N'VIEW',@level1name=N'MaterialDropDown2'
GO
/****** Object:  View [Weld].[MaterialDropDown1]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Weld].[MaterialDropDown1]
AS
SELECT     MDName, MDYieldStrength
FROM         Weld.MaterialData
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "MaterialData (Weld)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 148
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Weld', @level1type=N'VIEW',@level1name=N'MaterialDropDown1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'Weld', @level1type=N'VIEW',@level1name=N'MaterialDropDown1'
GO
/****** Object:  StoredProcedure [Weld].[MaterialDataFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[MaterialDataFetch]

	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM Weld.MaterialData
	RETURN
GO
/****** Object:  View [wACom].[MachineListDropView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wACom].[MachineListDropView]
AS
SELECT        MLID, MLPlantID, MLCELLNAME, MLLINEID, MLActive
FROM            wACom.MachineList
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 209
               Right = 194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3720
         Alias = 1980
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'MachineListDropView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'MachineListDropView'
GO
/****** Object:  StoredProcedure [wACom].[LineDropUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[LineDropUpdate]

	@ID int,
	@LineName nVarChar(max),
	@Satellite int,
	@LIActive bit

AS
	
	UPDATE wACom.Lines
	SET
		LILineName = @LineName,
		LISatellite = @Satellite,
		LIActive = @LIActive
	WHERE
		LIID = @ID


	RETURN
GO
/****** Object:  StoredProcedure [wACom].[LineDropInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[LineDropInsert]
	
	@LILineName nVarChar(max),
	@LISatellite int,
	@LIPlant int,
	@RETURN_VALUE INT = 0 OUTPUT 


AS
	INSERT INTO wACom.Lines
		(
			LILineName,
			LISatellite,
			LIPlant,
			LIActive
		)
	VALUES
		(
			@LILineName,
			@LISatellite,
			@LIPLant,
			1
		)

	SELECT LIID FROM wACom.LInes WHERE (LIID = SCOPE_IDENTITY())
	
	
	RETURN @RETURN_VALUE
GO
/****** Object:  StoredProcedure [wACom].[LineDrop]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[LineDrop]
@Plant as Integer
AS

	SELECT * FROM wACom.Lines
	WHERE LIPlant = @Plant AND LIActive = 1
	ORDER BY LILineName


	RETURN
GO
/****** Object:  StoredProcedure [wACom].[MachineDropUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[MachineDropUpdate]

	@ID int,
	@Name nVarChar(max),
	@Line int,
	@Active bit,
	@RETURN_VALUE INT = 0 OUTPUT 



AS
DECLARE @woCount AS INTEGER;

	IF @ACTIVE = 0
	BEGIN
	SET @woCount = 	(SELECT COUNT(DISID) FROM WO.WorkOrderMain
		WHERE DISCloseDate IS NULL AND DISLineNumber = @ID);

		IF @woCount > 0
		BEGIN


			SELECT MLACTIVE FROM wACom.MachineList WHERE (MLID = @ID)
			RETURN;

		END
		ELSE
		BEGIN

			UPDATE wACom.MachineList
			SET
				MLCellName = @Name,
				MLLineID = @Line,
				MLActive = @Active
			WHERE MLID = @ID


		END

	END

	RETURN @RETURN_VALUE
GO
/****** Object:  StoredProcedure [wACom].[MachineDropInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[MachineDropInsert]

	@Name nVarChar(max),
	@LIne int,
	@PlantID int,
	@RETURN_VALUE INT = 0 OUTPUT 

AS
	
	INSERT INTO wACom.MachineList
		(
			MLCellName ,
			MLLineID ,
			MLPlantID,
			MLActive
		)
	VALUES
		(
			@Name,
			@Line,
			@PlantID,
			1
			)



	SELECT MLID FROM wACom.MachineList WHERE (MLID = SCOPE_IDENTITY())
	
	
	RETURN @RETURN_VALUE
GO
/****** Object:  StoredProcedure [OI].[OpenItemAddNew]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [OI].[OpenItemAddNew]

@PunchItem VarChar(5000),
@DateEntered Date,
@DateRequired Date,
@EquipmentNumber Integer,
@Originator Integer, 
@ARGNumber Integer,
@ManagedBy Integer,
@KanBanNum Integer,
@Category Integer, 
@Responsible Integer, 
@Type Integer,
@Return Integer OUTPUT

AS 
SET NOCOUNT ON;

DECLARE @strInsert nVarChar(4000);
DECLARE @ParamList nVarChar(4000);
DECLARE @Return2 Integer;

Set @ParamList = '
@PunchItem1 VarChar(5000),
@DateEntered1 Date,
@DateRequired1 Date,
@EquipmentNumber1 Integer,
@Originator1 Integer,
@ARGNumber1 Integer,
@ManagedBy1 Integer,
@KanBanNum1 Integer,
@Type1 Integer,
@Category1 Integer,
@Responsible1 Integer,
@Return1 Integer OUTPUT';



Set @strInsert = '
INSERT INTO OI.OpenItemsMaster(
OILPunchItem,
OILDateEntered,
OILDateRequired,
OILEquipmentNumber,
OILOriginator,
OILARGNumber, 
OILManagedby,
OILKBLineNumber,
OILType,
OILCategory,
OILResponsible
)

VALUES(
@PunchItem1,
@DateEntered1,
@DateRequired1,
@EquipmentNumber1,
@Originator1,
@ARGNumber1,
@ManagedBy1,
@KanBanNum1,
@Type1,
@Category1,
@Responsible1

);

Select @Return1 = Scope_Identity();';

EXEC sp_executesql
 @strInsert,
 @ParamList,
 @PunchItem1 = @PunchItem,
 @DateEntered1 = @DateEntered,
 @DateRequired1 = @DateRequired,
 @EquipmentNumber1 = @EquipmentNumber,
 @Originator1 = @Originator,
 @ARGNumber1 = @ArgNumber,
 @ManagedBy1 = @ManagedBy,
 @KanBanNum1 = @KanBanNum,
 @Type1 = @Type,
 @Category1 = @Category,
 @Responsible1 = @Responsible,

 @Return1 = @Return2 OUTPUT
 ;


 Set @Return = @Return2;

 DELETE  OI.EventTable WHERE ETPLID = @Return;


INSERT INTO OI.EventTable(
ETDateEntered,
ETPLID,
ETEvent,
ETDueDate,
ETDateResolved
)
VALUES
(
@DateEntered,
@Return,
'Entered Into Data System',
@DateEntered,
@DateEntered

);

	RETURN @Return
GO
/****** Object:  StoredProcedure [wAppTeam].[MyChampsUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[MyChampsUpdate]

	@MCID int,
	@MCTEXT1 nVarChar(max),
	@MCIMAGE1 image

AS
	
	UPDATE TEAM.MyChamps
		SET 
			MCText1 = @MCTEXT1,
			MCIMAGE1 = @MCIMAGE1
	WHERE 
		MCTEXT1 = @MCTEXT1

	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[MyChampsFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[MyChampsFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM TEAM.MyChamps
	RETURN
GO
/****** Object:  StoredProcedure [Team].[NOvertimeBase]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Team].[NOvertimeBase]

	@TeamMember Integer,
	@PayDate Date

AS

	IF (SELECT COUNT(*) FROM TEAM.NOvertimeHours WHERE OTTeamMember =  @TeamMember  AND OTPayPeriod = @PayDate) = 0
			Insert Into Team.NOvertimeHours (OTTeamMember,OTPayPeriod,OTLastChange) VALUES(@TeamMember,@PayDate,GETDATE());
	

	
RETURN
GO
/****** Object:  View [wAppEQP].[ModelView]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppEQP].[ModelView]
AS
SELECT        EQModID, EQModModelNumber, EQModManID, EQModDescription, EQModVendorID, EQModOrderNumber, EQModImageOne, EQModGroupTier, 
                         EQModGroupLink
FROM            EQP.EquipmentModelNumber
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EquipmentModelNumber (EQP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 291
               Right = 245
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppEQP', @level1type=N'VIEW',@level1name=N'ModelView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppEQP', @level1type=N'VIEW',@level1name=N'ModelView'
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelNumberUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelNumberUpdate]
@EQModID as Integer,
@EQModModelNumber as nVarChar(max),
@EQModManID as Integer,
@EQModDescription as nVarChar(max),
@EQModVendorID as Integer,
@EQModOrderNumber as nVarChar(max),
@EQModGroupLink as Integer,
@EQModGroupTier as Integer


AS
	
	UPDATE EQP.EquipmentModelNumber
	SET
		EQModModelNumber	=		@EQModModelNumber,
		EQModManID			=		@EQModManID,
		EQModDescription	= 		@EQModDescription,
		EQModVendorID		= 		@EQModVendorID ,
		EQModOrderNumber	= 		@EQModOrderNumber,
		EQModGroupLink		=		@EQModGroupLink,
		EQModGroupTier		=		@EQModGroupTier
	WHERE EQModID = @EQModID


	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelNumberInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelNumberInsert]

@EQModModelNumber as nVarChar(max),
@EQModManID as Integer,
@EQModDescription as nVarChar(max),
@EQModVendorID as Integer,
@EQModOrderNumber as nVarChar(max),
@EQModGroupLink as integer,
@EQModGroupTier as Integer,
@RETURN_VALUE INT = 0 OUTPUT 

AS
	
	INSERT INTO EQP.EquipmentMOdelNumber
	(
		EQModModelNumber,
		EQModManID,
		EQModDescription,
		EQModVendorID,
		EQModOrderNumber,
		EQmodGroupLink,
		EQModGroupTier
 	)
	VALUES
	(
		@EQModModelNumber,
		@EQModManID,
		@EQModDescription,
		@EQModVendorID,
		@EQModOrderNumber,
		@EQModGroupLink ,
		@EQModGroupTier
	)

	SELECT EQModID FROM EQP.EquipmentModelNumber WHERE (EQModID = SCOPE_IDENTITY())
	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelNumberDelete]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelNumberDelete]
@ModID as Integer

AS
	DELETE FROM EQP.EquipmentModelNumber
	WHERE EQModID = @ModID
	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelGroupTwoUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelGroupTwoUpdate]

	@MGTwoID Int,
	@MGTwoName nVarChar(max),
	@MGTwoOneLink Int,
	@MGTwoActive bit
AS
	
	UPDATE EQP.ModelGroupTwo
		SET
			MGTwoName = @MGTwoName,
			MGTwoOneLink = @MGTwoOneLink,
			MGTwoActive = @MGTwoActive
		WHERE
			MGTwoID = @MGTwoID


	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelGroupTwoInsert]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelGroupTwoInsert]
	@MGTwoName nVarChar(max),
	@MGTwoOneLink int,
	@RETURN_VALUE INT = 0 OUTPUT 

AS
	
	INSERT INTO EQP.ModelGroupTwo (MGTwoName,MGTwoOneLink) VALUES (@MGTwoName,@MGTwoOneLink)




	SELECT MGTwoID FROM EQP.ModelGroupTwo WHERE (MGTwoID = SCOPE_IDENTITY())

	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelGroupTwoFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelGroupTwoFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM EQP.ModelGroupTwo
		WHERE MGTwoActive = 1
	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[PayPeriodFetch]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[PayPeriodFetch]

AS

	
	SELECT TOP 5 GSCWMonDate FROM TPM.GrandSchedule
	WHERE GSCWMonDate !> DateAdd(Day,0,GetDate())
	ORDER BY GSCWMonDate Desc

	RETURN
GO
/****** Object:  View [Team].[PayPeriodDropDown]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Team].[PayPeriodDropDown]
AS
SELECT     TOP (10) PayPeriod
FROM         Team.PayPeriods
WHERE     (PayPeriod <= GETDATE())
ORDER BY PayPeriod DESC
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[9] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PayPeriods (Team)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 101
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 2820
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'VIEW',@level1name=N'PayPeriodDropDown'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'Team', @level1type=N'VIEW',@level1name=N'PayPeriodDropDown'
GO
/****** Object:  StoredProcedure [wAppTeam].[OvertimeOneUpdate]    Script Date: 10/26/2012 10:35:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[OvertimeOneUpdate]
@ID  as Integer,
@Mon as Decimal(18,2) = 0,
@Tue as Decimal(18,2) = 0,
@Wed as Decimal(18,2) = 0,
@Thur as Decimal(18,2) = 0,
@Fri as Decimal(18,2) = 0,
@Sat as Decimal(18,2) = 0,
@Sun as Decimal(18,2) = 0,
@SatVol as Bit = false,
@SunVol as Bit =  false,
@Edit as integer = 0,
@MonCode as integer = 19,
@TueCode as integer = 19,
@WedCode as integer = 19,
@ThuCode as integer = 19,
@FriCode as integer = 19,
@SatCode as integer = 19,
@SunCode as integer = 19


AS
	
	UPDATE Team.NOvertimeHours
	SET
		OTHMon1Reg = @Mon,
		OTHTue1Reg = @Tue,
		OTHWed1Reg = @Wed,
		OTHThu1Reg = @Thur,
		OTHFri1Reg = @Fri,
		OTHSat1Reg = @Sat,
		OTHSun1Reg = @Sun,
		OTSat1Vol = @SatVol,
		OTSun1Vol = @SunVol,
		OTLastEdit = @Edit,
		OTTCodeMon = @MonCode,
		OTTCodeTue = @TueCode,
		OTTCodeWed = @WedCode,
		OTTCodeThur = @ThuCode,
		OTTCodeFri = @FriCode,
		OTTCodeSat = @SatCode,
		OTTCodeSun = @SunCode

	WHERE OTID = @ID



	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[OvertimeAutoAdd]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[OvertimeAutoAdd]
	@TeamMember Integer,
	@PayDate Date

AS
DECLARE @iCount as Integer;
Set @iCount = 0;
WHILE @iCount < 5
BEGIN

	IF (SELECT COUNT(*) FROM TEAM.NOvertimeHours WHERE OTTeamMember =  @TeamMember  AND OTPayPeriod = DATEADD(Day,-(@iCount * 7),@PayDate)) = 0
	     Insert Into Team.NOvertimeHours
		  (
			OTTeamMember,
		    OTPayPeriod,
		    OTLastChange,
			OTHMon1Reg,
			OTHTue1Reg,
			OTHWed1Reg,
			OTHThu1Reg,
			OTHFri1Reg,
			OTHSat1Reg,
			OTHSun1Reg,
			OTTCodeMon,
			OTTCodeTue,
			OTTCodeWed,
			OTTCodeThur,
			OTTCodeFri,
			OTTCodeSat,
			OTTCodeSun,
			OTLastEdit

		  )
		  VALUES
		  (
			@TeamMember,
			(DATEADD(Day,-(@iCount * 7),@PayDate)),
			GETDATE(),
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			19,
			19,
			19,
			19,
			19,
			19,
			19,
			22


		  );

	SET @iCount = @iCount + 1;
END;
	
RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[OpenTPMUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[OpenTPMUpdate]
@WONumber as Integer,
@TM as Integer,
@NumTM as Integer,
@Min as Integer,
@Notes as nVarChar(max)


AS

	UPDATE WO.WorkOrderMain
	SET
		DISCloseDate = GetDate(),
		DISNumberAss = @NumTM,
		DISManHours = @Min,
		DISWorkAccomp = @Notes,
		DISRequestor = @TM
	WHERE DISID = @WONumber

	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[PayPeriodSingleFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[PayPeriodSingleFetch]

AS

----DECLARE @TestDate as Date;

--SET @TestDate = '7/29/2012';

	SELECT TOP 4 GSCWMonDate FROM TPM.GrandSchedule
	WHERE GSCWMonDate !> DateAdd(Day,0,GetDate())
	ORDER BY GSCWMonDate Desc
	
	
	RETURN
GO
/****** Object:  UserDefinedFunction [wAppTeam].[OTStraightTimeCalc]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [wAppTeam].[OTStraightTimeCalc]
	(
		@PayPeriod Date,
		@TMID	Integer,
		@returnType Decimal  
			-- 1 straight time
			-- 2 1.5 x
			-- 3 2 x
	)
RETURNS Decimal
AS
	BEGIN

	DECLARE @MonMin Decimal;
	DECLARe @TueMin Decimal;
	DECLARE @WedMin Decimal;
	DECLARE @ThuMin Decimal;
	DECLARE @FriMin Decimal;
	DECLARE @SatMin Decimal;
	DECLARE @SunMin Decimal;
	 



	SET @MonMin = (SELECT TOP 1 OTHMon1Reg FROM Team.NOvertimeHours WHERE OTTeamMember = @TMID AND OTPayPeriod = @PayPeriod);
	SET @TueMin = (SELECT TOP 1 OTHTue1Reg FROM Team.NOvertimeHours WHERE OTTeamMember = @TMID AND OTPayPeriod = @PayPeriod);
	SET @WedMin = (SELECT TOP 1 OTHWed1Reg FROM Team.NOvertimeHours WHERE OTTeamMember = @TMID AND OTPayPeriod = @PayPeriod);
	SET @ThuMin = (SELECT TOP 1 OTHThu1Reg FROM Team.NOvertimeHours WHERE OTTeamMember = @TMID AND OTPayPeriod = @PayPeriod);
	SET @FriMin = (SELECT TOP 1 OTHFri1Reg FROM Team.NOvertimeHours WHERE OTTeamMember = @TMID AND OTPayPeriod = @PayPeriod);
	SET @SatMin = (SELECT TOP 1 OTHSat1Reg FROM Team.NOvertimeHours WHERE OTTeamMember = @TMID AND OTPayPeriod = @PayPeriod);
	SET @SunMin = (SELECT TOP 1 OTHSun1Reg FROM Team.NOvertimeHours WHERE OTTeamMember = @TMID AND OTPayPeriod = @PayPeriod);


	

	

	


	RETURN 1
	END
GO
/****** Object:  StoredProcedure [wAppTeam].[SignatureSheetReport]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[SignatureSheetReport]
@Plant Integer,
@Shift Integer,
@PayDate Date



AS

DECLARE @holdDate Date;
SET @holdDate = wACom.GetCWMonDate(wACom.GetCWFromDate(@PayDate),DatePart(year,@PayDate));

SET @PayDate = @holdDate;

		SELECT * FROM (
	
		SELECT 
				s.TMFirstName,
				s.TMLastName,
				s.TMFirstName + ' ' + s.TMLastName as ShowName,
				s.TMID,
				wAppTeam.OTHourCalc(s.TMID,e.OTPayPeriod,1,e.OTHMon1Reg) as MonMin,
				wAppTeam.OTHourCalc(s.TMID,e.OTPayPeriod,2,e.OTHTue1Reg) as TueMin,
				wAppTeam.OTHourCalc(s.TMID,e.OTPayPeriod,3,e.OTHWed1Reg) as WedMin,
				wAppTeam.OTHourCalc(s.TMID,e.OTPayPeriod,4,e.OTHThu1Reg) as ThuMin,
				wAppTeam.OTHourCalc(s.TMID,e.OTPayPeriod,5,e.OTHFri1Reg) as FriMin,
				wAppTeam.OTHourCalc(s.TMID,e.OTPayPeriod,6,e.OTHSat1Reg) as SatMin,
				wAppTeam.OTHourCalc(s.TMID,e.OTPayPeriod,7,e.OTHSun1Reg) as SunMin,
				wAppTeam.OTStraightTimeCalc(e.OTPayPeriod, s.TMID,1) as TotalStraight,
				ISNULL(e.TCMonName, 'No Code') as MonCode,
				ISNULL(e.TCTueName, 'No Code') as TueCode,
				ISNULL(e.TCWedName, 'No Code') as WedCode,
				ISNULL(e.TCThurName, 'No Code') as ThuCode,
				ISNULL(e.TCFriName, 'No Code') as FriCode,
				ISNULL(e.TCSatName, 'No Code') as SatCode,
				ISNULL(e.TCSunName, 'No Code') as SunCode,
				ISNULL(e.OTSat1Vol, 0) as SatVol,
				ISNULL(e.OTSun1Vol, 0) as SunVol,
				ISNULL(e.OTPayPeriod,@PayDate) AS PayPeriod,
				s.PNID,
				s.TMEmpNumber,
				s.TMPayStatus
		FROM wAppTeam.SignatureSheetView as s
		LEFT JOIN wAppTeam.OvertimeOneView as e ON e.OTTeamMember = s.TMID
		WHERE s.TMNShift = @Shift ) t
		WHERE t.PayPeriod = @PayDate AND t.PNID = @Plant AND t.TMPayStatus = 1
		ORDER BY t.TMLastName
		










	RETURN
GO
/****** Object:  UserDefinedFunction [Development].[RetrieveProcString]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Development].[RetrieveProcString]
	(
		@ProcedureNumber int
	)

RETURNS nVarChar(max)

AS
BEGIN



DECLARE @resultString nVarChar(max) = (char(13) + char(10));
DECLARE @taskNumber int;
DECLARE @taskText nVarChar(max);

DECLARE @CWTable TABLE
(
	taskNumber INTEGER,
	task	nVarChar(max)
);


INSERT INTO @CWTable 
	SELECT TPMTLID, TPMTLTask
		FROM TPM.TPMTaskList as TL
			LEFT JOIN TPM.TPMTaskAssembly AS TA ON TA.TPMTATaskID = TL.TPMTLID
		WHERE TA.TPMTAProcedureID = @ProcedureNumber 


DECLARE cwTable CURSOR FAST_FORWARD FOR
	SELECT * FROM @CWTable

OPEN cwTable


FETCH NEXT FROM cwTable INTO @taskNumber, @taskText

WHILE @@FETCH_STATUS = 0

BEGIN

	 -- cycle through all of the tasks and assemble them into the final string


	SET @resultString = ISNULL(@resultString,(char(13) + char(10))) + ISNULL(@taskText, '') +  (char(13) + char(10))
FETCH NEXT FROM cwTable INTO @taskNumber, @taskText
END


CLOSE cwTable
DEALLOCATE cwTable



RETURN @resultString;

	END
GO
/****** Object:  StoredProcedure [wAppTeam].[paySequenceFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[paySequenceFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM Team.PaySequence
	RETURN
GO
/****** Object:  StoredProcedure [WO].[ReportCalc1]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[ReportCalc1]
@MonDate as DATE

AS
	SET @MonDate = '10/3/2011';

	SELECT DISCloseDate,
		 SUM(CASE WHEN DISType = 3 THEN (DISNumberAss * DISManHours) END) as tpm,
		 SUM(CASE WHEN DISType <> 3 THEN (DISNumberAss * DISManHours) END) as CI,
		 (SELECT sum(OTHMON1REG) FROM TEAM.OvertimeHours WHERE OTPayPeriod = @MonDate) AS hrs
	FROM WO.WorkOrderMain
	WHERE DISCloseDate BETWEEN @MonDate and  DATEADD(Day,7, @MonDate)
	Group By DISCloseDate;


	RETURN
GO
/****** Object:  StoredProcedure [Development].[RecursiveTestIng]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Development].[RecursiveTestIng]

	@level int = 0

AS

with cte
as
	(
	SELECT IDCol,NameCol,Parent FROM RecursiveTest WHERE Parent = 0

	UNION ALL

	SELECT C.IDCol,C.NameCol,C.Parent FROM cte AS R
		inner join RecursiveTest AS C
		 on C.Parent = R.IDCol
	)



	SELECT * from cte
GO
/****** Object:  StoredProcedure [wAppTeam].[ShiftFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[ShiftFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM Team.ShiftTable
	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TaskCatetoryIIFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TaskCatetoryIIFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM TPM.TaskListSubTypeOne
	ORDER BY TLTSIName
	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TaskCategoryFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TaskCategoryFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS

	SELECT * FROM TPM.TaskCatagoryLevelI
	ORDER BY TCLIText
	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[teamAssignFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[teamAssignFetch]
@Plant int
AS
	SELECT * FROM TEAM.TeamAssignments
	WHERE ASGPlant = @Plant
	RETURN
GO
/****** Object:  StoredProcedure [Team].[TeamAssgnFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Team].[TeamAssgnFetch]
@Plant as integer
AS
	IF @Plant > 0
	BEGIN
	SELECT * FROM Team.TeamAssignments
	WHERE ASGPlant = @Plant
	END
	ELSE
	BEGIN
	SELECT * FROM Team.TeamAssignments
	END
	RETURN
GO
/****** Object:  View [wAppParts].[ScheduledSparePartsView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppParts].[ScheduledSparePartsView]
AS
SELECT     SP.ScheduledUsageList.SULID, SP.ScheduledUsageList.SULListType, SP.ScheduledUsageList.SULTableLink, SP.ScheduledUsageList.SULSPLink, 
                      SP.ScheduledUsageList.SULQtyRequired, SPMaster2_1.SP2VWNumber
FROM         SP.ScheduledUsageList LEFT OUTER JOIN
                      SP.SPMaster2 AS SPMaster2_1 ON SP.ScheduledUsageList.SULSPLink = SPMaster2_1.SP2ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ScheduledUsageList (SP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 248
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SPMaster2_1"
            Begin Extent = 
               Top = 6
               Left = 449
               Bottom = 254
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 35
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppParts', @level1type=N'VIEW',@level1name=N'ScheduledSparePartsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppParts', @level1type=N'VIEW',@level1name=N'ScheduledSparePartsView'
GO
/****** Object:  StoredProcedure [WO].[SchduleUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[SchduleUpdate]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
declare @start date;
declare @finish date;

SET @start = '4/23/2012';
SET @finish = '5/06/2012';


	UPDATE Wo.ScheduleTable
		SET
		 STMaintShiftOne = 2,
		 STMaintShiftTwo = 3,
		 STMaintShiftThree = 1
	WHERE STDate BETWEEN @start and @finish

	RETURN
GO
/****** Object:  View [Weld].[RWErrorLogView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Weld].[RWErrorLogView]
AS
SELECT     RWELID, RWELIDNum, RWELDate, RWELProgramNumber, RWELFaultNumber, RWELFaultText, RWELProgramedValue, RWELActualValue, 
                      RWELProgrammedTime, RWELActualTime, RWELSpotName, RWELWear, RWELTimerName
FROM         Weld.ResistanceWeldErrorLog
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ResistanceWeldErrorLog (Weld)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 9
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Weld', @level1type=N'VIEW',@level1name=N'RWErrorLogView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'Weld', @level1type=N'VIEW',@level1name=N'RWErrorLogView'
GO
/****** Object:  StoredProcedure [Weld].[RWErrorLogInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[RWErrorLogInsert]
	
	@RWELIDNum Integer,
	@RWELDate DateTime,
	@RWELProgramNumber Integer,
	@RWELFaultNumber Integer,
	@RWELFaultText nVarChar(max),
	@RWELProgramedValue Decimal(18,4),
	@RWELActualValue Decimal(18,4),
	@RWELProgrammedTime Decimal(18,4),
	@RWELActualtime Decimal(18,4),
	@RWELSpotName nVarChar(max),
	@RWELWear Decimal(18,4),
	@RWELTimerName nVarChar(max)


AS

DECLARE @isThere as Integer;

SET @isThere = (SELECT COUNT(RWELID) FROM WELD.ResistanceWeldErrorLog
					WHERE RWELIDNum = @RWELIDNum AND RWELTimerName = @RWELTimerName)





if @isThere = 0
BEGIN


	INSERT INTO WELD.ResistanceWeldErrorLog
		(
			RWELIDNum,
			RWELDate,
			RWELProgramNumber,
			RWELFaultNumber,
			RWELFaultText,
			RWELProgramedValue,
			RWELActualValue,
			RWELProgrammedtime,
			RWELActualTime,
			RWELSpotName,
			RWELWear,
			RWELTimerName
		)
	VALUES
		(
			@RWELIDNum,
			@RWELDate,
			@RWELProgramNumber,
			@RWELFaultNumber,
			@RWELFaultText,
			@RWELProgramedValue,
			@RWELActualValue,
			@RWELProgrammedtime,
			@RWELActualTime,
			@RWELSpotName,
			@RWELWear,
			@RWELTimerName
		)
END



	RETURN
GO
/****** Object:  View [wACom].[ResponsiblePartyView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wACom].[ResponsiblePartyView]
AS
SELECT     TOP (100) PERCENT RPID, RPName, RPPlantID, RPActive
FROM         COM.ResponsibleParty
ORDER BY RPID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ResponsibleParty (COM)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 192
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'ResponsiblePartyView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'ResponsiblePartyView'
GO
/****** Object:  View [wAppParts].[SparePartsView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppParts].[SparePartsView]
AS
SELECT     SP.SPMaster2.SP2ExcelRef, SP.SPMaster2.SP2VWNumber, SP.SPMaster2.SP2Specification, SP.SPMaster2.SP2SupplierPN, SP.SPMaster2.SP2MFGPN, 
                      SP.SPMaster2.SP2SAPMFGPN, SP.SPMaster2.SP2MFGID, SP.SPMaster2.SP2MFGGuess, SP.SPMaster2.SP2MFGActual, SP.SPMaster2.SP2ShortDescr, 
                      SP.SPMaster2.SP2ShortSAPDescr, SP.SPMaster2.SP2ShortCount, SP.SPMaster2.SP2EClass, SP.SPMaster2.SP2ValuationClass, SP.SPMaster2.SP2LongDesc, 
                      SP.SPMaster2.SP2ShopUsed, SP.SPMaster2.SP2UnitPrice, SP.SPMaster2.SP2RecQuantity, SP.SPMaster2.SP2Priority, SP.SPMaster2.SP2EstLife, 
                      SP.SPMaster2.SP2Leadtime, SP.SPMaster2.SP2PurchUOM, SP.SPMaster2.SP2IssueUOM, SP.SPMaster2.SP2SpareType, SP.SPMaster2.SP2DrawingNumber, 
                      SP.SPMaster2.SP2StoresItem, SP.SPMaster2.SP2ShopCartNum, SP.SPMaster2.SP2SPLNumber, SP.SPMaster2.SP2Notes, SP.SPMaster2.SP2LineBuilder, 
                      SP.SPMaster2.SP2EnvRelv, SP.SPMaster2.SP2GSRec, SP.SPMaster2.SP2Date, SP.SPMaster2.SP2Min, SP.SPMaster2.SP2Max, SP.SPMaster2.SP2BinLocation, 
                      SP.SPMaster2.SP2QtyIssue, SP.SPMaster2.SP2BOH, SP.SPMaster2.SP2DateIssued, SP.SPMaster2.SP2SPUploadDate, SP.SPMaster2.SP2InStock, 
                      SP.SPMaster2.SP2SAPOnHand, SP.SPMaster2.SP2SAPBinLoc, SP.SPMaster2.SP2ProvToPurch, SP.SPMaster2.SP2SourcedTo, SP.SPMaster2.SP2SourcePrice, 
                      SP.SPMaster2.SP2SourcingStatus, wACom.VendorList.VLName, wACom.VendorList.VLAddressStreet, wACom.VendorList.VLAdderssCity, 
                      wACom.VendorList.VLAddressState, wACom.VendorList.VLAddressZip, wACom.VendorList.VLAddressPhone1, wACom.VendorList.VLAddressPhone2, 
                      wACom.VendorList.VLID, SP.SPMaster2.SP2ID, wACom.VendorList.VLContactCell, wACom.VendorList.VLSAPID, wACom.VendorList.VLWebSite, 
                      wACom.VendorList.VLFax, wACom.VendorList.VLEmail, wACom.VendorList.VLContact
FROM         SP.SPMaster2 LEFT OUTER JOIN
                      wACom.VendorList ON SP.SPMaster2.SP2MFGID = wACom.VendorList.VLSAPID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "VendorList (wACom)"
            Begin Extent = 
               Top = 8
               Left = 319
               Bottom = 252
               Right = 486
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "SPMaster2 (SP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 341
               Right = 213
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppParts', @level1type=N'VIEW',@level1name=N'SparePartsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppParts', @level1type=N'VIEW',@level1name=N'SparePartsView'
GO
/****** Object:  View [TPM].[winAppFrequencyView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [TPM].[winAppFrequencyView]
AS
SELECT     TPM.TPMFrequency.*
FROM         TPM.TPMFrequency
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TPMFrequency (TPM)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 222
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'VIEW',@level1name=N'winAppFrequencyView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'VIEW',@level1name=N'winAppFrequencyView'
GO
/****** Object:  StoredProcedure [DT].[WinAppDeleteDTM]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[WinAppDeleteDTM]
@DTID integer,
@Solution nVarChar(max) = " ",
@Malfunction nVarChar(max) = " " ,
@LongTerm nVarChar(max) = " ",
@DateDown Date = '1/1/1975',
@TimeDown nVarChar(max),
@TimeUp nVarchar(max),
@DateUp Date = '1/1/1975',
@RespPart Integer,
@Originator Integer,
@Robot Integer,
@Line Integer,
@FaultCode Integer

AS

	INSERT INTO DT.DTMainTable
		(
			DTSolution,
			DTMalfunction,
			DTLongTerm,
			DTNDateDown,
			DTNTimeDown,
			DTNTimeUp,
			DTNDateUp,
			DTResponsibility,
			DTOriginator,
			DTRobot,
			DTLine,
			DTT3Code
		)
		VALUES
		(
			@Solution,
			@Malfunction,
			@LongTerm,
			@DateDown,
			@TimeDown,
			@TimeUp,
			@DateUp,
			@RespPart,
			@Originator,
			@Robot,
			@Line,
			@FaultCode
		)
		DELETE FROM DT.DTMainTable WHERE DTID = @DTID
	RETURN
GO
/****** Object:  StoredProcedure [Weld].[WeldTableUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[WeldTableUpdate]
@SIDID int = 0,
@ProgNumber int = 0,
@RobotCall nVarChar(max) = '',
@WeldID nVArChar(max) = '',
@RobotSequence int = 0,
@TearDownID int = 0,
@MaxForce decimal = 0.0,
@ElectrodeFace nVarChar(max) = '',
@Sealer bit = 0,
@MatOneThick decimal = 0.0,
@MatTwoThick decimal = 0.0,
@MatThreeThick decimal = 0.0,
@MatFourThick decimal = 0.0,
@Nugget	nVarChar(max) = '',
@TimerLink int = 0,
@RobotLink int = 0,
@MatOneLink int = 0,
@MatTwoLink int = 0,
@MatThreeLink int = 0,
@MatFourLink int = 0,
@WeldGunTypeLInk int = 0,
@TearDownGroupLink int = 0

AS

UPDATE Weld.WeldTable

SET 

SIDProgramNumber = @ProgNumber ,
SIDRobotCallNumber = @RobotCall ,
SIDWeldIDNumber = @WeldID ,
SIDRobotSequence = @RobotSequence ,
SIDTearDownID = @TearDownID ,
SIDMaxForce = @MaxForce ,
SIDElectrodeFace = @ElectrodeFace ,
SIDSealerPresent = @Sealer,
SIDMatOneThick = @MatOneThick ,
SIDMatTwoThick = @MatTwoThick ,
SIDMatThreeThick = @MatThreeThick ,
SIDMatFourThick = @MatFourThick ,
SIDNuggetSize = @Nugget	,
SIDTimerLink = @TimerLink ,
SIDRobotLink = @RobotLink ,
SIDMatOneLink = @MatOneLink ,
SIDMatTwoLink = @MatTwoLink ,
SIDMatThreeLink = @MatThreeLink ,
SIDMatFourLink = @MatFourLink ,
SIDWeldGunTypeLink = @WeldGunTypeLInk,
SIDTearDownGroup = @TearDownGroupLink

WHERE SIDID = @SIDID





	RETURN
GO
/****** Object:  StoredProcedure [WO].[winAppSPWOInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[winAppSPWOInsert]

@WorkReq as nVarChar(max),
@WorkAcc as nVarChar(max),
@DateOpen as Date,
@DateDue as Date,
@Originator as Integer,
@Request as Integer,
@Type as Integer,
@Line as Integer,
@Responsible as Integer,
@TMs as Integer,
@Mins as Integer,
@Equip as Integer
AS
	INSERT INTO WO.WorkOrderMain
		 (DISWorkRequired,
		 DISWorkAccomp,
		 DISOpenDate,
		 DISDueDate,
		 DISOriginator,
		 DISRequestor,
		 DISType,
		 DISLineNumber,
		 DISResponsible,
		 DISNumberAss,
		 DISManHours,
		 DISEquip)

		 VALUES(

			@WorkReq,
			@WorkAcc,
			Cast(@DateOpen as Date),
			Cast(@DateDue as Date),
			@Originator,
			@Request,
			@Type,
			@Line,
			@Responsible,
			@TMs,
			@Mins,
			@Equip)


	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[WorkOrderUtilizationDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[WorkOrderUtilizationDelete]
	
	(
		@id integer
	)
	
AS
	
	DELETE FROM WO.WorkOrderUtilization 
	WHERE WOUTID = @id

	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[WorkOrderUtilizationUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[WorkOrderUtilizationUpdate]
	
	(
		@id integer,
		@time integer
	)
	
AS
	
		UPDATE WO.WorkOrderUtilization
		SET WOUMin = @time
		WHERE WOUTID = @id

	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[WorkOrderUtilizationInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[WorkOrderUtilizationInsert]
	
	(
	@WorkOrderNumber Integer,
	@TMID Integer,
	@WOUMin Integer = 30
	)
	
AS

	Insert Into WO.WorkOrderUtilization
		 (
			WOUTMID,
			WODISID,
			WOUMin

		)
		VALUES
			(
				@TMID,
				@WorkOrderNumber,
				30
			)


	RETURN
GO
/****** Object:  StoredProcedure [DT].[YTDCWRetrieval]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[YTDCWRetrieval]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	

	SELECT 
		GSCW,
		GSCWMonDate
	FROM
		TPM.GrandSchedule
	WHERE
		DATEPART(YEAR, GSCWMonDate) = 2011;
		
	RETURN
GO
/****** Object:  StoredProcedure [WO].[winAppWOMainEditUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[winAppWOMainEditUpdate]
@WorkReq as nVarChar(max),
@WorkAcc as nVarChar(max),
@DateOpen as Date,
@DateClosed as Date,
@DateDue as Date,
@Originator as Integer,
@Request as Integer,
@Type as Integer,
@Line as Integer,
@Responsible as Integer,
@TMs as Integer,
@Mins as Integer,
@Equip as Integer,
@DISID as Integer
AS
	UPDATE WO.WorkOrderMain
	SET DISWorkRequired = @WorkReq, DISWorkAccomp = @WorkAcc, DISOpenDate = Cast(@DateOpen as Date), DISCloseDate = Cast(@DateClosed as Date), 
		DISDueDate = Cast(@DateDue as Date), DISOriginator = @Originator, DISRequestor = @Request, DISType = @Type, DISLineNumber = @Line, DISResponsible = @Responsible,
		DISNumberAss = @TMs, DISManHours = @Mins, DISEquip = @Equip
	WHERE DISID = @DISID
	RETURN
GO
/****** Object:  StoredProcedure [wAppParts].[TPMPartsInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppParts].[TPMPartsInsert]
@PartLink as integer,
@Qty as integer,
@Procedure as integer

AS
	INSERT INTO SP.TPMPartLink
	(
	TPSPartLink,
	TPSQty,
	TPSTPMprocedure)
	VALUES
	(
		@PartLink,
		@Qty,
		@Procedure
	)
	
	RETURN
GO
/****** Object:  StoredProcedure [wAppParts].[TPMPartsDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppParts].[TPMPartsDelete]
@Serial as Integer
AS
	DELETE FROM SP.TPMPartLink
	WHERE TSPID = @Serial
	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMLineAvailFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMLineAvailFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM TPM.TPMProcedureAvailability
	ORDER BY TPMAvID

	RETURN
GO
/****** Object:  View [wAppTeam].[TimeCodeView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTeam].[TimeCodeView]
AS
SELECT     TCID, TCName, TCCode, TCCode + N' - ' + TCName AS TCDisplay
FROM         Team.TimeCodes
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TimeCodes (Team)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 154
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2880
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4485
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTeam', @level1type=N'VIEW',@level1name=N'TimeCodeView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppTeam', @level1type=N'VIEW',@level1name=N'TimeCodeView'
GO
/****** Object:  StoredProcedure [wAppDoc].[TierTwoInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[TierTwoInsert]
	
	@Name nVarChar(50),
	@parent int

AS
	
	INSERT INTO Documentation.DocTierTwo (DTTwTierOneLink,DTTwName) VALUES (@parent,@Name)

	RETURN
GO
/****** Object:  StoredProcedure [Weld].[TearDownGroupIUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[TearDownGroupIUpdate]

	@TDGIID int = 0,
	@TDGIName nVarChar(max),
	@TDGShortName nVarChar(50)

AS

	UPDATE Weld.TearDownGroupI
	SET 
		TDGIName = @TDGIName,
		TDGIShortName = @TDGShortName
	WHERE
		TDGIID = @TDGIID


	RETURN
GO
/****** Object:  StoredProcedure [Weld].[TearDownGroupIInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[TearDownGroupIInsert]
	
	@TDGIName nVarChar(max),
	@TDGIShortName nVarChar(max) = ''

AS
	Insert Into Weld.TearDownGroupI (TDGIName,TDGIShortName) VALUES (@TDGIName,@TDGIShortName)

	RETURN
GO
/****** Object:  StoredProcedure [Weld].[TearDownGroupIFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[TearDownGroupIFetch]

	

AS
	SELECT * FROM Weld.TearDownGroupI
	ORDER BY TDGIName
	RETURN
GO
/****** Object:  StoredProcedure [Weld].[TearDownGroupIDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[TearDownGroupIDelete]
	
	@TDGIID int = 0

AS
	
	DELETE FROM Weld.TearDownGroupI
	WHERE TDGIID  = @TDGIID
	
	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TaskUsageDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TaskUsageDelete]
	
	(
		@id integer
	)
	
AS

	DELETE FROM TPM.TPMTaskAssembly WHERE TPMTAID = @id
	
	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[TeamMemberTitleFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[TeamMemberTitleFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	 SELECT * FROM Team.TeamMemberTitles
	RETURN
GO
/****** Object:  StoredProcedure [wAppDoc].[tierOneDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[tierOneDelete]

@ID int

AS

	DELETE FROM Documentation.DocTierOne WHERE DTOID = @ID


	RETURN
GO
/****** Object:  StoredProcedure [wAppDoc].[tierOneInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[tierOneInsert]

	@Name nVarChar(50)

AS

	INSERT INTO Documentation.DocTierOne (DTOName) VALUES (@Name)

	RETURN
GO
/****** Object:  StoredProcedure [wAppDoc].[tierTwoDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[tierTwoDelete]

	@ID int


AS
	 
	 DELETE FROM Documentation.DocTierTwo WHERE DTTwID = @ID

	RETURN
GO
/****** Object:  StoredProcedure [wAppDoc].[tierThreeInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[tierThreeInsert]

@ID int,
@name nVarChar(50)

AS
	

	INSERT INTO Documentation.DocTierThree (DTTHtierTwoLink,DTTHName) VALUES (@ID, @name)


	RETURN
GO
/****** Object:  StoredProcedure [Weld].[WeldMoveInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[WeldMoveInsert]

	@WMReason nVarChar(max),
	@WMTM	Int,	
	@WMMoveDate Date,
	@WMSourceRobot Int,
	@WMDestRobot Int,
	@WMWeldNumber int,
	@RETURN_VALUE INT = 0 OUTPUT 
AS
	
	Insert Into Weld.WeldMoves
		(
			WMReason,
			WMTM,
			WMMoveDate,
			WMSourceRobot,
			WMDestRobot,
			WMWeldNumber
		)
	VALUES
		(
			@WMReason,
			@WMTM,
			@WMMoveDate,
			@WMSourceRobot,
			@WMDestRobot,
			@WMWeldNumber

		)


	SELECT WMID FROM Weld.WeldMoves WHERE (WMID = SCOPE_IDENTITY())

	RETURN
GO
/****** Object:  StoredProcedure [Weld].[WeldMoveFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[WeldMoveFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM Weld.WeldMoves

	RETURN
GO
/****** Object:  StoredProcedure [wAppParts].[WearTypeFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppParts].[WearTypeFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM SP.WearTypes
	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[waTeamUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waTeamUpdate]
	@TEID int,
	@TEName nVarChar(100),
	@TEGNlink int
AS


	UPDATE Team.waTeam
	SET 
		TEName = @TEName,
		TEGNLink = @TEGNLink
	WHERE
		TEID = @TEID

	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[waTeamInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waTeamInsert]

	@TEName nVarChar(100),
	@TEGNlink int,
	@RETURN_VALUE INT = 0 OUTPUT 

AS
	
	INSERT INTO Team.waTeam
		(
			TEName,
			TEGNLink
		)
	VALUES
		(
			@TEName,
			@TEGNLink
		)

	SELECT TEID FROM Team.waTeam WHERE (TEID = SCOPE_IDENTITY())
GO
/****** Object:  StoredProcedure [wAppTeam].[waTeamFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waTeamFetch]

AS
	
	SELECT * FROM Team.waTeam

	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[waTeamDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waTeamDelete]

	@TEID int

AS
		
		DELETE FROM Team.waTeam
		WHERE TEID = @TEID

	RETURN
GO
/****** Object:  View [wAppWorkOrder].[wAppWOCodes]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppWorkOrder].[wAppWOCodes]
AS
SELECT     WO.WorkOrderCodes.*
FROM         WO.WorkOrderCodes
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WorkOrderCodes (WO)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 139
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'wAppWOCodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'wAppWOCodes'
GO
/****** Object:  View [wAppTPM].[wAppTPMType]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTPM].[wAppTPMType]
AS
SELECT     TPM.TPMType.*
FROM         TPM.TPMType
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TPMType (TPM)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 169
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppTPMType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppTPMType'
GO
/****** Object:  StoredProcedure [wAppTeam].[waPlantFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waPlantFetch]
@Plant Int
AS
	IF @Plant > 0
	BEGIN
		SELECT * FROM Team.waPlants
		WHERE PNID = @Plant or PNID = 0
	END
	ELSE
	BEGIN
		SELECT * FROM Team.waPlants
	END

	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[waGroupUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waGroupUpdate]
	@GNID int,
	@GNNames nVarChar(50),
	@GNCode nVarChar(10),
	@GNDNCode int,
	@GNPlant int

AS

	UPDATE Team.wAGroupNames
	SET
		GNNames = @GNNames,
		GNCode = @GNCode,
		GNDNCode = @GNDNCode,
		GNPlant = @GNPlant
	WHERE
		GNID = @GNID


	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[waGroupInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waGroupInsert]
	
	@GNNames nVarChar(50),
	@GNCode nVarChar(10),
	@GNDNCode int,
	@GNPlant int,
	@RETURN_VALUE INT = 0 OUTPUT 

AS
	
	INSERT INTO Team.wAGroupNames
		(
			GNNames,
			GNCode,
			GNDNCode,
			GNPlant
		)
	VALUES
		(
			@GNNames,
			@GNCode,
			@GNDNCode,
			@GNPlant
		)


	SELECT GNID FROM Team.waGroupNames WHERE (GNID = SCOPE_IDENTITY())


	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[wAGroupFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[wAGroupFetch]
@Plant int
AS
	IF @Plant > 0
	BEGIN
		SELECT * FROM Team.wAGroupNames
		WHERE GNPlant = @Plant or GNPlant = 0
	END
	ELSE
	BEGIN
		SELECT * FROM Team.wAGroupNames
	END
	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[waGroupDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waGroupDelete]

@GNID int


AS

	DELETE FROM Team.wAGroupNames
	WHERE 
		GNID = @GNID

	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[waDepartmentUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waDepartmentUpdate]
@DNID int,
@DNName nVarChar(50),
@DNCode nVarChar(10),
@DNPNLink int,
@DNPlant int



AS

	UPDATE Team.waDepartments
	SET
		DNName= @DNName,
		DNCode = @DNCode,
		DNPNLink = @DNPNLink,
		DNPlant = @DNPlant
	WHERE
		DNID = @DNID
	

	RETURN
GO
/****** Object:  View [wAppTPM].[wAppTPMFrequency]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTPM].[wAppTPMFrequency]
AS
SELECT     TPM.TPMFrequency.*
FROM         TPM.TPMFrequency
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TPMFrequency (TPM)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 218
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppTPMFrequency'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppTPMFrequency'
GO
/****** Object:  StoredProcedure [wAppParts].[UsageListInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppParts].[UsageListInsert]
@ListType  as Integer,
@TableLink as Integer,
@PartNumber as Integer,
@QtyUsed as Integer,
@QtyNeeded as Integer,
@Notes as nVarChar(max),
@WearType as Integer

AS

	INSERT INTO SP.UsageList
	(
		ULListtype,
		ULTableLink,
		ULSPLink,
		ULSPQtyUsed,
		ULSPQtyNeeded,
		ULSPNotes,
		USWearType,
		ULDate

	)
	VALUES
	(
		@ListType,
		@TableLink,
		@PartNumber,
		@QtyUsed,
		@QtyNeeded,
		@Notes,
		@WearType,
		GetDate()
	)

	RETURN
GO
/****** Object:  View [wAppTPM].[TPMTaskAssemblyView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTPM].[TPMTaskAssemblyView]
AS
SELECT     TPM.TPMTaskAssembly.TPMTAID, TPM.TPMTaskAssembly.TPMTAProcedureID, TPM.TPMTaskAssembly.TPMTATaskID, TPM.TPMTaskList.TPMTLTitle, 
                      TPM.TPMTaskList.TPMTLTask, TPM.TPMTaskList.TPMTLNumTM, TPM.TPMTaskList.TPMTLMin, TPM.TPMTaskAssembly.TPMTAOrder
FROM         TPM.TPMTaskAssembly LEFT OUTER JOIN
                      TPM.TPMTaskList ON TPM.TPMTaskAssembly.TPMTATaskID = TPM.TPMTaskList.TPMTLID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TPMTaskAssembly (TPM)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 186
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TPMTaskList (TPM)"
            Begin Extent = 
               Top = 8
               Left = 348
               Bottom = 200
               Right = 500
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'TPMTaskAssemblyView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'TPMTaskAssemblyView'
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMTaskAssemblyUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMTaskAssemblyUpdate]
	
	@TPMTAID int,
	@TPMTAOrder int
	
AS
	
	UPDATE TPM.TPMTaskAssembly
	SET TPMTAOrder = @TPMTAOrder
	WHERE TPMTAID = @TPMTAID


	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMTaskAssemblyInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMTaskAssemblyInsert]
	
	(
		@procID Integer = 88888888,
		@TaskID Integer,
		@Order Integer


	)
	
AS
	
	INSERT INTO TPM.TPMTaskAssembly (TPMTAProcedureID, TPMTATaskID, TPMTAOrder )
	VALUES
		(
			@procID,
			@TaskID,
			@Order
		);
	
		RETURN
GO
/****** Object:  View [wAppTPM].[TPMTaskListView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTPM].[TPMTaskListView]
AS
SELECT        TPM.TPMTaskList.TPMTLID, TPM.TPMTaskList.TPMTLTitle, TPM.TPMTaskList.TPMTLTask, TPM.TPMTaskList.TPMTLMin, TPM.TPMTaskList.TPMTLNumTM, 
                         TPM.TPMTaskList.TPMTLCategory, TPM.TaskListSubTypeOne.TLTSIID, TPM.TaskListSubTypeOne.TLTSIName, TPM.TaskListSubTypeOne.TLTSITextCode, 
                         TPM.TaskListSubTypeOne.TLTSITypeLink, TPM.TaskCatagoryLevelI.TCLIParent, TPM.TaskCatagoryLevelI.TCLICode, TPM.TaskCatagoryLevelI.TCLIText, 
                         TPM.TaskCatagoryLevelI.TCLIID, TPM.TPMTaskList.TPMTLPlant, TPM.TPMTaskList.TPMTLShare
FROM            TPM.TaskCatagoryLevelI RIGHT OUTER JOIN
                         TPM.TaskListSubTypeOne ON TPM.TaskCatagoryLevelI.TCLIID = TPM.TaskListSubTypeOne.TLTSITypeLink RIGHT OUTER JOIN
                         TPM.TPMTaskList ON TPM.TaskListSubTypeOne.TLTSIID = TPM.TPMTaskList.TPMTLCategory
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TaskCatagoryLevelI (TPM)"
            Begin Extent = 
               Top = 24
               Left = 726
               Bottom = 153
               Right = 896
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TaskListSubTypeOne (TPM)"
            Begin Extent = 
               Top = 29
               Left = 249
               Bottom = 158
               Right = 419
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TPMTaskList (TPM)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 240
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'TPMTaskListView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'TPMTaskListView'
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMTaskListUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMTaskListUpdate]

	(
		@TPMTLID Integer,
		@TPMTLTitle nVarChar(max),
		@TPMTLTask nVarChar(max),
		@TPMTLNumTM integer,
		@TPMTLMin integer,
		@TPMTLCategory integer,
		@TPMTLShare bit


	)

AS
	
	UPDATE TPM.TPMTaskList
	SET
	
		TPMTLTitle = @TPMTLTitle,
		TPMTLTask = @TPMTLTask,
		TPMTLNumTM = @TPMTLNumTM,
		TPMTLMin = @TPMTLMin,
		TPMTLCategory = @TPMTLCategory,
		TPMTLShare = @TPMTLShare
	WHERE TPMTLID = @TPMTLID

	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMTaskListInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMTaskListInsert]
	
	(
		
	    @TPMTLTitle nVarChar(max),
		@TPMTLTask nVarChar(max),
		@TPMTLNumTM integer,
		@TPMTLMin integer,
		@TPMTLCategory integer,
		@TPMTLPlant integer,
		@TPMTLShare bit,
		@RETURN_VALUE INT = 0 OUTPUT 
	)
	
AS
	
	INSERT INTO TPM.TPMTaskList(TPMTLTitle,TPMTLTask,TPMTLNumTM,TPMTLMin,TPMTLCategory,TPMTLPlant,TPMTLShare)
		VALUES
			(
				@TPMTLTITLE,
				@TPMTLTASK,
				@TPMTLNumTM,
				@TPMTLMIN,
				@TPMTLCategory,
				@TPMTLPlant,
				@TPMTLShare
				
			)

	SELECT TPMTLID FROM TPM.TPMTaskList WHERE (TPMTLID = SCOPE_IDENTITY())
	
	
	RETURN @RETURN_VALUE
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMPriorityFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMPriorityFetch]


AS

	SELECT * FROM TPM.TPMPriority
	ORDER BY TPMPRID

	RETURN
GO
/****** Object:  StoredProcedure [wAppDoc].[tierThreeDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[tierThreeDelete]

@ID int

AS

	DELETE FROM Documentation.DocTierThree WHERE DTTHid = @ID

	RETURN
GO
/****** Object:  StoredProcedure [WO].[UpdateUtilizations]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [WO].[UpdateUtilizations]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	
	DECLARE @utwolist TABLE
	(

		WONUMBER Integer

	);

	INSERT INTO  @utwolist  (WONUMBER)
	
	SELECT WODISID FROM wo.WorkOrderUtilization ;


	INSERT INTO WO.WorkOrderUtilization (WOUTMID, WOUMin, WODISID)
	SELECT 163, ISNULL(DISManHours,0),DISID FROM WO.WorkOrderMain
	Where DISID Not In(SELECT * FROM @utwolist);



	RETURN
GO
/****** Object:  StoredProcedure [wAppParts].[UsageListDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppParts].[UsageListDelete]
@Serial as Integer

AS
	DELETE FROM SP.UsageList
	WHERE ULID = @Serial
	RETURN
GO
/****** Object:  View [WO].[TypeCodeDropDown]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [WO].[TypeCodeDropDown]
AS
SELECT     WOCName, WOCID
FROM         WO.WorkOrderCodes
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WorkOrderCodes (WO)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 91
               Right = 190
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'WO', @level1type=N'VIEW',@level1name=N'TypeCodeDropDown'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'WO', @level1type=N'VIEW',@level1name=N'TypeCodeDropDown'
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMTaskListDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMTaskListDelete]
	
	(
		@ID integer
	)
	
AS
	
	DELETE FROM TPM.TPMTaskList
	WHERE TPMTLID = @ID


	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMTaskAssemblyDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMTaskAssemblyDelete]
	
	(
		@id integer
	)
	
AS

	DELETE FROM TPM.TPMTaskAssembly
	WHERE TPMTAID = @id

	RETURN
GO
/****** Object:  View [wAppParts].[UsageListView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppParts].[UsageListView]
AS
SELECT        SP.UsageList.ULID, SP.UsageList.ULSPLink, SP.UsageList.ULSPQtyUsed, SP.UsageList.ULSPQtyNeeded, SP.UsageList.ULSPNotes, SP.UsageList.USWearType, 
                         SP.WearTypes.WTID, SP.WearTypes.WTDescription, SP.WearTypes.WTDisplay, SP.UsageTypes.UTID, SP.UsageTypes.UTName, SP.UsageTypes.UTDisplay, 
                         SP.UsageList.ULTableLink, SP.UsageList.ULListType, SP.UsageList.ULDate, SP.SPMaster2.SP2VWNumber, SP.SPMaster2.SP2ShortSAPDescr
FROM            SP.UsageList LEFT OUTER JOIN
                         SP.SPMaster2 ON SP.UsageList.ULSPLink = SP.SPMaster2.SP2ID LEFT OUTER JOIN
                         SP.UsageTypes ON SP.UsageList.ULListType = SP.UsageTypes.UTID LEFT OUTER JOIN
                         SP.WearTypes ON SP.UsageList.USWearType = SP.WearTypes.WTID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "UsageList (SP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 250
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SPMaster2 (SP)"
            Begin Extent = 
               Top = 6
               Left = 745
               Bottom = 322
               Right = 928
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "UsageTypes (SP)"
            Begin Extent = 
               Top = 68
               Left = 391
               Bottom = 262
               Right = 543
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "WearTypes (SP)"
            Begin Extent = 
               Top = 175
               Left = 521
               Bottom = 367
               Right = 691
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 16
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         N' , @level0type=N'SCHEMA',@level0name=N'wAppParts', @level1type=N'VIEW',@level1name=N'UsageListView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'ewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppParts', @level1type=N'VIEW',@level1name=N'UsageListView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppParts', @level1type=N'VIEW',@level1name=N'UsageListView'
GO
/****** Object:  StoredProcedure [wAppTeam].[waDepartmentInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waDepartmentInsert]

@DNName nVarChar(50),
@DNCode nVarChar(10),
@DNPNLink int,
@DNPlant int,
@RETURN_VALUE INT = 0 OUTPUT 

AS
	INSERT INTO Team.waDepartments
		(
			DNName,
			DNCode,
			DNPNLink,
			DNPlant
		)
	VALUES
		(
			@DNName,
			@DNCode,
			@DNPNLink,
			@DNPlant
		)


	SELECT DNID FROM Team.waDepartments WHERE (DNID = SCOPE_IDENTITY())
	
	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[wADepartmentFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[wADepartmentFetch]
 @Plant int
AS

	IF @Plant > 0
		BEGIN
			SELECT * FROM TEAM.wADepartments
			WHERE DNPlant = @Plant OR DNPlant = 0
		END 
		ELSE
		BEGIN
			SELECT * FROM TEAM.wADepartments
		END

	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[waDepartmentDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[waDepartmentDelete]

@DNID int

AS

	DELETE FROM Team.waDepartments
	WHERE
		DNID = @DNID

	RETURN
GO
/****** Object:  StoredProcedure [wACom].[VendorListFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [wACom].[VendorListFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS

	SELECT * FROM wACom.ManufacturerListView
	ORDER BY VLName
	
	RETURN
GO
/****** Object:  StoredProcedure [wAppParts].[UsageListReportFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppParts].[UsageListReportFetch]
@Start Date,
@End	Date
AS

	SELECT * FROM wAppParts.UsageListView
	WHERE ULDATE BETWEEN @Start AND @End
	


	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TypeFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TypeFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM wAppTPM.wAppTPMType

	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMStatsReport1]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMStatsReport1]

@Plant as Integer = 1 

-- TPM 52 Week Closed Report for shop in percentages.

AS

DECLARE @CW1 as Int
DECLARE @CW1Mon as Date;

DECLARE @CW as int
DECLARE @Mon as date;

SET @CW1 = wACom.GetCWFromDate(DateAdd(day,0,GetDate()));
SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,0,GetDate())));

DECLARE @faultTable TABLE
(
	faultCode INT

)



DECLARE @resultTable TABLE
(

	TotalWorkOrders int,
	Closed Int,
	ClosedLate Int,
	OverDue Int,
	Incomplete Int,
	CW INT,
	CWD Date

);

DECLARE @CWTable TABLE
(
	GSCW INTEGER,
	GSCWMonDate DATE
);

INSERT INTO @CWTable 
	SELECT TOP 52 GSCW, GSCWMonDate
	FROM TPM.GrandSchedule
	WHERE GSCWMonDate < @CW1Mon
	ORDER BY GSCWMonDate DESC

DECLARE cwTable CURSOR FAST_FORWARD FOR
	SELECT * FROM @CWTable

OPEN cwTable



WHILE @@FETCH_STATUS = 0
BEGIN
FETCH NEXT FROM cwTable INTO @CW, @Mon


INSERT INTO @resultTable
	(
		TotalWorkOrders,
		Closed,
		ClosedLate,
		Overdue,
		Incomplete,
		CW,
		CWD
	)
	VALUES
	(

		(SELECT Count(DISID) FROM WO.WorkOrderMain WHERE DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon) AND DISType = 3), -- total
		-- Closed not overdue
		(SELECT Count(DISID) FROM WO.WorkOrderMain WHERE
					DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
					AND 
					(DISCloseDate <= DISDueDate) AND (DISCloseDate >= DISOpenDate) AND (DISType = 3)),
		-- Closed Overdue
		(SELECT Count(DISID) FROM WO.WorkOrderMain WHERE
					DISCloseDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
					AND 
					(DISCloseDate > DISDueDate) AND (DISCloseDate >= DISOpenDate) AND (DISType = 3)),
		--Open but Overdue
		(SELECT Count(DISID) FROM WO.WorkOrderMain WHERE
					DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
					AND
					DISCloseDate IS NULL
					AND
					GetDate() > DISDueDate AND DISType = 3),
		-- Incomplete
		(SELECT Count(DISID) FROM WO.WorkOrderMain WHERE
					DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
					AND
					DISCloseDate < DISOpenDate AND DISType = 3),
		@CW,
		@Mon
	
	)

END
CLOSE cwTable
DEALLOCATE cwTable


SELECT * FROM (
		SELECT  TotalWorkOrders, Closed,ClosedLate,OverDue, Incomplete, e.GSCW, e.GSCWMonDate
		FROM @CWTable as E
		Left Outer Join (SELECT * FROM @resultTable) as D ON D.CWD = E.GSCWMonDate) t
	ORDER BY GSCWMonDate ASC



	RETURN
GO
/****** Object:  StoredProcedure [dbo].[TPMStatsReport1]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TPMStatsReport1]

@Plant as Integer = 1 

-- TPM 52 Week Closed Report for shop in percentages.

AS

DECLARE @CW1 as Int
DECLARE @CW1Mon as Date;

DECLARE @CW as int
DECLARE @Mon as date;

SET @CW1 = wACom.GetCWFromDate(DateAdd(day,0,GetDate()));
SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,0,GetDate())));

DECLARE @faultTable TABLE
(
	faultCode INT

)



DECLARE @resultTable TABLE
(

	TotalWorkOrders int,
	Closed Int,
	ClosedLate Int,
	OverDue Int,
	Incomplete Int,
	CW INT,
	CWD Date

);

DECLARE @CWTable TABLE
(
	GSCW INTEGER,
	GSCWMonDate DATE
);

INSERT INTO @CWTable 
	SELECT TOP 52 GSCW, GSCWMonDate
	FROM TPM.GrandSchedule
	WHERE GSCWMonDate < @CW1Mon
	ORDER BY GSCWMonDate DESC

DECLARE cwTable CURSOR FAST_FORWARD FOR
	SELECT * FROM @CWTable

OPEN cwTable



WHILE @@FETCH_STATUS = 0
BEGIN
FETCH NEXT FROM cwTable INTO @CW, @Mon


INSERT INTO @resultTable
	(
		TotalWorkOrders,
		Closed,
		ClosedLate,
		Overdue,
		Incomplete,
		CW,
		CWD
	)
	VALUES
	(

		(SELECT Count(DISID) FROM WO.WorkOrderMain WHERE DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon) AND DISType = 3), -- total
		-- Closed not overdue
		(SELECT Count(DISID) FROM WO.WorkOrderMain WHERE
					DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
					AND 
					(DISCloseDate <= DISDueDate) AND (DISCloseDate >= DISOpenDate) AND (DISType = 3)),
		-- Closed Overdue
		(SELECT Count(DISID) FROM WO.WorkOrderMain WHERE
					DISCloseDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
					AND 
					(DISCloseDate > DISDueDate) AND (DISCloseDate >= DISOpenDate) AND (DISType = 3)),
		--Open but Overdue
		(SELECT Count(DISID) FROM WO.WorkOrderMain WHERE
					DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
					AND
					DISCloseDate IS NULL
					AND
					GetDate() > DISDueDate AND DISType = 3),
		-- Incomplete
		(SELECT Count(DISID) FROM WO.WorkOrderMain WHERE
					DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
					AND
					DISCloseDate < DISOpenDate AND DISType = 3),
		@CW,
		@Mon
	
	)

END
CLOSE cwTable
DEALLOCATE cwTable


SELECT * FROM (
		SELECT  TotalWorkOrders, Closed,ClosedLate,OverDue, Incomplete, e.GSCW, e.GSCWMonDate
		FROM @CWTable as E
		Left Outer Join (SELECT * FROM @resultTable) as D ON D.CWD = E.GSCWMonDate) t
	ORDER BY GSCWMonDate ASC



	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMTaskListFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMTaskListFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	
	SELECT * FROM wAppTPM.TPMTaskListView

	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMTaskAssemblyFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMTaskAssemblyFetch]
	
	(
		@Procedure Int
	)
	
AS
	
	SELECT * FROM wAppTPM.TPMTaskAssemblyView
	WHERE TPMTAProcedureID = @Procedure
	ORDER BY TPMTAOrder


	RETURN
GO
/****** Object:  StoredProcedure [wAppParts].[UsageListFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppParts].[UsageListFetch]
@Type as Int = 0, -- 1 = Work Order, 2 = Downtime.
@Link as Int = 0  -- Work order or Downtime number
AS
	if @Type > 0 AND @Link > 0
	BEGIN
	SELECT * FROM wAppParts.UsageListView
	WHERE ULListType = @Type AND ULTableLink = @Link
	END
	ELSE
	BEGIN
	SELECT * FROM wAppParts.UsageListView
	END


	RETURN
GO
/****** Object:  View [wAppTPM].[wAppTPMReport1]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTPM].[wAppTPMReport1]
AS
SELECT     EQP.EquipmentModelNumber.EQModID, EQP.EquipmentModelNumber.EQModModelNumber, EQP.EquipmentModelNumber.EQModManID, 
                      EQP.EquipmentModelNumber.EQModDescription, EQP.EquipmentModelNumber.EQModVendorID, EQP.EquipmentModelNumber.EQModOrderNumber, 
                      EQP.EquipmentModelNumber.EQModImageOne, EQP.ProcNumbers.PROCNAME, EQP.ProcNumbers.PROCNUMBER, EQP.ProcNumbers.PROCASSET, 
                      EQP.ProcNumbers.PROCARG, EQP.ProcNumbers.PROCMODEL, EQP.ProcNumbers.PROCQUARTGROUP, EQP.ProcNumbers.PROCSEMIGROUP, 
                      EQP.ProcNumbers.PROCANUALGROUP, EQP.ProcNumbers.PROCMONTHGROUP, EQP.ProcNumbers.PROCWEEKGROUP, EQP.ProcNumbers.PROCID, 
                      EQP.ProcNumbers.PROCBIMONTHGROUP, EQP.ProcNumbers.PROCTWOYRGRUP, EQP.ProcNumbers.PROCTHREEYRGROUP, 
                      EQP.ProcNumbers.PROCFOURYRGROUP, EQP.ProcNumbers.PROCEIGHTYRGROUP, wACom.MachineList.MLCELLNAME, 
                      wACom.MachineList.MLLINEID, wACom.MachineList.MLID, wACom.MachineList.MLPlantID, wACom.Lines.LILineName, wACom.Lines.LISatellite, 
                      wACom.Lines.LIPlannerGroup, wACom.Lines.LIID, wACom.Lines.LIPlant
FROM         wACom.MachineList LEFT OUTER JOIN
                      wACom.Lines ON wACom.MachineList.MLLINEID = wACom.Lines.LIID RIGHT OUTER JOIN
                      EQP.ProcNumbers ON wACom.MachineList.MLID = EQP.ProcNumbers.PROCARG LEFT OUTER JOIN
                      EQP.EquipmentModelNumber ON EQP.ProcNumbers.PROCMODEL = EQP.EquipmentModelNumber.EQModID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 174
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 6
               Left = 232
               Bottom = 121
               Right = 387
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 6
               Left = 425
               Bottom = 121
               Right = 615
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EquipmentModelNumber (EQP)"
            Begin Extent = 
               Top = 6
               Left = 653
               Bottom = 121
               Right = 833
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         ' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppTPMReport1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppTPMReport1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppTPMReport1'
GO
/****** Object:  StoredProcedure [wAppDoc].[tierThreeFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[tierThreeFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	Select * FROM wAppDoc.DocTierIIIView
	RETURN
GO
/****** Object:  StoredProcedure [wAppDoc].[tierOneFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[tierOneFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	Select * FROM wAppDoc.DocTier1View

	RETURN
GO
/****** Object:  View [wAppDT].[TechnologyReportView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppDT].[TechnologyReportView]
AS
SELECT     wACom.Lines.LILineName, wACom.Lines.LIID, DT.DTMainTable.TotalMinutes, DT.DTMainTable.DTNDateDown, DT.T2Code.T2ID, 
                      DT.T2Code.T2Designation, DT.T2Code.T2CodeName, DT.DTMainTable.DTT3Code, wACom.Lines.LIPlant, wACom.MachineList.MLPlantID
FROM         DT.T3Code LEFT OUTER JOIN
                      DT.T2Code ON DT.T3Code.T2CodeLink = DT.T2Code.T2ID RIGHT OUTER JOIN
                      DT.DTMainTable ON DT.T3Code.T3ID = DT.DTMainTable.DTT3Code LEFT OUTER JOIN
                      wACom.Lines RIGHT OUTER JOIN
                      wACom.MachineList ON wACom.Lines.LIID = wACom.MachineList.MLLINEID ON DT.DTMainTable.DTLine = wACom.MachineList.MLID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "T3Code (DT)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T2Code (DT)"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 114
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DTMainTable (DT)"
            Begin Extent = 
               Top = 6
               Left = 416
               Bottom = 114
               Right = 574
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 6
               Left = 612
               Bottom = 114
               Right = 766
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 804
               Bottom = 114
               Right = 955
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
       ' , @level0type=N'SCHEMA',@level0name=N'wAppDT', @level1type=N'VIEW',@level1name=N'TechnologyReportView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppDT', @level1type=N'VIEW',@level1name=N'TechnologyReportView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppDT', @level1type=N'VIEW',@level1name=N'TechnologyReportView'
GO
/****** Object:  StoredProcedure [wAppDoc].[tierTwoFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[tierTwoFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	Select * FROM wAppDoc.DocTierIIView
	RETURN
GO
/****** Object:  StoredProcedure [wAppTeam].[TimeCodeFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTeam].[TimeCodeFetch]

AS

	SELECT * FROM wAppTeam.TimeCodeView
	ORDER BY TCDisplay

	RETURN
GO
/****** Object:  UserDefinedFunction [wAppDT].[Top5]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [wAppDT].[Top5]
	(
	    @StartDate Date,
		@NumDays Integer,
		@Line Integer,
		@Group Integer = 0,
		@showAll Integer = 0
	)
RETURNS  @retTable TABLE (DTNDateDown DATE, TotalMinutes Integer, DTMalfunction nVarChar(max), DTSolution nVarChar(max), MLCELLNAME nVarChar(100)) 
AS
	BEGIN
	INSERT INTO @retTable 
			SELECT TOP 5 DTNDateDown, TotalMinutes, DTMalfunction, DTSolution, MLCELLNAME FROM DT.DowntimeReportingMain
			WHERE DTNDATEDOWN BETWEEN DateAdd(Day, -(@NumDays), @StartDate) AND @StartDate   AND (LIID = @Line OR AAID = @Group OR LIPlant =  @showAll)
			ORDER BY TotalMinutes DESC
	RETURN
	END
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMLineStatStatic]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMLineStatStatic]

@Line as Integer = 5,
@Date as Date = '10/24/2011'

AS

Declare @closeHold as Integer
DECLARE @openHold as Integer
DECLARE @pastDue as Integer
DECLARE @DateHold as Date

SET @DateHold = wACom.GetCWMonDate(wACom.GetCWFromDate(GetDate()), DatePart(year,GetDate()))

DECLARE @reportTable TABLE
(
	numClosed INT,
	numOpened INT,
	numPastDue INT
)

if @Line > 0
BEGIN
SET @closeHold = (SELECT COUNT(DISID) as Total FROM WO.WorkOrderMain WHERE DISCloseDate BETWEEN @DateHold and DATEADD(Day,6,@DateHold) AND DISLineNumber = @Line AND DISType = 3)

SET @openHold = (SELECT COUNT(DISID) as Total FROM WO.WorkOrderMain WHERE  DISCloseDate IS NULL AND DISLineNumber = @Line AND DISType = 3)

SET @pastDue = (SELECT COUNT(DISID) as Total FROM Wo.WorkOrderMain WHERE (DISCloseDate IS NULL) AND (DISLineNumber = @Line) AND (DISDueDate < GETDATE()) AND DISType = 3)
END

if @Line = -1
BEGIN
SET @closeHold = (SELECT COUNT(DISID) as Total FROM WO.WorkOrderMain WHERE DISCloseDate BETWEEN @DateHold and DATEADD(Day,6,@DateHold)  AND DISType = 3)

SET @openHold = (SELECT COUNT(DISID) as Total FROM WO.WorkOrderMain WHERE  DISCloseDate IS NULL  AND DISType = 3)

SET @pastDue = (SELECT COUNT(DISID) as Total FROM Wo.WorkOrderMain WHERE (DISCloseDate IS NULL)  AND (DISDueDate < GETDATE()) AND DISType = 3)


END

INSERT INTO @reportTable (numClosed,numOpened,numPastDue) VALUES (@closeHold, @openHold, @pastDue)

SELECT * FROM @reportTable
GO
/****** Object:  View [wAppParts].[TPMProcedurePartsView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppParts].[TPMProcedurePartsView]
AS
SELECT        wAppParts.SparePartsView.SP2VWNumber, wAppParts.SparePartsView.SP2MFGPN, SP.TPMPartLink.TSPID, SP.TPMPartLink.TPSPartLink, SP.TPMPartLink.TPSQty, 
                         SP.TPMPartLink.TPSTPMProcedure, wAppParts.SparePartsView.SP2ShortDescr, wAppParts.SparePartsView.SP2ShortSAPDescr, 
                         wAppParts.SparePartsView.SP2LongDesc
FROM            SP.TPMPartLink LEFT OUTER JOIN
                         wAppParts.SparePartsView ON SP.TPMPartLink.TPSPartLink = wAppParts.SparePartsView.SP2ID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TPMPartLink (SP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 162
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SparePartsView (wAppParts)"
            Begin Extent = 
               Top = 5
               Left = 370
               Bottom = 235
               Right = 545
            End
            DisplayFlags = 280
            TopColumn = 7
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppParts', @level1type=N'VIEW',@level1name=N'TPMProcedurePartsView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppParts', @level1type=N'VIEW',@level1name=N'TPMProcedurePartsView'
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMProcedureDetailsOne]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMProcedureDetailsOne]

	@procedureNumber INTEGER,
	@model INTEGER
AS
	
	DECLARE @results TABLE
	(
		eqpCount INTEGER,
		woCount	 INTEGER,
		avgTime  INTEGER

	)

	INSERT INTO @results (eqpCount, woCount, avgTime)
		VALUES
		(
		(SELECT COUNT(PROCID) FROM EQP.ProcNumbers WHERE PROCMODEL = @model),
		(SELECT COUNT(DISID) FROM WO.WorkOrderMain WHERE DISTPMNumber = @procedureNumber),
		1)
		


	SELECT * FROM @results




	RETURN
GO
/****** Object:  StoredProcedure [DT].[YTDRobotDownTimes]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[YTDRobotDownTimes]
-- 4/16/2012 Not used. 


	@DatePass Date,
	@CWPass Integer,
	@TypePass Integer,
	@ReturnVal Integer OUTPUT

AS

	SET @ReturnVal = (SELECT
		SUM(TotalMinutes + DTMinutes)
	FROM DT.DTMainTable
	WHERE DTT3Code IN (
						SELECT DT3.T3ID
						FROM DT.T3Code as DT3
						Left Join DT.T2Code ON T2ID = DT3.T2Codelink
						WHERE T2ID = @TypePass)
		      AND
		  DTTimeDown1 BETWEEN (SELECT GSCWMonDate FROM TPM.GrandSchedule WHERE GSCW = @CWPass AND DATEPART(YEAR,GSCWMonDate) = DATEPART(YEAR,@DatePass))
			  AND
          DATEADD(DAY,6,(SELECT GSCWMonDate FROM TPM.GrandSchedule WHERE GSCW = @CWPass AND DATEPART(YEAR,GSCWMonDate) = DATEPART(YEAR,@DatePass)))
						
						);
		
		


	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[WOMainUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[WOMainUpdate]
@WorkReq as nVarChar(max),
@WorkAcc as nVarChar(max),
@DateOpen as Date,
@DateClosed as Date,
@DateDue as Date,
@Originator as Integer,
@Request as Integer,
@Type as Integer,
@Line as Integer,
@Responsible as Integer,
@TMs as Integer = 0,
@Mins as Integer = 0,
@Equip as Integer = 0,
@DISID as Integer,
@SchedDate as Date = null,
@Schedshift as Integer = 0

AS

	if @TMs < 1 OR @TMs IS Null
		BEGIN
			SET @TMs = 1
		END

	if @Mins < 10 OR @Mins IS Null
		BEGIN
			SET @Mins = 10
		END



	UPDATE WO.WorkOrderMain
	SET DISWorkRequired = @WorkReq, DISWorkAccomp = @WorkAcc, DISOpenDate = Cast(@DateOpen as Date), DISCloseDate = Cast(@DateClosed as Date), 
		DISDueDate = Cast(@DateDue as Date), DISOriginator = @Originator, DISRequestor = @Request, DISType = @Type, DISLineNumber = @Line, DISResponsible = @Responsible,
		DISNumberAss = @TMs, DISManHours = @Mins, DISEquip = @Equip, DISAsset = (SELECT PROCASSET FROM EQP.PROCNUMBERS WHERE PROCID = @Equip), DISSchedDate = @SchedDate, DISSchedShift = @Schedshift
	WHERE DISID = @DISID
	RETURN
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[WOMainInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[WOMainInsert]

@WorkReq as nVarChar(max),
@WorkAcc as nVarChar(max),
@DateOpen as Date,
@DateDue as Date,
@Originator as Integer,
@Request as Integer,
@Type as Integer,
@Line as Integer,
@Responsible as Integer,
@TMs as Integer,
@Mins as Integer,
@Equip as Integer = 0,

@RETURN_VALUE INT = 0 OUTPUT 

AS
	INSERT INTO WO.WorkOrderMain
		 (DISWorkRequired,
		 DISWorkAccomp,
		 DISOpenDate,
		 DISDueDate,
		 DISOriginator,
		 DISRequestor,
		 DISType,
		 DISLineNumber,
		 DISResponsible,
		 DISNumberAss,
		 DISManHours,
		 DISEquip,
		 DISAsset
		 )

		 VALUES(

			@WorkReq,
			@WorkAcc,
			GetDate(),
			Cast(@DateDue as Date),
			@Originator,
			@Request,
			@Type,
			@Line,
			@Responsible,
			@TMs,
			@Mins,
			@Equip,
			(SELECT PROCASSET FROM EQP.ProcNumbers WHERE PROCID = @Equip)
			
			)


	SELECT DISID FROM WO.WorkOrderMain WHERE (DISID = SCOPE_IDENTITY())

	RETURN @RETURN_VALUE
GO
/****** Object:  StoredProcedure [wAppWorkOrder].[WOCodeFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppWorkOrder].[WOCodeFetch]

AS

	Select * FROM WAppWorkOrder.wAppWOCodes

	RETURN
GO
/****** Object:  StoredProcedure [DT].[WinAppRecUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[WinAppRecUpdate]

@DTID integer = 1,
@Solution nVarChar(max) = " ",
@Malfunction nVarChar(max) = " " ,
@LongTerm nVarChar(max) = " ",
@DateDown Date = '1/1/1975',
@TimeDown nVarChar(max),
@TimeUp nVarchar(max),
@DateUp Date = '1/1/1975',
@RespPart Integer,
@Originator Integer,
@Robot Integer = 0,
@Line Integer,
@FaultCode Integer,
@LostProd bit = 0


AS




	UPDATE DT.DTMainTable
	SET
		DTSolution = @Solution,
		DTMalfunction = @Malfunction,
		DTLongTerm = @LongTerm,
		DTNDateDown = @DateDown,
		DTNTimeDown = CAST(@TimeDown as TIME),
		DTNTimeUp = CAST(@TimeUp as TIME),
		DTNDateUp = @DateUp,
		DTResponsibility = @RespPart,
		DTOriginator = @Originator,
		DTRobot = @Robot,
		DTLine = @Line,
		DTT3Code = @FaultCode,
		DTAsset = (SELECT PROCASSET FROM EQP.ProcNumbers WHERE PROCID = @Robot),
		DTLostProduction = @LostProd
	WHERE DTID = @DTID;

	-- Added for compatability between the Access system and the .NET system
	-- this keeps the times in sync. Remove this after the ACCESS system is
	-- Superceeded. P.C. 11.26.2011
	UPDATE DT.DTMainTable
	SET DTTimeDown1 = DTNCDown, DTTimeUp2 = DTNCUp
	WHERE DTID = @DTID;



	RETURN
GO
/****** Object:  StoredProcedure [DT].[WinAppRecInsertDTM]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[WinAppRecInsertDTM]
@Solution nVarChar(max) = " ",
@Malfunction nVarChar(max) = " " ,
@LongTerm nVarChar(max) = " ",
@DateDown Date = '1/1/1975',
@TimeDown nVarChar(max),
@TimeUp nVarchar(max),
@DateUp Date = '1/1/1975',
@RespPart Integer,
@Originator Integer,
@Robot Integer,
@Line Integer,
@FaultCode Integer,
@LostProd bit = 0,
@RETURN_VALUE INT = 0 OUTPUT 

AS

	INSERT INTO DT.DTMainTable
		(
			DTSolution,
			DTMalfunction,
			DTLongTerm,
			DTNDateDown,
			DTNTimeDown,
			DTNTimeUp,
			DTNDateUp,
			DTResponsibility,
			DTOriginator,
			DTRobot,
			DTLine,
			DTT3Code,
			DTAsset,
			DTLostProduction

		)
		VALUES
		(
			@Solution,
			@Malfunction,
			@LongTerm,
			@DateDown,
			CAST(@TimeDown AS TIME),
			CAST(@TimeUp AS TIME),
			@DateUp,
			@RespPart,
			@Originator,
			@Robot,
			@Line,
			@FaultCode,
			(SELECT PROCASSET FROM EQP.ProcNumbers WHERE PROCID = @Robot),
			@LostProd
		);

-- Added while the Access and the .NET version are still running together.
-- remove this  update when the old system is superceeded.
-- P.C. 11/26/2011

--		Removed on 4/16/2012. Access version no longer operational.
--		UPDATE DT.DTMainTable
--		SET DTTimeDown1 = DTNCDown, DTTimeUp2 = DTNCUp
--		WHERE DTID = Scope_Identity();


SELECT DTID FROM DT.DTMainTable WHERE (DTID = SCOPE_IDENTITY())


		return @RETURN_VALUE;
GO
/****** Object:  StoredProcedure [EQP].[winAppProcUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [EQP].[winAppProcUpdate]
@ProcID as Integer,
@ProcName as nVarChar(max),
@ProcNumber as nVarChar(max),
@ProcAsset as Integer,
@ProcArg as Integer,
@ProcModel as Integer,
@Quarterly as Integer,
@Semi as Integer,
@Anual as Integer,
@Month as Integer,
@Week as Integer,
@BiMonth as Integer,
@Two as Integer,
@Three as Integer,
@Four as Integer,
@Eight as Integer


AS

	UPDATE EQP.ProcNumbers
	SET
	PROCNAME = @ProcName,
	PROCNUMBER = @ProcNumber,
	PROCASSET = @ProcAsset,
	PROCARG = @ProcArg,
	PROCMODEL = @ProcModel,
	PROCQUARTGROUP = @Quarterly,
	PROCSEMIGROUP = @Semi,
	PROCANUALGROUP = @Anual,
	PROCMONTHGROUP = @Month, 
	PROCBIMONTHGROUP = @BiMonth,
	PROCTWOYRGRUP = @Two,
	PROCTHREEYRGROUP = @Three,
	PROCFOURYRGROUP = @Four,
	PROCEIGHTYRGROUP = @Eight
	WHERE PROCID = @ProcID

	RETURN
GO
/****** Object:  StoredProcedure [EQP].[winAppProcInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [EQP].[winAppProcInsert]
@ProcName as nVarChar(max),
@ProcNumber as nVarChar(max),
@ProcAsset as Integer,
@ProcArg as Integer,
@ProcModel as Integer,
@Quarterly as Integer,
@Semi as Integer,
@Anual as Integer,
@Month as Integer,
@Week as Integer,
@BiMonth as Integer,
@Two as Integer,
@Three as Integer,
@Four as Integer,
@Eight as Integer


AS

	INSERT INTO EQP.ProcNumbers
	(
		PROCNAME,
		PROCNUMBER,
		PROCASSET,
		PROCARG,
		PROCMODEL,
		PROCQUARTGROUP,
		PROCSEMIGROUP,
		PROCANUALGROUP,
		PROCMONTHGROUP,
		PROCBIMONTHGROUP,
		PROCTWOYRGRUP,
		PROCTHREEYRGROUP,
		PROCFOURYRGROUP,
		PROCEIGHTYRGROUP
	)
	VALUES
	(
		@ProcName,
		@ProcNumber,
		@ProcAsset,
		@ProcArg,
		@ProcModel,
		@Quarterly,
		@Semi,
		@Anual,
		@Month, 
		@BiMonth,
		@Two,
		@Three,
		@Four,
		@Eight
	)
	

	RETURN
GO
/****** Object:  View [EQP].[winAppPLProcNumber]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [EQP].[winAppPLProcNumber]
AS
SELECT     wACom.MachineList.MLARGNUMBER, wACom.MachineList.MLCELLNAME, wACom.MachineList.MLPlantID, wACom.MachineList.MLLINEID, 
                      EQP.Equipment.EQTID, EQP.Equipment.SerNo, EQP.Equipment.MFGNo, EQP.Equipment.Note, EQP.EquipmentModelNumber.EQModModelNumber, 
                      EQP.EquipmentModelNumber.EQModManID, EQP.EquipmentModelNumber.EQModDescription, EQP.EquipmentModelNumber.EQModVendorID, 
                      EQP.EquipmentModelNumber.EQModOrderNumber, EQP.EquipmentModelNumber.EQModImageOne, EQP.EquipmentModelNumber.EQModID, 
                      wACom.MachineList.MLID, EQP.ProcNumbers.PROCNUMBER, EQP.ProcNumbers.PROCNAME, EQP.ProcNumbers.PROCASSET, 
                      EQP.ProcNumbers.PROCARG, EQP.ProcNumbers.PROCMODEL, EQP.ProcNumbers.PROCQUARTGROUP, EQP.ProcNumbers.PROCSEMIGROUP, 
                      EQP.ProcNumbers.PROCANUALGROUP, EQP.ProcNumbers.PROCMONTHGROUP, EQP.ProcNumbers.PROCWEEKGROUP, EQP.ProcNumbers.PROCID, 
                      EQP.ProcNumbers.PROCBIMONTHGROUP, EQP.ProcNumbers.PROCTWOYRGRUP, EQP.ProcNumbers.PROCEIGHTYRGROUP, 
                      EQP.ProcNumbers.PROCFOURYRGROUP, EQP.ProcNumbers.PROCTHREEYRGROUP
FROM         EQP.ProcNumbers LEFT OUTER JOIN
                      EQP.EquipmentModelNumber ON EQP.ProcNumbers.PROCMODEL = EQP.EquipmentModelNumber.EQModID LEFT OUTER JOIN
                      EQP.Equipment ON EQP.ProcNumbers.PROCASSET = EQP.Equipment.EQTID LEFT OUTER JOIN
                      wACom.MachineList ON EQP.ProcNumbers.PROCARG = wACom.MachineList.MLID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 257
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EquipmentModelNumber (EQP)"
            Begin Extent = 
               Top = 0
               Left = 972
               Bottom = 237
               Right = 1152
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 62
               Left = 773
               Bottom = 262
               Right = 953
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Equipment (EQP)"
            Begin Extent = 
               Top = 13
               Left = 352
               Bottom = 264
               Right = 533
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
' , @level0type=N'SCHEMA',@level0name=N'EQP', @level1type=N'VIEW',@level1name=N'winAppPLProcNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'EQP', @level1type=N'VIEW',@level1name=N'winAppPLProcNumber'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'EQP', @level1type=N'VIEW',@level1name=N'winAppPLProcNumber'
GO
/****** Object:  View [Weld].[WeldTableCombinedView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Weld].[WeldTableCombinedView]
AS
SELECT     EQP.ProcNumbers.PROCNUMBER, EQP.ProcNumbers.PROCID, EQP.ProcNumbers.PROCASSET, wACom.MachineList.MLCELLNAME, 
                      wACom.MachineList.MLID, wACom.MachineList.MLPlantID, wACom.Lines.LILineName, wACom.Lines.LIID, wACom.Lines.LIPlant, wACom.Areas.AAID, 
                      wACom.Areas.AAPlant, wACom.Areas.AAareaname, Weld.MaterialData.MDName AS MatOneName, 
                      Weld.MaterialData.MDYieldStrength AS MatOneYield, Weld.MaterialData.MDID AS MatOneID, MaterialData_2.MDName AS MatTwoName, 
                      MaterialData_2.MDID AS MatTwoID, MaterialData_2.MDYieldStrength AS MatTwoYield, MaterialData_1.MDName AS MatThreeName, 
                      MaterialData_1.MDYieldStrength AS MatThreeYield, MaterialData_1.MDID AS MatThreeID, MaterialData_3.MDName AS MatFourName, 
                      MaterialData_3.MDYieldStrength AS MatFourYield, MaterialData_3.MDID AS MatFourID, EQP.EquipmentModelNumber.EQModModelNumber, 
                      EQP.EquipmentModelNumber.EQModDescription, EQP.EquipmentModelNumber.EQModID, Weld.WeldTable.Timer, 
                      Weld.WeldTable.SIDProgramNumber, Weld.WeldTable.SIDRobotCallNumber, Weld.WeldTable.SIDWeldIDNumber, 
                      Weld.WeldTable.SIDRobotSequence, Weld.WeldTable.SIDTearDownID, Weld.WeldTable.WeldGunID, Weld.WeldTable.SIDMaxForce, 
                      Weld.WeldTable.SIDElectrodeFace, Weld.WeldTable.SIDSealerPresent, Weld.WeldTable.SIDMatOneThick, Weld.WeldTable.SIDMatTwoThick, 
                      Weld.WeldTable.SIDMatThreeThick, Weld.WeldTable.SIDMatFourThick, Weld.WeldTable.SIDNuggetSize, Weld.WeldTable.SIDID, 
                      Weld.WeldTable.SIDTimerLink, Weld.WeldTable.SIDRobotLink, Weld.WeldTable.SIDWeldGunType, Weld.WeldTable.SIDMatOneLink, 
                      Weld.WeldTable.SIDMatTwoLink, Weld.WeldTable.SIDMatThreeLink, Weld.WeldTable.SIDMatFourLink, Weld.WeldTable.SIDWeldGunTypeLink, 
                      Weld.WeldTable.SIDTearDownGroup
FROM         EQP.EquipmentModelNumber RIGHT OUTER JOIN
                      Weld.MaterialData AS MaterialData_2 RIGHT OUTER JOIN
                      Weld.WeldTable LEFT OUTER JOIN
                      Weld.MaterialData AS MaterialData_3 ON Weld.WeldTable.SIDMatFourLink = MaterialData_3.MDID LEFT OUTER JOIN
                      Weld.MaterialData AS MaterialData_1 ON Weld.WeldTable.SIDMatThreeLink = MaterialData_1.MDID ON 
                      MaterialData_2.MDID = Weld.WeldTable.SIDMatTwoLink LEFT OUTER JOIN
                      Weld.MaterialData ON Weld.WeldTable.SIDMatOneLink = Weld.MaterialData.MDID ON 
                      EQP.EquipmentModelNumber.EQModID = Weld.WeldTable.SIDWeldGunType LEFT OUTER JOIN
                      wACom.Areas RIGHT OUTER JOIN
                      wACom.Lines ON wACom.Areas.AAID = wACom.Lines.LISatellite RIGHT OUTER JOIN
                      wACom.MachineList INNER JOIN
                      EQP.ProcNumbers ON wACom.MachineList.MLID = EQP.ProcNumbers.PROCARG ON wACom.Lines.LIID = wACom.MachineList.MLLINEID ON 
                      Weld.WeldTable.SIDRobotLink = EQP.ProcNumbers.PROCID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[50] 4[11] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[74] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[49] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 4
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EquipmentModelNumber (EQP)"
            Begin Extent = 
               Top = 24
               Left = 285
               Bottom = 294
               Right = 464
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "MaterialData_2"
            Begin Extent = 
               Top = 113
               Left = 290
               Bottom = 190
               Right = 469
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "WeldTable (Weld)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 415
               Right = 241
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "MaterialData_3"
            Begin Extent = 
               Top = 238
               Left = 298
               Bottom = 375
               Right = 477
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "MaterialData_1"
            Begin Extent = 
               Top = 147
               Left = 290
               Bottom = 315
               Right = 469
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "MaterialData (Weld)"
            Begin Extent = 
               Top = 79
               Left = 289
               Bottom = 261
               Right = 468
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Areas (wACom)"
            Begin Extent = 
               Top = 349
               Left = 1159
               Bottom = 478
       ' , @level0type=N'SCHEMA',@level0name=N'Weld', @level1type=N'VIEW',@level1name=N'WeldTableCombinedView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'        Right = 1322
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 145
               Left = 1208
               Bottom = 342
               Right = 1379
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 167
               Left = 954
               Bottom = 364
               Right = 1124
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 184
               Left = 642
               Bottom = 389
               Right = 856
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 53
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2760
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 2190
         Alias = 1755
         Table = 3405
         Output = 795
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'Weld', @level1type=N'VIEW',@level1name=N'WeldTableCombinedView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'Weld', @level1type=N'VIEW',@level1name=N'WeldTableCombinedView'
GO
/****** Object:  StoredProcedure [wAppParts].[SparePartsFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppParts].[SparePartsFetch]
@TextSearch nVarchar(max) = '%',
@PartNumber nVarChar(max) = '%',
@ManufName nVarChar(max) = '%',
@ItemNumber Integer = 0
AS
DECLARE @TextString nVarChar(max);
DECLARE @PartString nVarChar(max);
DECLARE @ManufString nVarChar(max);

SET @TextString = '%' + @TextSearch + '%';
SET @PartString = '%' + @PartNumber + '%';
SET @ManufString = '%' + @ManufName + '%';

	if @ItemNumber = 0 
	    BEGIN

	    SELECT * FROM wAppParts.SparePartsView
		WHERE 
				((SP2ShortSAPDescr LIKE @TextString) OR (SP2LongDesc LIKE @TextString))
			 AND 
				((SP2VWNumber LIKE @PartString)  OR (SP2SupplierPN LIKE @PartString) OR (SP2MFGPN LIKE @PartString) OR (SP2SAPMFGPN LIKE @PartString))
			 AND
				((SP2MFGGuess LIKE @ManufString) OR (SP2MFGActual LIKE @ManufString))
	    END
	ELSE
		BEGIN
			SELECT * FROM wAppParts.SparePartsView
			WHERE 
					((SP2ShortSAPDescr LIKE @TextString) OR (SP2LongDesc LIKE @TextString))
				 AND 
					((SP2VWNumber LIKE @PartString) OR (SP2SupplierPN LIKE @PartString) OR (SP2MFGPN LIKE @PartString) OR (SP2SAPMFGPN LIKE @PartString))
				 AND
					((SP2MFGGuess LIKE @ManufString) OR (SP2MFGActual LIKE @ManufString))

				 AND (SP2ID = @ItemNumber)
		END	
	
RETURN
GO
/****** Object:  StoredProcedure [wAppParts].[ScheduledUsageListFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppParts].[ScheduledUsageListFetch]
	
	(
		@type int,
		@tableLink int
	)
	
AS
	
	SELECT * FROM wAppParts.ScheduledSparePartsView
	WHERE SULTableLink = @tableLink AND SULListType = @type


	-- Types 1. Work Order
	--		2. Downtime (not used in this context)
	--		3. TPM

	RETURN
GO
/****** Object:  StoredProcedure [Weld].[RWErrorLogFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[RWErrorLogFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM WELD.RWErrorLogView
	WHERE RWELID = -1000
	RETURN


	-- Emtpy dataset returned on purpose. Do not change this.
GO
/****** Object:  StoredProcedure [wACom].[RPDrop]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[RPDrop]
@Plant as Integer
AS

	SELECT * FROM wACom.ResponsiblePartyView
	ORDER BY RPName

	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[ProcNumberInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [wAppTPM].[ProcNumberInsert]
@ProcName as nVarChar(max),
@ProcNumber as nVarChar(max),
@ProcAsset as Integer,
@ProcArg as Integer,
@ProcModel as Integer,
@Quarterly as Integer,
@Semi as Integer,
@Anual as Integer,
@Month as Integer,
@Week as Integer,
@BiMonth as Integer,
@Two as Integer,
@Three as Integer,
@Four as Integer,
@Eight as Integer


AS

	INSERT INTO EQP.ProcNumbers
	(
		PROCNAME,
		PROCNUMBER,
		PROCASSET,
		PROCARG,
		PROCMODEL,
		PROCQUARTGROUP,
		PROCSEMIGROUP,
		PROCANUALGROUP,
		PROCMONTHGROUP,
		PROCBIMONTHGROUP,
		PROCTWOYRGRUP,
		PROCTHREEYRGROUP,
		PROCFOURYRGROUP,
		PROCEIGHTYRGROUP
	)
	VALUES
	(
		@ProcName,
		@ProcNumber,
		@ProcAsset,
		@ProcArg,
		@ProcModel,
		@Quarterly,
		@Semi,
		@Anual,
		@Month, 
		@BiMonth,
		@Two,
		@Three,
		@Four,
		@Eight
	)
	

	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ProcNumberInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ProcNumberInsert]
@ProcName as nVarChar(max),
@ProcNumber as nVarChar(max),
@ProcAsset as Integer,
@ProcArg as Integer,
@ProcModel as Integer,
@Quarterly as Integer,
@Semi as Integer,
@Anual as Integer,
@Month as Integer,
@Week as Integer,
@BiMonth as Integer,
@Two as Integer,
@Three as Integer,
@Four as Integer,
@Eight as Integer,
@RETURN_VALUE INT = 0 OUTPUT 


AS

	INSERT INTO EQP.ProcNumbers
	(
		PROCNAME,
		PROCNUMBER,
		PROCASSET,
		PROCARG,
		PROCMODEL,
		PROCQUARTGROUP,
		PROCSEMIGROUP,
		PROCANUALGROUP,
		PROCMONTHGROUP,
		PROCBIMONTHGROUP,
		PROCTWOYRGRUP,
		PROCTHREEYRGROUP,
		PROCFOURYRGROUP,
		PROCEIGHTYRGROUP
	)
	VALUES
	(
		@ProcName,
		@ProcNumber,
		@ProcAsset,
		@ProcArg,
		@ProcModel,
		@Quarterly,
		@Semi,
		@Anual,
		@Month, 
		@BiMonth,
		@Two,
		@Three,
		@Four,
		@Eight
	)
	
	SELECT PROCID FROM EQP.ProcNumbers WHERE (ProcID= SCOPE_IDENTITY())
	
	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[ProcNumberUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[ProcNumberUpdate]
@ProcID as Integer,
@ProcName as nVarChar(max),
@ProcNumber as nVarChar(max),
@ProcAsset as Integer,
@ProcArg as Integer,
@ProcModel as Integer,
@Quarterly as Integer,
@Semi as Integer,
@Anual as Integer,
@Month as Integer,
@Week as Integer,
@BiMonth as Integer,
@Two as Integer,
@Three as Integer,
@Four as Integer,
@Eight as Integer,
@assign as Integer = 0


AS

	UPDATE EQP.ProcNumbers
	SET
	PROCNAME = @ProcName,
	PROCNUMBER = @ProcNumber,
	PROCASSET = @ProcAsset,
	PROCARG = @ProcArg,
	PROCMODEL = @ProcModel,
	PROCQUARTGROUP = @Quarterly,
	PROCSEMIGROUP = @Semi,
	PROCANUALGROUP = @Anual,
	PROCMONTHGROUP = @Month, 
	PROCBIMONTHGROUP = @BiMonth,
	PROCTWOYRGRUP = @Two,
	PROCTHREEYRGROUP = @Three,
	PROCFOURYRGROUP = @Four,
	PROCEIGHTYRGROUP = @Eight,
	PROCASSIGNTO = @Assign

	WHERE PROCID = @ProcID

	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ProcNumberUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ProcNumberUpdate]
@ProcID as Integer,
@ProcName as nVarChar(max),
@ProcNumber as nVarChar(max),
@ProcAsset as Integer,
@ProcArg as Integer,
@ProcModel as Integer,
@Quarterly as Integer,
@Semi as Integer,
@Anual as Integer,
@Month as Integer,
@Week as Integer,
@BiMonth as Integer,
@Two as Integer,
@Three as Integer,
@Four as Integer,
@Eight as Integer,
@assign as Integer = 0,
@PROCACTIVE as bit,
@PROCASSETASSIGNABLE as bit


AS

	UPDATE EQP.ProcNumbers
	SET
	PROCNAME = @ProcName,
	PROCNUMBER = @ProcNumber,
	PROCASSET = @ProcAsset,
	PROCARG = @ProcArg,
	PROCMODEL = @ProcModel,
	PROCQUARTGROUP = @Quarterly,
	PROCSEMIGROUP = @Semi,
	PROCANUALGROUP = @Anual,
	PROCMONTHGROUP = @Month, 
	PROCBIMONTHGROUP = @BiMonth,
	PROCTWOYRGRUP = @Two,
	PROCTHREEYRGROUP = @Three,
	PROCFOURYRGROUP = @Four,
	PROCEIGHTYRGROUP = @Eight,
	PROCASSIGNTO = @Assign,
	PROCACTIVE = @PROCACTIVE,
	PROCASSETASSIGNABLE = @PROCASSETASSIGNABLE

	WHERE PROCID = @ProcID

	RETURN
GO
/****** Object:  View [wACom].[ProcNumberDropMain]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wACom].[ProcNumberDropMain]
AS
SELECT     EQP.ProcNumbers.PROCNUMBER, EQP.ProcNumbers.PROCNAME, EQP.ProcNumbers.PROCID, EQP.ProcNumbers.PROCARG, 
                      MachineList_1.MLPlantID, MachineList_1.MLID
FROM         EQP.ProcNumbers LEFT OUTER JOIN
                      wACom.MachineList AS MachineList_1 ON EQP.ProcNumbers.PROCARG = MachineList_1.MLID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 247
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MachineList_1"
            Begin Extent = 
               Top = 6
               Left = 504
               Bottom = 121
               Right = 656
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'ProcNumberDropMain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wACom', @level1type=N'VIEW',@level1name=N'ProcNumberDropMain'
GO
/****** Object:  StoredProcedure [wAppDT].[rept16mAvail]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[rept16mAvail]

@Line AS Integer = 1

/* Six Month Week report for the Plant Availability Graph. */

AS

DECLARE @Mo1 as DATE;
DECLARE @Mo2 AS DATE;
DECLARE @Mo3 AS DATE;
DECLARE @Mo4 AS DATE;
DECLARE @Mo5 AS DATE;
DECLARE @Mo6 AS DATE;
DECLARE @Mo7 AS DATE;

SET @Mo1 = CAST (('1/' + CAST(DatePart(month,GetDate()) AS nVarchar(20)) + '/' + CAST(DatePart(year,GetDate()) AS nVArChar(20)) + ' ') AS DATE);
SET @Mo2 = DATEADD(MONTH,-1,@Mo1);
SET @Mo3 = DATEADD(MONTH,-2,@Mo1);
SET @Mo4 = DATEADD(MONTH,-3,@Mo1);
SET @Mo5 = DATEADD(MONTH,-4,@Mo1);
SET @Mo6 = DATEADD(MONTH,-5,@Mo1);
SET @Mo7 = DATEADD(MONTH,-6,@Mo1);





print @Mo1
print @Mo2
print @Mo3
print @Mo4
print @Mo5
print @Mo6
print @Mo7



SELECT * FROM (
SELECT ISNULL(DTID,8888888) as DTID,ISNULL(LIID,@Line) as LIID, GDTDate , ISNULL(TotalMinutes,0) as Total  , ISNULL(DTResponsibility,4) as DTResponsibility,
CASE 
	WHEN (GDTDate BETWEEN @Mo7 AND DATEADD(day,-1,@Mo6)) THEN DATENAME(MONTH,@Mo7)
	WHEN (GDTDate BETWEEN @Mo6 AND DATEADD(day,-1,@Mo5)) THEN DATENAME(MONTH,@Mo6)
	WHEN (GDTDate BETWEEN @Mo5 AND DATEADD(day,-1,@Mo4)) THEN DATENAME(MONTH,@Mo5)
	WHEN (GDTDate BETWEEN @Mo4 AND DATEADD(day,-1,@Mo3)) THEN DATENAME(MONTH,@Mo4)
	WHEN (GDTDate BETWEEN @Mo3 AND DATEADD(day,-1,@Mo2)) THEN DATENAME(MONTH,@Mo3)
	WHEN (GDTDate BETWEEN @Mo2 AND DATEADD(day,-1,@Mo1)) THEN DATENAME(MONTH,@Mo2)

	ELSE 'nothing'
END AS strMonth

FROM wACom.GenericDateTable

LEFT OUTER JOIN (SELECT * FROM DT.DowntimeReportingMain WHERE LIID = @Line) as D
	ON GDTDate = D.DTNDateDown

WHERE  (GDTDate Between @Mo6 and DateAdd(day,-1,@Mo1))
Group BY GDTDate, DTResponsibility, TotalMinutes, LIID, DTID
) t


	RETURN
GO
/****** Object:  StoredProcedure [DT].[Reporting14Day2]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[Reporting14Day2]
--@StartDate Date
@Line AS Integer = 1,
@Start AS Date = '10/1/2011',
@Days AS Integer = 30

AS

DECLARE @RepDate AS DATE = '10/1/2011';

SELECT t.DTNDateDown, MLCellName as CellName, SUM(TotalMinutes) AS Total
FROM DT.DowntimeReportingMain t
WHERE (DTNDateDown BETWEEN DATEADD(Day,0,Cast(@Start AS Date)) AND DATEADD(Day, @Days, Cast(@Start AS Date))) AND t.LIID = @Line
Group By t.DTNDateDown, MLCellName
RETURN
GO
/****** Object:  StoredProcedure [DT].[Reporting14Day1]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [DT].[Reporting14Day1]
--@StartDate Date
@Line AS Integer,
@Start AS Date,
@Days AS Integer

AS

DECLARE @RepDate AS DATE = '10/1/2011';

SELECT DT.DowntimeReportingMain.DTNDateDown, SUM(TotalMinutes)
FROM DT.DowntimeReportingMain
WHERE (DTNDateDown BETWEEN DATEADD(Day,0,Cast(@Start AS Date)) AND DATEADD(Day, @Days, Cast(@Start AS Date))) AND LIID = @Line
Group By DT.DowntimeReportingMain.DTNDateDown

RETURN
GO
/****** Object:  StoredProcedure [wACom].[pEquipListing]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[pEquipListing]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS

	SELECT * FROM wACom.EquipListing
	RETURN
GO
/****** Object:  StoredProcedure [wAppDoc].[ModelBindingFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[ModelBindingFetch]


AS

	SELECT * FROM wAppDoc.DocModelBindingView


	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[ModelNumberFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[ModelNumberFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
/*  Change Log

	J. Steve Witt 10/18/2012
	Used by EquipmentMaster cdAddAsset_click
	This list appears in the New Asset dialog box unordered
	so I order it by the text the user uses to discribe the asset
*/
	SELECT * FROM wAppEqp.ModelView  order by EQModModelNumber
	RETURN
GO
/****** Object:  StoredProcedure [wACom].[MachineDrop]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[MachineDrop]
@Plant as Integer
AS

	SELECT * FROM wACom.MachineListDropView
	WHERE MLPlantID = @Plant AND MLActive = 1
	ORDER BY MLCELLNAME

	RETURN
GO
/****** Object:  StoredProcedure [wACom].[ManufacturersListFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[ManufacturersListFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS

	SELECT * FROM wACom.ManufacturerListView
	ORDER BY VLName
	
	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[IPTableFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[IPTableFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM wAppEqp.IPTableView
	RETURN
GO
/****** Object:  View [wAppDoc].[DocTierAssemblyView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppDoc].[DocTierAssemblyView]
AS
SELECT     wAppDoc.DocTier1View.DTOID, wAppDoc.DocTier1View.DTOName, wAppDoc.DocTierIIIView.DTThName, wAppDoc.DocTierIIIView.DTThTierTwoLink, 
                      wAppDoc.DocTierIIIView.DTThID, wAppDoc.DocTierIIView.DTTwName, wAppDoc.DocTierIIView.DTTwTierOneLink, wAppDoc.DocTierIIView.DTTwID
FROM         wAppDoc.DocTier1View LEFT OUTER JOIN
                      wAppDoc.DocTierIIView ON wAppDoc.DocTier1View.DTOID = wAppDoc.DocTierIIView.DTTwTierOneLink LEFT OUTER JOIN
                      wAppDoc.DocTierIIIView ON wAppDoc.DocTierIIView.DTTwID = wAppDoc.DocTierIIIView.DTThTierTwoLink
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DocTier1View (wAppDoc)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 153
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DocTierIIIView (wAppDoc)"
            Begin Extent = 
               Top = 9
               Left = 590
               Bottom = 156
               Right = 751
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DocTierIIView (wAppDoc)"
            Begin Extent = 
               Top = 4
               Left = 251
               Bottom = 149
               Right = 414
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppDoc', @level1type=N'VIEW',@level1name=N'DocTierAssemblyView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppDoc', @level1type=N'VIEW',@level1name=N'DocTierAssemblyView'
GO
/****** Object:  StoredProcedure [wAppDT].[DowntimeInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[DowntimeInsert]

@Solution nVarChar(max) = " ",
@Malfunction nVarChar(max) = " " ,
@LongTerm nVarChar(max) = " ",
@DateDown Date = '1/1/1975',
@TimeDown nVarChar(max),
@TimeUp nVarchar(max),
@DateUp Date = '1/1/1975',
@RespPart Integer,
@Originator Integer,
@Robot Integer,
@Line Integer,
@FaultCode Integer,
@RETURN_VALUE INT = 0 OUTPUT 
AS

	INSERT INTO DT.DTMainTable
		(
			DTSolution,
			DTMalfunction,
			DTLongTerm,
			DTNDateDown,
			DTNTimeDown,
			DTNTimeUp,
			DTNDateUp,
			DTResponsibility,
			DTOriginator,
			DTRobot,
			DTLine,
			DTT3Code,
			DTAsset
		)
		VALUES
		(
			@Solution,
			@Malfunction,
			@LongTerm,
			@DateDown,
			CAST(@TimeDown AS TIME),
			CAST(@TimeUp AS TIME),
			@DateUp,
			@RespPart,
			@Originator,
			@Robot,
			@Line,
			@FaultCode,
			(SELECT PROCASSET FROM EQP.ProcNumbers WHERE PROCID = @Robot)
		);

			SELECT DTID FROM DT.DTMainTable WHERE (DTID = SCOPE_IDENTITY())

		return @RETURN_VALUE;
GO
/****** Object:  StoredProcedure [wAppDT].[DowntimeUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[DowntimeUpdate]
@DTID integer = 1,
@Solution nVarChar(max) = " ",
@Malfunction nVarChar(max) = " " ,
@LongTerm nVarChar(max) = " ",
@DateDown Date = '1/1/1975',
@TimeDown nVarChar(max),
@TimeUp nVarchar(max),
@DateUp Date = '1/1/1975',
@RespPart Integer,
@Originator Integer,
@Robot Integer = 0,
@Line Integer,
@FaultCode Integer


AS




	UPDATE DT.DTMainTable
	SET
		DTSolution = @Solution,
		DTMalfunction = @Malfunction,
		DTLongTerm = @LongTerm,
		DTNDateDown = @DateDown,
		DTNTimeDown = CAST(@TimeDown as TIME),
		DTNTimeUp = CAST(@TimeUp as TIME),
		DTNDateUp = @DateUp,
		DTResponsibility = @RespPart,
		DTOriginator = @Originator,
		DTRobot = @Robot,
		DTLine = @Line,
		DTT3Code = @FaultCode,
		DTAsset = (SELECT PROCASSET FROM EQP.ProcNumbers WHERE PROCID = @Robot)
	WHERE DTID = @DTID;
GO
/****** Object:  StoredProcedure [wAppDT].[DTRep3]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[DTRep3]

@Line AS Integer = 1,
@Group as Integer = 0,
@showAll AS Integer = 0

/* Six Month Week report for the Plant Availability Graph. */

AS

DECLARE @Mo1 as DATE;
DECLARE @Mo2 AS DATE;
DECLARE @Mo3 AS DATE;
DECLARE @Mo4 AS DATE;
DECLARE @Mo5 AS DATE;
DECLARE @Mo6 AS DATE;
DECLARE @Mo7 AS DATE;
DECLARE @Mo12 AS DATE;



SET @Mo1 = CAST ((CAST(DatePart(month,GetDate()) AS nVarchar(20)) + '/1' + '/' + CAST(DatePart(year,GetDate()) AS nVArChar(20)) + ' ') AS DATE);
SET @Mo2 = DATEADD(MONTH,-1,@Mo1);
SET @Mo3 = DATEADD(MONTH,-2,@Mo1);
SET @Mo4 = DATEADD(MONTH,-3,@Mo1);
SET @Mo5 = DATEADD(MONTH,-4,@Mo1);
SET @Mo6 = DATEADD(MONTH,-5,@Mo1);
SET @Mo7 = DATEADD(MONTH,-6,@Mo1);
SET @Mo12 = DATEADD(MONTH, -12, @mo1);






print CAST(@Mo7 AS nVarChar(20)) + ' - ' + CAST (DATEADD(DAY,-1,@Mo6) AS nVarChar(20))
print @Mo2
print @Mo3
print @Mo4
print @Mo5
print @Mo6
print @Mo7



SELECT * FROM (
SELECT ISNULL(DTID,8888888) as DTID,ISNULL(LIID,@Line) as LIID, ISNULL(AAID,0) AS AAID, GDTDate , ISNULL(TotalMinutes,0) as Total  , ISNULL(DTResponsibility,4) as DTResponsibility,
ISNULL(DATENAME(MONTH,DTNDateDown),'') AS strMonth
--CASE 
--	WHEN (GDTDate BETWEEN @Mo7 AND DATEADD(day,-1,@Mo6)) THEN DATENAME(MONTH,@Mo7)
--	WHEN (GDTDate BETWEEN @Mo6 AND DATEADD(day,-1,@Mo5)) THEN DATENAME(MONTH,@Mo6)
--	WHEN (GDTDate BETWEEN @Mo5 AND DATEADD(day,-1,@Mo4)) THEN DATENAME(MONTH,@Mo5)
--	WHEN (GDTDate BETWEEN @Mo4 AND DATEADD(day,-1,@Mo3)) THEN DATENAME(MONTH,@Mo4)
--	WHEN (GDTDate BETWEEN @Mo3 AND DATEADD(day,-1,@Mo2)) THEN DATENAME(MONTH,@Mo3)
--	WHEN (GDTDate BETWEEN @Mo2 AND DATEADD(day,-1,@Mo1)) THEN DATENAME(MONTH,@Mo2)

--	ELSE 'nothing'
--END AS strMonth

FROM wACom.GenericDateTable

LEFT OUTER JOIN (SELECT * FROM DT.DowntimeReportingMain WHERE (LIID = @Line or AAID = @Group OR LIPlant =  @showAll)) as D
	ON GDTDate = D.DTNDateDown

WHERE  (GDTDate Between @Mo12 and DateAdd(day,-1,@Mo1))
Group BY GDTDate, DTResponsibility, TotalMinutes, LIID, AAID, DTID, DTNDateDown
) t


	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[DTRep2]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[DTRep2]

@Line AS Integer = 1,
@Group AS Integer = 0,
@showAll AS Integer = 0

/* Four Calander Week report for the Plant Availability Graph. */

AS

DECLARE @CW1 as Int;
DECLARE @CW2 as Int;
DECLARE @CW3 as Int;
DECLARE @CW4 as Int;
DECLARE @CW1Mon as Date;
DECLARE @CW2Mon as Date;
DECLARE @CW3Mon as Date;
DECLARE @CW4Mon as Date;

SET @CW1 = wACom.GetCWFromDate(DateAdd(day,-28,GetDate()));
SET @CW2 = wACom.GetCWFromDate(DateAdd(day,-21,GetDate()));
SET @CW3 = wACom.GetCWFromDate(DateAdd(day,-14,GetDate()));
SET @CW4 = wACom.GetCWFromDate(DateAdd(day,- 7,GetDate()));

SET @CW4Mon = WACom.GetCWMonDate(@CW4,DatePart(year,DateAdd(day,- 7,GetDate())));

SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,-28,@CW4Mon)));
Set @CW2Mon = wACom.GetCWMonDate(@CW2,DatePart(year,DateAdd(day,-21,@CW4Mon)));
SET @CW3Mon = wACom.GetCWMonDate(@CW3,DatePart(year,DateAdd(day,-14,@CW4Mon)));


SELECT * FROM (
SELECT ISNULL(DTID,8888888) as DTID,ISNULL(LIID,@Line) as LIID, ISNULL(AAID, 0) as AAID, GDTDate , ISNULL(TotalMinutes,0) as Total  , ISNULL(DTResponsibility,4) as DTResponsibility,
CASE 
	WHEN (GDTDate BETWEEN @CW1Mon AND DateAdd(day,6,@CW1Mon)) THEN @CW1
	WHEN (GDTDate BETWEEN @CW2Mon AND DateAdd(day,6,@CW2Mon)) THEN @CW2
	WHEN (GDTDate BETWEEN @CW3Mon AND DateAdd(day,6,@CW3Mon)) THEN @CW3
	WHEN (GDTDate BETWEEN @CW4Mon AND DateAdd(day,6,@CW4Mon)) THEN @CW4
	ELSE 0
END AS calWk

FROM wACom.GenericDateTable

LEFT OUTER JOIN (SELECT * FROM DT.DowntimeReportingMain WHERE (LIID = @Line OR AAID = @Group OR LIPlant =  @showAll)) as D
	ON GDTDate = D.DTNDateDown

WHERE  (GDTDate Between @CW1Mon and DateAdd(day,6,@CW4Mon))
Group BY GDTDate, DTResponsibility, TotalMinutes, LIID, AAID, DTID
) t


	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[DTRep1]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[DTRep1]
--@StartDate Date
@Line AS Integer = 0,
@Start AS Date,
@Days AS Integer = 30,
@Group AS Integer = 0,
@showAll as Integer = 0

AS


SET @Start = DateAdd(Day, -30,GetDate());


SELECT * FROM (
SELECT ISNULL(DTID,8888888) as DTID,ISNULL(LIID,@Line) as LIID, ISNULL(AAID, 0) as AAID, GDTDate , ISNULL(TotalMinutes,0) as Total  , ISNULL(DTResponsibility,4) as DTResponsibility
FROM wACom.GenericDateTable

LEFT OUTER JOIN (SELECT * FROM DT.DowntimeReportingMain WHERE (LIID = @Line OR AAID = @Group OR LIPlant = @showAll)) as D
	ON GDTDate = D.DTNDateDown

WHERE  (GDTDate BETWEEN DATEADD(Day,0,Cast(@Start AS Date)) AND DATEADD(Day, @Days, Cast(@Start AS Date))) 
Group BY GDTDate, DTResponsibility, TotalMinutes, LIID, AAID, DTID
) t

RETURN
GO
/****** Object:  UserDefinedFunction [wAppDT].[DTGetCW]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [wAppDT].[DTGetCW]
	(
		@Mon DATE,
		@dayMult int
	)
RETURNS INT
AS
	BEGIN
	DECLARE @retVal int;

	SET @retVal = wACom.GetCWFromDate(DATEADD(DAY,-(@dayMult * 7),@Mon))

	RETURN @retVal
	END
GO
/****** Object:  StoredProcedure [dbo].[dt_setpropertybyid_u]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
**	If the property already exists, reset the value; otherwise add property
**		id -- the id in sysobjects of the object
**		property -- the name of the property
**		uvalue -- the text value of the property
**		lvalue -- the binary value of the property (image)
*/
create procedure [dbo].[dt_setpropertybyid_u]
	@id int,
	@property varchar(64),
	@uvalue nvarchar(255),
	@lvalue image
as
	set nocount on
	-- 
	-- If we are writing the name property, find the ansi equivalent. 
	-- If there is no lossless translation, generate an ansi name. 
	-- 
	declare @avalue varchar(255) 
	set @avalue = null 
	if (@uvalue is not null) 
	begin 
		if (convert(nvarchar(255), convert(varchar(255), @uvalue)) = @uvalue) 
		begin 
			set @avalue = convert(varchar(255), @uvalue) 
		end 
		else 
		begin 
			if 'DtgSchemaNAME' = @property 
			begin 
				exec dbo.dt_generateansiname @avalue output 
			end 
		end 
	end 
	if exists (select * from dbo.dtproperties 
			where objectid=@id and property=@property)
	begin
		--
		-- bump the version count for this row as we update it
		--
		update dbo.dtproperties set value=@avalue, uvalue=@uvalue, lvalue=@lvalue, version=version+1
			where objectid=@id and property=@property
	end
	else
	begin
		--
		-- version count is auto-set to 0 on initial insert
		--
		insert dbo.dtproperties (property, objectid, value, uvalue, lvalue)
			values (@property, @id, @avalue, @uvalue, @lvalue)
	end
GO
/****** Object:  View [wAppEQP].[EqpEdit]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppEQP].[EqpEdit]
AS
SELECT        EQP.Equipment.EQNote, EQP.Equipment.EQTModelLink, EQP.Equipment.EQTIDold, EQP.Equipment.EQTPrintNumber, EQP.Equipment.EQInService, 
                         EQP.Equipment.EQTID, EQP.Equipment.EQServiceDate, EQP.Equipment.EQSerialNumber, EQP.EquipmentModelNumber.EQModModelNumber, 
                         EQP.EquipmentModelNumber.EQModDescription, EQP.ProcNumbers.PROCARG, wACom.MachineList.MLCELLNAME, wACom.Lines.LILineName, 
                         EQP.ProcNumbers.PROCNUMBER, EQP.Equipment.EQPlant, wACom.MachineList.MLID, wACom.Lines.LIID, EQP.EquipmentModelNumber.EQModID, 
                         Team.wAPlants.PNID, EQP.ProcNumbers.PROCID, EQP.Equipment.EQTDescription, EQP.Equipment.EQTIdleLocation
FROM            wACom.Lines LEFT OUTER JOIN
                         Team.wAPlants ON wACom.Lines.LIPlant = Team.wAPlants.PNID RIGHT OUTER JOIN
                         wACom.MachineList ON wACom.Lines.LIID = wACom.MachineList.MLLINEID RIGHT OUTER JOIN
                         EQP.ProcNumbers ON wACom.MachineList.MLID = EQP.ProcNumbers.PROCARG RIGHT OUTER JOIN
                         EQP.Equipment ON EQP.ProcNumbers.PROCASSET = EQP.Equipment.EQTID LEFT OUTER JOIN
                         EQP.EquipmentModelNumber ON EQP.Equipment.EQTModelLink = EQP.EquipmentModelNumber.EQModID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 84
               Left = 801
               Bottom = 222
               Right = 956
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "wAPlants (Team)"
            Begin Extent = 
               Top = 83
               Left = 1021
               Bottom = 176
               Right = 1172
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 85
               Left = 568
               Bottom = 211
               Right = 720
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 85
               Left = 307
               Bottom = 247
               Right = 497
            End
            DisplayFlags = 344
            TopColumn = 10
         End
         Begin Table = "Equipment (EQP)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 240
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "EquipmentModelNumber (EQP)"
            Begin Extent = 
               Top = 23
               Left = 308
               Bottom = 230
               Right = 497
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
        ' , @level0type=N'SCHEMA',@level0name=N'wAppEQP', @level1type=N'VIEW',@level1name=N'EqpEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppEQP', @level1type=N'VIEW',@level1name=N'EqpEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppEQP', @level1type=N'VIEW',@level1name=N'EqpEdit'
GO
/****** Object:  View [wAppDT].[EqpDTReport]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppDT].[EqpDTReport]
AS
SELECT     DT.DTMainTable.DTRobot, EQP.ProcNumbers.PROCNUMBER, DT.DTMainTable.DTMalfunction, DT.DTMainTable.DTSolution, 
                      DT.DTMainTable.DTNDateDown, DT.DTMainTable.TotalMinutes, EQP.Equipment.EQTID, wACom.MachineList.MLCELLNAME
FROM         DT.DTMainTable LEFT OUTER JOIN
                      EQP.ProcNumbers ON DT.DTMainTable.DTRobot = EQP.ProcNumbers.PROCID LEFT OUTER JOIN
                      EQP.Equipment ON DT.DTMainTable.DTAsset = EQP.Equipment.EQTID LEFT OUTER JOIN
                      wACom.MachineList ON DT.DTMainTable.DTLine = wACom.MachineList.MLID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DTMainTable (DT)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 257
               Right = 197
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 235
               Bottom = 161
               Right = 387
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Equipment (EQP)"
            Begin Extent = 
               Top = 6
               Left = 425
               Bottom = 224
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 6
               Left = 623
               Bottom = 257
               Right = 813
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppDT', @level1type=N'VIEW',@level1name=N'EqpDTReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppDT', @level1type=N'VIEW',@level1name=N'EqpDTReport'
GO
/****** Object:  StoredProcedure [EQP].[EquipHistoryWO]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [EQP].[EquipHistoryWO]
@EquipNumber as integer = 5
AS
	
SELECT     WO.WorkOrderMain.DISOpenDate, WO.WorkOrderMain.DISCloseDate, WO.WorkOrderMain.DISWorkRequired, WO.WorkOrderMain.DISNumberAss, 
                      WO.WorkOrderMain.DISManHours, WO.WorkOrderMain.DISWorkAccomp, WO.WorkOrderMain.DISLineNumber, WO.WorkOrderMain.DISEquip, 
                      WO.WorkOrderMain.DISDueDate, WO.WorkOrderMain.DISOriginator, WO.WorkOrderMain.DISResponsible, WO.WorkOrderMain.DISType, 
                      WO.WorkOrderMain.DISRequestor, WO.WorkOrderMain.DISOpenItemNumber, WO.WorkOrderMain.DISTPMNumber, WO.WorkOrderMain.DISID, 
                      WO.WorkOrderMain.DISIntHold, WO.WorkOrderMain.DISCharHold, WO.WorkOrderMain.DISAsset, EQP.Equipment.EQTID, 
                      EQP.ProcNumbers.PROCNUMBER
FROM         EQP.Equipment RIGHT OUTER JOIN
                      WO.WorkOrderMain ON EQP.Equipment.EQTID = WO.WorkOrderMain.DISAsset LEFT OUTER JOIN
                      EQP.ProcNumbers ON WO.WorkOrderMain.DISEquip = EQP.ProcNumbers.PROCID
WHERE     (EQP.Equipment.EQTID = @EquipNumber)
UNION ALL
SELECT     WO.Archive.DISOpenDate, WO.Archive.DISCloseDate, WO.Archive.DISWorkRequired, WO.Archive.DISNumberAss, 
                      WO.Archive.DISManHours, WO.Archive.DISWorkAccomp, WO.Archive.DISLineNumber, WO.Archive.DISEquip, 
                      WO.Archive.DISDueDate, WO.Archive.DISOriginator, WO.Archive.DISResponsible, WO.Archive.DISType, 
                      WO.Archive.DISRequestor, WO.Archive.DISOpenItemNumber, WO.Archive.DISTPMNumber, WO.Archive.DISID, 
                      WO.Archive.DISIntHold, WO.Archive.DISCharHold, WO.Archive.DISAsset, EQP.Equipment.EQTID, 
                      EQP.ProcNumbers.PROCNUMBER
FROM         EQP.Equipment RIGHT OUTER JOIN
                      WO.Archive ON EQP.Equipment.EQTID = WO.Archive.DISAsset LEFT OUTER JOIN
                      EQP.ProcNumbers ON WO.Archive.DISEquip = EQP.ProcNumbers.PROCID
WHERE     (EQP.Equipment.EQTID = @EquipNumber)
	RETURN
GO
/****** Object:  View [TPM].[EQPvsMODReportView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [TPM].[EQPvsMODReportView]
AS
SELECT     EQP.EquipmentModelNumber.*, EQP.ProcNumbers.*, wACom.MachineList.*, wACom.Lines.*
FROM         wACom.MachineList LEFT OUTER JOIN
                      wACom.Lines ON wACom.MachineList.MLLINEID = wACom.Lines.LIID RIGHT OUTER JOIN
                      EQP.ProcNumbers ON wACom.MachineList.MLID = EQP.ProcNumbers.PROCARG LEFT OUTER JOIN
                      EQP.EquipmentModelNumber ON EQP.ProcNumbers.PROCMODEL = EQP.EquipmentModelNumber.EQModID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EquipmentModelNumber (EQP)"
            Begin Extent = 
               Top = 1
               Left = 274
               Bottom = 252
               Right = 454
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 0
               Left = 17
               Bottom = 251
               Right = 207
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 6
               Left = 484
               Bottom = 238
               Right = 640
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 6
               Left = 678
               Bottom = 121
               Right = 833
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         ' , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'VIEW',@level1name=N'EQPvsMODReportView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'VIEW',@level1name=N'EQPvsMODReportView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'VIEW',@level1name=N'EQPvsMODReportView'
GO
/****** Object:  View [EQP].[EquipmentWoHistory]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [EQP].[EquipmentWoHistory]
AS
SELECT     WO.WorkOrderMain.DISOpenDate, WO.WorkOrderMain.DISCloseDate, WO.WorkOrderMain.DISWorkRequired, WO.WorkOrderMain.DISNumberAss, 
                      WO.WorkOrderMain.DISManHours, WO.WorkOrderMain.DISWorkAccomp, WO.WorkOrderMain.DISLineNumber, WO.WorkOrderMain.DISEquip, 
                      WO.WorkOrderMain.DISDueDate, WO.WorkOrderMain.DISOriginator, WO.WorkOrderMain.DISResponsible, WO.WorkOrderMain.DISType, 
                      WO.WorkOrderMain.DISRequestor, WO.WorkOrderMain.DISOpenItemNumber, WO.WorkOrderMain.DISTPMNumber, WO.WorkOrderMain.DISID, 
                      WO.WorkOrderMain.DISIntHold, WO.WorkOrderMain.DISCharHold, WO.WorkOrderMain.DISAsset, EQP.Equipment.EQTID, 
                      EQP.ProcNumbers.PROCNUMBER
FROM         EQP.Equipment RIGHT OUTER JOIN
                      WO.WorkOrderMain ON EQP.Equipment.EQTID = WO.WorkOrderMain.DISAsset LEFT OUTER JOIN
                      EQP.ProcNumbers ON WO.WorkOrderMain.DISEquip = EQP.ProcNumbers.PROCID
WHERE     (EQP.Equipment.EQTID IS NOT NULL)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Equipment (EQP)"
            Begin Extent = 
               Top = 31
               Left = 776
               Bottom = 263
               Right = 936
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "WorkOrderMain (WO)"
            Begin Extent = 
               Top = 7
               Left = 18
               Bottom = 257
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "ProcNumbers (EQP)"
            Begin Extent = 
               Top = 0
               Left = 389
               Bottom = 251
               Right = 579
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'EQP', @level1type=N'VIEW',@level1name=N'EquipmentWoHistory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'EQP', @level1type=N'VIEW',@level1name=N'EquipmentWoHistory'
GO
/****** Object:  StoredProcedure [wAppEQP].[IdleAssetFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[IdleAssetFetch]



AS
	SELECT * FROM wAppEQP.IdleAssetView


	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[FrequencyFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[FrequencyFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM wAppTPM.wAppTPMFrequency
	ORDER BY TPMFreqID
	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[forteenDayLine]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[forteenDayLine]
--@StartDate Date
@Line AS Integer = 0,
@Start AS Date = '3/1/2012',
@Days AS Integer = 30,
@Group AS Integer = 0,
@showAll as Integer = 0

AS

DECLARE @defaultLineName nVarChar(50) = 'No line name';

IF (@Line > 0)
BEGIN
SET @defaultLineName = (SELECT TOP 1 LILineName FROM wACom.Lines WHERE LIID = @Line);
END

DECLARE @defaultAreaName nVarChar(50) = 'no area name';

IF (@Group > 0)
Begin
SET @defaultAreaName = (SELECT TOP 1 AAareaname FROM wACom.Areas WHERE AAID = @Group)
SET @defaultLineName = (SELECT TOP 1 LILineName FROM wACom.Lines WHERE LISatellite = @Group)
End





SELECT * FROM (
SELECT ISNULL(DTID,8888888) as DTID,ISNULL(LIID,@Line) as LIID, ISNULL(AAID, 0) as AAID, GDTDate , ISNULL(TotalMinutes,0) as Total  , ISNULL(AAareaname, @defaultAreaName) as AreaName, ISNULL(MLCELLNAME,@defaultLineName) as CellName, ISNULL(LILineName,@defaultLineName) as LineName
FROM wACom.GenericDateTable

LEFT OUTER JOIN (SELECT * FROM DT.DowntimeReportingMain WHERE (LIID = @Line OR AAID = @Group OR LIPlant = @showAll)) as D
	ON GDTDate = D.DTNDateDown

WHERE  (GDTDate BETWEEN DATEADD(Day,0,Cast(@Start AS Date)) AND DATEADD(Day, @Days, Cast(@Start AS Date))) 
Group BY GDTDate,TotalMinutes, LIID, AAID, DTID, AAAreaname,MLCellName, LILineName
) t

RETURN
GO
/****** Object:  StoredProcedure [TPM].[FetchOverviewItem]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TPM].[FetchOverviewItem]


	@DatePass Date = '9/2/2011',
	@LineNumber Integer = 1,
	@TPMProc Integer,
	@TPMFreq Integer,
	@WeekNumber Integer,
	@ReturnDate Date OUTPUT



AS
	DECLARE @DateHold1 Date;
	DECLARE @DateHold2 Date;
	DECLARE @DateHold3 Date;


		
	-- Find the monday for the Calander week sent over with @DatePass
	Set @DateHold1 = (SELECT TOP 1 GSCWMonDate FROM TPM.GrandSchedule
									WHERE GSCWMonDate <= @DatePass
									ORDER BY GSCWMonDate DESC)

    -- Find the first monday of the calander month from the monday date in the previous step. This should be the beginning of the month
	SET @DateHold2 = (SELECT TOP 1 GSCWMonDate FROM TPM.GrandSchedule
									WHERE DATEPART(YEAR,GSCWMonDate) = DATEPART(YEAR,@DateHold1)
									AND
									DATEPART(MONTH,GSCWMonDate) = DATEPART(MONTH,@DateHold1)
									ORDER BY GSCWMonDate ASC)
	
	SET @DateHold3 = DATEADD(DAY,(@WeekNumber * 7),@DateHold2);
	SET @ReturnDate = @DateHold3;

	-- Calculate the monthly tpms that are due.
	IF @TPMFreq = 6
	   BEGIN
			SELECT 
				Count(TP.TPMProcID) AS Total
			FROM
				TPM.TPMProcdure as TP
			JOIN EQP.ProcNumbers as PN on PN.PROCMODEL = TP.TMPProcModelLink
			WHERE (PN.PROCMONTHGROUP = (SELECT  GSMonthGroup FROM TPM.GrandSchedule WHERE GSCWMonDate = @DateHold3)
					AND TP.TPMProcID = @TPMProc
					AND PN.PROCARG = @LineNumber);
						
		END
	ELSE
	-- Calculate the weekly TPM's that are due
	IF @TPMFreq = 4
	   BEGIN
			SELECT 
				Count(TP.TPMProcID) AS Total
			FROM
				TPM.TPMProcdure as TP
			JOIN EQP.ProcNumbers as PN on PN.PROCMODEL = TP.TMPProcModelLink
			WHERE ( TP.TPMProcID = @TPMProc
					AND PN.PROCARG = @LineNumber);
						
		END
	ELSE
	-- Calculate the Quarterly tpms that are due.
	IF @TPMFreq = 7
	   BEGIN
			SELECT 
				Count(TP.TPMProcID) AS Total
			FROM
				TPM.TPMProcdure as TP
			JOIN EQP.ProcNumbers as PN on PN.PROCMODEL = TP.TMPProcModelLink
			WHERE (PN.PROCQUARTGROUP = (SELECT  GSQuarterlyGroup FROM TPM.GrandSchedule WHERE GSCWMonDate = @DateHold3)
					AND TP.TPMProcID = @TPMProc
					AND PN.PROCARG = @LineNumber);
						
		END
	ELSE
	-- Calculate the Semi Anual tpms that are due.
	IF @TPMFreq = 8
	   BEGIN
			SELECT 
				Count(TP.TPMProcID) AS Total
			FROM
				TPM.TPMProcdure as TP
			JOIN EQP.ProcNumbers as PN on PN.PROCMODEL = TP.TMPProcModelLink
			WHERE (PN.PROCSEMIGROUP = (SELECT  GSSemiAnGroup FROM TPM.GrandSchedule WHERE GSCWMonDate = @DateHold3)
					AND TP.TPMProcID = @TPMProc
					AND PN.PROCARG = @LineNumber);
						
		END
	ELSE
	-- Calculate the Anual tpms that are due.
	IF @TPMFreq = 9
	   BEGIN
			SELECT 
				Count(TP.TPMProcID) AS Total
			FROM
				TPM.TPMProcdure as TP
			JOIN EQP.ProcNumbers as PN on PN.PROCMODEL = TP.TMPProcModelLink
			WHERE (PN.PROCANUALGROUP = (SELECT  GSAnGroup FROM TPM.GrandSchedule WHERE GSCWMonDate = @DateHold3)
					AND TP.TPMProcID = @TPMProc
					AND PN.PROCARG = @LineNumber);
						
		END
	ELSE
		BEGIN

			SELECT 0 AS Total
		END




	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[EqpEditReport]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[EqpEditReport]
@Cell as nVarChar(max),
@Line as nVarChar(max),
@Plant as Integer,
@Model as nVarChar(max) 


AS
DECLARE @machineTable TABLE 
(
	machineNumber  Integer,
	idCol Integer
)

INSERT INTO @machineTable (machineNumber) SELECT (data) FROM wACom.Split(@Cell,',')

	SELECT * FROM wAppEQP.EqpEdit
	--WHERE EQPlant = @Plant and MLID IN (SELECT machineNumber FROM @machineTable )
	WHERE EQPlant = @Plant and MLID IN (SELECT (data) FROM wACom.Split(@Cell,',') ) AND EQModID IN (SELECT (data) FROM wACom.Split(@Model,','))
	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[EquipmentModelFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[EquipmentModelFetch]

AS

	SELECT * FROM wAppTPM.wAppModelNumbers
	ORDER BY EQModModelNumber

	RETURN
GO
/****** Object:  StoredProcedure [wAppEQP].[EqpEditFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppEQP].[EqpEditFetch]
@Plant as Integer = 0
AS

	SELECT  * FROM EqpEdit
	--WHERE EQPlant = @Plant

	RETURN
GO
/****** Object:  StoredProcedure [EQP].[EqpDTReport]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [EQP].[EqpDTReport]
@EqpNum as Integer
AS

	SELECT * FROM wAppDT.EqpDTReport
	WHERE EQTID = @EqpNum

	RETURN
GO
/****** Object:  UserDefinedFunction [wAppTeam].[DTGetCWTechMin]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [wAppTeam].[DTGetCWTechMin]
	(
		@Mon date,
		@Plant int,
		@Tech int,
		@dayMult int
	)
RETURNS int
AS



	BEGIN
	DECLARE @retVal INT;
	DECLARE @MonCalc Date;

	SET @MonCalc = DATEADD(DAY,-(@dayMult * 7),@Mon);

	SET @retVal = (SELECT SUM(TotalMinutes) FROM wAppDT.TechnologyReportView WHERE DTNDateDown BETWEEN @MonCalc AND DateAdd(Day,6,@MonCalc) AND LIPLant = @Plant AND T2ID = @Tech)

	RETURN  @retVal
	END
GO
/****** Object:  UserDefinedFunction [wAppDT].[DTGetCWTechMin]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [wAppDT].[DTGetCWTechMin]
	(
		@Mon date,
		@Plant int,
		@Tech int,
		@dayMult int
	)
RETURNS int
AS



	BEGIN
	DECLARE @retVal INT;
	DECLARE @MonCalc Date;

	SET @MonCalc = DATEADD(DAY,-(@dayMult * 7),@Mon);

	SET @retVal = (SELECT SUM(TotalMinutes) FROM wAppDT.TechnologyReportView WHERE DTNDateDown BETWEEN @MonCalc AND DateAdd(Day,6,@MonCalc) AND MLPlantID = @Plant AND T2ID = @Tech)

	RETURN  @retVal
	END
GO
/****** Object:  StoredProcedure [Development].[AutoGenTest]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [Development].[AutoGenTest]

--@RecCount Integer OUTPUT

AS

DECLARE @strSQL nVarChar(max);
DECLARE @strSQLOne nVarChar(max);
DECLARE @strParam nVarChar(max);
DECLARE @DatePass date;
DECLARE @failedOver bit;


SET @DatePass = CAST(GETDATE() AS Date)

-- Close Work orders that are past thier cycle date. 


	UPDATE Development.WorkOrderMain
	SET DISCloseDate = '2/7/1977', DISClosedIncomplete = GetDate()
	WHERE DISID IN(
						SELECT  Development.WorkOrderMain.DISID
						FROM    TPM.TPMFrequency
						RIGHT OUTER JOIN
						    TPM.TPMProcdure ON TPM.TPMFrequency.TPMFreqID = TPM.TPMProcdure.TPMProcFreq
						RIGHT OUTER JOIN
							 Development.WorkOrderMain ON TPM.TPMProcdure.TPMProcID = Development.WorkOrderMain.DISTPMNumber
						WHERE   (
									Development.WorkOrderMain.DISType = 3 
									AND
									GetDate() > DateAdd(Day, TPMFreqPeriod,DISOpenDate)
									AND
									DISCloseDate IS NULL
								)
					)

-- Get the Schedule structrure from the Grand Schedule and Load it.

DECLARE	@MG		INT	= (SELECT TOP 1 GSMonthGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@BMG	INT	= (SELECT TOP 1 GSBiMonthGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@QG		INT	= (SELECT TOP 1 GSQuarterlyGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@SAG	INT	= (SELECT TOP 1 GSSemiAnGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@AG		INT	= (SELECT TOP 1 GSAnGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@TYG	INT	= (SELECT TOP 1 GSTwoYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@THYG	INT	= (SELECT TOP 1 GSThreeYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@FYG	INT	= (SELECT TOP 1 GSFourYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@EYG	INT	= (SELECT TOP 1 GSEightYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC);





INSERT INTO Development.WorkOrderMain
			(
				DISEquip,
				DISLineNumber,
				DISIntHold,
				DISType,
				DISOpenDate,
				DISDueDate,
				DISTPMNumber,
				DISWorkRequired,
				DISResponsible,
				DISManHours
			)

	SELECT 
			PN.PROCID,
			PN.PROCARG,
			PN.PROCMODEL,
			Type = 3,
			OPENDATE = @DatePass,
			DUEDATE = DATEADD(DAY,6,@DatePass),
			TPR.TPMProcID,
			(TPR.TPMProcProcedure + DEVELOPMENT.RetrieveProcString(TPR.TPMProcID)),
			PN.PROCASSIGNTO,
			TPR.TPMPRocEstMin
		FROM EQP.ProcNumbers as PN
		JOIN TPM.TPMProcdure AS TPR ON TPR.TMPProcModelLink = PN.PROCMODEL
		WHERE 
		(
			(
				(PN.PROCMONTHGROUP		= @MG	AND TPR.TPMProcFreq = 6)
					OR
				(PN.PROCBIMONTHGROUP	= @BMG	AND TPR.TPMProcFreq = 5) 
					OR
				(PN.PROCQUARTGROUP		= @QG	AND TPR.TPMProcFreq = 7)
					OR
				(PN.PROCSEMIGROUP		= @QG	AND TPR.TPMProcFreq = 8)
					OR
				(PN.PROCANUALGROUP		= @AG	AND TPR.TPMProcFreq = 9)
					OR
				(PN.PROCTWOYRGRUP		= @TYG	AND TPR.TPMProcFreq = 10) 	
					OR
				(PN.PROCTHREEYRGROUP	= @THYG	AND TPR.TPMProcFreq = 11)
					OR
				(PN.PROCFOURYRGROUP		= @FYG	AND TPR.TPMProcFreq = 13)
					OR
				(PN.PROCEIGHTYRGROUP	= @EYG	AND TPR.TPMProcFreq = 14) 
			)
			
			--AND PN.PROCID NOT IN (SELECT * FROM wAppTPM.CheckTPMExists(TPR.TPMProcID))
			AND PN.PROCID NOT IN (	SELECT DISEquip 
									FROM Development.WorkOrderMain
									WHERE DISCloseDate Is Null
									AND
									DISTPMNumber = TPR.TPMProcID)
		)
		
		return
GO
/****** Object:  View [wAppDoc].[AssyDocView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppDoc].[AssyDocView]
AS
SELECT     Documentation.DocumentMaster.DMid, Documentation.DocumentMaster.DMTitle, Documentation.DocumentMaster.DMTierThreeLink, 
                      Documentation.DocumentMaster.DMDocWebURL, Documentation.DocumentMaster.DMSearchTags, Documentation.DocumentMaster.DMNotes, 
                      wAppDoc.DocTierAssemblyView.DTOID, wAppDoc.DocTierAssemblyView.DTOName, wAppDoc.DocTierAssemblyView.DTThName, 
                      wAppDoc.DocTierAssemblyView.DTThTierTwoLink, wAppDoc.DocTierAssemblyView.DTThID, wAppDoc.DocTierAssemblyView.DTTwName, 
                      wAppDoc.DocTierAssemblyView.DTTwTierOneLink, wAppDoc.DocTierAssemblyView.DTTwID
FROM         wAppDoc.DocTierAssemblyView RIGHT OUTER JOIN
                      Documentation.DocumentMaster ON wAppDoc.DocTierAssemblyView.DTThID = Documentation.DocumentMaster.DMTierThreeLink
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[35] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "DocumentMaster (Documentation)"
            Begin Extent = 
               Top = 11
               Left = 57
               Bottom = 189
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DocTierAssemblyView (wAppDoc)"
            Begin Extent = 
               Top = 29
               Left = 523
               Bottom = 208
               Right = 686
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 15
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2685
         Width = 1500
         Width = 1500
         Width = 3000
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 3840
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppDoc', @level1type=N'VIEW',@level1name=N'AssyDocView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppDoc', @level1type=N'VIEW',@level1name=N'AssyDocView'
GO
/****** Object:  View [TPM].[CloseIncompleteWorkOrderView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [TPM].[CloseIncompleteWorkOrderView]
AS
SELECT     WO.WorkOrderMain.DISID, WO.WorkOrderMain.DISOpenDate, WO.WorkOrderMain.DISCloseDate, WO.WorkOrderMain.DISDueDate, 
                      WO.WorkOrderMain.DISType, WO.WorkOrderMain.DISTPMNumber, TPM.TPMFrequency.TPMFreqPeriod
FROM         TPM.TPMFrequency RIGHT OUTER JOIN
                      TPM.TPMProcdure ON TPM.TPMFrequency.TPMFreqID = TPM.TPMProcdure.TPMProcFreq RIGHT OUTER JOIN
                      WO.WorkOrderMain ON TPM.TPMProcdure.TPMProcID = WO.WorkOrderMain.DISTPMNumber
WHERE     (WO.WorkOrderMain.DISType = 3)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WorkOrderMain (WO)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 257
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "TPMProcdure (TPM)"
            Begin Extent = 
               Top = 6
               Left = 259
               Bottom = 254
               Right = 443
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TPMFrequency (TPM)"
            Begin Extent = 
               Top = 6
               Left = 481
               Bottom = 253
               Right = 661
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'VIEW',@level1name=N'CloseIncompleteWorkOrderView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'VIEW',@level1name=N'CloseIncompleteWorkOrderView'
GO
/****** Object:  StoredProcedure [TPM].[ManpowerEstimates]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TPM].[ManpowerEstimates]

--@RecCount Integer OUTPUT
	@date date,
	@plant integer

AS

DECLARE @strSQL nVarChar(max);
DECLARE @strSQLOne nVarChar(max);
DECLARE @strParam nVarChar(max);
DECLARE @DatePass date = @date;


-- Get the Schedule structrure from the Grand Schedule and Load it.

DECLARE	@MG		INT	= (SELECT TOP 1 GSMonthGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@BMG	INT	= (SELECT TOP 1 GSBiMonthGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@QG		INT	= (SELECT TOP 1 GSQuarterlyGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@SAG	INT	= (SELECT TOP 1 GSSemiAnGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@AG		INT	= (SELECT TOP 1 GSAnGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@TYG	INT	= (SELECT TOP 1 GSTwoYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@THYG	INT	= (SELECT TOP 1 GSThreeYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@FYG	INT	= (SELECT TOP 1 GSFourYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@EYG	INT	= (SELECT TOP 1 GSEightYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@cwpass INT = (SELECT TOP 1 GSCW FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass ORDER BY GSCWMonDate DESC);

DECLARE @hold2 TABLE
(
	DISEquip Integer,
	DISLineNumber Integer,
	DISIntHold Integer,
	DISTpmNumber Integer,
	totMin Integer,
	totMen Integer,
	title nVarchar(100),
	cw integer

)


INSERT INTO @hold2
			(
				DISEquip,
				DISLineNumber,
				DISIntHold,
				DISTPMNumber,
				totMin,
				totMen,
				title,
				cw

			)

	SELECT 
			PN.PROCID,
			PN.PROCARG,
			PN.PROCMODEL,
			TPR.TPMProcID,
			TPMProcEstMin,
			(TPMProcNumTM * TPMProcEstMin),
			TPMProcTitle,
			@cwPass
		FROM EQP.ProcNumbers as PN
		JOIN TPM.TPMProcdure AS TPR ON TPR.TMPProcModelLink = PN.PROCMODEL
		WHERE 
		(
			(
				(PN.PROCMONTHGROUP		= @MG	AND TPR.TPMProcFreq = 6)
					OR
				(PN.PROCBIMONTHGROUP	= @BMG	AND TPR.TPMProcFreq = 5) 
					OR
				(PN.PROCQUARTGROUP		= @QG	AND TPR.TPMProcFreq = 7)
					OR
				(PN.PROCSEMIGROUP		= @QG	AND TPR.TPMProcFreq = 8)
					OR
				(PN.PROCANUALGROUP		= @AG	AND TPR.TPMProcFreq = 9)
					OR
				(PN.PROCTWOYRGRUP		= @TYG	AND TPR.TPMProcFreq = 10) 	
					OR
				(PN.PROCTHREEYRGROUP	= @THYG	AND TPR.TPMProcFreq = 11)
					OR
				(PN.PROCFOURYRGROUP		= @FYG	AND TPR.TPMProcFreq = 13)
					OR
				(PN.PROCEIGHTYRGROUP	= @EYG	AND TPR.TPMProcFreq = 14) 
			)
			
			AND ((SELECT MLPlantID FROM wACom.MachineList WHERE MLID = PN.PROCARG) = @plant)
							
		)
		
	SELECT * FROM @hold2



		return
GO
/****** Object:  StoredProcedure [TPM].[MonthlyScheduledLine]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TPM].[MonthlyScheduledLine]
	@DatePass date = '9/2/2011',
	@LineNumber integer = 1

AS
	DECLARE @DateHold1 Date;
	DECLARE @DateHold2 Date;

		
	-- Find the monday for the Calander week sent over with @DatePass
	Set @DateHold1 = (SELECT TOP 1 GSCWMonDate FROM TPM.GrandSchedule
									WHERE GSCWMonDate <= @DatePass
									ORDER BY GSCWMonDate DESC)

    -- Find the first monday of the calander month from the monday date in the previous step. This should be the beginning of the month
	SET @DateHold2 = (SELECT TOP 1 GSCWMonDate FROM TPM.GrandSchedule
									WHERE DATEPART(YEAR,GSCWMonDate) = DATEPART(YEAR,@DateHold1)
									AND
									DATEPART(MONTH,GSCWMonDate) = DATEPART(MONTH,@DateHold1)
									ORDER BY GSCWMonDate ASC)
									 
SELECT DISTINCT
	 TP.TPMProcID,
	 TP.TPMProcTitle,
	 TP.TPMProcFreq,
	 Count(PN.PROCID) as Total
FROM TPM.TPMProcdure AS TP
JOIN EQP.ProcNumbers AS PN ON PN.PROCMODEL = TP.TMPProcModelLink
WHERE (
	   (
         PN.PROCMONTHGROUP IN 
							(
							   SELECT  GSMonthGroup FROM TPM.GrandSchedule
	 						   WHERE DATEPART(MONTH,GSCWMonDate) = DATEPART(MONTH,@DateHold2)
								     AND
									 DATEPART(YEAR,GSCWMonDate) = DATEPART(YEAR,@DateHold2)
		                    )
	     AND 
		    TP.TPMProcFreq = 6
	     AND 
		    PN.PROCARG = @LineNumber
	   )
OR
	   (
         PN.PROCQUARTGROUP IN 
							(
							   SELECT  GSQuarterlyGroup FROM TPM.GrandSchedule
	 						   WHERE DATEPART(MONTH,GSCWMonDate) = DATEPART(MONTH,@DateHold2)
								     AND
									 DATEPART(YEAR,GSCWMonDate) = DATEPART(YEAR,@DateHold2)
		                    )
	     AND 
		    TP.TPMProcFreq = 7
	     AND 
		    PN.PROCARG = @LineNumber
	   )
OR 
       (
         PN.PROCSEMIGROUP IN 
							(
							   SELECT  GSSemiAnGroup FROM TPM.GrandSchedule
	 						   WHERE DATEPART(MONTH,GSCWMonDate) = DATEPART(MONTH,@DateHold2)
								     AND
									 DATEPART(YEAR,GSCWMonDate) = DATEPART(YEAR,@DateHold2)
		                    )
	     AND 
		    TP.TPMProcFreq = 8
	     AND 
		    PN.PROCARG = @LineNumber
	   )
OR 
       (
         PN.PROCANUALGROUP IN 
							(
							   SELECT  GSAnGroup FROM TPM.GrandSchedule
	 						   WHERE DATEPART(MONTH,GSCWMonDate) = DATEPART(MONTH,@DateHold2)
								     AND
									 DATEPART(YEAR,GSCWMonDate) = DATEPART(YEAR,@DateHold2)
		                    )
	     AND 
		    TP.TPMProcFreq = 9
	     AND 
		    PN.PROCARG = @LineNumber
	   )
OR
       (
	        TP.TPMProcFreq = 4
	     AND 
		    PN.PROCARG = @LineNumber
	   )
		
	  ) -- End Where	
		


GROUP BY TP.TPMProcID, TP.TPMProcTitle,TP.TPMProcFreq;


	RETURN
GO
/****** Object:  StoredProcedure [wACom].[ProcDrop]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[ProcDrop]
@Plant as Integer
AS

	SELECT PROCNUMBER, PROCID, MLID FROM wACom.ProcNumberDropMain
	WHERE MLPlantID = @Plant
	RETURN
GO
/****** Object:  StoredProcedure [wACom].[PLProcNumber]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [wACom].[PLProcNumber]
@Plant as Integer
AS

	SELECT * FROM EQP.winAppPLProcNumber
	WHERE MLPlantID = @Plant


	RETURN
GO
/****** Object:  StoredProcedure [wACom].[ProcFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wACom].[ProcFetch]
@Plant as Integer,
@Cell as Integer = 0
AS

	IF @CELL > 0 
	BEGIN

	SELECT PROCNUMBER, PROCID FROM wACom.ProcNumberDropMain
	WHERE MLPlantID = @Plant AND PROCARG = @Cell
	ORDER BY PROCNUMBER

	END
	ELSE
	BEGIN
	SELECT PROCNUMBER, PROCID FROM wACom.ProcNumberDropMain
	WHERE MLPlantID = @Plant 
	ORDER BY PROCNUMBER

	END


	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[ProcedureUpdate]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[ProcedureUpdate]
@ID integer,
@Title nVarChar(max),
@Procedure nVarChar(max),
@Frequency integer,
@Type	integer,
@Model integer,
@Minutes decimal,
@Team decimal,
@TPMLineStatus integer = 1,
@TPMPriority integer = 1
AS

	UPDATE TPM.TPMProcdure
	SET TPMProctitle = @Title, 
		TPMProcProcedure = @Procedure,
		TPMProcFreq = @Frequency,
		TPMProcType = @Type,
		TMPProcModelLink = @Model,
		TPMProcEstMin = @Minutes,
		TPMPRocNumTM = @Team,
		TPMProcLineStatus = @TPMLineStatus,
		TPMProcPriority  = @TPMPriority
	WHERE TPMProcID = @ID

	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[ProcedureInsert]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[ProcedureInsert]
@Title nVarChar(max) = '',
@Frequency integer = 1,
@Type integer = 1,
@Procedure nVarChar(max) = '',
@Model integer = 1,
@ProcContrDocNum int = 1,
@NumTM int = 0,
@NumMin int = 0,
@lineStatus int = 0,
@priority int = 0,
@plantAssign int = 1,


@RETURN_VALUE INT = 0 OUTPUT 

AS
	
	INSERT INTO TPM.TPMProcdure (
			TPMProcTitle,
			TPMProcFreq,
			TPMProcType,
			TPMProcProcedure,
			TMPProcModelLink,
			TPMProcContDocNum,
			TPMProcNumTM,
			TPMProcEstMin,
			TPMProcLineStatus,
			TPMProcPriority,
			TPMProcPlantAssign

			)
			 VALUES(
			 @Title,
			 @Frequency,
			 @Type,
			 @Procedure,
			 @Model,
			 @ProcContrDocNum,
			 @NumTM,
			 @NumMin,
			 @LineStatus,
			 @priority,
			 @plantAssign
			 
			 )


	SELECT TPMProcID FROM TPM.TPMProcdure WHERE (TPMProcID = SCOPE_IDENTITY())

	RETURN @RETURN_VALUE
GO
/****** Object:  UserDefinedFunction [wAppTPM].[RetrievePartsString]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [wAppTPM].[RetrievePartsString]

	(
		@ProcedureNumber int
	)

RETURNS nVarChar(max)

AS
BEGIN



DECLARE @resultString nVarChar(max) = (char(13) + char(10));
DECLARE @partNumber nVarChar(max);
DECLARE @qty nVarChar(max);
DECLARE @name nVarChar(max);

DECLARE @CWTable TABLE
(
	partNumber nVarChar(max),
	qty nVarChar(max),
	partname nVarChar(max)
);


INSERT INTO @CWTable 
	SELECT SP2VWNumber, TPSQty, SP2ShortSAPDescr
		FROM wAppParts.TPMProcedurePartsView as TL
		WHERE TL.TPSTPMProcedure = @ProcedureNumber 


DECLARE cwTable CURSOR FAST_FORWARD FOR
	SELECT * FROM @CWTable

OPEN cwTable


FETCH NEXT FROM cwTable INTO @partNumber, @qty, @name

WHILE @@FETCH_STATUS = 0

BEGIN

	 -- cycle through all of the tasks and assemble them into the final string


	SET @resultString = ISNULL(@resultString,(char(13) + char(10))) + 'Part # :' + ISNULL(@partNumber, '') + ' - ' + @name + ' - (QTY ' + ISNULL(@qty,'0') + ')' +  (char(13) + char(10))

FETCH NEXT FROM cwTable INTO @partNumber, @qty, @name
END


CLOSE cwTable
DEALLOCATE cwTable




RETURN @resultString;

	END
GO
/****** Object:  StoredProcedure [wAppTPM].[Report1Fetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[Report1Fetch]
@ModID as Integer
AS
	
	SELECT * FROM wAppTPM.wAppTPMReport1
	WHERE EQModID = @ModID

	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[ProcedureDelete]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[ProcedureDelete]
	
	(
		@id int
	)
	
AS
	DELETE FROM TPM.TPMProcdure WHERE TPMProcID = @id
	RETURN
GO
/****** Object:  View [wAppTPM].[TaskUsageView]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTPM].[TaskUsageView]
AS
SELECT        TPM.TPMTaskAssembly.TPMTATaskID, TPM.TPMProcdure.TPMProcTitle, TPM.TPMProcdure.TPMProcID, TPM.TPMTaskAssembly.TPMTAID
FROM            TPM.TPMTaskAssembly LEFT OUTER JOIN
                         TPM.TPMProcdure ON TPM.TPMTaskAssembly.TPMTAProcedureID = TPM.TPMProcdure.TPMProcID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TPMTaskAssembly (TPM)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 259
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TPMProcdure (TPM)"
            Begin Extent = 
               Top = 6
               Left = 343
               Bottom = 258
               Right = 555
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 7350
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'TaskUsageView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'TaskUsageView'
GO
/****** Object:  StoredProcedure [Weld].[WeldTableFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[WeldTableFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM Weld.WeldTableCombinedView
	RETURN
GO
/****** Object:  StoredProcedure [Weld].[WeldRobotList]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Weld].[WeldRobotList]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT DISTINCT PROCNUMBER,PROCID,MLID FROM Weld.WeldTableCombinedView
	RETURN
GO
/****** Object:  View [wAppWorkOrder].[TPMReportingViewOne]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppWorkOrder].[TPMReportingViewOne]
AS
SELECT     wACom.Lines.LIPlant, Team.wAPlants.PNID, Team.wAPlants.PNName, wACom.Lines.LIID, wACom.MachineList.MLCELLNAME, 
                      wACom.MachineList.MLID, wACom.MachineList.MLPlantID, wACom.Lines.LILineName, wACom.Areas.AAareaname, wACom.Areas.AAID, 
                      TPM.TPMProcdure.TPMProcID, TPM.TPMProcdure.TPMProcTitle, TPM.TPMProcdure.TMPProcModelLink, TPM.TPMFrequency.TPMFreqFrequency, 
                      WO.WorkOrderMain.DISOpenDate, WO.WorkOrderMain.DISCloseDate, WO.WorkOrderMain.DISDueDate, WO.WorkOrderMain.DISType, 
                      WO.WorkOrderMain.DISTPMNumber, WO.WorkOrderMain.DISID
FROM         TPM.TPMProcdure LEFT OUTER JOIN
                      TPM.TPMFrequency ON TPM.TPMProcdure.TPMProcFreq = TPM.TPMFrequency.TPMFreqID RIGHT OUTER JOIN
                      WO.WorkOrderMain ON TPM.TPMProcdure.TPMProcID = WO.WorkOrderMain.DISTPMNumber LEFT OUTER JOIN
                      wACom.Lines LEFT OUTER JOIN
                      wACom.Areas ON wACom.Lines.LISatellite = wACom.Areas.AAID LEFT OUTER JOIN
                      Team.wAPlants ON wACom.Lines.LIPlant = Team.wAPlants.PNID RIGHT OUTER JOIN
                      wACom.MachineList ON wACom.Lines.LIID = wACom.MachineList.MLLINEID ON 
                      WO.WorkOrderMain.DISLineNumber = wACom.MachineList.MLID
WHERE     (WO.WorkOrderMain.DISType = 3)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "WorkOrderMain (WO)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 260
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "Lines (wACom)"
            Begin Extent = 
               Top = 11
               Left = 483
               Bottom = 119
               Right = 637
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "MachineList (wACom)"
            Begin Extent = 
               Top = 10
               Left = 292
               Bottom = 118
               Right = 443
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "wAPlants (Team)"
            Begin Extent = 
               Top = 11
               Left = 775
               Bottom = 139
               Right = 926
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "Areas (wACom)"
            Begin Extent = 
               Top = 11
               Left = 938
               Bottom = 119
               Right = 1091
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TPMProcdure (TPM)"
            Begin Extent = 
               Top = 54
               Left = 374
               Bottom = 259
               Right = 557
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TPMFrequency (TPM)"
            Begin Extent = 
               Top = 88
               Left = 672
               Bottom = 196
             ' , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'TPMReportingViewOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  Right = 851
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'TPMReportingViewOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppWorkOrder', @level1type=N'VIEW',@level1name=N'TPMReportingViewOne'
GO
/****** Object:  StoredProcedure [wAppParts].[TPMPartsListFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppParts].[TPMPartsListFetch]
@Procedure as Integer
AS

	SELECT * FROM wAppParts.TPMProcedurePartsView
	WHERE TPSTPMProcedure = @Procedure

	RETURN
GO
/****** Object:  StoredProcedure [TPM].[TPMGenMonthly]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TPM].[TPMGenMonthly]
--@RecCount Integer OUTPUT

AS

DECLARE @strSQL nVarChar(max);
DECLARE @strSQLOne nVarChar(max);
DECLARE @strParam nVarChar(max);
DECLARE @DatePass date;


SET @DatePass = CAST(GETDATE() AS Date)



INSERT INTO WO.WorkOrderMain
			(
				DISEquip,
				DISLineNumber,
				DISIntHold,
				DISType,
				DISOpenDate,
				DISDueDate,
				DISTPMNumber,
				DISWorkRequired
			)

	SELECT 
			PN.PROCID,
			PN.PROCARG,
			PN.PROCMODEL,
			Type = 3,
			OPENDATE = @DatePass,
			DUEDATE = DATEADD(DAY,6,@DatePass),
			TPR.TPMProcID,
			TPR.TPMProcProcedure
		FROM EQP.ProcNumbers as PN
		JOIN TPM.TPMProcdure AS TPR ON TPR.TMPProcModelLink = PN.PROCMODEL
		--LEFT JOIN EQP.EquipmentModelNumber AS EQM ON PN.PROCMODEL =  EQM.EQModID
		--JOIN TPM.TPMProcdure AS TPR ON EQM.EQModID = TPR.TMPProcModelLink
		WHERE (PN.PROCMONTHGROUP =
		             ( SELECT TOP 1 GSMonthGroup FROM TPM.GrandSchedule
			 	       WHERE GSCWMonDate <= @DatePass
				       ORDER BY GSCWMonDate DESC)

                        			  AND

			           TPR.TPMProcFreq = 6 
			       
				                      AND
     					PN.PROCID NOT IN ( SELECT DISEquip 
										   FROM WO.WorkOrderMain
										   WHERE DISCloseDate Is Null
										       	AND
											DISTPMNumber = TPR.TPMProcID))
				OR
				(PN.PROCBIMONTHGROUP =
		             ( SELECT TOP 1 GSBiMonthGroup FROM TPM.GrandSchedule
			 	       WHERE GSCWMonDate <= @DatePass
				       ORDER BY GSCWMonDate DESC)

                        			  AND

			           TPR.TPMProcFreq = 5 
			       
				                      AND
     					PN.PROCID NOT IN ( SELECT DISEquip 
										   FROM WO.WorkOrderMain
										   WHERE DISCloseDate Is Null
										       	AND
											DISTPMNumber = TPR.TPMProcID))
			     OR
				(       
				        TPR.TPMProcFreq = 4 
			       
				                      AND
     					PN.PROCID NOT IN ( SELECT DISEquip 
										   FROM WO.WorkOrderMain
										   WHERE DISCloseDate Is Null
										       	AND
											DISTPMNumber = TPR.TPMProcID))	
 				
				
				OR
				(PN.PROCQUARTGROUP =
		             ( SELECT TOP 1 GSQuarterlyGroup FROM TPM.GrandSchedule
			 	       WHERE GSCWMonDate <= @DatePass
				       ORDER BY GSCWMonDate DESC)

                        			  AND

			           TPR.TPMProcFreq = 7 
			       
				                      AND
     					PN.PROCID NOT IN ( SELECT DISEquip 
										   FROM WO.WorkOrderMain
										   WHERE DISCloseDate Is Null
										       	AND
											DISTPMNumber = TPR.TPMProcID))

				OR
				(PN.PROCSEMIGROUP =
		             ( SELECT TOP 1 GSSemiAnGroup FROM TPM.GrandSchedule
			 	       WHERE GSCWMonDate <= @DatePass
				       ORDER BY GSCWMonDate DESC)

                        			  AND

			           TPR.TPMProcFreq = 8 
			       
				                      AND
     					PN.PROCID NOT IN ( SELECT DISEquip 
										   FROM WO.WorkOrderMain
										   WHERE DISCloseDate Is Null
										       	AND
											DISTPMNumber = TPR.TPMProcID))
				OR
				(PN.PROCANUALGROUP =
		             ( SELECT TOP 1 GSAnGroup FROM TPM.GrandSchedule
			 	       WHERE GSCWMonDate <= @DatePass
				       ORDER BY GSCWMonDate DESC)

                        			  AND

			           TPR.TPMProcFreq = 9 
			       
				                      AND
     					PN.PROCID NOT IN ( SELECT DISEquip 
										   FROM WO.WorkOrderMain
										   WHERE DISCloseDate Is Null
										       	AND
											DISTPMNumber = TPR.TPMProcID))
				OR
				(PN.PROCTWOYRGRUP =
		             ( SELECT TOP 1 GSTwoYearGroup FROM TPM.GrandSchedule
			 	       WHERE GSCWMonDate <= @DatePass
				       ORDER BY GSCWMonDate DESC)

                        			  AND

			           TPR.TPMProcFreq = 10 
			       
				                      AND
     					PN.PROCID NOT IN ( SELECT DISEquip 
										   FROM WO.WorkOrderMain
										   WHERE DISCloseDate Is Null
										       	AND
											DISTPMNumber = TPR.TPMProcID))
				OR
				(PN.PROCTHREEYRGROUP =
		             ( SELECT TOP 1 GSThreeYearGroup FROM TPM.GrandSchedule
			 	       WHERE GSCWMonDate <= @DatePass
				       ORDER BY GSCWMonDate DESC)

                        			  AND

			           TPR.TPMProcFreq = 11 
			       
				                      AND
     					PN.PROCID NOT IN ( SELECT DISEquip 
										   FROM WO.WorkOrderMain
										   WHERE DISCloseDate Is Null
										       	AND
											DISTPMNumber = TPR.TPMProcID))
				OR
				(PN.PROCFOURYRGROUP =
		             ( SELECT TOP 1 GSFourYearGroup FROM TPM.GrandSchedule
			 	       WHERE GSCWMonDate <= @DatePass
				       ORDER BY GSCWMonDate DESC)

                        			  AND

			           TPR.TPMProcFreq = 13 
			       
				                      AND
     					PN.PROCID NOT IN ( SELECT DISEquip 
										   FROM WO.WorkOrderMain
										   WHERE DISCloseDate Is Null
										       	AND
											DISTPMNumber = TPR.TPMProcID))
				OR
				(PN.PROCEIGHTYRGROUP =
		             ( SELECT TOP 1 GSEightYearGroup FROM TPM.GrandSchedule
			 	       WHERE GSCWMonDate <= @DatePass
				       ORDER BY GSCWMonDate DESC)

                        			  AND

			           TPR.TPMProcFreq = 14 
			       
				                      AND
     					PN.PROCID NOT IN ( SELECT DISEquip 
										   FROM WO.WorkOrderMain
										   WHERE DISCloseDate Is Null
										       	AND
											DISTPMNumber = TPR.TPMProcID))	
											
																			;														
	--Set @RecCount = @@RowCount

 RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMAutoGenerator]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMAutoGenerator]
--@RecCount Integer OUTPUT

AS

DECLARE @strSQL nVarChar(max);
DECLARE @strSQLOne nVarChar(max);
DECLARE @strParam nVarChar(max);
DECLARE @DatePass date;
DECLARE @failedOver bit;


SET @DatePass = CAST(GETDATE() AS Date)

-- Close Work orders that are past thier cycle date. 


	UPDATE WO.WorkOrderMain
	SET DISCloseDate = '2/7/1977', DISClosedIncomplete = GetDate()
	WHERE DISID IN(
						SELECT  WO.WorkOrderMain.DISID
						FROM    TPM.TPMFrequency
						RIGHT OUTER JOIN
						    TPM.TPMProcdure ON TPM.TPMFrequency.TPMFreqID = TPM.TPMProcdure.TPMProcFreq
						RIGHT OUTER JOIN
							 WO.WorkOrderMain ON TPM.TPMProcdure.TPMProcID = WO.WorkOrderMain.DISTPMNumber
						WHERE   (
									WO.WorkOrderMain.DISType = 3 
									AND
									GetDate() > DateAdd(Day, TPMFreqPeriod,DISOpenDate)
									AND
									DISCloseDate IS NULL
								)
					)

-- Get the Schedule structrure from the Grand Schedule and Load it.

DECLARE	@MG		INT	= (SELECT TOP 1 GSMonthGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@BMG	INT	= (SELECT TOP 1 GSBiMonthGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@QG		INT	= (SELECT TOP 1 GSQuarterlyGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@SAG	INT	= (SELECT TOP 1 GSSemiAnGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@AG		INT	= (SELECT TOP 1 GSAnGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@TYG	INT	= (SELECT TOP 1 GSTwoYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@THYG	INT	= (SELECT TOP 1 GSThreeYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@FYG	INT	= (SELECT TOP 1 GSFourYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC),
		@EYG	INT	= (SELECT TOP 1 GSEightYearGroup FROM TPM.GrandSchedule WHERE GSCWMonDate <= @DatePass	ORDER BY GSCWMonDate DESC);





INSERT INTO WO.WorkOrderMain
			(
				DISEquip,
				DISLineNumber,
				DISIntHold,
				DISType,
				DISOpenDate,
				DISDueDate,
				DISTPMNumber,
				DISWorkRequired,
				DISRequestor,
				DISManHours
			)

	SELECT 
			PN.PROCID,
			PN.PROCARG,
			PN.PROCMODEL,
			Type = 3,
			OPENDATE = @DatePass,
			case Freq.TPMFreqDueModifier
				when 0 then DATEADD(DAY,6,@DatePass)
				else DATEADD(DAY,Freq.TPMFreqDueModifier,@DatePass)
			end DUEDATE,
			TPR.TPMProcID,
			(TPR.TPMProcProcedure + wAppTPM.RetrieveProcString(TPR.TPMProcID)),
			PN.PROCASSIGNTO,
			TPR.TPMPRocEstMin
		FROM EQP.ProcNumbers as PN
		JOIN TPM.TPMProcdure AS TPR ON TPR.TMPProcModelLink = PN.PROCMODEL
		join TPM.TPMFrequency Freq on tpr.TPMProcFreq = Freq.TPMFreqID
		WHERE 
		(
			(
				(PN.PROCMONTHGROUP		= @MG	AND TPR.TPMProcFreq = 6)
					OR
				(PN.PROCBIMONTHGROUP	= @BMG	AND TPR.TPMProcFreq = 5) 
					OR
				(PN.PROCQUARTGROUP		= @QG	AND TPR.TPMProcFreq = 7)
					OR
				(PN.PROCSEMIGROUP		= @QG	AND TPR.TPMProcFreq = 8)
					OR
				(PN.PROCANUALGROUP		= @AG	AND TPR.TPMProcFreq = 9)
					OR
				(PN.PROCTWOYRGRUP		= @TYG	AND TPR.TPMProcFreq = 10) 	
					OR
				(PN.PROCTHREEYRGROUP	= @THYG	AND TPR.TPMProcFreq = 11)
					OR
				(PN.PROCFOURYRGROUP		= @FYG	AND TPR.TPMProcFreq = 13)
					OR
				(PN.PROCEIGHTYRGROUP	= @EYG	AND TPR.TPMProcFreq = 14) 
			)
			
			--AND PN.PROCID NOT IN (SELECT * FROM wAppTPM.CheckTPMExists(TPR.TPMProcID))
			AND PN.PROCID NOT IN (	SELECT DISEquip 
									FROM WO.WorkOrderMain
									WHERE DISCloseDate Is Null
									AND
									DISTPMNumber = TPR.TPMProcID)
		)
		
		return
GO
/****** Object:  StoredProcedure [wAppDT].[TopFiveTwelveMonth]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[TopFiveTwelveMonth]
	
	(
		@StartDate Date,
		@NumDays Integer,
		@Line Integer,
		@Group Integer,
		@showAll Integer
	
	 
	)
	
AS

DECLARE @Mo1 as DATE;




	SET @Mo1 = CAST ((CAST(DatePart(month,GetDate()) AS nVarchar(20)) + '/1' + '/' + CAST(DatePart(year,GetDate()) AS nVArChar(20)) + ' ') AS DATE);



	SELECT * FROM wAppDT.Top5(@Mo1,@NumDays,@Line,@Group,@showAll)



	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[Top5SevenDay]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[Top5SevenDay]

	(
		@StartDate Date,
		@NumDays Integer,
		@Line Integer,
		@Group Integer,
		@showAll Integer
	
	 
	)
	
AS

	SELECT * FROM wAppDT.Top5(@StartDate,@NumDays,@Line, @Group,@showAll)



	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[Top5Month]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[Top5Month]
	
	(
		@StartDate Date,
		@NumDays Integer,
		@Line Integer,
		@Group Integer,
		@showAll Integer = 0
	
	 
	)
	
AS

	SELECT * FROM wAppDT.Top5(@StartDate,@NumDays,@Line,@Group,@showAll)



	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[TechnologyReport2]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[TechnologyReport2]
@Line AS Integer = 1,
@Tech as nVarChar(max) = '1',
@Plant as Integer = 1 

/* Fifty Two Calander Week report for the Plant Availability Graph. */
-- This is a chart by TECHNOLOGY

AS

DECLARE @CW1 as Int
DECLARE @CW1Mon as Date;
DECLARE @faultCTR as int;

DECLARE @faultRows INT;
DECLARE @cwRows INT;
DECLARE @faultRowCurrent INT;
DECLARE @cwRowCurrent INT;
DECLARE @currentFault INT;

DECLARE @CW as int
DECLARE @Mon as date;

SET @CW1 = wACom.GetCWFromDate(DateAdd(day,0,GetDate()));
SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,0,GetDate())));

DECLARE @faultTable TABLE
(
	faultCode INT,
	keyCol INT not null primary key identity(1,1)

)
INSERT INTO @faultTable (faultCode) SELECT DATA FROM  wACom.Split(@tech,',');
SET @faultRows = @@ROWCOUNT;

DECLARE @resultTable TABLE
(

	LILineName nVarChar(255),
	LIID INT ,
	TotalMinutes INT,
	T2ID INT,
	T2Designation nVarChar(255),
	T2CodeName nVarChar(255),
	CW INT,
	CWD Date

);

DECLARE @CWTable TABLE
(
	GSCW INTEGER,
	GSCWMonDate DATE,
	keyCol INT not null primary key identity(1,1)
);

INSERT INTO @CWTable 
	SELECT TOP 52 GSCW, GSCWMonDate
	FROM TPM.GrandSchedule
	WHERE GSCWMonDate < @CW1Mon
	ORDER BY GSCWMonDate DESC;

SET @cwRows = @@ROWCOUNT;



	SET @cwRowCurrent = 0;
	WHILE @cwRowCurrent < @cwRows
	BEGIN
	SET @cwRowCurrent = @cwRowCurrent + 1;

	SELECT @CW = (SELECT TOP 1 GSCW FROM @CWTABLE WHERE keyCol = @cwRowCurrent);
	SELECT @Mon = (SELECT TOP 1 GSCWMonDate FROM @CWTABLE WHERE keyCol = @cwRowCurrent);


	INSERT INTO @resultTable (LIlineName,LIID,TotalMinutes,T2ID,T2Designation,T2CodeName , CW, CWD)
		SELECT LILineName,LIID, TotalMinutes, ISNULL(T2ID, 88888) as T2ID, ISNULL(T2Designation, 'ND') AS T2Designation, ISNULL(T2CodeName, 'ND') as T2CodeName,@CW, @Mon
		FROM wAppDT.TechnologyReportView
		WHERE DTNDateDown BETWEEN @Mon AND DateAdd(Day,6,@Mon) AND LIPLant = @Plant AND T2ID IN(SELECT faultCode FROM @faultTable);

		SET @faultRowCurrent = 0;
		WHILE @faultRowCurrent < @faultRows
		BEGIN
		SET @faultRowCurrent = @faultRowCurrent + 1;
		SET @currentFault = (SELECT TOP 1 faultCode FROM @faultTable WHERE keyCol = @faultRowCurrent);

				INSERT INTO @resultTable
					(
						LIlineName,
						LIID,
						TotalMinutes,
						T2ID,
						T2Designation,
						T2CodeName,
						CW,
						CWD
					)
				VALUES
					(
						'Place Hold', -- LIne Name
						99, -- LIID
						0, -- TotalMinutes
						@currentFault, -- T2ID
						(SELECT Top 1 T2Designation FROM DT.T2Code WHERE T2ID = @currentFault), -- T2Designation
						(SELECT Top 1 T2CodeName FROM DT.T2Code WHERE T2ID = @currentFault), -- T2CodeName 
						@cw, -- CW
						@Mon -- CW Monday
					)
		END

	END


DECLARE @DummyFault as nVarChar(50)

SET @DummyFault = (SELECT TOP 1 T2CodeName FROM @resultTable)

SELECT * FROM (
		SELECT  T2ID, ISNULL(T2CodeName, @DummyFault) AS T2Designation, ISNULL(TotalMinutes,0) AS TotalMinutes, e.GSCW, e.GSCWMonDate
		FROM @CWTable as E
		Left Outer Join (SELECT * FROM @resultTable) as D ON D.CWD = E.GSCWMonDate) t
ORDER BY GSCWMonDate ASC



	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[TechnologyReport]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[TechnologyReport]
@Line AS Integer = 1,
@Tech as nVarChar(max) = '1',
@Plant as Integer = 1 

/* Fifty Two Calander Week report for the Plant Availability Graph. */
-- This is a chart by LINE.

AS

DECLARE @CW1 as Int
DECLARE @CW1Mon as Date;

DECLARE @CW as int
DECLARE @Mon as date;

SET @CW1 = wACom.GetCWFromDate(DateAdd(day,0,GetDate()));
SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,0,GetDate())));

DECLARE @faultTable TABLE
(
	faultCode INT

)

DECLARE @faultNumber varchar(10)
DECLARE @Pos int

	SET @Tech = LTRIM(RTRIM(@Tech)) + ','
	SET @Pos = CHARINDEX(',', @Tech, 1)

	IF REPLACE(@Tech, ',', '') <> ''

		BEGIN
			WHILE @Pos > 0
				BEGIN
					SET @faultNumber = LTRIM(RTRIM(LEFT(@Tech, @Pos - 1)))
					
					IF @faultNumber <> ''
						BEGIN
							INSERT INTO @faultTable (faultCode) VALUES (CAST(@faultNumber AS int)) 
							print @FaultNumber
						END
					
					SET @Tech = RIGHT(@Tech, LEN(@Tech) - @Pos)
					
					SET @Pos = CHARINDEX(',', @Tech, 1)

				END
		END	





DECLARE @resultTable TABLE
(

	LILineName nVarChar(255),
	LIID INT ,
	TotalMinutes INT,
	T2ID INT,
	T2Designation nVarChar(255),
	T2CodeName nVarChar(255),
	CW INT,
	CWD Date

);

DECLARE @CWTable TABLE
(
	GSCW INTEGER,
	GSCWMonDate DATE
);

INSERT INTO @CWTable 
	SELECT TOP 52 GSCW, GSCWMonDate
	FROM TPM.GrandSchedule
	WHERE GSCWMonDate < @CW1Mon
	ORDER BY GSCWMonDate DESC

DECLARE cwTable CURSOR FAST_FORWARD FOR
	SELECT * FROM @CWTable

OPEN cwTable



WHILE @@FETCH_STATUS = 0
BEGIN
FETCH NEXT FROM cwTable INTO @CW, @Mon


INSERT INTO @resultTable (LIlineName,LIID,TotalMinutes,T2ID,T2Designation,T2CodeName , CW, CWD)
	SELECT LILineName,LIID, TotalMinutes, ISNULL(T2ID, 88888) as T2ID, ISNULL(T2Designation, 'ND') AS T2Designation, ISNULL(T2CodeName, 'ND') as T2CodeName,@CW, @Mon
	FROM wAppDT.TechnologyReportView
	WHERE DTNDateDown BETWEEN @Mon AND DateAdd(Day,6,@Mon) AND LIID = @LINE  AND MLPlantID = @Plant AND T2ID IN(SELECT * FROM @faultTable)

END
CLOSE cwTable
DEALLOCATE cwTable

DECLARE @DummyFault as nVarChar(50)

SET @DummyFault = (SELECT TOP 1 T2CodeName FROM @resultTable)

SELECT * FROM (
		SELECT  T2ID, ISNULL(T2CodeName, @DummyFault) AS T2Designation, ISNULL(TotalMinutes,0) AS TotalMinutes, e.GSCW, e.GSCWMonDate
		FROM @CWTable as E
		Left Outer Join (SELECT * FROM @resultTable) as D ON D.CWD = E.GSCWMonDate) t
	ORDER BY GSCWMonDate ASC



	RETURN
GO
/****** Object:  View [TPM].[WAppTPMProcedureOne]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [TPM].[WAppTPMProcedureOne]
AS
SELECT     TPM.TPMProcdure.*, TPM.TPMType.*, TPM.TPMFrequency.*
FROM         TPM.TPMProcdure INNER JOIN
                      TPM.TPMFrequency ON TPM.TPMProcdure.TPMProcFreq = TPM.TPMFrequency.TPMFreqID INNER JOIN
                      TPM.TPMType ON TPM.TPMProcdure.TPMProcType = TPM.TPMType.TPMTypeID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TPMProcdure (TPM)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 257
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TPMType (TPM)"
            Begin Extent = 
               Top = 6
               Left = 260
               Bottom = 241
               Right = 412
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TPMFrequency (TPM)"
            Begin Extent = 
               Top = 6
               Left = 450
               Bottom = 121
               Right = 630
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'VIEW',@level1name=N'WAppTPMProcedureOne'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'TPM', @level1type=N'VIEW',@level1name=N'WAppTPMProcedureOne'
GO
/****** Object:  View [wAppTPM].[wAppTPMProcedure]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [wAppTPM].[wAppTPMProcedure]
AS
SELECT        TPM.TPMProcdure.TPMProcID, TPM.TPMProcdure.TPMProcTitle, TPM.TPMProcdure.TPMProcFreq, TPM.TPMProcdure.TPMProcType, 
                         TPM.TPMProcdure.TPMProcProcedure, TPM.TPMProcdure.TMPProcModelLink, TPM.TPMProcdure.TPMProcContDocNum, TPM.TPMProcdure.TPMPRocNumTM, 
                         TPM.TPMProcdure.TPMProcEstMin, TPM.TPMType.TPMTypeID, TPM.TPMType.TPMTypeName, TPM.TPMFrequency.TPMFreqID, 
                         TPM.TPMFrequency.TPMFreqFrequency, TPM.TPMFrequency.TPMFreqNotes, TPM.TPMFrequency.TPMFreqPeriod, TPM.TPMFrequency.TPMFreqDueModifier, 
                         TPM.TPMFrequency.TPMInProduction, TPM.TPMFrequency.TPMProcGroupName, TPM.TPMFrequency.TPMBulkDigital, TPM.TPMFrequency.RightCol, 
                         EQP.EquipmentModelNumber.EQModModelNumber, EQP.EquipmentModelNumber.EQModDescription, EQP.EquipmentModelNumber.EQModID, 
                         TPM.TPMProcedureAvailability.TPMAvText, TPM.TPMProcdure.TPMProcLineStatus, TPM.TPMProcdure.TPMProcPriority, TPM.TPMPriority.TPMPRText, 
                         TPM.TPMProcdure.TPMProcPlantAssign
FROM            TPM.TPMProcdure LEFT OUTER JOIN
                         TPM.TPMPriority ON TPM.TPMProcdure.TPMProcPriority = TPM.TPMPriority.TPMPRID LEFT OUTER JOIN
                         TPM.TPMProcedureAvailability ON TPM.TPMProcdure.TPMProcLineStatus = TPM.TPMProcedureAvailability.TPMAvID LEFT OUTER JOIN
                         TPM.TPMFrequency ON TPM.TPMProcdure.TPMProcFreq = TPM.TPMFrequency.TPMFreqID LEFT OUTER JOIN
                         TPM.TPMType ON TPM.TPMProcdure.TPMProcType = TPM.TPMType.TPMTypeID LEFT OUTER JOIN
                         EQP.EquipmentModelNumber ON TPM.TPMProcdure.TMPProcModelLink = EQP.EquipmentModelNumber.EQModID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[9] 2[22] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TPMProcdure (TPM)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 263
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "TPMPriority (TPM)"
            Begin Extent = 
               Top = 224
               Left = 561
               Bottom = 319
               Right = 731
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TPMProcedureAvailability (TPM)"
            Begin Extent = 
               Top = 181
               Left = 559
               Bottom = 276
               Right = 729
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TPMFrequency (TPM)"
            Begin Extent = 
               Top = 7
               Left = 485
               Bottom = 254
               Right = 752
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "TPMType (TPM)"
            Begin Extent = 
               Top = 65
               Left = 375
               Bottom = 258
               Right = 615
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "EquipmentModelNumber (EQP)"
            Begin Extent = 
               Top = 126
               Left = 406
               Bottom = 356
               Right = 672
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths ' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppTPMProcedure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'= 24
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppTPMProcedure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'wAppTPM', @level1type=N'VIEW',@level1name=N'wAppTPMProcedure'
GO
/****** Object:  StoredProcedure [wAppTPM].[TPMStatsReport2]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TPMStatsReport2]

@Plant as Integer = 1 ,
@Line as Integer = 0,
@Group as Integer = 0,
@StartDate as Date = '3/1/2012',
@Days as Integer = 30

-- TPM 52 Week Closed Report for shop in percentages.

AS
DECLARE @ShowAll as Int = @Plant;
DECLARE @CW1 as Int
DECLARE @CW1Mon as Date;
DECLARE @totalwo as int;
DECLARE @closedontime as int;
DECLARE @closedoverdue as int;
DECLARE @openoverdue as int;
DECLARE @incomplete as int;
DECLARE @opengood as int;

DECLARE @CW as int
DECLARE @Mon as date;

SET @CW1 = wACom.GetCWFromDate(DateAdd(day,0,GetDate()));
SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,0,GetDate())));

DECLARE @faultTable TABLE
(
	faultCode INT

)

DECLARE @holdTable TABLE
(

	LIPlant  Int,
	PNID Int,
	PNName  nVarChar(100),
	LIID  Int,
	MLCellName  nVarChar(100),
	MLID  Int,
	MLPlantID  Int,
	LILineName  nVarChar(100),
	AAAreaname  nVarChar(100),
	AAID  Int,
	TPMProcID  Int,
	TPMProcTitle  nVarChar(100),
	TPMProcModelLink  Int,
	TPMFreqFrequency  nVarChar(100),
	DISOpenDate  Date,
	DISCloseDate  Date,
	DISDueDate  Date,
	DISType  Int,
	DISTPMNumber  Int,
	DISID  int
	
);

DECLARE @resultTable TABLE
(

	TotalWorkOrders int,
	Closed Int,
	ClosedLate Int,
	OverDue Int,
	Incomplete Int,
	CurrentlyOpen Int,
	CW INT,
	CWD Date

);

DECLARE @CWTable TABLE
(
	GSCW INTEGER,
	GSCWMonDate DATE
);

INSERT INTO @CWTable 
	SELECT TOP 52 GSCW, GSCWMonDate
	FROM TPM.GrandSchedule
	WHERE GSCWMonDate < @CW1Mon
	ORDER BY GSCWMonDate DESC

DECLARE cwTable CURSOR FAST_FORWARD FOR
	SELECT * FROM @CWTable

OPEN cwTable




WHILE @@FETCH_STATUS = 0
BEGIN
FETCH NEXT FROM cwTable INTO @CW, @Mon

INSERT INTO @holdTable SELECT * FROM wAppWorkOrder.TPMReportingViewOne WHERE DISOpenDate BETWEEN @Mon AND DateAdd(day,6,@Mon)
					AND (LIID = @Line OR AAID = @Group OR LIPlant = @showAll);


-- Count the total number of records for the calander week. Gives the percentage.
	SET @totalwo = (SELECT Count(DISID) FROM @holdtable);

-- Count the number of WO's closed during that calander week that were at or under thier due date
	SET @closedontime = (SELECT Count(DISID) FROM @holdtable WHERE
						(DISCloseDate <= DISDueDate) AND (DISCloseDate >= DISOpenDate))

-- Closed Overdue: work orders that were closed but closed past thier due date.
	SET @closedoverdue =  (SELECT Count(DISID) FROM @holdtable WHERE
					(DISCloseDate > DISDueDate))

-- Work orders from that calander week that are still open and overdue
	SET @openoverdue = 	(SELECT Count(DISID) FROM @holdtable WHERE
					DISCloseDate IS NULL
					AND	GetDate() > DISDueDate)
-- Incomplete: Work orders that were closed by the system.
	SET @incomplete = (SELECT Count(DISID) FROM @holdtable WHERE
					DISCloseDate < DISOpenDate)

--Currently Open but not overdue.
	SET @opengood = 	(SELECT Count(DISID) FROM @holdtable WHERE
					DISCLoseDate IS NULL AND GetDate() < DISDueDate)

INSERT INTO @resultTable
	(
		TotalWorkOrders,
		Closed,
		ClosedLate,
		Overdue,
		Incomplete,
		CurrentlyOpen,
		CW,
		CWD
	)
	VALUES
	(

	
		@totalwo, 
		@closedontime,
		@closedoverdue,
		@openoverdue,
		@incomplete,
		@opengood,
		@CW,
		@Mon
	


	)

	DELETE FROM @holdtable;
END
CLOSE cwTable
DEALLOCATE cwTable


SELECT * FROM (
		SELECT  TotalWorkOrders, Closed, ClosedLate, OverDue, Incomplete, CurrentlyOpen, e.GSCW, e.GSCWMonDate
		FROM @CWTable as E
		Left Outer Join (SELECT * FROM @resultTable) as D ON D.CWD = E.GSCWMonDate) t
	ORDER BY GSCWMonDate ASC



	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[ThreePageTechReport]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[ThreePageTechReport]
(
--@Line AS Integer = 1,
--@Tech as Integer = 1,
@Plant as Integer = 1 ,
@techList as nVarChar(max) = '1,2,3,4,5,6,7,8'

)

/* Fifty Two Calander Week report for the Plant Availability Graph. */
-- This is a chart by TECHNOLOGY

AS

DECLARE @CW1 as Int
DECLARE @CW1Mon as Date;
DECLARE @TechCounter as Int;

DECLARE @CW as int
DECLARE @Mon as date;

SET @CW1 = wACom.GetCWFromDate(DateAdd(day,0,GetDate()));
SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,0,GetDate())));

SET @Mon = @CW1Mon;

DECLARE @techTable TABLE
(
	tech int

)

INSERT INTO @techTable (tech) SELECT DATA FROM  wACom.Split(@techList,',');

DECLARE @finishTable TABLE
(
	tech nVarChar(255),
	cw1 int,
	cw2 int,
	cw3 int,
	cw4 int,
	cw5 int,
	cw6 int,
	cw7 int,
	cw8 int,
	cw9 int,
	cw10 int,
	cw11 int, 
	cw12 int,
	cw13 int,
	cw14 int,
	cw15 int,
	cw16 int,
	cw17 int,
	cw18 int,
	cw19 int,
	cw20 int,
	cw21 int,
	cw22 int,
	cw23 int,
	cw24 int,
	cw25 int,
	cw26 int,
	cw27 int,
	cw28 int,
	cw29 int,
	cw30 int,
	cw31 int,
	cw32 int,
	cw33 int,
	cw34 int,
	cw35 int,
	cw36 int,
	cw37 int,
	cw38 int,
	cw39 int,
	cw40 int,
	cw41 int,
	cw42 int,
	cw43 int,
	cw44 int,
	cw45 int,
	cw46 int,
	cw47 int,
	cw48 int,
	cw49 int,
	cw50 int,
	cw51 int,
	cw52 int,
	cwNum1 int,
	cwNum2 int,
	cwNum3 int,
	cwNum4 int,
	cwNum5 int,
	cwNum6 int,
	cwNum7 int,
	cwNum8 int,
	cwNum9 int,
	cwNum10 int,
	cwNum11 int, 
	cwNum12 int,
	cwNum13 int,
	cwNum14 int,
	cwNum15 int,
	cwNum16 int,
	cwNum17 int,
	cwNum18 int,
	cwNum19 int,
	cwNum20 int,
	cwNum21 int,
	cwNum22 int,
	cwNum23 int,
	cwNum24 int,
	cwNum25 int,
	cwNum26 int,
	cwNum27 int,
	cwNum28 int,
	cwNum29 int,
	cwNum30 int,
	cwNum31 int,
	cwNum32 int,
	cwNum33 int,
	cwNum34 int,
	cwNum35 int,
	cwNum36 int,
	cwNum37 int,
	cwNum38 int,
	cwNum39 int,
	cwNum40 int,
	cwNum41 int,
	cwNum42 int,
	cwNum43 int,
	cwNum44 int,
	cwNum45 int,
	cwNum46 int,
	cwNum47 int,
	cwNum48 int,
	cwNum49 int,
	cwNum50 int,
	cwNum51 int,
	cwNum52 int



)



DECLARE techCursor CURSOR FAST_FORWARD FOR
	SELECT * FROM @techTable

OPEN techCursor

WHILE @@FETCH_STATUS = 0
BEGIN
FETCH NEXT FROM techCursor INTO @techCounter


INSERT INTO @finishTable
 (
 
 	tech,
	cw1,	cw2,	cw3,	cw4,	cw5,	cw6,	cw7,	cw8,	cw9,	cw10,
	cw11,	cw12,	cw13,	cw14,	cw15,	cw16,	cw17,	cw18,	cw19,	cw20,
	cw21,	cw22,	cw23,	cw24,	cw25,	cw26,	cw27,	cw28,	cw29,	cw30,
	cw31,	cw32,	cw33,	cw34,	cw35,	cw36,	cw37,	cw38,	cw39,	cw40,
	cw41,	cw42,	cw43,	cw44,	cw45,	cw46,	cw47,	cw48,	cw49,	cw50,
	cw51,	cw52,
	cwNum1,		cwNum2,		cwNum3,		cwNum4,		cwNum5,		cwNum6,		cwNum7,		cwNum8,		cwNum9,		cwNum10,
	cwNum11,	cwNum12,	cwNum13,	cwNum14,	cwNum15,	cwNum16,	cwNum17,	cwNum18,	cwNum19,	cwNum20,
	cwNum21,	cwNum22,	cwNum23,	cwNum24,	cwNum25,	cwNum26,	cwNum27,	cwNum28,	cwNum29,	cwNum30,
	cwNum31,	cwNum32,	cwNum33,	cwNum34,	cwNum35,	cwNum36,	cwNum37,	cwNum38,	cwNum39,	cwNum40,
	cwNum41,	cwNum42,	cwNum43,	cwNum44,	cwNum45,	cwNum46,	cwNum47,	cwNum48,	cwNum49,	cwNum50,
	cwNum51,	cwNum52 
 
 )

 VALUES
 (

	(SELECT T2CodeName FROM DT.T2Code WHERE T2ID = @techCounter),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,52),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,51),

	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,50),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,49),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,48),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,47),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,46),

	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,45),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,44),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,43),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,42),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,41),
	
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,40),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,39),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,38),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,37),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,36),

	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,35),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,34),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,33),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,32),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,31),

	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,30),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,29),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,28),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,27),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,26),

	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,25),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,24),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,23),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,22),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,21),

	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,20),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,19),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,18),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,17),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,16),

	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,15),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,14),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,13),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,12),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,11),

	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,10),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,9),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,8),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,7),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,6),

	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,5),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,4),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,3),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,2),
	wAppDT.DTGetCWTechMin(@Mon,@Plant,@techCounter,1),

	wAppDT.DTGetCW(@Mon,52),
	wAppDT.DTGetCW(@Mon,51),
	wAppDT.DTGetCW(@Mon,50),

	wAppDT.DTGetCW(@Mon,49),
	wAppDT.DTGetCW(@Mon,48),
	wAppDT.DTGetCW(@Mon,47),
	wAppDT.DTGetCW(@Mon,46),

	wAppDT.DTGetCW(@Mon,45),
	wAppDT.DTGetCW(@Mon,44),
	wAppDT.DTGetCW(@Mon,43),
	wAppDT.DTGetCW(@Mon,42),

	wAppDT.DTGetCW(@Mon,41),
	wAppDT.DTGetCW(@Mon,40),
	wAppDT.DTGetCW(@Mon,39),
	wAppDT.DTGetCW(@Mon,38),

	wAppDT.DTGetCW(@Mon,37),
	wAppDT.DTGetCW(@Mon,36),
	wAppDT.DTGetCW(@Mon,35),
	wAppDT.DTGetCW(@Mon,34),

	wAppDT.DTGetCW(@Mon,33),
	wAppDT.DTGetCW(@Mon,32),
	wAppDT.DTGetCW(@Mon,31),
	wAppDT.DTGetCW(@Mon,30),

	wAppDT.DTGetCW(@Mon,29),
	wAppDT.DTGetCW(@Mon,28),
	wAppDT.DTGetCW(@Mon,27),
	wAppDT.DTGetCW(@Mon,26),

	wAppDT.DTGetCW(@Mon,25),
	wAppDT.DTGetCW(@Mon,24),
	wAppDT.DTGetCW(@Mon,23),
	wAppDT.DTGetCW(@Mon,22),

	wAppDT.DTGetCW(@Mon,21),
	wAppDT.DTGetCW(@Mon,20),
	wAppDT.DTGetCW(@Mon,19),
	wAppDT.DTGetCW(@Mon,18),

	wAppDT.DTGetCW(@Mon,17),
	wAppDT.DTGetCW(@Mon,16),
	wAppDT.DTGetCW(@Mon,15),
	wAppDT.DTGetCW(@Mon,14),

	wAppDT.DTGetCW(@Mon,13),
	wAppDT.DTGetCW(@Mon,12),
	wAppDT.DTGetCW(@Mon,11),
	wAppDT.DTGetCW(@Mon,10),
	
	wAppDT.DTGetCW(@Mon,9),
	wAppDT.DTGetCW(@Mon,8),
	wAppDT.DTGetCW(@Mon,7),
	wAppDT.DTGetCW(@Mon,6),
	wAppDT.DTGetCW(@Mon,5),

	wAppDT.DTGetCW(@Mon,4),
	wAppDT.DTGetCW(@Mon,3),
	wAppDT.DTGetCW(@Mon,2),
	wAppDT.DTGetCW(@Mon,1)


 )
 
 
END

CLOSE techCursor

DEALLOCATE techCursor


SELECT * FROM @finishTable



	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[TaskUsageFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[TaskUsageFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT * FROM wAppTPM.TaskUsageView
	ORDER BY TPMProcID

	RETURN
GO
/****** Object:  StoredProcedure [wAppDT].[StatsReportThree]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDT].[StatsReportThree]


@Plant as Integer = 1 ,
@Line as Integer = 0,
@Group as Integer = 0,
@StartDate as Date = '3/1/2012',
@Days as Integer = 30,
@ARG as Integer = 0

-- TPM 52 Week Closed Report for shop in percentages.

AS
DECLARE @ShowAll as Int = @Plant;
DECLARE @CW1 as Int
DECLARE @CW1Mon as Date;
DECLARE @totalwo as int;
DECLARE @closedontime as int;
DECLARE @closedoverdue as int;
DECLARE @openoverdue as int;
DECLARE @incomplete as int;
DECLARE @opengood as int;

DECLARE @CW as int
DECLARE @Mon as date;

SET @CW1 = wACom.GetCWFromDate(DateAdd(day,0,GetDate()));
SET @CW1Mon = wACom.GetCWMonDate(@CW1,DatePart(year,DateAdd(day,0,GetDate())));

DECLARE @faultTable TABLE
(
	faultCode INT

)

DECLARE @holdTable TABLE
(

	LIPlant  Int,
	PNID Int,
	PNName  nVarChar(100),
	LIID  Int,
	MLCellName  nVarChar(100),
	MLID  Int,
	MLPlantID  Int,
	LILineName  nVarChar(100),
	AAAreaname  nVarChar(100),
	AAID  Int,
	TPMProcID  Int,
	TPMProcTitle  nVarChar(100),
	TPMProcModelLink  Int,
	TPMFreqFrequency  nVarChar(100),
	DISOpenDate  Date,
	DISCloseDate  Date,
	DISDueDate  Date,
	DISType  Int,
	DISTPMNumber  Int,
	DISID  int
	
);

DECLARE @resultTable TABLE
(

	TotalWorkOrders int,
	Closed Int,
	CW INT,
	CWD Date

);

DECLARE @CWTable TABLE
(
	GSCW INTEGER,
	GSCWMonDate DATE
);

INSERT INTO @CWTable 
	SELECT TOP 52 GSCW, GSCWMonDate
	FROM TPM.GrandSchedule
	WHERE GSCWMonDate < @CW1Mon
	ORDER BY GSCWMonDate DESC

DECLARE cwTable CURSOR FAST_FORWARD FOR
	SELECT * FROM @CWTable

OPEN cwTable




WHILE @@FETCH_STATUS = 0
BEGIN
FETCH NEXT FROM cwTable INTO @CW, @Mon


--(Disclosedate is null) or 
-- original version from Paul 08/21/2012
--INSERT INTO @holdTable SELECT * FROM wAppWorkOrder.TPMReportingViewOne WHERE (DISOpenDate < DateAdd(day,7,@Mon)) AND (DISCloseDate > DateAdd(day, -1, @Mon))
--					AND (MLID = @ARG OR LIID = @Line OR AAID = @Group OR LIPlant = @showAll);

INSERT INTO @holdTable SELECT * FROM wAppWorkOrder.TPMReportingViewOne WHERE (DISOpenDate < DateAdd(day,7,@Mon)) AND ((Disclosedate is null) or (DISCloseDate > DateAdd(day, -1, @Mon)))
					AND (MLID = @ARG OR LIID = @Line OR AAID = @Group OR LIPlant = @showAll);


-- Count the total number of records for the calander week. Gives the percentage.
	SET @totalwo = (SELECT Count(DISID) FROM @holdtable);

-- Count the number of WO's closed during that calander week that were at or under thier due date
	SET @closedontime = (SELECT Count(DISID) FROM @holdtable WHERE DISCloseDate BETWEEN @Mon AND DateAdd(day,6,@Mon))




INSERT INTO @resultTable
	(
		TotalWorkOrders,
		Closed,
		CW,
		CWD
	)
	VALUES
	(

	
		@totalwo, 
		@closedontime,
		@CW,
		@Mon
	


	)

	DELETE FROM @holdtable;
END

CLOSE cwTable
DEALLOCATE cwTable


SELECT * FROM (
		SELECT  TotalWorkOrders, Closed,  e.GSCW, e.GSCWMonDate
		FROM @CWTable as E
		Left Outer Join (SELECT * FROM @resultTable) as D ON D.CWD = E.GSCWMonDate) t
	ORDER BY GSCWMonDate ASC



	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[ProcedureFetchFiltered]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[ProcedureFetchFiltered]
@ProcNumber as Integer
AS

	DECLARE @holdString nVarChar(max);

	Select * INTO #aTempTable FROM wAppTPM.wAppTPMProcedure
	WHERE TPMProcID = @ProcNumber
	ORDER BY TPMProcID

	SET @holdString = (SELECT TOP 1 TPMProcProcedure FROM #aTempTable);

	SET @holdString = @holdString + wAppTPM.RetrieveProcString(@ProcNumber) + wAppTPM.RetrievePartsString(@ProcNumber);

	UPDATE #aTempTable SET TPMProcProcedure = @holdString;

	SELECT * FROM  #aTempTable

	RETURN
GO
/****** Object:  StoredProcedure [wAppTPM].[ProcedureFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppTPM].[ProcedureFetch]
	
	(
		@plant int = 0
	)
	
AS

	if @plant > 1
		BEGIN
			Select * FROM wAppTPM.wAppTPMProcedure
			WHERE TPMProcPlantAssign  = @plant
			ORDER BY TPMProcID
		END
	ELSE
		BEGIN
			Select * FROM wAppTPM.wAppTPMProcedure
			ORDER BY TPMProcID
		END

	RETURN
GO
/****** Object:  StoredProcedure [wAppDoc].[DocListFetch]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [wAppDoc].[DocListFetch]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	
	SELECT * FROM wAppDoc.AssyDocView


	RETURN
GO
/****** Object:  StoredProcedure [TPM].[CloseIncompleteWO]    Script Date: 10/26/2012 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [TPM].[CloseIncompleteWO]

AS
	
	SELECT  * FROM TPM.closeIncompleteWorkOrderView

	WHERE (GetDate() > DateAdd(Day, TPMFreqPeriod,DISOpenDate)) AND DISCloseDate IS NULL


	RETURN
GO
/****** Object:  Default [DF_ProcNumbers_PROCACTIVE]    Script Date: 10/26/2012 10:34:59 ******/
ALTER TABLE [EQP].[ProcNumbers] ADD  CONSTRAINT [DF_ProcNumbers_PROCACTIVE]  DEFAULT ((1)) FOR [PROCACTIVE]
GO
/****** Object:  Default [DF_ProcNumbers_PROCASSETASSIGNABLE]    Script Date: 10/26/2012 10:34:59 ******/
ALTER TABLE [EQP].[ProcNumbers] ADD  CONSTRAINT [DF_ProcNumbers_PROCASSETASSIGNABLE]  DEFAULT ((0)) FOR [PROCASSETASSIGNABLE]
GO
/****** Object:  Default [DF_DTMainTable_DTMinutes]    Script Date: 10/26/2012 10:34:59 ******/
ALTER TABLE [DT].[DTMainTable] ADD  CONSTRAINT [DF_DTMainTable_DTMinutes]  DEFAULT ((0)) FOR [DTMinutes]
GO
/****** Object:  Default [DF_Areas_AAActive]    Script Date: 10/26/2012 10:34:59 ******/
ALTER TABLE [wACom].[Areas] ADD  CONSTRAINT [DF_Areas_AAActive]  DEFAULT ((1)) FOR [AAActive]
GO
/****** Object:  Default [DF_Lines_LIActive]    Script Date: 10/26/2012 10:34:59 ******/
ALTER TABLE [wACom].[Lines] ADD  CONSTRAINT [DF_Lines_LIActive]  DEFAULT ((1)) FOR [LIActive]
GO
/****** Object:  Default [DF_MachineList_MLActive]    Script Date: 10/26/2012 10:34:59 ******/
ALTER TABLE [wACom].[MachineList] ADD  CONSTRAINT [DF_MachineList_MLActive]  DEFAULT ((1)) FOR [MLActive]
GO
/****** Object:  Default [DF_teammembers_TMWorkAssignment]    Script Date: 10/26/2012 10:34:59 ******/
ALTER TABLE [Team].[teammembers] ADD  CONSTRAINT [DF_teammembers_TMWorkAssignment]  DEFAULT ((0)) FOR [TMWorkAssignment]
GO
/****** Object:  Default [DF_teammembers_TMTeamLink]    Script Date: 10/26/2012 10:34:59 ******/
ALTER TABLE [Team].[teammembers] ADD  CONSTRAINT [DF_teammembers_TMTeamLink]  DEFAULT ((0)) FOR [TMTeamLink]
GO
/****** Object:  Default [DF_teammembers_TMTitleLink]    Script Date: 10/26/2012 10:34:59 ******/
ALTER TABLE [Team].[teammembers] ADD  CONSTRAINT [DF_teammembers_TMTitleLink]  DEFAULT ((1)) FOR [TMTitleLink]
GO
/****** Object:  Default [DF_TPMTaskList_TPMTLNumTM]    Script Date: 10/26/2012 10:35:02 ******/
ALTER TABLE [TPM].[TPMTaskList] ADD  CONSTRAINT [DF_TPMTaskList_TPMTLNumTM]  DEFAULT ((0)) FOR [TPMTLNumTM]
GO
/****** Object:  Default [DF_TPMTaskList_TPMTLMin]    Script Date: 10/26/2012 10:35:02 ******/
ALTER TABLE [TPM].[TPMTaskList] ADD  CONSTRAINT [DF_TPMTaskList_TPMTLMin]  DEFAULT ((0)) FOR [TPMTLMin]
GO
/****** Object:  Default [DF_NOvertimeHours_OTHMon1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[NOvertimeHours] ADD  CONSTRAINT [DF_NOvertimeHours_OTHMon1Reg]  DEFAULT ((0)) FOR [OTHMon1Reg]
GO
/****** Object:  Default [DF_NOvertimeHours_OTHTue1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[NOvertimeHours] ADD  CONSTRAINT [DF_NOvertimeHours_OTHTue1Reg]  DEFAULT ((0)) FOR [OTHTue1Reg]
GO
/****** Object:  Default [DF_NOvertimeHours_OTHWed1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[NOvertimeHours] ADD  CONSTRAINT [DF_NOvertimeHours_OTHWed1Reg]  DEFAULT ((0)) FOR [OTHWed1Reg]
GO
/****** Object:  Default [DF_NOvertimeHours_OTHThu1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[NOvertimeHours] ADD  CONSTRAINT [DF_NOvertimeHours_OTHThu1Reg]  DEFAULT ((0)) FOR [OTHThu1Reg]
GO
/****** Object:  Default [DF_NOvertimeHours_OTHFri1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[NOvertimeHours] ADD  CONSTRAINT [DF_NOvertimeHours_OTHFri1Reg]  DEFAULT ((0)) FOR [OTHFri1Reg]
GO
/****** Object:  Default [DF_NOvertimeHours_OTHSat1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[NOvertimeHours] ADD  CONSTRAINT [DF_NOvertimeHours_OTHSat1Reg]  DEFAULT ((0)) FOR [OTHSat1Reg]
GO
/****** Object:  Default [DF_NOvertimeHours_OTHSun1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[NOvertimeHours] ADD  CONSTRAINT [DF_NOvertimeHours_OTHSun1Reg]  DEFAULT ((0)) FOR [OTHSun1Reg]
GO
/****** Object:  Default [DF_EquipmentModelNumber_EQModGroupLink]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[EquipmentModelNumber] ADD  CONSTRAINT [DF_EquipmentModelNumber_EQModGroupLink]  DEFAULT ((0)) FOR [EQModGroupLink]
GO
/****** Object:  Default [DF_EquipmentModelNumber_EQModGroupTier]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[EquipmentModelNumber] ADD  CONSTRAINT [DF_EquipmentModelNumber_EQModGroupTier]  DEFAULT ((0)) FOR [EQModGroupTier]
GO
/****** Object:  Default [DF_EquipmentModelNumber_EQAddressable]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[EquipmentModelNumber] ADD  CONSTRAINT [DF_EquipmentModelNumber_EQAddressable]  DEFAULT ((0)) FOR [EQAddressable]
GO
/****** Object:  Default [DF_AccessTable_ATOvertimeEdit]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [SEC].[AccessTable] ADD  CONSTRAINT [DF_AccessTable_ATOvertimeEdit]  DEFAULT ((0)) FOR [ATOvertimeEdit]
GO
/****** Object:  Default [DF_AccessTable_ATDocEdit]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [SEC].[AccessTable] ADD  CONSTRAINT [DF_AccessTable_ATDocEdit]  DEFAULT ((0)) FOR [ATDocEdit]
GO
/****** Object:  Default [DF_AccessTable_wABeta]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [SEC].[AccessTable] ADD  CONSTRAINT [DF_AccessTable_wABeta]  DEFAULT ((0)) FOR [wABeta]
GO
/****** Object:  Default [DF_AccessTable_waWeld_Menu]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [SEC].[AccessTable] ADD  CONSTRAINT [DF_AccessTable_waWeld_Menu]  DEFAULT ((0)) FOR [waWeld_Menu]
GO
/****** Object:  Default [DF_AccessTable_waWeld_Edit]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [SEC].[AccessTable] ADD  CONSTRAINT [DF_AccessTable_waWeld_Edit]  DEFAULT ((0)) FOR [waWeld_Edit]
GO
/****** Object:  Default [DF_AccessTable_waWeld_Supervisor]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [SEC].[AccessTable] ADD  CONSTRAINT [DF_AccessTable_waWeld_Supervisor]  DEFAULT ((0)) FOR [waWeld_Supervisor]
GO
/****** Object:  Default [DF_TeamAssignments_ASGLeaderGroup]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[TeamAssignments] ADD  CONSTRAINT [DF_TeamAssignments_ASGLeaderGroup]  DEFAULT ((0)) FOR [ASGLeaderGroup]
GO
/****** Object:  Default [DF_TeamAssignments_ASGDeptLink]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[TeamAssignments] ADD  CONSTRAINT [DF_TeamAssignments_ASGDeptLink]  DEFAULT ((0)) FOR [ASGDeptLink]
GO
/****** Object:  Default [DF_WeldTable_SIDTearDownGroup]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Weld].[WeldTable] ADD  CONSTRAINT [DF_WeldTable_SIDTearDownGroup]  DEFAULT ((0)) FOR [SIDTearDownGroup]
GO
/****** Object:  Default [DF_SpotID_SIDProgramNumber]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[SpotID] ADD  CONSTRAINT [DF_SpotID_SIDProgramNumber]  DEFAULT ((0)) FOR [SIDProgramNumber]
GO
/****** Object:  Default [DF_SpotID_SIDRobotCallNumber]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[SpotID] ADD  CONSTRAINT [DF_SpotID_SIDRobotCallNumber]  DEFAULT ('') FOR [SIDRobotCallNumber]
GO
/****** Object:  Default [DF_SpotID_SIDWeldIDNumber]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[SpotID] ADD  CONSTRAINT [DF_SpotID_SIDWeldIDNumber]  DEFAULT ('') FOR [SIDWeldIDNumber]
GO
/****** Object:  Default [DF_SpotID_SIDTimerLink]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[SpotID] ADD  CONSTRAINT [DF_SpotID_SIDTimerLink]  DEFAULT ((0)) FOR [SIDTimerLink]
GO
/****** Object:  Default [DF_SpotID_SIDRobotLink]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[SpotID] ADD  CONSTRAINT [DF_SpotID_SIDRobotLink]  DEFAULT ((0)) FOR [SIDRobotLink]
GO
/****** Object:  Default [DF_SpotID_SIDWeldGunType]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[SpotID] ADD  CONSTRAINT [DF_SpotID_SIDWeldGunType]  DEFAULT ((0)) FOR [SIDWeldGunType]
GO
/****** Object:  Default [DF_SpotID_SIDMatOneLink]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[SpotID] ADD  CONSTRAINT [DF_SpotID_SIDMatOneLink]  DEFAULT ((0)) FOR [SIDMatOneLink]
GO
/****** Object:  Default [DF_SpotID_SIDMatTwoLink]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[SpotID] ADD  CONSTRAINT [DF_SpotID_SIDMatTwoLink]  DEFAULT ((0)) FOR [SIDMatTwoLink]
GO
/****** Object:  Default [DF_SpotID_SIDMatThreeLink]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[SpotID] ADD  CONSTRAINT [DF_SpotID_SIDMatThreeLink]  DEFAULT ((0)) FOR [SIDMatThreeLink]
GO
/****** Object:  Default [DF_SpotID_SIDMatFourLink]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[SpotID] ADD  CONSTRAINT [DF_SpotID_SIDMatFourLink]  DEFAULT ((0)) FOR [SIDMatFourLink]
GO
/****** Object:  Default [DF_SpotID_SIDWeldGunTypeLink]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[SpotID] ADD  CONSTRAINT [DF_SpotID_SIDWeldGunTypeLink]  DEFAULT ((0)) FOR [SIDWeldGunTypeLink]
GO
/****** Object:  Default [DF_ResistanceWeldErrorLog_RWELProgramedValue]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Weld].[ResistanceWeldErrorLog] ADD  CONSTRAINT [DF_ResistanceWeldErrorLog_RWELProgramedValue]  DEFAULT ((0)) FOR [RWELProgramedValue]
GO
/****** Object:  Default [DF_ResistanceWeldErrorLog_RWELActualValue]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Weld].[ResistanceWeldErrorLog] ADD  CONSTRAINT [DF_ResistanceWeldErrorLog_RWELActualValue]  DEFAULT ((0)) FOR [RWELActualValue]
GO
/****** Object:  Default [DF_ResistanceWeldErrorLog_RWELProgrammedTime]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Weld].[ResistanceWeldErrorLog] ADD  CONSTRAINT [DF_ResistanceWeldErrorLog_RWELProgrammedTime]  DEFAULT ((0)) FOR [RWELProgrammedTime]
GO
/****** Object:  Default [DF_ResistanceWeldErrorLog_RWELActualTime]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Weld].[ResistanceWeldErrorLog] ADD  CONSTRAINT [DF_ResistanceWeldErrorLog_RWELActualTime]  DEFAULT ((0)) FOR [RWELActualTime]
GO
/****** Object:  Default [DF_ResistanceWeldErrorLog_RWELWear]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Weld].[ResistanceWeldErrorLog] ADD  CONSTRAINT [DF_ResistanceWeldErrorLog_RWELWear]  DEFAULT ((0)) FOR [RWELWear]
GO
/****** Object:  Default [DF_OvertimeHours_OTHMon1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHMon1Reg]  DEFAULT ((0)) FOR [OTHMon1Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHTue1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHTue1Reg]  DEFAULT ((0)) FOR [OTHTue1Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHWed1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHWed1Reg]  DEFAULT ((0)) FOR [OTHWed1Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHThu1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHThu1Reg]  DEFAULT ((0)) FOR [OTHThu1Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHFri1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHFri1Reg]  DEFAULT ((0)) FOR [OTHFri1Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHSat1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHSat1Reg]  DEFAULT ((0)) FOR [OTHSat1Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHSun1Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHSun1Reg]  DEFAULT ((0)) FOR [OTHSun1Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHMon2Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHMon2Reg]  DEFAULT ((0)) FOR [OTHMon2Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHTue2Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHTue2Reg]  DEFAULT ((0)) FOR [OTHTue2Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHWed2Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHWed2Reg]  DEFAULT ((0)) FOR [OTHWed2Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHThu2Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHThu2Reg]  DEFAULT ((0)) FOR [OTHThu2Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHFri2Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHFri2Reg]  DEFAULT ((0)) FOR [OTHFri2Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHSat2Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHSat2Reg]  DEFAULT ((0)) FOR [OTHSat2Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTHSun2Reg]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTHSun2Reg]  DEFAULT ((0)) FOR [OTHSun2Reg]
GO
/****** Object:  Default [DF_OvertimeHours_OTSat1vol]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTSat1vol]  DEFAULT ((0)) FOR [OTSat1vol]
GO
/****** Object:  Default [DF_OvertimeHours_OTSun1vol]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTSun1vol]  DEFAULT ((0)) FOR [OTSun1vol]
GO
/****** Object:  Default [DF_OvertimeHours_OTSat2vol]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTSat2vol]  DEFAULT ((0)) FOR [OTSat2vol]
GO
/****** Object:  Default [DF_OvertimeHours_OTSun2vol]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [Team].[OvertimeHours] ADD  CONSTRAINT [DF_OvertimeHours_OTSun2vol]  DEFAULT ((0)) FOR [OTSun2vol]
GO
/****** Object:  Default [DF_ModelGroupOne_MGOneActive]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[ModelGroupOne] ADD  CONSTRAINT [DF_ModelGroupOne_MGOneActive]  DEFAULT ((1)) FOR [MGOneActive]
GO
/****** Object:  Default [DF_ModelGroupThree_MGThreeActive]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[ModelGroupThree] ADD  CONSTRAINT [DF_ModelGroupThree_MGThreeActive]  DEFAULT ((1)) FOR [MGThreeActive]
GO
/****** Object:  Default [DF_ModelGroupTwo_MGTwoActive]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[ModelGroupTwo] ADD  CONSTRAINT [DF_ModelGroupTwo_MGTwoActive]  DEFAULT ((1)) FOR [MGTwoActive]
GO
/****** Object:  Default [DF_AssetAssignmentHistory_AAHAssetID]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [EQP].[AssetAssignmentHistory] ADD  CONSTRAINT [DF_AssetAssignmentHistory_AAHAssetID]  DEFAULT ((0)) FOR [AAHAssetID]
GO
/****** Object:  Default [DF__dtpropert__versi__6B24EA82]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [dbo].[dtproperties] ADD  DEFAULT ((0)) FOR [version]
GO
/****** Object:  ForeignKey [FK_T2Code_T1Code]    Script Date: 10/26/2012 10:34:59 ******/
ALTER TABLE [DT].[T2Code]  WITH CHECK ADD  CONSTRAINT [FK_T2Code_T1Code] FOREIGN KEY([T2T1CodeLink])
REFERENCES [DT].[T1Code] ([T1ID])
GO
ALTER TABLE [DT].[T2Code] CHECK CONSTRAINT [FK_T2Code_T1Code]
GO
/****** Object:  ForeignKey [FK_AccessTable_teammembers]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [SEC].[AccessTable]  WITH CHECK ADD  CONSTRAINT [FK_AccessTable_teammembers] FOREIGN KEY([ATUID])
REFERENCES [Team].[teammembers] ([TMID])
GO
ALTER TABLE [SEC].[AccessTable] CHECK CONSTRAINT [FK_AccessTable_teammembers]
GO
/****** Object:  ForeignKey [FK_TPMType_TPMType]    Script Date: 10/26/2012 10:35:03 ******/
ALTER TABLE [TPM].[TPMType]  WITH CHECK ADD  CONSTRAINT [FK_TPMType_TPMType] FOREIGN KEY([TPMTypeID])
REFERENCES [TPM].[TPMType] ([TPMTypeID])
GO
ALTER TABLE [TPM].[TPMType] CHECK CONSTRAINT [FK_TPMType_TPMType]
GO
