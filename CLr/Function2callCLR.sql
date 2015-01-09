CREATE FUNCTION [dbo].[Encrypt](@STRING [nvarchar](100), @KEY [nvarchar](100))
RETURNS [nvarchar](100) WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [AES_EncryptDecrypt].[sqlClrExample.AES_EncryptDecryptLibrary].[AES_Encrypt]
GO

CREATE FUNCTION [dbo].[Decrypt](@STRING [nvarchar](100), @KEY [nvarchar](100))
RETURNS [nvarchar](100) WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [AES_EncryptDecrypt].[sqlClrExample.AES_EncryptDecryptLibrary].[AES_Decrypt]
GO