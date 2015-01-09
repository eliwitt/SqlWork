declare @xmlStr nvarchar(4000)
select @xmlStr = '<?xml version="1.0"?><msc_validtype>'
select @xmlStr = @xmlStr + '<validtype id="{' + convert(nvarchar(40),validtype_key) + 
'}"><validtypeshort_nm>' + validtypeshort_nm + 
'</validtypeshort_nm><validtype_nm>' + validtype_nm + 
'</validtype_nm><allowedit_flg>' + allowedit_flg + 
'</allowedit_flg></validtype>'
from msc_validtype
select @xmlStr + '</msc_validtype>'