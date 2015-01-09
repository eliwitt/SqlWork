CREATE TABLE [dbo].[MyStatus](
 [Status_Id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
 [StatusDesc] [varchar](25) NULL,
)

INSERT INTO MyStatus VALUES ('Active')
INSERT INTO MyStatus VALUES ('OnHold')
INSERT INTO MyStatus VALUES ('Disabled')
INSERT INTO MyStatus VALUES ('Closed')