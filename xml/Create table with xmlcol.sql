CREATE TABLE xmldtmTable
    (
      ID int,
      xmlCol xml,
    CONSTRAINT PK_xmldtmTable
      PRIMARY KEY CLUSTERED (ID)
    )

    INSERT INTO xmldtmTable (ID, xmlCol)
    VALUES (1, '<root><childElement1 value="1"/><childElement2 value="2"/></root>')

    INSERT INTO xmldtmTable (ID, xmlCol)
    VALUES (2, '<root><childElement value="1"/><childElement value="2"/></root>')
