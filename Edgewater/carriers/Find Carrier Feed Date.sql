select org.organization_nm, carrier.group_key, lastfeed_dttm from grp_groupcarrier carrier
	right join grp_group [group] on carrier.group_key = [group].group_key
	right join msc_organization org on [group].group_key = org.organization_key
where carrier.organization_key = '{a7ca4fe9-c2c1-4b07-8120-358205d2c078}' order by lastfeed_dttm desc

select * from grp_groupcarrier
where organization_key = '{a7ca4fe9-c2c1-4b07-8120-358205d2c078}' and
group_key in ('0CB6A4DA-01E7-48AA-A11C-ACD13099677E','A4BD8D0C-6634-4BD4-8202-42D31249E54E')