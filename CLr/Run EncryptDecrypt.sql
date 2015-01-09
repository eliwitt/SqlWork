SELECT '123456789' AS ClearString,dbo.Encrypt ('123456789','ayb&e#i&BWLGMe2V') AS EncryptedString

SELECT 'ZT3VdRKl2iVhdVEwiQvTzA==' AS EncryptedString, dbo.Decrypt ('ZT3VdRKl2iVhdVEwiQvTzA==','ayb&e#i&BWLGMe2V') AS DecryptedString