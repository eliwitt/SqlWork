--
--  let's query the table with xml data types
--
select * from xmldtmTable
--
-- for row with an id of 1 retrieve the childElement2
--
SELECT xmlCol.query('/root/childElement2')
    FROM xmldtmTable
    WHERE ID = 1
--
-- retrieve the value of the value attribute from the [#] of the array
-- the first query retrieves the first entry of childElement2s and the
-- second query retrieves the second entry in that array.
--
SELECT xmlCol.value('(/root/childElement2/@value)[1]', 'int') Value
    FROM xmldtmTable
    WHERE ID = 1
SELECT xmlCol.value('(/root/childElement/@value)[2]', 'int') Value
    FROM xmldtmTable
    WHERE ID = 2    
--
-- check for the existance of an xml condition
--
   SELECT xmlCol.exist('/root/childElement2[@value=1]') Wehave
    FROM xmldtmTable
    WHERE ID = 1
--
-- retrieve the collection of id 2s childElement attributes
--
SELECT T.C.value('@value', 'int') AS Value
    FROM xmldtmTable
    CROSS APPLY xmlCol.nodes('/root/childElement') AS T(C)
    WHERE ID = 2