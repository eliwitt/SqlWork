   select e.id,p.id , p.firstname + ' ' + p.lastname name, p.emailaddress from employee e join person p on p.id = e.personinfoptr
   where e.id in (955209, 2353186) order by p.lastname asc, p.firstname asc


   select * from employee e 
   where id in (467736, 148026, 467745, 66436)

--update employee set emailaddress = 'SWitt@AdaptInfoTech.com'
--where id in (467736, 148026, 467745, 66436)