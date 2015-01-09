select quest.QuestionUsage_key, quest.Answer_key, ans.*
from ans_answer ans
	inner join ans_questionusage quest
		on ans.answer_key = quest.answer_key
where quest.answer_key = 'E685EF13-A282-4B4C-83A1-EBA4A781838C'