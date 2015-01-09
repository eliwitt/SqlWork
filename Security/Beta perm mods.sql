
UPDATE [dbo].[edg_tbl_Permision_Definitions] SET [Active]=1 WHERE [id]=123
UPDATE [dbo].[edg_tbl_Permision_Definitions] SET [Description]='System Administration' WHERE [id]=163
UPDATE [dbo].[edg_tbl_Permision_Definitions] SET [Help]=NULL WHERE [id]=179
INSERT INTO [dbo].[edg_tbl_Permision_Definitions] ([Tag], [Description], [Active], [Help], [Subscriber_Type], [Menu_Type], [Menu_Order]) VALUES ('edgQBSetup', 'QuickBooks Setup', 1, NULL, 1, 2, 635)
INSERT INTO [dbo].[edg_tbl_Permision_Definitions] ([Tag], [Description], [Active], [Help], [Subscriber_Type], [Menu_Type], [Menu_Order]) VALUES ('edgReportList2', 'Admin Reports', 1, NULL, 1, 2, 640)
INSERT INTO [dbo].[edg_tbl_Permision_Definitions] ([Tag], [Description], [Active], [Help], [Subscriber_Type], [Menu_Type], [Menu_Order]) VALUES ('edgQBInvoice', 'QuickBooks', 1, NULL, 1, 2, 535)
