-- On the web the user can request a file that contains Hipaa data for
-- the requested carrier.  This request comes from the carrier pages.
-- At times a problem araises that the date of the download gets set
-- but because of an error the download does not that place.  In order for
-- the user to be able to re-request the download you will need to reset the
-- groupcarrier lastfeed date.
--
-- Use this script to reset the groupcarriers last download date.  You can get
-- the id from the web page.
--
update grp_groupcarrier
set lastfeed_dttm = '2008-05-20'
where organization_key = '{a7ca4fe9-c2c1-4b07-8120-358205d2c078}' and
group_key in ('0CB6A4DA-01E7-48AA-A11C-ACD13099677E','A4BD8D0C-6634-4BD4-8202-42D31249E54E')