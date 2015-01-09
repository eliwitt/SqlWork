create table [Transactions] (
	[custid] [int] not null,
	[balance] [int] not null,
	[code] [char] (10))

create table [customers] (
	[custid] [int] not null,
	[balance] [int] null)