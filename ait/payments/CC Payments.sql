/****** Script for SelectTopNRows command from SSMS  ******/
SELECT * FROM ChargeRequest
--update chargerequest set status = 100 where id = 1
--insert into ChargeRequest 
--      (CompletionDate, DebitOrCredit, CardType, 
--      CardHolderNameEnc,          CardNumberEnc, 
--      CardNumberLast4, ExpirationMonth, ExpirationYear,
--      CardAddr,           CardCity, CardState, CardZip, Cardemail, 
--      CardCnty, CVVCode, ChargeAmount, Approved) 
--values('2011-03-24',   'C',           'Visa',
--      '2atYfqNAYv7t/df2DeLfpg==', 'WR6/9gVWbRI3C7JFkaSbB5CzGE2Nhp0V',
--      '7912',          '10',           '12',
--      '1234 Testing Ln', 'Hamilton', 'OH',     '11111',  '',
--      'US',     '111',   '30.00',      '')