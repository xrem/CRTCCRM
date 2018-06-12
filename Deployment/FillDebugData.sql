/** DATA **/

USE [$(DatabaseName)]
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