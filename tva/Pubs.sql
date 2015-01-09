select pub.pub_id, pub_name, title, type, price
from publishers pub
	join titles title on pub.pub_id = title.pub_id
-- individual tables
select * from employee
select * from jobs
select * from titleview
select * from sales
--
-- employees of a specific publisher
--
select pub.pub_name, emp.fname, emp.minit, emp.lname, job.job_desc 
from employee emp
	join jobs job on emp.job_id = job.job_id
	join publishers pub on emp.pub_id = pub.pub_id
where emp.pub_id = 1389
--
-- list of the employees by publisher
--
select pub.pub_name, emp.fname, emp.minit, emp.lname, job.job_desc 
from employee emp
	join jobs job on emp.job_id = job.job_id
	join publishers pub on emp.pub_id = pub.pub_id
order by pub_name 
-- heres another
select pub_name, fname, minit, lname, hire_date, job_desc
	from publishers pubs
		join employee emp on pubs.pub_id = emp.pub_id
		left join jobs on emp.job_id = jobs.job_id
order by pub_name
--
-- total book sales
--
select book.title_id, title, price, qty, 
	price * qty totalsales
from titles book 
	left join (select title_id, sum(qty) qty
	 from sales group by title_id)
	 sale on book.title_id = sale.title_id
--
-- total book sales by store
--
select book.title_id, title, price, qty, price * qty totalsales, stor_id
from titles book 
	left join sales sale on book.title_id = sale.title_id
-- 
-- a list of the books and their authors and the publisher
--
select title, price, pub_name, au_fname, au_lname
from authors 
	join titleauthor tiauthor 
		on authors.au_id = tiauthor.au_id
	join titles on tiauthor.title_id = titles.title_id
	join publishers pubs on titles.pub_id = pubs.pub_id
order by title, au_lname, au_fname
--
-- all books in the database
--
select book.title_id, title, price, au_fname, au_lname
from titles book 
	left join titleauthor tiauth
		on book.title_id = tiauth.title_id
	left join authors on tiauth.au_id = authors.au_id