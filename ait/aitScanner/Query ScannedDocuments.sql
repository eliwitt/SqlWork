select * from scanneddocuments
--update scanneddocuments set ImageBarData = '0000001BAR' where imageid = 367
--delete from scanneddocument
--delete from ScannedDocuments where ImageType = 0 and ImageBarData like '0072494%'
--SELECT count(*) FROM ScannedDocuments 
--where ImageBarData like '%BAR' and ImageType = 0
SELECT ImageID, ImageBarData, DateStamp, ImagePic, DocDescription, employeeptr, officeptr
 FROM ScannedDocuments 
 where ImageBarData like '%BAR'
 and ImageType = 0 order by officeptr, employeeptr