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
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[LeadId] [int] NOT NULL,
	[OperationDate] [datetime] NOT NULL,
	[IsAssigned] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_AssigneHistoryItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AvailableCategories]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AvailableCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_AvailableCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lead]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lead](
	[Id] [int] IDENTITY(1,1) NOT NULL,
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
	[WorkStatusId] [int] NOT NULL,
 CONSTRAINT [PK_Lead] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadCategory]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_LeadCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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
 CONSTRAINT [PK_LeadPackage] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadSource]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadSource](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_LeadSource] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadStatus]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_LeadStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadType]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_LeadType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeadWorkStatus]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeadWorkStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_LeadWorkStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LeadId] [int] NOT NULL,
	[ContactTypeId] [int] NOT NULL,
	[ContactPerson] [nvarchar](200) NOT NULL,
	[ContactData] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactHistoryItem]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactHistoryItem](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[ContactId] [int] NOT NULL,
	[Context] [nvarchar](max) NOT NULL,
	[ContactDate] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_ContactHistoryItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactType]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_ContactType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Surname] [nvarchar](max) NOT NULL,
	[PositionId] [int] NOT NULL,
	[Login] [nvarchar](max) NOT NULL,
	[Password] [varchar](40) NOT NULL,
	[ChefId] [int] NULL,
	[Online] [bit] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeKPI]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeKPI](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[KPIId] [int] NOT NULL,
	[ActualValue] [decimal](18, 0) NULL,
	[PlannedValue] [decimal](18, 0) NULL,
 CONSTRAINT [PK_EmployeeKPI] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeePosition]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeePosition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Position] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_EmployeePosition] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Internet]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Internet](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Internet] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KeyPerformanceIndicator]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KeyPerformanceIndicator](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Measure] [nvarchar](50) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_KeyPerformanceIndicator] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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
	[Enabled] [bit] NOT NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Package]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Package](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InternetId] [int] NOT NULL,
	[TelevisionId] [int] NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Package] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RejectionReason]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RejectionReason](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_RejectionReason] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Television]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Television](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Television] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UnavailabilityCalendar]    Script Date: 19.02.2018 10:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UnavailabilityCalendar](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Deleted] [bit] NOT NULL,
	[Approved] [bit] NULL,
	[ApprovedDate] [datetime] NULL,
	[ApprovedBy] [int] NULL,
 CONSTRAINT [PK_UnavailabilityCalendar] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Relations ******/

ALTER TABLE [dbo].[AssigneHistoryItem] ADD  CONSTRAINT [DF_AssigneHistoryItem_OperationDate]  DEFAULT (getutcdate()) FOR [OperationDate]
GO
ALTER TABLE [dbo].[AssigneHistoryItem] ADD  CONSTRAINT [DF_AssigneHistoryItem_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[AvailableCategories] ADD  CONSTRAINT [DF_AvailableCategories_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Lead] ADD  CONSTRAINT [DF_Lead_CreationDate]  DEFAULT (getutcdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[Lead] ADD  CONSTRAINT [DF_Lead_StatusId]  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[Lead] ADD  CONSTRAINT [DF_Lead_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[LeadCategory] ADD  CONSTRAINT [DF_LeadCategory_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[LeadPackage] ADD  CONSTRAINT [DF_LeadPackage_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[LeadSource] ADD  CONSTRAINT [DF_LeadSource_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[LeadStatus] ADD  CONSTRAINT [DF_LeadStatus_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[LeadType] ADD  CONSTRAINT [DF_LeadType_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[LeadWorkStatus] ADD  CONSTRAINT [DF_LeadWorkStatus_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Contact] ADD  CONSTRAINT [DF_Contact_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[ContactHistoryItem] ADD  CONSTRAINT [DF_ContactHistoryItem_ContactDate]  DEFAULT (getutcdate()) FOR [ContactDate]
GO
ALTER TABLE [dbo].[ContactHistoryItem] ADD  CONSTRAINT [DF_ContactHistoryItem_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[ContactType] ADD  CONSTRAINT [DF_ContactType_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_Online]  DEFAULT ((0)) FOR [Online]
GO
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [DF_Employee_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[EmployeePosition] ADD  CONSTRAINT [DF_EmployeePosition_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Internet] ADD  CONSTRAINT [DF_Internet_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[KeyPerformanceIndicator] ADD  CONSTRAINT [DF_KeyPerformanceIndicator_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Language] ADD  CONSTRAINT [DF_Language_Enabled]  DEFAULT ((0)) FOR [Enabled]
GO
ALTER TABLE [dbo].[Package] ADD  CONSTRAINT [DF_Package_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[RejectionReason] ADD  CONSTRAINT [DF_RejectionReason_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[Television] ADD  CONSTRAINT [DF_Television_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[UnavailabilityCalendar] ADD  CONSTRAINT [DF_UnavailabilityCalendar_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[AssigneHistoryItem]  WITH CHECK ADD  CONSTRAINT [FK_AssigneHistoryItem_Lead] FOREIGN KEY([LeadId])
REFERENCES [dbo].[Lead] ([Id])
GO
ALTER TABLE [dbo].[AssigneHistoryItem] CHECK CONSTRAINT [FK_AssigneHistoryItem_Lead]
GO
ALTER TABLE [dbo].[AssigneHistoryItem]  WITH CHECK ADD  CONSTRAINT [FK_AssigneHistoryItem_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[AssigneHistoryItem] CHECK CONSTRAINT [FK_AssigneHistoryItem_Employee]
GO
ALTER TABLE [dbo].[AvailableCategories]  WITH CHECK ADD  CONSTRAINT [FK_AvailableCategories_LeadCategory] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[LeadCategory] ([Id])
GO
ALTER TABLE [dbo].[AvailableCategories] CHECK CONSTRAINT [FK_AvailableCategories_LeadCategory]
GO
ALTER TABLE [dbo].[AvailableCategories]  WITH CHECK ADD  CONSTRAINT [FK_AvailableCategories_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[AvailableCategories] CHECK CONSTRAINT [FK_AvailableCategories_Employee]
GO
ALTER TABLE [dbo].[Lead]  WITH CHECK ADD  CONSTRAINT [FK_Lead_LeadCategory] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[LeadCategory] ([Id])
GO
ALTER TABLE [dbo].[Lead] CHECK CONSTRAINT [FK_Lead_LeadCategory]
GO
ALTER TABLE [dbo].[Lead]  WITH CHECK ADD  CONSTRAINT [FK_Lead_LeadSource] FOREIGN KEY([SourceId])
REFERENCES [dbo].[LeadSource] ([Id])
GO
ALTER TABLE [dbo].[Lead] CHECK CONSTRAINT [FK_Lead_LeadSource]
GO
ALTER TABLE [dbo].[Lead]  WITH CHECK ADD  CONSTRAINT [FK_Lead_LeadStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[LeadStatus] ([Id])
GO
ALTER TABLE [dbo].[Lead] CHECK CONSTRAINT [FK_Lead_LeadStatus]
GO
ALTER TABLE [dbo].[Lead]  WITH CHECK ADD  CONSTRAINT [FK_Lead_LeadType] FOREIGN KEY([TypeId])
REFERENCES [dbo].[LeadType] ([Id])
GO
ALTER TABLE [dbo].[Lead] CHECK CONSTRAINT [FK_Lead_LeadType]
GO
ALTER TABLE [dbo].[Lead]  WITH CHECK ADD  CONSTRAINT [FK_Lead_LeadWorkStatus] FOREIGN KEY([WorkStatusId])
REFERENCES [dbo].[LeadWorkStatus] ([Id])
GO
ALTER TABLE [dbo].[Lead] CHECK CONSTRAINT [FK_Lead_LeadWorkStatus]
GO
ALTER TABLE [dbo].[Lead]  WITH CHECK ADD  CONSTRAINT [FK_Lead_Employee] FOREIGN KEY([AssignedEmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[Lead] CHECK CONSTRAINT [FK_Lead_Employee]
GO
ALTER TABLE [dbo].[Lead]  WITH CHECK ADD  CONSTRAINT [FK_Lead_Language] FOREIGN KEY([LanguageId])
REFERENCES [dbo].[Language] ([Id])
GO
ALTER TABLE [dbo].[Lead] CHECK CONSTRAINT [FK_Lead_Language]
GO
ALTER TABLE [dbo].[Lead]  WITH CHECK ADD  CONSTRAINT [FK_Lead_RejectionReason] FOREIGN KEY([RejectionReasonId])
REFERENCES [dbo].[RejectionReason] ([Id])
GO
ALTER TABLE [dbo].[Lead] CHECK CONSTRAINT [FK_Lead_RejectionReason]
GO
ALTER TABLE [dbo].[LeadPackage]  WITH CHECK ADD  CONSTRAINT [FK_LeadPackage_Lead] FOREIGN KEY([LeadId])
REFERENCES [dbo].[Lead] ([Id])
GO
ALTER TABLE [dbo].[LeadPackage] CHECK CONSTRAINT [FK_LeadPackage_Lead]
GO
ALTER TABLE [dbo].[LeadPackage]  WITH CHECK ADD  CONSTRAINT [FK_LeadPackage_Package] FOREIGN KEY([PackageId])
REFERENCES [dbo].[Package] ([Id])
GO
ALTER TABLE [dbo].[LeadPackage] CHECK CONSTRAINT [FK_LeadPackage_Package]
GO
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_Lead] FOREIGN KEY([LeadId])
REFERENCES [dbo].[Lead] ([Id])
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_Lead]
GO
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_ContactType] FOREIGN KEY([ContactTypeId])
REFERENCES [dbo].[ContactType] ([Id])
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_ContactType]
GO
ALTER TABLE [dbo].[ContactHistoryItem]  WITH CHECK ADD  CONSTRAINT [FK_ContactHistoryItem_Contact] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contact] ([Id])
GO
ALTER TABLE [dbo].[ContactHistoryItem] CHECK CONSTRAINT [FK_ContactHistoryItem_Contact]
GO
ALTER TABLE [dbo].[ContactHistoryItem]  WITH CHECK ADD  CONSTRAINT [FK_ContactHistoryItem_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ContactHistoryItem] CHECK CONSTRAINT [FK_ContactHistoryItem_Employee]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_EmployeeChef] FOREIGN KEY([ChefId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_EmployeeChef]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_EmployeePosition] FOREIGN KEY([PositionId])
REFERENCES [dbo].[EmployeePosition] ([Id])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_EmployeePosition]
GO
ALTER TABLE [dbo].[EmployeeKPI]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeKPI_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[EmployeeKPI] CHECK CONSTRAINT [FK_EmployeeKPI_Employee]
GO
ALTER TABLE [dbo].[EmployeeKPI]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeKPI_KeyPerformanceIndicator] FOREIGN KEY([KPIId])
REFERENCES [dbo].[KeyPerformanceIndicator] ([Id])
GO
ALTER TABLE [dbo].[EmployeeKPI] CHECK CONSTRAINT [FK_EmployeeKPI_KeyPerformanceIndicator]
GO
ALTER TABLE [dbo].[Package]  WITH CHECK ADD  CONSTRAINT [FK_Package_Internet] FOREIGN KEY([InternetId])
REFERENCES [dbo].[Internet] ([Id])
GO
ALTER TABLE [dbo].[Package] CHECK CONSTRAINT [FK_Package_Internet]
GO
ALTER TABLE [dbo].[Package]  WITH CHECK ADD  CONSTRAINT [FK_Package_Television] FOREIGN KEY([TelevisionId])
REFERENCES [dbo].[Television] ([Id])
GO
ALTER TABLE [dbo].[Package] CHECK CONSTRAINT [FK_Package_Television]
GO
ALTER TABLE [dbo].[UnavailabilityCalendar]  WITH CHECK ADD  CONSTRAINT [FK_UnavailabilityCalendar_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[UnavailabilityCalendar] CHECK CONSTRAINT [FK_UnavailabilityCalendar_Employee]
GO
ALTER TABLE [dbo].[UnavailabilityCalendar]  WITH CHECK ADD  CONSTRAINT [FK_UnavailabilityCalendar_EmployeeApprover] FOREIGN KEY([ApprovedBy])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[UnavailabilityCalendar] CHECK CONSTRAINT [FK_UnavailabilityCalendar_EmployeeApprover]
GO

USE [master]
GO
ALTER DATABASE [$(DatabaseName)] SET  READ_WRITE 
GO

/** DATA **/

USE [crmdb]
GO

SET NOCOUNT ON
GO

SET QUOTED_IDENTIFIER ON
GO

PRINT N'Filling up table LeadCategory...';
GO

SET IDENTITY_INSERT [dbo].[LeadCategory] ON 
INSERT [dbo].[LeadCategory] ([Id], [Name], [Deleted]) VALUES (1, N'Золотой', 0)
INSERT [dbo].[LeadCategory] ([Id], [Name], [Deleted]) VALUES (2, N'Серебряный', 0)
INSERT [dbo].[LeadCategory] ([Id], [Name], [Deleted]) VALUES (3, N'Платиновый', 0)
INSERT [dbo].[LeadCategory] ([Id], [Name], [Deleted]) VALUES (4, N'Без категории', 0)
SET IDENTITY_INSERT [dbo].[LeadCategory] OFF
GO

PRINT N'Filling up table LeadSource...';
GO

SET IDENTITY_INSERT [dbo].[LeadSource] ON 
INSERT [dbo].[LeadSource] ([Id], [Name], [Deleted]) VALUES (1, N'Интернет', 0)
INSERT [dbo].[LeadSource] ([Id], [Name], [Deleted]) VALUES (2, N'Торговый центр', 0)
INSERT [dbo].[LeadSource] ([Id], [Name], [Deleted]) VALUES (3, N'Другой', 0)
SET IDENTITY_INSERT [dbo].[LeadSource] OFF
GO

PRINT N'Filling up table LeadStatus...';
GO

SET IDENTITY_INSERT [dbo].[LeadStatus] ON 
INSERT [dbo].[LeadStatus] ([Id], [Name], [Deleted]) VALUES (1, N'Потенциальный клиент', 0)
INSERT [dbo].[LeadStatus] ([Id], [Name], [Deleted]) VALUES (2, N'На подписании', 0)
INSERT [dbo].[LeadStatus] ([Id], [Name], [Deleted]) VALUES (3, N'Выигран', 0)
INSERT [dbo].[LeadStatus] ([Id], [Name], [Deleted]) VALUES (4, N'Проигран', 0)
SET IDENTITY_INSERT [dbo].[LeadStatus] OFF
GO

PRINT N'Filling up table LeadType...';
GO

SET IDENTITY_INSERT [dbo].[LeadType] ON 
INSERT [dbo].[LeadType] ([Id], [Type], [Deleted]) VALUES (1, N'Розничный клиент', 0)
INSERT [dbo].[LeadType] ([Id], [Type], [Deleted]) VALUES (2, N'Отптовый клиент', 0)
INSERT [dbo].[LeadType] ([Id], [Type], [Deleted]) VALUES (3, N'TP ISP клиент', 0)
SET IDENTITY_INSERT [dbo].[LeadType] OFF
GO

PRINT N'Filling up table LeadWorkStatus...';
GO

SET IDENTITY_INSERT [dbo].[LeadWorkStatus] ON 
INSERT [dbo].[LeadWorkStatus] ([Id], [Name], [Deleted]) VALUES (1, N'Открыт', 0)
INSERT [dbo].[LeadWorkStatus] ([Id], [Name], [Deleted]) VALUES (2, N'Назначен', 0)
INSERT [dbo].[LeadWorkStatus] ([Id], [Name], [Deleted]) VALUES (3, N'В работе', 0)
INSERT [dbo].[LeadWorkStatus] ([Id], [Name], [Deleted]) VALUES (4, N'Выполнен', 0)
SET IDENTITY_INSERT [dbo].[LeadWorkStatus] OFF
GO

PRINT N'Filling up table ContactType...';
GO

SET IDENTITY_INSERT [dbo].[ContactType] ON 
INSERT [dbo].[ContactType] ([Id], [Type], [Deleted]) VALUES (1, N'Домашний телефон', 0)
INSERT [dbo].[ContactType] ([Id], [Type], [Deleted]) VALUES (2, N'Рабочий телефон', 0)
INSERT [dbo].[ContactType] ([Id], [Type], [Deleted]) VALUES (3, N'Email', 0)
INSERT [dbo].[ContactType] ([Id], [Type], [Deleted]) VALUES (4, N'Web-сайт', 0)
INSERT [dbo].[ContactType] ([Id], [Type], [Deleted]) VALUES (5, N'Адрес', 0)
SET IDENTITY_INSERT [dbo].[ContactType] OFF
GO

PRINT N'Filling up table EmployeePosition...';
GO

SET IDENTITY_INSERT [dbo].[EmployeePosition] ON 
INSERT [dbo].[EmployeePosition] ([Id], [Position], [Deleted]) VALUES (1, N'Руководитель', 0)
INSERT [dbo].[EmployeePosition] ([Id], [Position], [Deleted]) VALUES (2, N'Менеджер', 0)
SET IDENTITY_INSERT [dbo].[EmployeePosition] OFF
GO

PRINT N'Filling up table Internet...';
GO

SET IDENTITY_INSERT [dbo].[Internet] ON 
INSERT [dbo].[Internet] ([Id], [Name], [Deleted]) VALUES (1, N'Интернет для частных лиц', 0)
INSERT [dbo].[Internet] ([Id], [Name], [Deleted]) VALUES (2, N'Интернет для жилых помещений', 0)
INSERT [dbo].[Internet] ([Id], [Name], [Deleted]) VALUES (3, N'Бизнес-интернет', 0)
INSERT [dbo].[Internet] ([Id], [Name], [Deleted]) VALUES (4, N'Интернет для жилых комплексов', 0)
INSERT [dbo].[Internet] ([Id], [Name], [Deleted]) VALUES (5, N'Интернет для торговых центров', 0)
SET IDENTITY_INSERT [dbo].[Internet] OFF
GO

PRINT N'Filling up table Television...';
GO

SET IDENTITY_INSERT [dbo].[Television] ON 
INSERT [dbo].[Television] ([Id], [Name], [Deleted]) VALUES (1, N'Телевидение без иностранных каналов', 0)
INSERT [dbo].[Television] ([Id], [Name], [Deleted]) VALUES (2, N'Телевидение с иностранными каналами', 0)
SET IDENTITY_INSERT [dbo].[Television] OFF
GO

PRINT N'Filling up table Package...';
GO

SET IDENTITY_INSERT [dbo].[Package] ON 
INSERT [dbo].[Package] ([Id], [InternetId], [TelevisionId], [Deleted]) VALUES (2, 1, 1, 0)
INSERT [dbo].[Package] ([Id], [InternetId], [TelevisionId], [Deleted]) VALUES (3, 2, 1, 0)
INSERT [dbo].[Package] ([Id], [InternetId], [TelevisionId], [Deleted]) VALUES (4, 3, 1, 0)
INSERT [dbo].[Package] ([Id], [InternetId], [TelevisionId], [Deleted]) VALUES (5, 4, 1, 0)
INSERT [dbo].[Package] ([Id], [InternetId], [TelevisionId], [Deleted]) VALUES (6, 5, 1, 0)
INSERT [dbo].[Package] ([Id], [InternetId], [TelevisionId], [Deleted]) VALUES (7, 1, 2, 0)
INSERT [dbo].[Package] ([Id], [InternetId], [TelevisionId], [Deleted]) VALUES (8, 2, 2, 0)
INSERT [dbo].[Package] ([Id], [InternetId], [TelevisionId], [Deleted]) VALUES (9, 3, 2, 0)
INSERT [dbo].[Package] ([Id], [InternetId], [TelevisionId], [Deleted]) VALUES (10, 4, 2, 0)
INSERT [dbo].[Package] ([Id], [InternetId], [TelevisionId], [Deleted]) VALUES (11, 5, 2, 0)
SET IDENTITY_INSERT [dbo].[Package] OFF
GO

PRINT N'Filling up table KeyPerformanceIndicator...';
GO

SET IDENTITY_INSERT [dbo].[KeyPerformanceIndicator] ON 
INSERT [dbo].[KeyPerformanceIndicator] ([Id], [Name], [Measure], [Deleted]) VALUES (1, N'Количество потенциальных клиентов', N'шт.', 0)
INSERT [dbo].[KeyPerformanceIndicator] ([Id], [Name], [Measure], [Deleted]) VALUES (2, N'Количество выигранных потенциальных клиентов', N'шт.', 0)
INSERT [dbo].[KeyPerformanceIndicator] ([Id], [Name], [Measure], [Deleted]) VALUES (3, N'Количество обслуженных потенциальных клиентов', N'шт.', 0)
INSERT [dbo].[KeyPerformanceIndicator] ([Id], [Name], [Measure], [Deleted]) VALUES (4, N'Процент выполнения плана по обслуживанию', N'%', 0)
INSERT [dbo].[KeyPerformanceIndicator] ([Id], [Name], [Measure], [Deleted]) VALUES (5, N'Процент выигранных потенциальных клиентов', N'%', 0)
SET IDENTITY_INSERT [dbo].[KeyPerformanceIndicator] OFF
GO

PRINT N'Filling up table Language...';
GO

SET IDENTITY_INSERT [dbo].[Language] ON 
INSERT [dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (1, N'en-GB', N'English', 2057, N'ENG', 0)
INSERT [dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (2, N'en-US', N'English', 1033, N'ENU', 1)
INSERT [dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (3, N'fr-FR', N'French', 1036, N'FRA', 1)
INSERT [dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (4, N'de-DE', N'German', 1031, NULL, 0)
INSERT [dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (5, N'lv-LV', N'Latvian', 1062, N'LVI', 0)
INSERT [dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (6, N'lt-LT', N'Lithuanian', 1063, N'LTH', 0)
INSERT [dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (7, N'ru-RU', N'Russian', 1049, N'RUS', 0)
INSERT [dbo].[Language] ([Id], [CultureName], [DisplayName], [CultureCode], [Iso639Code], [Enabled]) VALUES (8, N'es-ES', N'Spanish', 3082, NULL, 0)
SET IDENTITY_INSERT [dbo].[Language] OFF
GO

PRINT N'Filling up table RejectionReason...';
GO

SET IDENTITY_INSERT [dbo].[RejectionReason] ON 
INSERT [dbo].[RejectionReason] ([Id], [Title], [Deleted]) VALUES (1, N'Нет подходящих продуктов', 0)
INSERT [dbo].[RejectionReason] ([Id], [Title], [Deleted]) VALUES (2, N'Нашел предложение дешевле', 0)
INSERT [dbo].[RejectionReason] ([Id], [Title], [Deleted]) VALUES (3, N'Уже выбрал продукт в другой компании', 0)
SET IDENTITY_INSERT [dbo].[RejectionReason] OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

SET NOCOUNT OFF
GO