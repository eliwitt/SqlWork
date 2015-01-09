SELECT techs.TechId,techs.userid, 
Sub.MarketCapacity,
techs.marketid, 
Users.UserName,
Users.[Password],
Users.FullName, 
Users.SubScriberId, 
Sub.SubscriberType, 
techs.MobileTech,
techs.inhousetech,
Users.DisableUser
FROM 
edg_tbl_Users Users
	inner JOIN edg_tbl_Subscribers Sub
		ON Users.SubScriberId = Sub.SubscriberId
	inner join edg_tbl_parentshoprelations fam
		on Users.Subscriberid = fam.childshopid
	left outer join edg_tbl_technicians techs
		on Users.userid = techs.userid
WHERE
fam.parentshopid = 3418 and
(AccountDisabled = 0) AND (AccountLockedOut = 0)