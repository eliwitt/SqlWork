insert into Settings values('readOnly','TRUE')

update settings set SettingValue = 'FALSE' where SettingType = 'readOnly'

delete from Settings where SettingType = 'readOnly'