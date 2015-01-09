Sp_configure 'clr enable',1
GO
RECONFIGURE
GO

CREATE ASSEMBLY AES_EncryptDecrypt
FROM 'C:\steve\Dlls\AES_EncryptDecrypt.dll'
WITH PERMISSION_SET = SAFE