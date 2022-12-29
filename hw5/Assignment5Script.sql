-- Script for Assignment 5  Fall 2022

-- Creating database with full name

CREATE DATABASE dvgfall2022assignment5;


-- Connecting to database 
\c dvgfall2022assignment5

-- Relation schemas and instances for assignment 5


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

create or replace view studentBuysBooks as
   select sid, array(select t.bno
                     from   Buys t
      	      	     where  t.sid = s.sid order by 1) as books
   from   Student s order by 1;

create or replace view bookBoughtByStudents as
   select bno, array(select t.sid
                     from   Buys t
      	      	     where  t.bno = b.bno order by 1) as students
   from   Book b order by 1;


create or replace view studentHasMajors as
   select sid, array(select hm.major
                     from   hasMajor hm
      	      	     where  hm.sid = s.sid order by 1) as majors
   from   Student s order by 1;


create or replace view majorOfStudents as
   select major, array(select hm.sid
                       from   hasMajor hm
      	      	       where  hm.major = m.major order by 1) as students
   from   Major m order by 1;


create or replace view bookCitesBooks as
   select bno, array(select c.bno2
                     from   Cites c
      	      	     where  c.bno1 = b.bno order by 1) as citedBooks
   from   Book b order by 1;


create or replace view bookCitedByBooks as
   select bno, array(select c.bno1
                     from   Cites c
      	      	     where  c.bno2 = b.bno order by 1) as citingBooks
   from   Book b order by 1;

-- We define the following functions and predicates

/*
Functions:
set_union(A,B)               A union B
set_intersection(A,B)        A intersection B
set_difference(A,B)          A - B
add_element(x,A)             {x} union A
remove_element(x,A)          A - {x}
make_singleton(x)            {x}
bag_to_set(A)                coerce a bag A to the corresponding set

Predicates:
is_in(x,A)                   x in A
is_not_in(x,A)               not(x in A)
is_empty(A)                  A is the emptyset
is_not_emptyset(A)           A is not the emptyset
subset(A,B)                  A is a subset of B
superset(A,B)                A is a super set of B
equal(A,B)                   A and B have the same elements
overlap(A,B)                 A intersection B is not empty
disjoint(A,B)                A and B are disjoint 
*/

-- Set Operations: union, intersection, difference

-- Set union $A \cup B$:
create or replace function set_union(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) union select unnest(B) order by 1);
$$ language sql;

-- Set intersection $A\cap B$:
create or replace function set_intersection(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) intersect select unnest(B) order by 1);
$$ language sql;

-- Set difference $A-B$:
create or replace function set_difference(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) except select unnest(B) order by 1);
$$ language sql;


-- Add element to set
create or replace function add_element(x anyelement, A anyarray) 
returns anyarray as
$$
   select bag_to_set(x || A);
$$ language sql;


-- Remove element from set
create or replace function remove_element(x anyelement, A anyarray) 
returns anyarray as
$$
   select array_remove(A, x);
$$ language sql;


-- Make singleton  x --->  {x}

create or replace function make_singleton(x anyelement) 
returns anyarray as
$$
   select add_element(x,'{}');
$$ language sql;


-- Bag operations

-- Bag union 
create or replace function bag_union(A anyarray, B anyarray) 
returns anyarray as
$$
   select A || B;
$$ language sql;

-- bag To set
create or replace function bag_to_set(A anyarray)
returns anyarray as
$$
   select array(select distinct unnest(A) order   by 1);
$$ language sql;


-- Set Predicates: set membership, set non membership, emptyset, subset, superset, overlap, disjoint

-- Set membership $x \in A$:
create or replace function is_in(x anyelement, A anyarray) 
returns boolean as
$$
   select x = SOME(A);
$$ language sql;

-- Set non membership $x \not\in A$:
create or replace function is_not_in(x anyelement, A anyarray) 
returns boolean as
$$
   select not(x = SOME(A));
$$ language sql;

-- emptyset test $A = \emptyset$:
create or replace function is_empty(A anyarray) 
returns boolean as
$$
   select A <@ '{}';
$$ language sql;


-- non emptyset test $A \neq \emptyset$:
create or replace function is_not_empty(A anyarray) 
returns boolean as
$$
   select not(A <@ '{}');
$$ language sql;

-- Subset test $A\subseteq B$:
create or replace function subset(A anyarray, B anyarray) 
returns boolean as
$$
   select A <@ B;
$$ language sql;

-- Superset test $A \supseteq B$:
create or replace function superset(A anyarray, B anyarray) 
returns boolean as
$$
   select A @> B;
$$ language sql;

-- Equality test $A = B$
create or replace function equal(A anyarray, B anyarray) 
returns boolean as
$$
   select A <@ B and A @> B;
$$ language sql;

-- Overlap test $A\cap B \neq \emptyset$:
create or replace function overlap(A anyarray, B anyarray) 
returns boolean as
$$
   select A && B;
$$ language sql;

-- Disjointness test $A\cap B = \emptyset$:
create or replace function disjoint(A anyarray, B anyarray) 
returns boolean as
$$
   select not A && B;
$$ language sql;



\qecho 'Problem 1'

-- Find the sid and name of each student who bought the most books.
with q as (
           select sid, cardinality(books) as bookcount
           from studentBuysBooks
           group by sid, books
)
select s.sid, s.sname
from student s join q on(s.sid=q.sid)
where bookcount=(select max(bookcount) from q);



\qecho 'Problem 2'

-- Find the sid and name of each student who bought the most books
-- that cost strictly more than $25.
with bk_25 as (select bno from book where price > 25),
     s_bk_25 as (select s.sid, 
                        cardinality(set_intersection((select sbk.books from studentBuysBooks sbk where sbk.sid=s.sid),
                                          ARRAY(select * from bk_25))) as bookcount
                 from studentBuysBooks s)

select s.sid, s.sname
from student s natural join s_bk_25
where bookcount=(select max(bookcount) from s_bk_25);


\qecho 'Problem 3'

-- Find the bno and title of each book that is bought by a student who is
-- (strictly) younger than each student who majors in Chemistry and who
-- also bought that book.





with chemistryStudent as (select s.sid, s.birthyear
                          from   Student s
			  where  is_in(s.sid, (select ms.students from majorofstudents ms where ms.major = 'Chemistry')))
			

select distinct b.bno, b.title
from book b, student s, bookboughtbystudents bs
where 
bs.bno = b.bno and is_in(s.sid, bs.students) and 
	s.birthyear > all(select s1.birthyear from chemistryStudent s1, studentbuysbooks sb where is_in(b.bno, sb.books) and s1.sid = sb.sid)
order by 1;



\qecho 'Problem 4'

-- Find each student-book pair (s, b) where s is the sid of a student who
-- majors in CS and who bought each book that costs no more than book b.


select b.bno, s.sid
from   Student s, Book b WHERE is_in(s.sid, (select ms.students from majorofstudents ms where ms.major = 'CS')) and
true = all(select is_in(q.bno, (select sb.books from studentbuysbooks sb where sb.sid = s.sid)) 
		   from (select b1.bno from book b1 where b1.price <= b.price) q )
order by 1,2;


\qecho 'Problem 5'

-- Find the bno and title of each book that cites a book and that was
-- bought by a student who majors in CS but not in Math.


with student as (
	select sm.sid from studenthasmajors sm where is_in('CS', sm.majors) and not is_in('Math', sm.majors))


select b.bno, b.title from book b
where (select cardinality(bc.citedbooks) > 0 from bookcitesbooks bc where bc.bno = b.bno) and 
	true = some(select is_in(s.sid, (select bs.students from bookboughtbystudents bs where bs.bno = b.bno)) from student s) order by 1, 2;



\qecho 'Problem 6'

-- Find each (s, b) pair where s is the sid of a student who bought book
-- b and such that each other book bought by s is a book cited by b.



select sb.sid, b.bno from studentbuysbooks sb, book b

where true = some(select is_in(b.bno, sb.books)) and
true = all(select is_in(r.u, (select bc.citedbooks from bookcitesbooks bc where bc.bno = b.bno)) from 		  
	(select unnest(remove_element(b.bno, sb.books)) as u ) r);



\qecho 'Problem 7'

-- Find each major that is not a major of any person who bought a book
-- with title ‘Databases’ or ‘Complexity’.

with book as (select b.bno from book b where b.title = 'Databases' or b.title = 'Complexity')


select m.major from major m

except 

select unnest(sm.majors) as major from studenthasmajors sm where sm.sid in 
	(select unnest(bs.students) from book b, bookboughtbystudents bs where b.bno = bs.bno);


\qecho 'Problem 8'

-- Find each major that is the major of at least three students who bought
-- a common book.

select distinct ms.major
from majorofstudents ms, bookboughtbystudents bs
where cardinality(bs.students)>=3 and overlap(ms.students,bs.students);

\qecho 'Problem 9'

-- Find each student who has no major in common with those of students
--  who bought a book with title ’Databases’ or ’AI’.

create or replace view studentBuysBookstitle as
   select sid, array(select b.title
                     from   Buys t,book b
      	      	     where  t.sid = s.sid and t.bno=b.bno order by 1) as titles
   from   Student s order by 1;

with studentbuysda as(
select st.sid
from studentbuysbookstitle st
where overlap('{"Databases","AI"}'::text[],st.titles))
--select * from studentbuysda;

select distinct sm1.sid
from studenthasmajors sm1
where true=all(select disjoint(sm1.majors,sm2.majors)
			  from studenthasmajors sm2, studentbuysda sda
			  where sm2.sid=sda.sid and sm1.sid<>sm2.sid);

\qecho 'Problem 10'

-- Find the set of bnos of books that each cite strictly more than 4
-- books and that each are cited by fewer than 2 books. (So this query
-- returns only one object, i.e., the set of bnos specified in the
-- query.)


select bag_to_set(array(select bc.bno from bookcitesbooks bc where cardinality(bc.citedbooks) > 4
intersect
select bced.bno from bookcitedbybooks bced where cardinality(bced.citingbooks) < 2));



\qecho 'Problem 11'

-- Find the sid and name of each student who has all the majors of the
-- combined set of all majors of the oldest students who bought the book
-- with bno 2000.

with studentbuy2000 as(
	select sb.sid
	from studentbuysbooks sb
	where true=is_in(2000,sb.books)),	
oldestbuy2000 as(
select q.sid
from studentbuy2000 q, student s
where q.sid=s.sid and true=all(select s.birthyear<=s2.birthyear
							   from studentbuy2000 q2,student s2
							   where q2.sid=s2.sid))
							   
							   
--select array(select distinct unnest(sm.majors)
--									from studenthasmajors sm, oldestbuy2000 o
--									where sm.sid=o.sid);
select s.sid,s.sname
from student s, studenthasmajors sm
where s.sid=sm.sid and subset(array(select distinct unnest(sm.majors)
									from studenthasmajors sm, oldestbuy2000 o
									where sm.sid=o.sid),sm.majors);
\qecho 'Problem 12'

-- Find the following set of sets
--  {M |M ⊆Major∧|M|≤3}.

with sub1 as (
select array_agg(m.major) as s1major
from Major m
group by major),
sub2 as(
select distinct add_element(m1.major, s1.s1major) as s2major
from Major m1, sub1 s1)
select distinct add_element(m2.major, s2.s2major) as majors
from Major m2, sub2 s2
union
select '{}';



\qecho 'Problem 13'

-- Reconsider Problem 12.
-- Let M denote the set {M | M ⊆ Major ∧ |M| ≤ 3}. Find the following set of sets
-- {X |X ⊆M∧|X|≥2}.

create type majortype as (major text);
create type majortypeset as (majors majortype[]);

with make_sets as (select (make_singleton(row('{}')::majortype)) as majors_display from major 
union
select make_singleton(row(major)::majortype) from major 
union 
select distinct set_union(make_singleton(row(sk1.major)::majortype),make_singleton(row(sk2.major)::majortype)) 
					 as major from major sk1,major sk2 where sk1.major!=sk2.major 
union 
select distinct set_union(make_singleton(row(sk3.major)::majortype),set_union(make_singleton(row(sk1.major)::majortype),make_singleton(row(sk2.major)::majortype))) 
					 as majors from major sk1,major sk2, major sk3 where sk1.major!=sk2.major and sk2.major!=sk3.major and sk1.major!=sk3.major )
select count(1) from(					 
select '{}'
union 
select make_singleton(row(ms.majors_display)::majortypeset) from make_sets ms
union 
select set_union(make_singleton(row(ms1.majors_display)::majortypeset),make_singleton(row(ms2.majors_display)::majortypeset))
from make_sets ms1, make_sets ms2 where row(ms1.majors_display)!=row(ms2.majors_display))q;



\qecho 'Problem 14'


-- Let t be a number called a threshold. We say that an (unordered)
-- triple of different sids {s1, s2, s3} co-occur with frequency at least
-- t if there are at least t books who are each bought by the students
-- s1, s2, and s3.  Write a function coOccur(t integer) that returns the
-- (unordered) triples {s1, s2, s3} of bno that co-occur with frequency
-- at least t.  Test your coOccur function for t in the range [0, 3].

create or replace function cooccur(t integer)
returns table(sid1 int,sid2 int,sid3 int) AS
$$

select distinct sb1.sid,sb2.sid,sb3.sid
from studentbuysbooks sb1, studentbuysbooks sb2, studentbuysbooks sb3
where cardinality(set_intersection(set_intersection(sb1.books, sb2.books),sb3.books))>=t and sb1.sid>sb2.sid and sb2.sid>sb3.sid;

$$language sql;

-- Test with t=0
select count(1)
from cooccur(0);
-- Test with t=1
select count(1)
from cooccur(1);
-- Test with t=2
select count(1)
from cooccur(2);

-- Data for problem 15 through 18
CREATE TABLE student (sid TEXT, sname TEXT, major TEXT, byear INT);
INSERT INTO student VALUES
('s100', 'Eric'  , 'CS'     , 1988),
('s101', 'Nick'  , 'Math'   , 1991),
('s102', 'Chris' , 'Biology', 1977),
('s103', 'Dinska', 'CS'     , 1978),
('s104', 'Zanna' , 'Math'   , 2001),
('s105', 'Vince' , 'CS'     , 2001);
CREATE TABLE course (cno TEXT, cname TEXT, dept TEXT);
INSERT INTO course VALUES
('c200', 'PL'      , 'CS'),
('c201', 'Calculus', 'Math'),
('c202', 'Dbs'     , 'CS'),
('c301', 'AI'      , 'CS'),
('c302', 'Logic'   , 'Philosophy');
CREATE TABLE enroll (sid TEXT, cno TEXT, grade TEXT);
insert into enroll values 
    ('s100','c200', 'A'),
    ('s100','c201', 'B'),
    ('s100','c202', 'A'),
    ('s101','c200', 'B'),
    ('s101','c201', 'A'),
    ('s102','c200', 'B'),
    ('s103','c201', 'A'),
    ('s101','c202', 'A'),
    ('s101','c301', 'C'),
    ('s101','c302', 'A'),
    ('s102','c202', 'A'),
    ('s102','c301', 'B'),
    ('s102','c302', 'A'),
    ('s104','c201', 'D');


\qecho 'problem 15'
-- create nested relation
create type studentsType AS (sid text);
create type courseType AS (cno text);
create type gradeStudentsType AS (grade text, students studentsType[ ]);

create or replace view courseGrades as
with e as (select cno, grade, ARRAY_AGG(ROW(sid)::studentsType) AS students
           from enroll
           group by (cno, grade)),
     f as (select cno, ARRAY_AGG(ROW(grade, students)::gradeStudentsType) as gradeinfo
           from e
           group by cno)
select cno, gradeinfo
from f;

select * from courseGrades
order by cno;

\qecho 'problem 16'

\qecho 'Problem 16.a'

select cg.cno, g.students
from courseGrades cg, unnest(cg.gradeinfo)g
where g.grade = 'A'
order by cno;

\qecho 'Problem 16.b'
select distinct sid, array_agg(row(cg.cno)::courseType) as courses
from courseGrades cg, unnest(cg.gradeinfo)g, unnest(g.students)s
where g.grade='A' or g.grade='B'
group by (sid)
order by sid;


\qecho 'Problem 17'

create or replace view jcourseGrades as
	with e as (select cno, grade, jsonb_agg(jsonb_build_object('sid', sid)) as students
			   from enroll
			   group by (cno, grade)),
	     f as (select jsonb_build_object('cno', cno, 'gradeInfo', 
										 jsonb_agg(jsonb_build_object('grade', grade, 'sid', students))) as courseinfo
			   from e
			   group by cno)
		 select courseinfo from f;

select * from jcourseGrades order by 1;



\qecho 'Problem 18'

\qecho 'Problem 18.a'

select cg.courseinfo->>'cno' as cno, s->>'sid' as sid
from jcourseGrades cg, jsonb_array_elements(cg.courseinfo->'gradeInfo')g, jsonb_array_elements(g->'sid')s
where g->'grade'='"A"'
order by 1;



\qecho 'Problem 18.b'

select distinct add_element(cg.courseinfo->>'cno',make_singleton(cg2.courseinfo->>'cno')) as cnoPair, set_intersection(array_agg(s->>'sid'),array_agg(s2->>'sid')) as sid
from jcourseGrades cg, jsonb_array_elements(cg.courseinfo->'gradeInfo')g, jsonb_array_elements(g->'sid')s,
	 jcourseGrades cg2, jsonb_array_elements(cg2.courseinfo->'gradeInfo')g2, jsonb_array_elements(g2->'sid')s2
where cg.courseinfo->>'cno'<cg2.courseinfo->>'cno' and g->'grade'='"A"' and g2->'grade'='"A"'
group by (cg.courseinfo->>'cno', cg2.courseinfo->>'cno')
union
select distinct add_element(cg.courseinfo->>'cno',make_singleton(cg2.courseinfo->>'cno')) as cnoPair, set_intersection(make_singleton('x'::text), make_singleton('y'::text)) as sid
from jcourseGrades cg, jsonb_array_elements(cg.courseinfo->'gradeInfo')g,
	 jcourseGrades cg2, jsonb_array_elements(cg2.courseinfo->'gradeInfo')g2
where cg.courseinfo->>'cno'<cg2.courseinfo->>'cno' and 
	  ('"A"' not in (select g->'grade' from
				    jcourseGrades cg3, jsonb_array_elements(cg3.courseinfo->'gradeInfo')g
				    where cg3=cg) or
	   '"A"' not in (select g->'grade' from
				    jcourseGrades cg4, jsonb_array_elements(cg4.courseinfo->'gradeInfo')g
				    where cg4=cg2))
group by (cg.courseinfo->>'cno', cg2.courseinfo->>'cno');





-- Connect to default database
\c postgres

-- Drop database created for this assignment

DROP DATABASE dvgfall2022assignment5;



