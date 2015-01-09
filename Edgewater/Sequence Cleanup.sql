DECLARE @anval_key uniqueidentifier, 
--@prod_key uniqueidentifier, 
@hold_key uniqueidentifier, 
@qu_key uniqueidentifier, 
@an_text varchar(60),
@an_tt_vv varchar(16),
@prdCt int

DECLARE seq_cursor CURSOR FOR
select ansq.questionusage_key, ansq.answervalue_key, 
ansa.answer_txt, ans.tabletype_vv  
from ans_questionusagesequence ansq,
ans_answervalue ansa,
ans_answer ans,
ans_questionUsage usage
where (ansq.answervalue_key = ansa.answervalue_key
and ansa.answer_key = ans.answer_key
and ans.tabletype_vv is not null) 
and (ansq.questionusage_key = usage.questionusage_key
and usage.Product_Key is not null)
order by ansq.questionusage_key

OPEN seq_cursor

-- Perform the first fetch.
FETCH NEXT FROM seq_cursor into @qu_key, @anval_key, @an_text, @an_tt_vv
set @hold_key = @qu_key
set @prdCt = 1
-- Check @@FETCH_STATUS to see if there are any more rows to fetch.
WHILE @@FETCH_STATUS = 0
BEGIN
   -- This is executed as long as the previous fetch succeeds.
	if @qu_key != @hold_key
		begin
		set @hold_key = @qu_key
		set @prdCt = @prdCt + 1
	end
	--
	-- delete from ans_questionusagesequence
	--	where questionusage_key = @qu_key
	--	and answervalue_key = @anval_key
	print cast(@qu_key as varchar(60)) + ' ' + cast(@anval_key as varchar(60)) + ' ' + @an_text + ' ' + @an_tt_vv
	--select @qu_key as QuestionKey, @anval_key as AnswerValueKey, @an_text as AnswerText, @an_tt_vv as TableType_vv
   FETCH NEXT FROM seq_cursor into @qu_key, @anval_key, @an_text, @an_tt_vv
END
print 'You have ' + cast(@prdCt as varchar(5)) + ' questions to clean'
CLOSE seq_cursor
DEALLOCATE seq_cursor
