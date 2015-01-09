SELECT QuestionUsage_key, length = DATALENGTH(Question_txt), Question_txt
FROM ans_questionusage
ORDER BY Question_txt
