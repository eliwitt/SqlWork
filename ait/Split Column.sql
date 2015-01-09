CREATE TABLE PayFoo (
foo_id int,
foo_memo NVARCHAR(512))

--	select id, memo from clm_payment where memo is not null
insert into PayFoo 
	select id, memo from clm_payment where id in (70, 71, 106, 123, 124)

--select * from PayFoo
Declare @Id int, @Memo nvarchar(512)

While (Select Count(*) From PayFoo) > 0 
Begin 
    Select Top 1 @Id = foo_id From PayFoo 
 
--    select @Memo = foo_memo from PayFoo where foo_id = @Id 
	select foo_memo from PayFoo where foo_id = @Id and
		Charindex(CHAR(13) + CHAR(10) + foo_memo + CHAR(13) + CHAR(10),
			CHAR(13) + CHAR(10) + foo_memo + CHAR(13) + CHAR(10)) > 0
--
--	Print convert(nvarchar(10), @Id) + ' ' + @Memo

--	SELECT foo_id, address_text, address_line
--	FROM (
--		SELECT foo_id, n,
--			CASE WHEN LEN(address_text) > 40 THEN
--			CASE n
--			WHEN 1 THEN LEFT(address_text, 40)
--			ELSE RIGHT(address_text, LEN(address_text) - 40)
--			END
--			ELSE
--				CASE n
--					WHEN 1 THEN address_text
--				END
--			END AS address_text, address_line
--		FROM (
--			SELECT SUBSTRING(foo_memo, n, CHARINDEX(CHAR(13) + CHAR(10), foo_memo + CHAR(13) + CHAR(10),
--				n) - n) AS address_text, n + 1 - LEN(REPLACE(LEFT(foo_memo, n), CHAR(13) + CHAR(10), '' )) AS address_line, foo_id
--			FROM PayFoo AS F
--		CROSS JOIN
--			(SELECT number FROM master..spt_values WHERE type = 'P' AND number BETWEEN 1 AND 250) AS Nums(n)
--		WHERE SUBSTRING(CHAR(13) + CHAR(10) + foo_memo, n, 2) = CHAR(13) + CHAR(10) AND n < LEN(foo_memo) + 2) AS T
--	CROSS JOIN
--		(SELECT 1 UNION SELECT 2) AS Nums(n) WHERE address_text <> '') AS T
--	WHERE address_text IS NOT NULL
--	ORDER BY foo_id, address_line, n
 
    delete from PayFoo where foo_id = @Id  
 
End 
drop table PayFoo