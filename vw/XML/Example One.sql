CREATE TABLE ClientInfo
(
  ClientID INT PRIMARY KEY IDENTITY,
  Info XML
);

INSERT INTO ClientInfo (Info)
VALUES
(
 '<People>
    <Person id="1234">
      <FirstName>John</FirstName>
      <LastName>Doe</LastName>
    </Person>
    <Person id="5678">
      <FirstName>Jane</FirstName>
      <LastName>Doe</LastName>
    </Person>
    <Person id="2468">
      <FirstName>John</FirstName>
      <LastName>Smith</LastName>
    </Person>
    <Person id="1357">
      <FirstName>Jane</FirstName>
      <LastName>Smith</LastName>
    </Person>
  </People>'
);

select * from ClientInfo

  SELECT Person.value(
    'concat(./FirstName[1], " ", ./LastName[1])',
    'varchar(50)') AS FullName
  FROM ClientInfo CROSS APPLY
    Info.nodes('/People/Person') AS People(Person)
  WHERE ClientID = 1