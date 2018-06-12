USE [master]
GO

--:setvar DatabaseName "crmdb"
:setvar __IsSqlCmdEnabled "True"
GO

IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END
GO

/* Drop DB if exists */
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'$(DatabaseName)') BEGIN
  ALTER DATABASE [$(DatabaseName)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
  DROP DATABASE [$(DatabaseName)]
END
GO

/* Create new DB */

CREATE DATABASE [$(DatabaseName)]
GO
ALTER DATABASE [$(DatabaseName)] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [$(DatabaseName)].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [$(DatabaseName)] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET ARITHABORT OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [$(DatabaseName)] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [$(DatabaseName)] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET  DISABLE_BROKER 
GO
ALTER DATABASE [$(DatabaseName)] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [$(DatabaseName)] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET RECOVERY FULL 
GO
ALTER DATABASE [$(DatabaseName)] SET  MULTI_USER 
GO
ALTER DATABASE [$(DatabaseName)] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [$(DatabaseName)] SET DB_CHAINING OFF 
GO
ALTER DATABASE [$(DatabaseName)] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [$(DatabaseName)] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

USE [$(DatabaseName)]
GO

/****** Object:  Table [dbo].[AssigneHistoryItem]    Script Date: 19.02.2018 10:13:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssigneHistoryItem](
	[Id] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[LeadId] [int] NOT NULL,
	[OperationDate] [datetime] NOT NULL,
	[IsAssigned] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AvailableCategories]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AvailableCategories](
	[Id] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lead]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lead](
	[Id] [int] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[TypeId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[SourceId] [int] NOT NULL,
	[AssignedEmployeeId] [int] NULL,
	[LanguageId] [int] NOT NULL,
	[CallbackDate] [datetime] NULL,
	[RejectionReasonId] [int] NULL,
	[RejectionDate] [datetime] NULL,
	[StatusId] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL,
	[WorkStatusId] [int] NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadCategory]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadCategory](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadPackage]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadPackage](
	[Id] [int] NOT NULL,
	[PackageId] [int] NOT NULL,
	[LeadId] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadSource]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadSource](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadStatus]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadStatus](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadType]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadType](
	[Id] [int] NOT NULL,
	[Type] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadWorkStatus]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadWorkStatus](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[Id] [int] NOT NULL,
	[LeadId] [int] NOT NULL,
	[ContactTypeId] [int] NOT NULL,
	[ContactPerson] [nvarchar](200) NOT NULL,
	[ContactData] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactHistoryItem]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactHistoryItem](
	[Id] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[ContactId] [int] NOT NULL,
	[Context] [nvarchar](max) NOT NULL,
	[ContactDate] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactType]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactType](
	[Id] [int] NOT NULL,
	[Type] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Surname] [nvarchar](max) NOT NULL,
	[PositionId] [int] NOT NULL,
	[Login] [nvarchar](max) NOT NULL,
	[Password] [varchar](40) NOT NULL,
	[ChefId] [int] NULL,
	[Online] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeKPI]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeKPI](
	[Id] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[KPIId] [int] NOT NULL,
	[ActualValue] [decimal](18, 0) NULL,
	[PlannedValue] [decimal](18, 0) NULL) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeePosition]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeePosition](
	[Id] [int] NOT NULL,
	[Position] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Internet]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Internet](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KeyPerformanceIndicator]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KeyPerformanceIndicator](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Measure] [nvarchar](50) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Language]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CultureName] [nvarchar](50) NOT NULL,
	[DisplayName] [nvarchar](max) NOT NULL,
	[CultureCode] [int] NOT NULL,
	[Iso639Code] [nvarchar](3) NULL,
	[Enabled] [bit] NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Package]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Package](
	[Id] [int] NOT NULL,
	[InternetId] [int] NOT NULL,
	[TelevisionId] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RejectionReason]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RejectionReason](
	[Id] [int] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Television]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Television](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnavailabilityCalendar]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnavailabilityCalendar](
	[Id] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[ImportedFromInstance] [nvarchar](max) NOT NULL,
	[Approved] [bit] NULL,
	[ApprovedDate] [datetime] NULL,
	[ApprovedBy] [int] NULL) ON [PRIMARY]
GO

/* Procedures */

CREATE PROCEDURE [dbo].[InitHardcodedLanguages] 
	@currentInstanceName nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @TEMPLATE NVARCHAR(MAX)
	DECLARE @SQL_SCRIPT NVARCHAR(MAX)
	SET @TEMPLATE = N'
	SET IDENTITY_INSERT [{DBNAME}].[dbo].[Language] ON 
     INSERT [{DBNAME}].[dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (1, N''en-GB'', N''English'', 2057, N''ENG'', 0)
     INSERT [{DBNAME}].[dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (2, N''en-US'', N''English'', 1033, N''ENU'', 1)
     INSERT [{DBNAME}].[dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (3, N''fr-FR'', N''French'', 1036, N''FRA'', 1)
     INSERT [{DBNAME}].[dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (4, N''de-DE'', N''German'', 1031, NULL, 0)
     INSERT [{DBNAME}].[dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (5, N''lv-LV'', N''Latvian'', 1062, N''LVI'', 0)
     INSERT [{DBNAME}].[dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (6, N''lt-LT'', N''Lithuanian'', 1063, N''LTH'', 0)
     INSERT [{DBNAME}].[dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (7, N''ru-RU'', N''Russian'', 1049, N''RUS'', 0)
     INSERT [{DBNAME}].[dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (8, N''es-ES'', N''Spanish'', 3082, NULL, 0)
     SET IDENTITY_INSERT [{DBNAME}].[dbo].[Language] OFF
	'
	SET @SQL_SCRIPT = REPLACE(@TEMPLATE, '{DBNAME}', @currentInstanceName)
	EXECUTE (@SQL_SCRIPT)
END
GO

CREATE PROCEDURE [dbo].[StoreDataFromAntoherInstance] 
	@currentInstanceName nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @TEMPLATE NVARCHAR(MAX)
	DECLARE @SQL_SCRIPT NVARCHAR(MAX)
	SET @TEMPLATE = N'
	INSERT INTO [{WAREHOUSE}].[dbo].[AssigneHistoryItem]
	([Id],[EmployeeId],[LeadId],[OperationDate],[IsAssigned],[Deleted],[ImportedFromInstance])
	SELECT [Id],[EmployeeId],[LeadId],[OperationDate],[IsAssigned],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[AssigneHistoryItem]

	INSERT INTO [{WAREHOUSE}].[dbo].[AvailableCategories]
	([Id],[EmployeeId],[CategoryId],[Deleted],[ImportedFromInstance])
	SELECT [Id],[EmployeeId],[CategoryId],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[AvailableCategories]

	INSERT INTO [{WAREHOUSE}].[dbo].[Contact]
	([Id],[LeadId],[ContactTypeId],[ContactPerson],[ContactData],[Deleted],[ImportedFromInstance])
	SELECT [Id],[LeadId],[ContactTypeId],[ContactPerson],[ContactData],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[Contact]

	INSERT INTO [{WAREHOUSE}].[dbo].[ContactHistoryItem]
	([Id],[EmployeeId],[ContactId],[Context],[ContactDate],[Deleted],[ImportedFromInstance])
	SELECT [Id],[EmployeeId],[ContactId],[Context],[ContactDate],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[ContactHistoryItem]

	INSERT INTO [{WAREHOUSE}].[dbo].[ContactType]
	([Id],[Type],[Deleted],[ImportedFromInstance])
	SELECT [Id],[Type],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[ContactType]

	INSERT INTO [{WAREHOUSE}].[dbo].[Employee]
	([Id],[Name],[Surname],[PositionId],[Login],[Password],[ChefId],[Online],[Deleted],[ImportedFromInstance])
	SELECT [Id],[Name],[Surname],[PositionId],[Login],[Password],[ChefId],[Online],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[Employee]

	INSERT INTO [{WAREHOUSE}].[dbo].[EmployeePosition]
	([Id],[Position],[Deleted],[ImportedFromInstance])
	SELECT [Id],[Position],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[EmployeePosition]

	INSERT INTO [{WAREHOUSE}].[dbo].[Internet]
	([Id],[Name],[Deleted],[ImportedFromInstance])
	SELECT [Id],[Name],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[Internet]

	INSERT INTO [{WAREHOUSE}].[dbo].[KeyPerformanceIndicator]
	([Id],[Name],[Measure],[Deleted],[ImportedFromInstance])
	SELECT [Id],[Name],[Measure],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[KeyPerformanceIndicator]

	INSERT INTO [{WAREHOUSE}].[dbo].[Lead]
	([Id],[Title],[CreationDate],[TypeId],[CategoryId],[SourceId],[AssignedEmployeeId],[LanguageId],[CallbackDate],[RejectionReasonId],[RejectionDate],[StatusId],[Deleted],[ImportedFromInstance],[WorkStatusId])
	SELECT [Id],[Title],[CreationDate],[TypeId],[CategoryId],[SourceId],[AssignedEmployeeId],[LanguageId],[CallbackDate],[RejectionReasonId],[RejectionDate],[StatusId],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance],[WorkStatusId]
	FROM [{DBNAME}].[dbo].[Lead]

	INSERT INTO [{WAREHOUSE}].[dbo].[LeadCategory]
	([Id],[Name],[Deleted],[ImportedFromInstance])
	SELECT [Id],[Name],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[LeadCategory]

	INSERT INTO [{WAREHOUSE}].[dbo].[LeadPackage]
	([Id],[PackageId],[LeadId],[Deleted],[ImportedFromInstance])
	SELECT [Id],[PackageId],[LeadId],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[LeadPackage]

	INSERT INTO [{WAREHOUSE}].[dbo].[LeadSource]
	([Id],[Name],[Deleted],[ImportedFromInstance])
	SELECT [Id],[Name],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[LeadSource]

	INSERT INTO [{WAREHOUSE}].[dbo].[LeadStatus]
	([Id],[Name],[Deleted],[ImportedFromInstance])
	SELECT [Id],[Name],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[LeadStatus]

	INSERT INTO [{WAREHOUSE}].[dbo].[LeadType]
	([Id],[Type],[Deleted],[ImportedFromInstance])
	SELECT [Id],[Type],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[LeadType]

	INSERT INTO [{WAREHOUSE}].[dbo].[LeadWorkStatus]
	([Id],[Name],[Deleted],[ImportedFromInstance])
	SELECT [Id],[Name],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[LeadWorkStatus]

	INSERT INTO [{WAREHOUSE}].[dbo].[Package]
	([Id],[InternetId],[TelevisionId],[Deleted],[ImportedFromInstance])
	SELECT [Id],[InternetId],[TelevisionId],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[Package]

	INSERT INTO [{WAREHOUSE}].[dbo].[RejectionReason]
	([Id],[Title],[Deleted],[ImportedFromInstance])
	SELECT [Id],[Title],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[RejectionReason]

	INSERT INTO [{WAREHOUSE}].[dbo].[Television]
	([Id],[Name],[Deleted],[ImportedFromInstance])
	SELECT [Id],[Name],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance]
	FROM [{DBNAME}].[dbo].[Television]

	INSERT INTO [{WAREHOUSE}].[dbo].[UnavailabilityCalendar]
	([Id],[EmployeeId],[StartDate],[EndDate],[Deleted],[ImportedFromInstance],[Approved],[ApprovedDate],[ApprovedBy])
	SELECT [Id],[EmployeeId],[StartDate],[EndDate],[Deleted],N''{DBNAME}'' AS [ImportedFromInstance],[Approved],[ApprovedDate],[ApprovedBy]
	FROM [{DBNAME}].[dbo].[UnavailabilityCalendar]
	'
	SET @SQL_SCRIPT = REPLACE(@TEMPLATE, '{DBNAME}', @currentInstanceName)
	SET @SQL_SCRIPT = REPLACE(@SQL_SCRIPT, '{WAREHOUSE}', (SELECT TOP 1 TABLE_CATALOG FROM INFORMATION_SCHEMA.COLUMNS))
	EXECUTE (@SQL_SCRIPT)
END
GO

USE [master]
GO
ALTER DATABASE [$(DatabaseName)] SET  READ_WRITE 
GO

USE [$(DatabaseName)]
GO

EXEC [dbo].[InitHardcodedLanguages] @currentInstanceName = N'$(DatabaseName)'
GO

CREATE VIEW [dbo].[LeadsView]
AS
SELECT        l.Title AS ClientTitle, lc.Name AS Category, ls.Name AS Source, ls2.Name AS Status, l2.DisplayName AS Language, lt.Type
FROM            dbo.Lead AS l INNER JOIN
                         dbo.LeadCategory AS lc ON l.CategoryId = lc.Id AND l.ImportedFromInstance = lc.ImportedFromInstance INNER JOIN
                         dbo.LeadSource AS ls ON l.SourceId = ls.Id AND l.ImportedFromInstance = ls.ImportedFromInstance INNER JOIN
                         dbo.LeadStatus AS ls2 ON l.StatusId = ls2.Id AND l.ImportedFromInstance = ls2.ImportedFromInstance INNER JOIN
                         dbo.Language AS l2 ON l.LanguageId = l2.Id INNER JOIN
                         dbo.LeadType AS lt ON l.TypeId = lt.Id AND l.ImportedFromInstance = lt.ImportedFromInstance
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
         Begin Table = "l"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "lc"
            Begin Extent = 
               Top = 6
               Left = 286
               Bottom = 136
               Right = 496
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ls"
            Begin Extent = 
               Top = 6
               Left = 534
               Bottom = 136
               Right = 744
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ls2"
            Begin Extent = 
               Top = 6
               Left = 782
               Bottom = 136
               Right = 992
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "l2"
            Begin Extent = 
               Top = 6
               Left = 1030
               Bottom = 136
               Right = 1200
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "lt"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 248
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
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LeadsView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Output = 720
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LeadsView'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LeadsView'
GO