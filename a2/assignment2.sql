-- Script for Assignment 2

-- Creating database with full name

CREATE DATABASE dvgfall2022assignment2;


-- Connecting to database 
\c dvgfall2022assignment2

-- Relation schemas and instances for assignment 2


CREATE TABLE Student(sid integer,
                     sname text,
                     birthYear integer,
                     primary key (sid));

CREATE TABLE Book(bno integer,
                  title text,
                  price integer,
                  primary key (bno));

CREATE TABLE Major(major text,
                   primary key (major));


CREATE TABLE Buys(sid integer,
                  bno integer,
                  primary key (sid,bno),
                  foreign key (sid) references Student(sid),
                  foreign key (bno) references Book(bno));


CREATE TABLE hasMajor(sid integer,
                      major text,
                      primary key (sid, major),
                      foreign key (sid) references Student (sid),
                      foreign key (major) references Major (major));


CREATE TABLE Cites(bno1 integer,
                   bno2 integer,
                   primary key (bno1,bno2),
                   foreign key (bno1) references Book(bno),
                   foreign key (bno2) references Book(bno));



INSERT INTO Student VALUES
 (1001,'Jean',1999),
 (1002,'Vidya',1999),
 (1003,'Anna',2001),
 (1004,'Qin',2001),
 (1005,'Megan',1999),
 (1006,'Ryan',1995),
 (1007,'Danielle',1997),
 (1008,'Emma',2000),
 (1009,'Hasan',2000),
 (1010,'Linda',1995),
 (1011,'Nick',1999),
 (1012,'Eric',1999),
 (1013,'Lisa',1998),
 (1014,'Deepa',2000),
 (1015,'Chris',1998),
 (1016,'YinYue',1995),
 (1017,'Latha',1997),
 (1018,'Arif',2000),
 (1019,'John',2003),
 (1020,'Margaret',1997);


INSERT INTO Book VALUES
 (2001,'Databases',20),
 (2002,'AI',20),
 (2003,'DataScience',25),
 (2004,'Databases',25),
 (2005,'Programming',30),
 (2006,'Complexity',30),
 (2007,'AI',20),
 (2008,'Algorithms',40),
 (2009,'Networks',40),
 (2010,'AI',30),
 (2011,'Logic',25),
 (2012,'Physics',45),
 (2013,'Physics',30);



INSERT INTO Buys VALUES
 (1003,2001),
 (1010,2007),
 (1011,2010),
 (1014,2007),
 (1010,2005),
 (1011,2003),
 (1008,2006),
 (1009,2003),
 (1006,2003),
 (1007,2008),
 (1017,2004),
 (1017,2003),
 (1004,2001),
 (1007,2006),
 (1005,2007),
 (1005,2011),
 (1013,2004),
 (1002,2009),
 (1009,2011),
 (1018,2011),
 (1015,2004),
 (1001,2011),
 (1013,2006),
 (1015,2002),
 (1005,2002),
 (1008,2009),
 (1014,2009),
 (1002,2002),
 (1001,2002),
 (1009,2001),
 (1006,2006),
 (1015,2007),
 (1019,2008),
 (1006,2002),
 (1018,2008),
 (1003,2004),
 (1006,2011),
 (1013,2005),
 (1003,2010),
 (1008,2008),
 (1007,2009),
 (1016,2008),
 (1011,2002),
 (1004,2005),
 (1004,2009),
 (1006,2010),
 (1001,2010),
 (1001,2006),
 (1009,2010),
 (1019,2002),
 (1004,2010),
 (1018,2010),
 (1009,2006),
 (1008,2003),
 (1018,2005),
 (1004,2002),
 (1011,2004),
 (1007,2002),
 (1015,2005),
 (1012,2001),
 (1017,2010),
 (1002,2001),
 (1016,2010),
 (1010,2003),
 (1003,2008),
 (1017,2005),
 (1016,2006),
 (1011,2007),
 (1006,2009),
 (1001,2005),
 (1007,2005),
 (1005,2004),
 (1013,2008),
 (1005,2008),
 (1004,2011),
 (1009,2009),
 (1013,2001),
 (1015,2006),
 (1003,2002),
 (1016,2001),
 (1006,2007),
 (1016,2011),
 (1006,2008),
 (1007,2003),
 (1015,2003),
 (1011,2011),
 (1010,2006),
 (1012,2009),
 (1001,2001),
 (1011,2001),
 (1013,2002),
 (1012,2007),
 (1002,2010),
 (1012,2010),
 (1001,2007),
 (1005,2003),
 (1011,2005),
 (1014,2011),
 (1011,2006),
 (1009,2002),
 (1008,2001),
 (1002,2003),
 (1002,2005),
 (1009,2008),
 (1008,2002),
 (1006,2001),
 (1008,2007),
 (1012,2002),
 (1017,2008),
 (1019,2009),
 (1010,2010),
 (1003,2011),
 (1017,2006),
 (1013,2011),
 (1006,2004),
 (1016,2004),
 (1019,2001),
 (1002,2006),
 (1018,2006),
 (1010,2009),
 (1010,2008),
 (1003,2007),
 (1009,2007),
 (1002,2007),
 (1018,2009),
 (1004,2004),
 (1018,2001),
 (1007,2001),
 (1004,2003),
 (1010,2001),
 (1008,2010),
 (1008,2005),
 (1015,2001),
 (1012,2003),
 (1005,2006),
 (1007,2010),
 (1010,2004),
 (1015,2010),
 (1017,2002),
 (1013,2003),
 (1001,2008),
 (1016,2002),
 (1005,2005),
 (1016,2009),
 (1012,2004),
 (1009,2004),
 (1020,2012),
 (1020,2013);



INSERT INTO Major VALUES
   ('CS'),
   ('DataScience'),
   ('Math'),
   ('Physics'),
   ('Chemistry'),
   ('English');

INSERT INTO hasMajor VALUES
 (1001,'CS'),
 (1001,'DataScience'),
 (1002,'CS'),
 (1002,'DataScience'),
 (1004,'DataScience'),
 (1004,'CS'),
 (1005,'DataScience'),
 (1005,'CS'),
 (1005,'Math'),
 (1006,'CS'),
 (1006,'Physics'),
 (1007,'Physics'),
 (1007,'CS'),
 (1009,'Physics'),
 (1009,'Math'),
 (1010,'Math'),
 (1011,'Math'),
 (1011,'Physics'),
 (1011,'DataScience'),
 (1011,'CS'),
 (1012,'DataScience'),
 (1012,'Physics'),
 (1012,'CS'),
 (1013,'CS'),
 (1013,'Physics'),
 (1013,'Math'),
 (1014,'Physics'),
 (1014,'DataScience'),
 (1014,'Math'),
 (1015,'CS'),
 (1015,'DataScience'),
 (1016,'Physics'),
 (1016,'DataScience'),
 (1017,'Math'),
 (1017,'CS'),
 (1018,'DataScience'),
 (1019,'Math'),
 (1020,'Chemistry');


INSERT INTO Cites VALUES
 (2004,2003),
 (2006,2003),
 (2009,2003),
 (2009,2004),
 (2009,2006),
 (2008,2007),
 (2010,2008),
 (2010,2007),
 (2010,2003),
 (2002,2001),
 (2009,2001),
 (2011,2003),
 (2011,2005),
 (2001,2004),
 (2012,2013);

create table PC(parent integer,
                child integer);

insert into PC values
 (1,2),
 (1,3),
 (1,4),
 (2,5),
 (2,6),
 (3,7),
 (5,8),
 (8,9),
 (8,10),
 (8,11),
 (7,12),
 (7,13),
 (12,14),
 (14,15);

\qecho 'Problem 3'

-- Find the bno and title of each book that is bought by a student who
-- is (strictly) younger than each student who majors in Chemistry and
-- who also bought that book.




\qecho 'Problem 3.c'

-- Express this query in Pure SQL by only using the ‘true = some’ or
-- ‘true = all’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.



select b.bno, b.title from book b where true = some (
	
		select y.bno = b.bno and true = some(select s.sid = y.sid and true = all(
			
				select s.birthYear > v.birthyear from (select s1.sid, s1.birthYear from student s1 where 
						true = some(select hm1.major = 'Chemistry' and hm1.sid = s1.sid from hasmajor hm1) and 
						true = some(select t1.sid = s1.sid and t1.bno = b.bno from buys t1))v ) 
											 
											 from student s) from buys y);
	
	
		    
\qecho 'Problem 3.d'

-- Express this query in Pure SQL by only using the ‘exists’ or ‘not
-- exists’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.



select b.bno, b.title from book b where exists (select 1 from buys y where (y.bno = b.bno and 
																			
		exists(select 1 from student s where s.sid = y.sid and 
				not exists (select 1 from 
							
						(select s1.sid, s1.birthYear from student s1 where 						
							exists (select 1 from hasmajor hm1 where hm1.major = 'Chemistry' and hm1.sid = s1.sid) and 
							exists (select 1 from buys t1 where t1.sid = s1.sid and t1.bno = b.bno))v 
																					
							where s.birthYear <= v.birthyear) )));





\qecho 'Problem 3.e'

-- Express this query in Pure SQL by only using the `in' or `not in' subquery
-- expressions. You can not use the set operations INTERSECT, UNION, and
-- EXCEPT.



with st as (select s.sid, s.birthyear, t1.bno from buys t1, student s where s.sid = t1.sid),
		
	chst as (select st1.sid, st1.birthyear, st1.bno from st st1, hasmajor h where h.sid = st1.sid and h.major = 'Chemistry')


select b.bno, b.title from book b where bno in 
	(select st1.bno from st st1 where st1.sid not in 
		(select s2.sid from student s2, chst c1 where c1.bno = st1.bno and s2.sid = st1.sid and st1.birthyear <= c1.birthyear));



\qecho 'Problem 3.f'

-- Express this query in Pure SQL without using subquery expressions. Now
-- you can use the set operations INTERSECT, UNION, and EXCEPT.






\qecho 'Problem 4'

-- Find each student-book pair (s, b) where s is the sid of a student who
-- majors in CS and who bought each book that costs no more than
-- book b.

\qecho 'Problem 4.b'

-- Express this query in Pure SQL by only using the ‘true = some’ or
-- ‘true = all’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.




select  h.sid, b.bno from hasmajor h, book b where h.major = 'CS' and 
	true = all (select true = some (select t1.sid = h.sid and q.bno = t1.bno from buys t1) 
				from (select b1.bno from book b1 where b1.price <= b.price) q ) order by h.sid, b.bno;


\qecho 'Problem 4.c'

-- Express this query in Pure SQL by only using the ‘exists’ or ‘not
-- exists’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.



select  h.sid, b.bno from hasmajor h, book b where h.major = 'CS' and 

	not exists (select 1 from (select b1.bno from book b1 where b1.price <= b.price) q 
		   where not exists (select 1 from buys t1 where t1.sid = h.sid and q.bno = t1.bno )) order by h.sid, b.bno;
		   
		   
		   		   
\qecho 'Problem 4.d'

-- Express this query in Pure SQL by only using the `in' or `not in' subquery
-- expressions. You can not use the set operations INTERSECT, UNION, and
-- EXCEPT.



select h.sid, b.bno from hasmajor h, book b where h.major = 'CS' and true not in 
		(select true from (select b1.bno from book b1 where b1.price <= b.price) q 
		 	where (h.sid, q.bno) not in (select t1.sid, t1.bno from buys t1)) order by h.sid, b.bno;



\qecho 'Problem 4.e'

-- Express this query in Pure SQL without using subquery expressions. Now
-- you can use the set operations INTERSECT, UNION, and EXCEPT.



\qecho 'Problem 5'

-- Find the sid and name of each student who bought all-but-one book that
-- cost strictly more than $30.



\qecho 'Problem 5.b'

-- Express this query in Pure SQL by only using the ‘true = some’ or
-- ‘true = all’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.


With view_o as (select b.bno from book b where b.price > 30)
		   
select s.sid, s.sname from student s where 

	true = some (select (true = all(select v1.bno <> v2.bno 
					from  (select y.bno from buys y, book b1 where y.sid = s.sid and b1.price > 30 and b1.bno = y.bno) v2) ) 
			 from view_o v1)  and 

			not true = some (select (v11.bno <> v12.bno and 
						 (select (true = all(select v11.bno <> v2.bno 
					from  (select y.bno from buys y, book b1 where y.sid = s.sid and b1.price > 30 and b1.bno = y.bno) v2) ) ) and 
						 (select (true = all(select v12.bno <> v2.bno 
					from  (select y.bno from buys y, book b1 where y.sid = s.sid and b1.price > 30 and b1.bno = y.bno) v2) ) ) ) 
				 from view_o v11, view_o v12);
	



\qecho 'Problem 5.c'

-- Express this query in Pure SQL by only using the ‘exists’ or ‘not
-- exists’ subquery expressions. You can not use the set operations
-- INTERSECT, UNION, and EXCEPT.



With view_o as (select b.bno from book b where b.price > 30)

select s.sid, s.sname from student s where 
		exists(select 1 from view_o v1 
	   		where not exists (select 1 from (select y.bno from buys y, book b1 where y.sid = s.sid and b1.price > 30 and b1.bno = y.bno) v2 where v1.bno = v2.bno )) and 
		not exists (select 1 from view_o v11, view_o v12 where v11.bno <> v12.bno and ( 
			not exists (select 1 from (select y.bno from buys y, book b1 where y.sid = s.sid and b1.price > 30 and b1.bno = y.bno) v2 where v11.bno = v2.bno )and 
			not exists (select 1 from (select y.bno from buys y, book b1 where y.sid = s.sid and b1.price > 30 and b1.bno = y.bno) v2 where v12.bno = v2.bno ) ));





\qecho 'Problem 5.d'

-- Express this query in Pure SQL by only using the `in' or `not in' subquery
-- expressions. You can not use the set operations INTERSECT, UNION, and
-- EXCEPT.



With view_o as (select b.bno from book b where b.price > 30)

select s.sid, s.sname from student s where 
		true in (select true from view_o v1 where v1.bno not in (select v2.bno from (select y.bno from buys y, book b1 where y.sid = s.sid and b1.price > 30 and b1.bno = y.bno) v2))
	
	and true not in (select true from view_o v11, view_o v12 where v11.bno <> v12.bno and (
			v11.bno not in (select v2.bno from (select y.bno from buys y, book b1 where y.sid = s.sid and b1.price > 30 and b1.bno = y.bno) v2) and 
			v12.bno not in (select v2.bno from (select y.bno from buys y, book b1 where y.sid = s.sid and b1.price > 30 and b1.bno = y.bno) v2) ));


\qecho 'Problem 5.e'

-- Express this query in Pure SQL without using subquery expressions. Now
-- you can use the set operations INTERSECT, UNION, and EXCEPT.




\qecho 'Problem 10.b'

-- Find the bno and title of each book that was bought by exactly one
-- student.

-- Express this query in RA SQL.



select distinct b.bno, b.title from book b join buys t on b.bno = t.bno

except 

select distinct R.bno, R.title from 
	((select t1.bno from buys t1 join buys t2 on (t1.sid <> t2.sid and t1.bno = t2.bno)) u NATURAL join book b ) R;


\qecho 'Problem 11.b'

-- Find each pair (m, b) where m is a major and b is the bno of a book
-- bought by a student who has major m and such that the price of b is
-- the lowest among the set of books bought by students with major m

-- Express this query in RA SQL.



with E as (select distinct * from buys natural join book natural join hasmajor)

select e.major, e.bno from E e
except
select e1.major, e1.bno from E e1 join E e2 on (e1.price > e2.price and e1.major = e2.major) 

order by major, bno;


\qecho 'Problem 12.b'

-- Find the bno and title of each book that is bought by a student who is
-- (strictly) younger than each student who majors in Chemistry and who
-- also bought that book.

-- Express this query in RA SQL.

	
			


with E1 as ( select * from buys natural join student),
	 E2 as (select * from student natural join 
		(select sid from hasmajor where major = 'Chemistry') sc natural join buys )


select bno, title from 
(select bno from E1
except
select E1.bno from E1 join E2 on (E1.bno = E2.bno and E1.birthyear <= E2.birthyear)) num natural join book;



 


\qecho 'Problem 13.b'

-- Find each student-book pair (s, b) where s is the sid of a student who
-- majors in CS and who bought each book that costs no more than
-- book b.

-- Express this query in RA SQL.


--select distinct sid, bno from hasmajor join book on (major = 'CS')

--INTERSECT 

--(select distinct sid, b.bno from buys cross join book b

--except

--select sid, bno from (
--select sid, bno from (select b1.bno from book b1 join book b on (b1.price< b.price)) E cross join (select sid from student) s 
--except 
--select sid, bno from buys tt) F ) order by sid, bno;






\qecho 'Problem 14.b'

-- Find the sid and name of each student who bought all-but-one book that
-- cost strictly more than $30.












\qecho 'Problem 27'

/*
 Define a parameterized view
 ‘PurchasedBookLessPrice(sid int, price integer)’
 that returns, for a given student identi- fied by ‘sid’ and
a given ‘price’ value, the subrelation of ‘Book’ of books that are
bought by that student and that cost strictly less than ‘price’.

Test your view for the parameter values (1001,15), (1001,20),
(1001,50), and (1002,30).
*/


create function PurchasedBookLessPrice(sno int, costs integer)
				returns table (bno integer, title text, price integer) as
				$$
					
					select b.bno, b.title, b.price from book b where (b.bno in 
						(select t1.bno from buys t1 where t1.sid = sno)) and b.price < costs;
				
				$$	LANGUAGE SQL;


-- drop function purchasedbooklessprice(sno integer, costs integer)


select * from PurchasedBookLessPrice(1001, 15);

select * from PurchasedBookLessPrice(1001, 30);

select * from PurchasedBookLessPrice(1001, 50);

select * from PurchasedBookLessPrice(1002, 30);




\qecho 'Problem 28'

/*
Define a parameterized view ‘CitedBookbyMajor(major text)’ that
returns for a major ‘major’ the subrelation of ‘Book’ of books that
are cited by a book bought by a the student who majors in ‘major’.

Test your view for each major.
*/


create FUNCTION CitedBookbyMajor(mj text)
	returns table (bno integer, title text, price integer) AS
	$$
	
	
	
	select b.bno, b.title, b.price from book b where 

		exists (select 1 from cites c where c.bno2 = b.bno and 
			exists (select 1 from buys t1 where t1.bno = c.bno1 and 
					exists(select 1 from hasmajor h where h.sid = t1.sid and h.major = mj))) order by b.bno, b.title;

	$$ LANGUAGE SQL;

	
select * from CitedBookbyMajor('CS');
select * from CitedBookbyMajor('DataScience');
select * from CitedBookbyMajor('Math');
select * from CitedBookbyMajor('Physics');
select * from CitedBookbyMajor('Chemistry');
select * from CitedBookbyMajor('English');


\qecho 'Problem 29'

/*
Define a parameterized view
‘JointlyBoughtBook(sid1 integer, sid2 integer)’
that returns the subrelation of ‘Book’ of books that are
bought by both the students with sids ‘sid1’ and ‘sid2’, respectively.

Test your view for the parameters (1001, 1002), (1001,1003), and
(1002,1003).
*/


create function JointlyBoughtBook(sid1 integer, sid2 integer) 
	returns table (bno integer, title text, price integer) AS
	$$
		select b.bno, b.title, b.price from book b where 

			true =some (select b.bno = t1.bno from buys t1 join buys t2 
				on (t1.bno = t2.bno and t1.sid <> t2.sid and t1.sid = sid1 and t2.sid = sid2))
	$$ LANGUAGE SQL;
	
	
	
select * from JointlyBoughtBook(1001, 1002);
select * from JointlyBoughtBook(1001, 1003);
select * from JointlyBoughtBook(1002, 1003);

\qecho 'Problem 30'

/*
Let PC(parent : integer,child : integer) be a rooted parent- child
tree. So a pair (n, m) in ‘PC’ indicates that node n is a parent of
node m. The ‘sameGeneration(n1, n2)’ binary relation is inductively
defined using the following two rules:

(1) If n is a node in PC, then the pair (n, n) is in the
sameGeneration relation. (Base rule)

(2) If n1 is the parent of m1 in PC and n2 is the parent of m2 in PC
and (n1,n2) is a pair in the sameGeneration relation then (m1, m2) is
a pair in the sameGeneration relation. (Inductive Rule)

Write a recursive view for the sameGeneration relation. Test your
view.
*/







-- Connect to default database
-- \c postgres

--
-- Drop database created for this assignment
-- DROP DATABASE dvgfall2022assignment2;




