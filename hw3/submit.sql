-- Script for Assignment 3
\qecho TEAM 37
\qecho Jia Wang, Xiao Wang, Yiyin Jiang, Yu Mo
-- Creating database with full name

CREATE DATABASE dvgassignment3;

-- Connecting to database 
\c dvgassignment3

-- Relation schemas and instances for assignment 2

CREATE TABLE Person(pid integer,
                    pname text,
                    city text,
                    primary key (pid));

CREATE TABLE Company(cname text,
                     headquarter text,
                     primary key (cname));

CREATE TABLE Skill(skill text,
                   primary key (skill));


CREATE TABLE worksFor(pid integer,
                      cname text,
                      salary integer,
                      primary key (pid),
                      foreign key (pid) references Person (pid),
                      foreign key (cname) references Company(cname));


CREATE TABLE companyLocation(cname text,
                             city text,
                             primary key (cname, city),
                             foreign key (cname) references Company (cname));


CREATE TABLE personSkill(pid integer,
                         skill text,
                         primary key (pid, skill),
                         foreign key (pid) references Person (pid) on delete cascade,
                         foreign key (skill) references Skill (skill) on delete cascade);


CREATE TABLE hasManager(eid integer,
                        mid integer,
                        primary key (eid, mid),
                        foreign key (eid) references Person (pid),
                        foreign key (mid) references Person (pid));

CREATE TABLE Knows(pid1 integer,
                   pid2 integer,
                   primary key(pid1, pid2),
                   foreign key (pid1) references Person (pid),
                   foreign key (pid2) references Person (pid));



INSERT INTO Person VALUES
     (1001,'Jean','Cupertino'),
     (1002,'Vidya', 'Cupertino'),
     (1003,'Anna', 'Seattle'),
     (1004,'Qin', 'Seattle'),
     (1005,'Megan', 'MountainView'),
     (1006,'Ryan', 'Chicago'),
     (1007,'Danielle','LosGatos'),
     (1008,'Emma', 'Bloomington'),
     (1009,'Hasan', 'Bloomington'),
     (1010,'Linda', 'Chicago'),
     (1011,'Nick', 'MountainView'),
     (1012,'Eric', 'Cupertino'),
     (1013,'Lisa', 'Indianapolis'), 
     (1014,'Deepa', 'Bloomington'), 
     (1015,'Chris', 'Denver'),
     (1016,'YinYue', 'Chicago'),
     (1017,'Latha', 'LosGatos'),
     (1018,'Arif', 'Bloomington'),
     (1019,'John', 'NewYork');

INSERT INTO Company VALUES
     ('Apple', 'Cupertino'),
     ('Amazon', 'Seattle'),
     ('Google', 'MountainView'),
     ('Netflix', 'LosGatos'),
     ('Microsoft', 'Redmond'),
     ('IBM', 'NewYork'),
     ('ACM', 'NewYork'),
     ('Yahoo', 'Sunnyvale');


INSERT INTO worksFor VALUES
     (1001,'Apple', 65000),
     (1002,'Apple', 45000),
     (1003,'Amazon', 55000),
     (1004,'Amazon', 55000),
     (1005,'Google', 60000),
     (1006,'Amazon', 60000),
     (1007,'Netflix', 50000),
     (1008,'Amazon', 50000),
     (1009,'Apple',60000),
     (1010,'Amazon', 55000),
     (1011,'Google', 70000), 
     (1012,'Apple', 45000),
     (1013,'Yahoo', 55000),
     (1014,'Apple', 50000), 
     (1015,'Amazon', 60000),
     (1016,'Amazon', 55000),
     (1017,'Netflix', 60000),
     (1018,'Apple', 50000),
     (1019,'Microsoft', 50000);

INSERT INTO companyLocation VALUES
   ('Apple', 'Bloomington'),
   ('Amazon', 'Chicago'),
   ('Amazon', 'Denver'),
   ('Amazon', 'Columbus'),
   ('Google', 'NewYork'),
   ('Netflix', 'Indianapolis'),
   ('Netflix', 'Chicago'),
   ('Microsoft', 'Bloomington'),
   ('Apple', 'Cupertino'),
   ('Amazon', 'Seattle'),
   ('Google', 'MountainView'),
   ('Netflix', 'LosGatos'),
   ('Microsoft', 'Redmond'),
   ('IBM', 'NewYork'),
   ('Yahoo', 'Sunnyvale');

INSERT INTO Skill VALUES
   ('Programming'),
   ('AI'),
   ('Networks'),
   ('OperatingSystems'),
   ('Databases');

INSERT INTO personSkill VALUES
 (1001,'Programming'),
 (1001,'AI'),
 (1002,'Programming'),
 (1002,'AI'),
 (1004,'AI'),
 (1004,'Programming'),
 (1005,'AI'),
 (1005,'Programming'),
 (1005,'Networks'),
 (1006,'Programming'),
 (1006,'OperatingSystems'),
 (1007,'OperatingSystems'),
 (1007,'Programming'),
 (1009,'OperatingSystems'),
 (1009,'Networks'),
 (1010,'Networks'),
 (1011,'Networks'),
 (1011,'OperatingSystems'),
 (1011,'AI'),
 (1011,'Programming'),
 (1012,'AI'),
 (1012,'OperatingSystems'),
 (1012,'Programming'),
 (1013,'Programming'),
 (1013,'OperatingSystems'),
 (1013,'Networks'),
 (1014,'OperatingSystems'),
 (1014,'AI'),
 (1014,'Networks'),
 (1015,'Programming'),
 (1015,'AI'),
 (1016,'OperatingSystems'),
 (1016,'AI'),
 (1017,'Networks'),
 (1017,'Programming'),
 (1018,'AI'),
 (1019,'Networks');

INSERT INTO hasManager VALUES
 (1004, 1003),
 (1006, 1003),
 (1015, 1003),
 (1016, 1004),
 (1016, 1006),
 (1008, 1015),
 (1010, 1008),
 (1013, 1007),
 (1017, 1013),
 (1002, 1001),
 (1009, 1001),
 (1014, 1012),
 (1011, 1005);


INSERT INTO Knows VALUES
 (1011,1009),
 (1007,1016),
 (1011,1010),
 (1003,1004),
 (1006,1004),
 (1002,1014),
 (1009,1005),
 (1018,1009),
 (1007,1017),
 (1017,1019),
 (1019,1013),
 (1016,1015),
 (1001,1012),
 (1015,1011),
 (1019,1006),
 (1013,1002),
 (1018,1004),
 (1013,1007),
 (1014,1006),
 (1004,1014),
 (1001,1014),
 (1010,1013),
 (1010,1014),
 (1004,1019),
 (1018,1007),
 (1014,1005),
 (1015,1018),
 (1014,1017),
 (1013,1018),
 (1007,1008),
 (1005,1015),
 (1017,1014),
 (1015,1002),
 (1018,1013),
 (1018,1010),
 (1001,1008),
 (1012,1011),
 (1002,1015),
 (1007,1013),
 (1008,1007),
 (1004,1002),
 (1015,1005),
 (1009,1013),
 (1004,1012),
 (1002,1011),
 (1004,1013),
 (1008,1001),
 (1008,1019),
 (1019,1008),
 (1001,1019),
 (1019,1001),
 (1004,1003),
 (1006,1003),
 (1015,1003),
 (1016,1004),
 (1016,1006),
 (1008,1015),
 (1010,1008),
 (1017,1013),
 (1002,1001),
 (1009,1001),
 (1011,1005),
 (1014,1012);





\qecho 'Problem 1'

create table E1 (x integer);
create table E2 (x integer);
create table F (c text);

\qecho 'Problem 1.a'

-- Write an RA expression in standard notation that expresses this
-- if-then-else query


create view ifthen as
select q1.*
from (select e1.*
	  from E1 e1
	  except
	  select e1.*
	  from E1 e1 cross join F f
	 )q1
union
select distinct q2.*
from (select e2.*
	  from E2 e2 cross join F f
	 )q2;


insert into E1 values (1), (2);
insert into E2 values (3), (4);

\qecho 'Problem 1.b'

-- Test you solution for the following E1, E2, and F
-- Note F is the empty set
select * from ifthen
order by x;
\qecho 'Problem 1.c'

-- Test you solution for the following E1, E2, and F

insert into F values ('a'), ('b'), ('c');

-- Note that F is not an empty set.

select * from ifthen
order by x;

drop view ifthen;

\qecho 'Problem 2'

-- Consider the following boolean SQL query:

drop table F;

create table F(x integer, y integer);

select true = all (select p1 = p2
                   from   F p1, F p2
                   where  p1.x = p2.x)  "isaFunction";

\qecho 'Problem 2.a'

-- Using the insights you gained from Problem 1, write an RA SQL query
-- that expresses the above boolean SQL query.

select((select TRUE
except
select true
from F p1 join F p2 on p1.x=p2.x and p1<>p2)
union
select distinct false
from F p1 join F p2 on p1.x=p2.x and p1<>p2) "isaFunction";

\qecho 'Problem 2.b'

-- Test your query for F = {}

select((select TRUE
except
select true
from F p1 join F p2 on p1.x=p2.x and p1<>p2)
union
select distinct false
from F p1 join F p2 on p1.x=p2.x and p1<>p2) "isaFunction";

\qecho 'Problem 2.c'

-- Test your query for F = {(1,10),(2,20)}

insert into F values (1,10), (2,20);
select((select TRUE
except
select true
from F p1 join F p2 on p1.x=p2.x and p1<>p2)
union
select distinct false
from F p1 join F p2 on p1.x=p2.x and p1<>p2) "isaFunction";



\qecho 'Problem 2.d'

-- Test your query for F = {(1,10),(1,20),(2,20)}

insert into F values (1,20);

select((select TRUE
except
select true
from F p1 join F p2 on p1.x=p2.x and p1<>p2)
union
select distinct false
from F p1 join F p2 on p1.x=p2.x and p1<>p2) "isaFunction";

drop table F;

\qecho 'Problem 6'

/*
Consider the query “Find the pid and pname of each persons who knows
no-one who works for the Apple company.” 

A possible way to write this
query in Pure SQL is
*/

select p.pid, p.pname
from   Person p
where  false = all (select exists (select 1
                                   from   worksFor w
                                   where  p1.pid = w.pid and w.cname = 'Apple') and
                           (p.pid,p1.pid) = some (select k.pid1, k.pid2
                                                  from   Knows k)                                            
                    from   Person p1);

\qecho 'Problem 6a.'

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

-- 'false=all(..)' is equivalent to 'not true=some(..)'
-- remove 'not' in where clause
select q.pid, q.pname from(
select p.*
from   Person p
except
select p.*
from Person p, Person p1
where exists (select 1
			   from   worksFor w
			   where  p1.pid = w.pid and w.cname = 'Apple') 
				and(p.pid,p1.pid) = some (select k.pid1, k.pid2 from Knows k)                                            
                    )q;
					
-- remove 'exist' in where clause	
select q.pid, q.pname 
from(
select p.*
from   Person p
except
select p.*
from Person p, Person p1, worksFor w
where p1.pid = w.pid and w.cname = 'Apple' and (p.pid,p1.pid) = some (select k.pid1, k.pid2 from   Knows k)                                            
                    )q;
					
-- remove 'and' in where clause		
select q.pid, q.pname 
from(
select p.*
from   Person p
except
select q1.id, q1.name, q1.c from(
select p.pid as id, p.pname as name, p.city as c, p1.*, w.*
from Person p, Person p1, worksFor w
where p1.pid = w.pid and w.cname = 'Apple' 
intersect
select p.pid as id, p.pname as name, p.city as c, p1.*, w.*
from Person p, Person p1, worksFor w
where (p.pid,p1.pid) = some (select k.pid1, k.pid2 from  Knows k))q1                                            
                    )q;
					
					
-- remove '(..)=some' in where clause				
select q.pid, q.pname 
from(
select p.*
from   Person p
except
select q1.id, q1.name, q1.c from(
select p.pid as id, p.pname as name, p.city as c, p1.*, w.*
from Person p, Person p1, worksFor w
where p1.pid = w.pid and w.cname = 'Apple' 
intersect
select p.pid as id, p.pname as name, p.city as c, p1.*, w.*
from Person p, Person p1, worksFor w, Knows k
where (p.pid,p1.pid)=(k.pid1, k.pid2) )q1                                            
                    )q;
					
					
-- introduce natural join and join
select q.pid, q.pname 
from(
select p.*
from   Person p
except
select q1.id, q1.name, q1.c from(
select p.pid as id, p.pname as name, p.city as c, p1.*, w.*
from (Person p cross join Person p1) join worksFor w on (p1.pid = w.pid and w.cname = 'Apple' )
intersect
select p.pid as id, p.pname as name, p.city as c, p1.*, w.*
from Person p cross join Person p1 cross join worksFor w join Knows k on (p.pid,p1.pid)=(k.pid1, k.pid2) 
)q1                                            
)q;


\qecho 'Problem 6b.'

-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.


-- rewrite 1
-- Elimination  for successive projection operation
-- remove '(..)q' and  irrelevant attributes
select p.pid, p.pname
from   Person p
except
select q1.id, q1.name from(
select p.pid as id, p.pname as name, p1.*, w.*
from (Person p cross join Person p1) join worksFor w on (p1.pid = w.pid and w.cname = 'Apple' )
intersect
select p.pid as id, p.pname as name, p1.*, w.*
from Person p cross join Person p1 cross join worksFor w join Knows k on (p.pid,p1.pid)=(k.pid1, k.pid2) 
)q1;


-- rewrite 2
-- Pushing down selections over joins
select p.pid, p.pname
from  Person p
except
select q1.id, q1.name from(
select p.pid as id, p.pname as name, p1.*, w.*
-- keep relevant attributes
from (select p.pid, p.pname from Person p)p cross join (select p1.pid, p1.pname from Person p1)p1 join worksFor w on (p1.pid = w.pid and w.cname = 'Apple' )
intersect
select p.pid as id, p.pname as name, p1.*, w.*
-- keep relevant attributes
from (select p.pid, p.pname from Person p)p cross join (select p1.pid, p1.pname from Person p1)p1 cross join worksFor w join Knows k on (p.pid,p1.pid)=(k.pid1, k.pid2) 
)q1;


-- rewrite 3
-- Distribution over 'except'

with pkns as (
	select p.pid, p.pname, ks.pid2
	from Person p join knows ks on (p.pid=ks.pid1)
	),
	
	apple_staff as (
	select q.pid2 
	 from 
	 (select w.pid as pid2
	   from  Person p1 natural join (select w.pid from  worksfor w where w.cname = 'Apple')w
	   intersect
	   select ks.pid2 as pid2
	   from Person p1 join knows ks on (p1.pid=ks.pid2))q
	)
select q.pid, q.pname
from ( select pid, pname
	   from pkns
	   except
	   select pid, pname
	   from pkns p join apple_staff astf on (p.pid2=astf.pid2)
	  )q
order by pid;

\qecho 'Problem 7a.'

/*
Find each pair $(c,p)$ where $c$ is the cname of a company and $p$ is
the pid of a person who works for that company and who earns strictly
more than all other persons who work for that company and who earns
more than 60000


A possible way to write this
query in Pure SQL is*/

select c.cname, p.pid
from   Company c, Person p
where  p.pid in (select w.pid
                 from   worksFor w
                 where  w.cname = c.cname and
                        true = all (select w1.salary <= 60000
                                    from   worksFor w1
                                    where  p.pid != w1.pid and 
                                           w1.cname = c.cname and
                                           w.salary <= w1.salary));

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.


-- try to eliminate "in" first 


select DISTINCT c.cname, p.pid
from   Company c, Person p, worksFor w
where p.pid = w.pid and w.cname = c.cname and true = all(select w1.salary <= 60000
                                    from   worksFor w1
                                    where  p.pid != w1.pid and 
                                           w1.cname = c.cname and
                                           w.salary <= w1.salary) order by c.cname, p.pid;


-- then eliminate "and" in where 
select distinct q.ccname, q.ppid

From(

select c.cname as ccname, p.pid as ppid, w.*
from   Company c, Person p, worksFor w
where p.pid = w.pid and w.cname = c.cname 	
		
intersect 
	
select c.cname, p.pid, w.*
from Company c, Person p, worksFor w	
where true = all (select w1.salary <= 60000
                            from   worksFor w1
                             where  p.pid != w1.pid and 
                                           w1.cname = c.cname and
                                           w.salary <= w1.salary)
)q order by q.ccname, q.ppid;






-- then eliminate "and" in the first subquery where
select distinct q.ccname, q.ppid

From(

select q1.ccname, q1.ppid, q1.wpid, q1.wcname, q1.wsalary from
	
	
(select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary
from Company c, Person p, worksFor w 
where p.pid = w.pid
	
INTERSECT
	
select c.cname, p.pid, w.*
from Company c, Person p, worksFor w	
where w.cname = c.cname ) q1

	
intersect 

	
select c.cname, p.pid, w.*
from Company c, Person p, worksFor w	
where true = all (select w1.salary <= 60000
                            from   worksFor w1
                             where  p.pid != w1.pid and 
                                           w1.cname = c.cname and
                                           w.salary <= w1.salary)
)q order by q.ccname, q.ppid;



-- m1.2 eliminate "true = all()", "where" * 2 subordinately

select distinct q.ccname, q.ppid

From(

select q1.ccname, q1.ppid, q1.wpid, q1.wcname, q1.wsalary from
	
	
(select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary
from Company c cross join (Person p natural join worksFor w) 

	
INTERSECT
	
select c.cname, p.pid, w.*
from Person p cross join (worksFor w natural join Company c)
) q1

	
intersect 

(select q2.ccname, q2.ppid, q2.wpid, q2.wcname, q2.wsalary from

(select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary
from Company c cross join Person p cross join worksFor w

EXCEPT

select c.cname, p.pid, w.*
from Company c, Person p, worksFor w, worksFor w1	
where  p.pid != w1.pid and w1.cname = c.cname and w.salary <= w1.salary and w1.salary > 60000)q2)
	
)q;




-- eliminate "and", "> = < " in the where subquery "except" query


select distinct q.ccname, q.ppid

From(

select q1.ccname, q1.ppid, q1.wpid, q1.wcname, q1.wsalary from
	
	
(select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary
from Company c cross join (Person p natural join worksFor w) 

	
INTERSECT
	
select c.cname, p.pid, w.*
from Person p cross join (worksFor w natural join Company c)
) q1

	
intersect 

(select q2.ccname, q2.ppid, q2.wpid, q2.wcname, q2.wsalary from

(select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary
from Company c cross join Person p cross join worksFor w

EXCEPT
(
select distinct q3.ccname, q3.ppid, q3.wpid, q3.wcname, q3.wsalary from (
	
select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary, w1.*
	from (Company c natural join (select * from worksFor w1 where w1.salary > 60000) w1) cross join Person p cross join worksFor w

intersect 

select c.cname, p.pid, w.*, w1.*
	from Company c cross join (Person p join (worksFor w join worksFor w1 on w.salary <= w1.salary) on  p.pid != w1.pid) )q3))q2)
	
)q;





\qecho 'Problem 7b.'


-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.


--rule 1: rewrite projections of pi and natural join, eliminate unnessasry attributes of w1
select distinct q.ccname, q.ppid

From(

select q1.ccname, q1.ppid, q1.wpid, q1.wcname, q1.wsalary from
	
	
(select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary
from Company c cross join (Person p natural join worksFor w) 
	
INTERSECT
	
select c.cname, p.pid, w.*
from Person p cross join (worksFor w natural join Company c)
) q1

	
intersect 

(select q2.ccname, q2.ppid, q2.wpid, q2.wcname, q2.wsalary from

(select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary
from Company c cross join Person p cross join worksFor w

EXCEPT
(
select distinct q3.ccname, q3.ppid, q3.wpid, q3.wcname, q3.wsalary from (

-- rewrite projections of pi and natural join, eliminate unnessasry attributes of w1, [example 1 slides]	
select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary, w1.cname
	from (select c.cname from company c) c natural join (select w1.cname from worksFor w1 where w1.salary > 60000) w1 cross join Person p cross join worksFor w

intersect 

select c.cname, p.pid, w.*, w1.cname
	from Company c cross join (Person p join (worksFor w join worksFor w1 on w.salary <= w1.salary) on  p.pid != w1.pid) )q3))q2)
	
)q;



--rule 2 eliminate some attributes of w and project cname out of c


select distinct q.ccname, q.ppid

From(

select q1.ccname, q1.ppid, q1.wsalary from
	
	
(select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary
from Company c cross join (Person p natural join worksFor w) 
	
INTERSECT
	
select c.cname, p.pid, w.*
from Person p cross join (worksFor w natural join Company c)
) q1

	
intersect 

(select q2.ccname, q2.ppid, q2.wsalary from

(select c.cname as ccname, p.pid as ppid, w.salary as wsalary
from Company c cross join Person p cross join worksFor w

EXCEPT
(
select distinct q3.ccname, q3.ppid, q3.wsalary from (

-- rewrite projections of pi and natural join, eliminate unnessasry attributes of w1	
select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary, w1.cname
	from (select c.cname from company c) c natural join (select w1.cname from worksFor w1 where w1.salary > 60000) w1 cross join Person p cross join worksFor w

intersect 


-- project out cname from c
select c.cname, p.pid, w.*, w1.cname
	from (select cname from Company )c cross join ((select pid from Person) p join (worksFor w join worksFor w1 on w.salary <= w1.salary) on  p.pid != w1.pid) 
)q3))q2)
	
)q;



--rule 3 intersection is natural join 



select distinct q.ccname, q.ppid

From(

(select q1.ccname, q1.ppid, q1.wsalary from
	
	
(select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary
from Company c cross join (Person p natural join worksFor w) 
	
INTERSECT
	
select c.cname, p.pid, w.*
from Person p cross join (worksFor w natural join Company c)
) q1)q11

-- covert intersect to natural join	!
natural join 

(select q2.ccname, q2.ppid, q2.wsalary from

(select c.cname as ccname, p.pid as ppid, w.salary as wsalary
from Company c cross join Person p cross join worksFor w

EXCEPT
(
select distinct q3.ccname, q3.ppid, q3.wsalary from (

-- rewrite projections of pi and natural join, eliminate unnessasry attributes of w1	
select c.cname as ccname, p.pid as ppid, w.pid as wpid, w.cname as wcname, w.salary as wsalary, w1.cname
	from (select c.cname from company c) c natural join (select w1.cname from worksFor w1 where w1.salary > 60000) w1 cross join Person p cross join worksFor w

intersect 


-- project out cname from c
select c.cname, p.pid, w.*, w1.cname
	from (select cname from Company )c cross join ((select pid from Person) p join (worksFor w join worksFor w1 on w.salary <= w1.salary) on  p.pid != w1.pid) 
)q3))q2)q22
	
)q;






\qecho 'Problem 8a.'

/*Find the pid of each person who has all-but-one job skill

A possible way to write this
query in Pure SQL is*/

select p.pid
from   person p
where  exists (select 1
               from   skill s
               where  not (p.pid, s.skill) in (select ps.pid, ps.skill
                                               from   personSkill ps)) and
       true = all (select s1.skill = s2.skill
                   from   skill s1, skill s2
                   where  (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                    from   personSkill ps) and
                          (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                    from   personSkill ps));
		    
-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

-- Translation of 'and' in the 'where' clause
select q.pid from(
select p.*
from   person p
where  exists (select 1
               from   skill s
               where  not (p.pid, s.skill) in (select ps.pid, ps.skill
                                               from   personSkill ps))
intersect
select p.*
from   person p
where  true = all (select s1.skill = s2.skill
                   from   skill s1, skill s2
                   where  (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                    from   personSkill ps) and
                          (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                    from   personSkill ps))
)q;

-- Translation of 'exists' and 'true=all'
select q.pid from(
select distinct p.*
from   person p, skill s
where  not (p.pid, s.skill) in (select ps.pid, ps.skill
                                from   personSkill ps)
intersect
(select p.*
from person p
except
select p.*
from person p, skill s1, skill s2
where (p.pid, s1.skill) not in (select ps.pid, ps.skill 
								from   personSkill ps) and
	  (p.pid, s2.skill) not in (select ps.pid, ps.skill 
								from   personSkill ps) and
	  s1.skill <> s2.skill)
)q;

-- Translation of 'not in' and 'and' in where clause
select q.pid from(
	select q1.pid, q1.pname, q1.city from(
		select distinct p.*, s.*
		from person p, skill s
		except 
		select p.*, s.*
		from person p, skill s, personSkill ps
		where p.pid=ps.pid and s.skill=ps.skill)q1
	intersect(
	select p.*
	from person p
	except
	select q2.pid, q2.pname, q2.city from(
		select p.*, s1.*, s2.*
		from person p, skill s1, skill s2
		where s1.skill<>s2.skill 
		except(
		select p.*, s1.*, s2.*
		from person p, skill s1, skill s2, personSkill ps
		where p.pid=ps.pid and s1.skill=ps.skill
		union
		select p.*, s1.*, s2.*
		from person p, skill s1, skill s2, personSkill ps
		where p.pid=ps.pid and s2.skill=ps.skill
		))q2)
)q;

-- Introduction of natural join and join
select q.pid from(
	select q1.pid, q1.pname, q1.city from(
		select distinct p.*, s.*
		from person p cross join skill s
		except 
		select p.*, s.*
		from person p join personSkill ps on (p.pid=ps.pid) join skill s on (s.skill=ps.skill)
		)q1
	intersect(
	select p.*
	from person p
	except
	select q2.pid, q2.pname, q2.city from(
		select p.*, s1.*, s2.*
		from person p cross join skill s1 join skill s2 on (s1.skill<>s2.skill)
		except(
		select p.*, s1.*, s2.*
		from person p join personSkill ps on (p.pid=ps.pid) join skill s1 on (s1.skill=ps.skill) cross join skill s2
		union
		select p.*, s1.*, s2.*
		from person p join personSkill ps on (p.pid=ps.pid) join skill s2 on (s2.skill=ps.skill) cross join skill s1
		))q2)
)q;



\qecho 'Problem 8b.'

-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.

-- Use the 'primary keys and distribution of projection over intersection and
-- set difference' rule to eliminate some attributes
select q1.pid from(
	select distinct p.pid, s.*
	from person p cross join skill s
	except 
	select p.pid, s.*
	from person p join personSkill ps on (p.pid=ps.pid) join skill s on (s.skill=ps.skill)
	)q1
intersect(
select p.pid
from person p
except
select q2.pid from(
	select p.pid, s1.*, s2.*
	from person p cross join skill s1 join skill s2 on (s1.skill<>s2.skill)
	except(
	select p.pid, s1.*, s2.*
	from person p join personSkill ps on (p.pid=ps.pid) join skill s1 on (s1.skill=ps.skill) cross join skill s2
	union
	select p.pid, s1.*, s2.*
	from person p join personSkill ps on (p.pid=ps.pid) join skill s2 on (s2.skill=ps.skill) cross join skill s1
	))q2);

-- Push the projection over the join
select q1.pid from(
	select distinct p1.pid, s.*
	from (select p.pid from person p)p1 cross join skill s
	except 
	select p1.pid, s.*
	from (select p.pid from person p)p1 join personSkill ps on (p1.pid=ps.pid) join skill s on (s.skill=ps.skill)
	)q1
intersect(
select p.pid
from person p
except
select q2.pid from(
	select p1.pid, s1.*, s2.*
	from (select p.pid from person p)p1 cross join skill s1 join skill s2 on (s1.skill<>s2.skill)
	except(
	select p1.pid, s1.*, s2.*
	from (select p.pid from person p)p1 join personSkill ps on (p1.pid=ps.pid) join skill s1 on (s1.skill=ps.skill) cross join skill s2
	union
	select p1.pid, s1.*, s2.*
	from (select p.pid from person p)p1 join personSkill ps on (p1.pid=ps.pid) join skill s2 on (s2.skill=ps.skill) cross join skill s1
	))q2);

-- Simplify the set operations. The previous version can be viewed as E intersect (F except G),
-- which is equivalent to (E intercept F) except G. Then observe that, E is a subset of F in this
-- case, since F contains all the tuples in table Person. Therefore, (E intercept F) = E, and 
-- therefore (E intercept F) except G can be replaced by E except G.
select q1.pid from(
	select distinct p1.pid, s.*
	from (select p.pid from person p)p1 cross join skill s
	except 
	select p1.pid, s.*
	from (select p.pid from person p)p1 join personSkill ps on (p1.pid=ps.pid) join skill s on (s.skill=ps.skill)
	)q1
except
select q2.pid from(
	select p1.pid, s1.*, s2.*
	from (select p.pid from person p)p1 cross join skill s1 join skill s2 on (s1.skill<>s2.skill)
	except(
	select p1.pid, s1.*, s2.*
	from (select p.pid from person p)p1 join personSkill ps on (p1.pid=ps.pid) join skill s1 on (s1.skill=ps.skill) cross join skill s2
	union
	select p1.pid, s1.*, s2.*
	from (select p.pid from person p)p1 join personSkill ps on (p1.pid=ps.pid) join skill s2 on (s2.skill=ps.skill) cross join skill s1
	))q2;



\qecho 'Problem 9a.'

/*
Consider the query ``\emph{Find the cname of each company that (1) is
not located in Chicago, (2) employs at least one person and (3) whose
workers who make strictly less 60000 neither have the programming
skill nor the AI skill

A possible way to write this
query in Pure SQL is*/

select c.cname
from   company c
where  c.cname in (select w.cname
                   from   worksfor w 
                   where  not exists (select 1
                                      from   companyLocation cl 
                                      where  w.cname = cl.cname and 
                                             cl.city = 'Chicago')) and
       true = all (select p.pid not in (select ps.pid
                                         from   personSkill ps
                                         where  ps.skill = 'Programming' or
                                                ps.skill = 'AI')
                   from   Person p
                   where  p.pid in (select w.pid
                                     from   worksFor w
                                     where  w.cname = c.cname and
                                            w.salary < 60000));

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

-- Translate the 'and' in where clause
select q.cname from (
	select c.*
	from   company c
	where  c.cname in (select w.cname
					   from   worksfor w 
					   where  not exists (select 1
										  from   companyLocation cl 
										  where  w.cname = cl.cname and 
												 cl.city = 'Chicago'))
	intersect
	select c.*
	from   company c
	where  true = all (select p.pid not in (select ps.pid
											 from   personSkill ps
											 where  ps.skill = 'Programming' or
													ps.skill = 'AI')
					   from   Person p
					   where  p.pid in (select w.pid
										 from   worksFor w
										 where  w.cname = c.cname and
												w.salary < 60000))
)q;     

-- Translate outer 'in' and 'true=all'
select q.cname from (
	select c.*
	from   company c, worksfor w
	where  c.cname=w.cname and not exists (select 1
										  from   companyLocation cl 
										  where  w.cname = cl.cname and 
												 cl.city = 'Chicago')
	intersect(
	select c.*
	from company c
	except
	select c.*
	from company c, Person p
	where p.pid in (select w.pid
					 from   worksFor w
					 where  w.cname = c.cname and
							w.salary < 60000) and
		  p.pid in (select ps.pid
					 from   personSkill ps
					 where  ps.skill = 'Programming' or
							ps.skill = 'AI'))
)q; 

-- Translate 'and not exists' and 'in'
select q.cname from (
	select q2.cname, q2.headquarter from (
		select c.*, w.pid, w.cname as cname1, w.salary
		from   company c, worksfor w
		where c.cname=w.cname
		except
		select c.*, w.pid, w.cname as cname1, w.salary
		from company c, worksfor w, companyLocation cl
		where c.cname=w.cname and w.cname=cl.cname and cl.city='Chicago')q2	
	intersect(
	select c.*
	from company c
	except
	select q3.cname, q3.headquarter from(
		select c.*, p.*
		from company c, Person p, worksFor w
		where p.pid=w.pid and w.cname=c.cname and w.salary<60000
		intersect
		select c.*, p.*
		from company c, Person p, personSkill ps
		where p.pid=ps.pid and (ps.skill='Programming' or ps.skill='AI')
		)q3)
)q; 

-- Move constant condition
select q.cname from (
	select q2.cname, q2.headquarter from (
		select c.*, w.pid, w.cname as cname1, w.salary
		from   company c, worksfor w
		where c.cname=w.cname
		except
		select c.*, w.pid, w.cname as cname1, w.salary
		from company c, worksfor w, (select cl.* from companyLocation cl where cl.city='Chicago')cl
		where c.cname=w.cname and w.cname=cl.cname)q2	
	intersect(
	select c.*
	from company c
	except
	select q3.cname, q3.headquarter from(
		select c.*, p.*
		from company c, Person p, (select w.* from worksFor w where w.salary<60000)w
		where p.pid=w.pid and w.cname=c.cname
		intersect
		select c.*, p.*
		from company c, Person p, (select ps.* from personSkill ps where ps.skill='Programming' or ps.skill='AI')ps
		where p.pid=ps.pid
		)q3)
)q; 

-- Introduction of natural join and join
select q.cname from (
	select q2.cname, q2.headquarter from (
		select c.*, w.pid, w.cname as cname1, w.salary
		from company c natural join worksfor w
		except
		select c.*, w.pid, w.cname as cname1, w.salary
		from company c natural join worksfor w natural join (select cl.* from companyLocation cl where cl.city='Chicago')cl
		)q2	
	intersect(
	select c.*
	from company c
	except
	select q3.cname, q3.headquarter from(
		select c.*, p.*
		from Person p natural join (select w.* from worksFor w where w.salary<60000)w natural join company c
		intersect
		select c.*, p.*
		from company c cross join Person p natural join (select ps.* from personSkill ps where ps.skill='Programming' or ps.skill='AI')ps
		)q3)
)q; 


\qecho 'Problem 9b.'
	       
-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.

-- Use the 'primary keys and distribution of projection over intersection and
-- set difference' rule to eliminate some attributes
select q2.cname from (
	select c.cname, w.pid, w.cname as cname1, w.salary
	from company c natural join worksfor w
	except
	select c.cname, w.pid, w.cname as cname1, w.salary
	from company c natural join worksfor w natural join (select cl.* from companyLocation cl where cl.city='Chicago')cl
	)q2	
intersect(
select c.cname
from company c
except
select q3.cname from(
	select c.cname, p.*
	from Person p natural join (select w.* from worksFor w where w.salary<60000)w natural join company c
	intersect
	select c.cname, p.*
	from company c cross join Person p natural join (select ps.* from personSkill ps where ps.skill='Programming' or ps.skill='AI')ps
	)q3); 

-- Push the projection over the join
(
select c.cname
from (select c.cname from company c)c natural join (select w.cname from worksfor w)w
except
select c.cname
from (select c.cname from company c)c natural join (select w.cname from worksfor w)w natural join (select cl.cname from companyLocation cl where cl.city='Chicago')cl
)
intersect(
select c.cname
from company c
except
select q3.cname from(
	select c.cname, p.pid
	from (select p.pid from Person p)p natural join (select w.pid, w.cname from worksFor w where w.salary<60000)w natural join (select c.cname from company c)c
	intersect
	select c.cname, p.pid
	from (select c.cname from company c)c cross join (select p.pid from Person p)p natural join (select ps.pid from personSkill ps where ps.skill='Programming' or ps.skill='AI')ps
	)q3); 

-- Simplify the set operations. The previous version can be viewed as E intersect (F except G),
-- which is equivalent to (E intercept F) except G. Then observe that, E is a subset of F in this
-- case, since F contains all the tuples in table Person. Therefore, (E intercept F) = E, and 
-- therefore (E intercept F) except G can be replaced by E except G.
select c.cname
from (select c.cname from company c)c natural join (select w.cname from worksfor w)w
except
select c.cname
from (select c.cname from company c)c natural join (select w.cname from worksfor w)w natural join (select cl.cname from companyLocation cl where cl.city='Chicago')cl
except
select q3.cname from(
	select c.cname, p.pid
	from (select p.pid from Person p)p natural join (select w.pid, w.cname from worksFor w where w.salary<60000)w natural join (select c.cname from company c)c
	intersect
	select c.cname, p.pid
	from (select c.cname from company c)c cross join (select p.pid from Person p)p natural join (select ps.pid from personSkill ps where ps.skill='Programming' or ps.skill='AI')ps
	)q3;

	 

\qecho 'Problem 10a'

-- Consider the following Pure SQL query.

select p.pid, exists (select 1
                      from   hasManager hm1, hasManager hm2
                      where  hm1.mid = p.pid and hm2.mid = p.pid and
                             hm1.eid <> hm2.eid)
from   Person p;

-- This query returns a pair (p,t) if p is the pid of a person who
-- manages at least two persons and returns the pair (p,f) other- wise.11

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

--Step1: 
select p.pid, true
from person p
where exists (select 1
                      from   hasManager hm1, hasManager hm2
                      where  hm1.mid = p.pid and hm2.mid = p.pid and
                             hm1.eid <> hm2.eid)
union
select p.pid, false
from person p
where not exists (select 1
                      from   hasManager hm1, hasManager hm2
                      where  hm1.mid = p.pid and hm2.mid = p.pid and
                             hm1.eid <> hm2.eid);

--Step 2: remove exists and not exists
select p.pid, true
from person p, hasManager hm1, hasManager hm2
where hm1.mid = p.pid and hm2.mid = p.pid and hm1.eid <> hm2.eid
union
select h.pid, false
from(
select p.pid,false
from person p
except
select p.pid,false
from person p,hasManager hm1, hasManager hm2
where hm1.mid = p.pid and hm2.mid = p.pid and hm1.eid <> hm2.eid)h;

--Step 3: transfer to RA
select p.pid,true
from person p join hasManager hm1 on hm1.mid = p.pid join hasManager hm2 on hm2.mid=hm1.mid and hm1.eid <> hm2.eid
union
select h.pid,false
from(
select p.pid,false
from person p
except
select p.pid,false
from person p join hasManager hm1 on hm1.mid = p.pid join hasManager hm2 on hm2.mid=hm1.mid and hm1.eid <> hm2.eid
)h;



\qecho 'Problem 10b'

-- Using Approach 2, optimize this RA SQL query and provide the optimized
-- expression in RA SQL.  Specify at least three conceptually different
-- rewrite rules that you used during the optimization.

--Step 1: push the projection over the join
select distinct m.pid,true
from (select p.pid from person p)m join (select hm1.mid from hasManager hm1  join hasManager hm2 on hm1.mid=hm2.mid and hm1.eid<>hm2.eid)n on m.pid=n.mid
union
select h.pid,false
from(
select p.pid,false
from person p
except
select m.pid,false
from (select p.pid from person p)m join (select hm1.mid from hasManager hm1  join hasManager hm2 on hm1.mid=hm2.mid and hm1.eid<>hm2.eid)n on m.pid=n.mid
)h;

--Step 2: pid is primary key. So remove the outside layer of select h.pid,false
select distinct m.pid,true
from (select p.pid from person p)m join (select hm1.mid from hasManager hm1  join hasManager hm2 on hm1.mid=hm2.mid and hm1.eid<>hm2.eid)n on m.pid=n.mid
union
(select p.pid,false
from person p
except
select m.pid,false
from (select p.pid from person p)m join (select hm1.mid from hasManager hm1  join hasManager hm2 on hm1.mid=hm2.mid and hm1.eid<>hm2.eid)n on m.pid=n.mid);

--Step 3: the expression is equal to E union (F except H), which can be optimalize as E union F except H.
select distinct m.pid,true
from (select p.pid from person p)m join (select hm1.mid from hasManager hm1  join hasManager hm2 on hm1.mid=hm2.mid and hm1.eid<>hm2.eid)n on m.pid=n.mid
union
select p.pid,false
from person p
except
select m.pid,false
from (select p.pid from person p)m join (select hm1.mid from hasManager hm1  join hasManager hm2 on hm1.mid=hm2.mid and hm1.eid<>hm2.eid)n on m.pid=n.mid;





\qecho 'Problem 11'

/*
Find each pair (c, a, l, u) where ‘c’ is the cname of a company that
pays each of its employees a salary between 50000 and 60000, ‘a′ is
the average salary of the employees who work for company ‘c’, ‘l’ is
the number of employees who earn a salary strictly below this average,
and ‘u’ is the number of employees who earn at least this average.
*/

with 
selectedcompany as(
	select c.cname
	from company c
	where true=some(select w.cname=c.cname
					from worksfor w) and
		  true=all(select w.salary>=50000 and w.salary<=60000
				   from worksfor w
				   where w.cname=c.cname)
),
companyemployee as(
	select sc.cname, w.pid, w.salary
	from selectedcompany sc natural join worksfor w
),
avgsalary as(
	select ce.cname, avg(ce.salary) as asala
	from companyemployee ce
	group by ce.cname
),
below as(
	select ce.cname, count(ce) as l
	from companyemployee ce, avgsalary a
	where ce.cname=a.cname and ce.salary<a.asala
	group by ce.cname
	union
	select ce.cname, 0 as l
	from companyemployee ce
	where ce.cname not in (select ce.cname
							from companyemployee ce, avgsalary a
							where ce.cname=a.cname and ce.salary<a.asala
							group by ce.cname)
),
atleast as(
	select ce.cname, count(ce) as u
	from companyemployee ce, avgsalary a
	where ce.cname=a.cname and ce.salary>=a.asala
	group by ce.cname
	union
	select ce.cname, 0 as l
	from companyemployee ce
	where ce.cname not in (select ce.cname
							from companyemployee ce, avgsalary a
							where ce.cname=a.cname and ce.salary>=a.asala
							group by ce.cname)
)
select distinct ce.cname as c, av.asala as a, below.l, atleast.u
from companyemployee ce, avgsalary av, below, atleast
where ce.cname=av.cname and ce.cname=below.cname and ce.cname=atleast.cname;

		   
		   
\qecho 'Problem 12'

/*
Find each skill that is the skill of at least 3 persons who each know
at least 2 persons who work for Apple and whose salary is at most 50000.
*/
with apple_staff as (select pid from worksfor where cname='Apple' and salary<=50000),
	 condition_ppl as(
		 select kn.pid1, count(kn)
		 from knows kn join apple_staff appstf on (kn.pid2=appstf.pid)
		 group by (kn.pid1)
		 having count(kn) >= 2)
select psk.skill 
from personskill psk join condition_ppl cppl on (psk.pid=cppl.pid1)
group by (psk.skill)
having count(psk)>=3;

	

\qecho 'Problem 13'


/*
Find the pid and name of each person p who has at least 3 job skills
in combined set of job skills of the persons who are managed by p.
*/
with m_skill as (select distinct hm.mid, ps.skill 
		 from hasmanager hm join personskill ps on (hm.mid=ps.pid)
		),
	 e_skill as (select distinct hm.mid, ps.skill 
		     from hasmanager hm join personskill ps on (hm.eid=ps.pid)
		    )
select pson.pid, pson.pname 
from
(
select q1.mid
from(select * from m_skill msk
     intersect 
     select * from e_skill esk
    )q1
group by q1.mid
having count(q1) >= 3
)q2 join person pson on (q2.mid=pson.pid);



\qecho 'Problem 14'

/*
Find the cname of each company that employs at least 4 persons and
that pays the highest average salary among such companies.
*/

CREATE FUNCTION NumberOfpid (name TEXT)
RETURNS bigint AS
$$
SELECT COUNT(w)
FROM worksfor w
WHERE w.cname = name;
$$ LANGUAGE SQL;

CREATE FUNCTION avgOfsalary (name TEXT)
RETURNS bigint AS
$$
SELECT avg(w.salary)
FROM worksfor w
WHERE w.cname = name;
$$ LANGUAGE SQL;

with companyatleast4 as
(select w.cname
from worksfor w
 where numberofpid(w.cname)>=4
)

select distinct ca.cname
from companyatleast4 ca
where avgofsalary(ca.cname)=(select max(avgofsalary(ca1.cname))
					  from companyatleast4 ca1
					  );

				 


\qecho 'Problem 15'

/*
Without using subquery expressions, find each pid of a person who
knows each person who earns the highest salary at company Amazon.
*/

with earnmost AS(select w.pid
				from worksfor w
				where w.cname='Amazon' and w.salary=(select max(w1.salary)
													from worksfor w1
													 where w1.cname='Amazon'
													))
select distinct k.pid1
from knows k
where (select count(em)
	  from earnmost em
	  where (select count(k1)
			from knows k1
			where k1.pid1=k.pid1 and k1.pid2=em.pid)=0)=0;


\qecho 'Problem 16'

/*
Without using subquery expressions, find each pairs (p1,p2) of pids of
different persons such that if s is a job skill of p1 then s is also a
job skill of person p2.
*/


		  
select pn1.pid, pn2.pid from person pn1, person pn2 where pn1.pid <> pn2.pid
except
select ps1.pid, ps2.pid from personskill ps1, personskill ps2 where (ps1.pid <> ps2.pid and ps1.skill = ps2.skill) group by (ps1.pid, ps2.pid) having count(1) > 0;
		   

\qecho 'Problem 17'

/* Find each pairs (p1,p2) of different pids of persons p1 and p2
and such that (1) the number of skills of person s1 is strictly less
than the number of skills of person s2 and (2) such that the gap
between these numbers is the largest among all such possible gaps.
 */


create function nummskills (p INTEGER)
returns bigint AS
$$
	select count(ps)
	from personskill ps
	where ps.pid = p;

$$ language sql;

with q as (
select ps.pid, nummskills(ps.pid) as nsk
from personskill ps
group by (ps.pid)

UNION

select pr.pid, 0 as nsk
from person pr
where pr.pid not in (select ps.pid from personskill ps))


select q1.pid, q2.pid from q q1, q q2
where q1.pid <> q2.pid and q1.nsk < q2.nsk and
 (q2.nsk - q1.nsk) >= (select max(q3.nsk) - min(q4.nsk) from q q3, q q4);




\qecho 'Problem 18'

/*
Consider three types of salaries:
• ‘low’ is a salary below 50000
• ‘medium’ is a salary between 50001 and 60000
• ‘high’ is a salary above 60001
Write a SQL query that returns each triple (c, t, n) where c is the
name of a company, t is a salary type (i.e., one of ‘low’, ‘medium’,
or ‘high’, and n is the number of employees who work for company
c and who have a salary of type t.
(You can think of this problem as that of creating a histogram.)
*/

with
lows as(
	select c.cname, 'low' as type, count(w) as ctEmployees
	from company c, worksfor w
	where w.cname=c.cname and w.salary<=50000
	group by c.cname
	union
	select c.cname, 'low' as type, 0 as ctEmployees
	from company c
	where c.cname not in (select c.cname
						  from company c, worksfor w
						  where w.cname=c.cname and w.salary<=50000
						  group by c.cname)
),
mediums as(
	select c.cname, 'medium' as type, count(w) as ctEmployees
	from company c, worksfor w
	where w.cname=c.cname and w.salary>=50001 and w.salary<=60000
	group by c.cname
	union
	select c.cname, 'medium' as type, 0 as ctEmployees
	from company c
	where c.cname not in (select c.cname
						  from company c, worksfor w
						  where w.cname=c.cname and w.salary>=50001 and w.salary<=60000
						  group by c.cname)
),
highs as(
	select c.cname, 'high' as type, count(w) as ctEmployees
	from company c, worksfor w
	where w.cname=c.cname and w.salary>=60001
	group by c.cname
	union
	select c.cname, 'high' as type, 0 as ctEmployees
	from company c
	where c.cname not in (select c.cname
						  from company c, worksfor w
						  where w.cname=c.cname and w.salary>=60001
						  group by c.cname)
)
select l.*
from lows l
union
select m.*
from mediums m
union
select h.*
from highs h
order by cname, type;




-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE dvgassignment3;
