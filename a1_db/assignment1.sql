-- Creating database with full name


CREATE DATABASE dirkassignment;

-- Connecting to database 
\c dirkassignment;

-- Relation schemas and instances for assignment 1

\qecho 'Problem 1'

-- Provide 4 conceptually different examples that illustrate how the
-- presence or absence of primary and foreign keys affect insert and
-- deletes in these relations.  To solve this problem, you will need to
-- experiment with the relation schemas and instances for this
-- assignment.  For example, you should consider altering primary keys
-- and foreign key constraints and then consider various sequences of
-- insert and delete operations.  You may need to change some of the
-- relation instances to observe the desired effects.  Certain inserts
-- and deletes should succeed but other should generate error
-- conditions.  (Consider the lecture notes about keys, foreign keys,
-- and inserts and deletes as a guide to solve this problem.)

-- Relation schemas and instances for assignment 1
 
CREATE TABLE Student(sid integer,
                     sname text,
                     homeCity text,
                     primary key (sid));

CREATE TABLE Department(deptName text,
                        mainOffice text,
                        primary key (deptName));

CREATE TABLE Major(major text,
                   primary key (major));


CREATE TABLE employedBy(sid integer,
                        deptName text,
                        salary integer,
                        primary key (sid),
                        foreign key (sid) references Student (sid),
                        foreign key (deptName) references Department(deptName));


CREATE TABLE departmentLocation(deptName text,
                                building text,
                                primary key (deptName, building),
                                foreign key (deptName) references Department (deptName));


CREATE TABLE studentMajor(sid integer,
                          major text,
                          primary key (sid, major),
                          foreign key (sid) references Student (sid),
                          foreign key (major) references Major (major));


CREATE TABLE hasFriend(sid1 integer,
                       sid2 integer,
                       primary key(sid1,sid2),
                       foreign key (sid1) references Student (sid),
                       foreign key (sid2) references Student (sid));


INSERT INTO Student VALUES
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


INSERT INTO Department VALUES
     ('CS', 'LuddyHall'),
     ('DataScience', 'LuddyHall'),
     ('Mathematics', 'RawlesHall'),
     ('Physics', 'SwainHall'),
     ('Biology', 'JordanHall'),
     ('Chemistry', 'ChemistryBuilding'),
     ('Astronomy', 'SwainHall');


INSERT INTO employedBy VALUES
     (1001,'CS', 65000),
     (1002,'CS', 45000),
     (1003,'DataScience', 55000),
     (1004,'DataScience', 55000),
     (1005,'Mathematics', 60000),
     (1006,'DataScience', 55000),
     (1007,'Physics', 50000),
     (1008,'DataScience', 50000),
     (1009,'CS',60000),
     (1010,'DataScience', 55000),
     (1011,'Mathematics', 70000), 
     (1012,'CS', 50000),
     (1013,'Physics', 55000),
     (1014,'CS', 50000), 
     (1015,'DataScience', 60000),
     (1016,'DataScience', 55000),
     (1017,'Physics', 60000),
     (1018,'CS', 50000),
     (1019,'Biology', 50000);

INSERT INTO departmentLocation VALUES
   ('CS', 'LindleyHall'),
   ('DataScience', 'LuddyHall'),
   ('DataScience', 'Kinsey'),
   ('DataScience', 'WellsLibrary'),
   ('Mathematics', 'RawlesHall'),
   ('Physics', 'SwainHall'),
   ('Physics', 'ChemistryBuilding'),
   ('Biology', 'JordanHall'),
   ('CS', 'LuddyHall'),
   ('Mathematics', 'SwainHall'),
   ('Physics', 'RawlesHall'),
   ('Biology', 'MultiDisciplinaryBuilding'),
   ('Chemistry', 'ChemistryBuilding');

INSERT INTO Major VALUES
   ('CS'),
   ('DataScience'),
   ('Physics'),
   ('Chemistry'),
   ('Biology');

INSERT INTO studentMajor VALUES
 (1001,'CS'),
 (1001,'DataScience'),
 (1002,'CS'),
 (1002,'DataScience'),
 (1004,'DataScience'),
 (1004,'CS'),
 (1005,'DataScience'),
 (1005,'CS'),
 (1005,'Physics'),
 (1006,'CS'),
 (1006,'Chemistry'),
 (1007,'Chemistry'),
 (1007,'CS'),
 (1009,'Chemistry'),
 (1009,'Physics'),
 (1010,'Physics'),
 (1011,'Physics'),
 (1011,'Chemistry'),
 (1011,'DataScience'),
 (1011,'CS'),
 (1012,'DataScience'),
 (1012,'Chemistry'),
 (1012,'CS'),
 (1013,'CS'),
 (1013,'DataScience'),
 (1013,'Chemistry'),
 (1013,'Physics'),
 (1014,'Chemistry'),
 (1014,'DataScience'),
 (1014,'Physics'),
 (1015,'CS'),
 (1015,'DataScience'),
 (1016,'Chemistry'),
 (1016,'DataScience'),
 (1017,'Physics'),
 (1017,'CS'),
 (1018,'DataScience'),
 (1019,'Physics');

INSERT INTO hasFriend VALUES
 (1001,1008),
 (1001,1012),
 (1001,1014),
 (1001,1019),
 (1002,1001),
 (1002,1002),
 (1002,1011),
 (1002,1014),
 (1002,1015),
 (1003,1004),
 (1004,1002),
 (1004,1003),
 (1004,1012),
 (1004,1013),
 (1004,1014),
 (1004,1019),
 (1005,1015),
 (1006,1003),
 (1006,1004),
 (1006,1006),
 (1007,1008),
 (1007,1013),
 (1007,1016),
 (1007,1017),
 (1008,1001),
 (1008,1007),
 (1008,1015),
 (1008,1019),
 (1009,1001),
 (1009,1005),
 (1009,1013),
 (1010,1008),
 (1010,1013),
 (1010,1014),
 (1011,1005),
 (1011,1009),
 (1011,1010),
 (1011,1011),
 (1012,1011),
 (1013,1002),
 (1013,1007),
 (1013,1018),
 (1014,1005),
 (1014,1006),
 (1014,1012),
 (1014,1017),
 (1015,1002),
 (1015,1003),
 (1015,1005),
 (1015,1011),
 (1015,1015),
 (1015,1018),
 (1016,1004),
 (1016,1006),
 (1016,1015),
 (1017,1013),
 (1017,1014),
 (1017,1019),
 (1018,1004),
 (1018,1007),
 (1018,1009),
 (1018,1010),
 (1018,1013),
 (1019,1001),
 (1019,1006),
 (1019,1008),
 (1019,1013);


-- Problem 1

-- Provide 4 conceptually different examples that illustrate how the
-- presence or absence of primary and foreign keys affect insert and
-- deletes in these relations.  To solve this problem, you will need to
-- experiment with the relation schemas and instances for this
-- assignment.  For example, you should consider altering primary keys
-- and foreign key constraints and then consider various sequences of
-- insert and delete operations.  You may need to change some of the
-- relation instances to observe the desired effects.  Certain inserts
-- and deletes should succeed but other should generate error
-- conditions.  (Consider the lecture notes about keys, foreign keys,
-- and inserts and deletes as a guide to solve this problem.)

/*
\qecho 'Problem 1 conceptual example 1'
INSERT INTO Department VALUES ('CS', 'SwainHall');

\qecho 'Problem 1 conceptual example 2'
INSERT INTO employedBy VALUES ('1001', 'CS', 10000);

\qecho 'Problem 1 conceptual example 3'
DELETE FROM Student WHERE sid = 1001;

\qecho 'Problem 1 conceptual example 4'
DELETE FROM Major WHERE Major = 'CS';
*/

INSERT INTO employedBy VALUES (1020,'CS', 65000);

INSERT INTO hasfriend VALUES (1021, 0333);

DELETE FROM Student WHERE sid = 1077;

DELETE FROM Major WHERE Major = 'Chemistry';



\qecho 'Problem 2'
-- Find each pair (d, m) where d is the name of a department and m is a
-- major of a student who is employed by that department and who earns a
-- salary of at least 20000.

select DISTINCT d.deptName, j.major
from department d, studentmajor j
where (d.deptName, j.sid) in 
(select e.deptName, e.sid from employedby e where e.salary >= 20000) order by d.deptname;





\qecho 'Problem 3'
-- Find each pair (s1,s2) of sids of different students who have the same
-- (set of) friends who work for the CS department.



--select s1.sid, s2.sid from student s1, student s2 where s1.sid <> s2.sid and not exists( SELECT 1 from 
--	 ((select e.sid from employedby e where e.deptname = 'CS' and e.sid in (select hf1.sid2 from hasfriend hf1 where hf1.sid1 =s1.sid)) except
--	 (select e.sid from employedby e where e.deptname = 'CS' and e.sid in (select hf2.sid2 from hasfriend hf2 where hf2.sid1 =s2.sid) )) v)




SELECT s1.sid, s2.sid
FROM   student s1, student s2
WHERE s1.Sid <> s2.Sid AND
               true = ALL (select (s2.sid, f.sid) in (select hf2.sid1, hf2.sid2 from hasfriend hf2)
                                    FROM    (select e.sid from employedby e where e.deptname = 'CS' ) f
                                    WHERE  (s1.sid, f.sid) in (select hf1.sid1, hf1.sid2 from hasfriend hf1)) and 
									true = ALL (select (s1.sid, f.sid) in (select hf1.sid1, hf1.sid2 from hasfriend hf1)
                                    	FROM    (select e.sid from employedby e where e.deptname = 'CS' ) f
                                    	WHERE  (s2.sid, f.sid) in (select hf2.sid1, hf2.sid2 from hasfriend hf2)) ;
									
									


\qecho 'Problem 4'
-- Find each major for which there exists a student with that major and
-- who does not only have friends who also have that major.

select distinct z.major 
from studentmajor z
where EXISTS (select z.major NOT IN 			  
			  (select o.major from studentmajor o 
			  	where o.sid in (select f.sid2 from hasfriend f where f.sid1 = z.sid) ));
			  



\qecho 'Problem 13'



select s1.sid, s1.sname from student s1 where EXISTS (
	select 1 from department d, employedby w 
		where d.deptname = w.deptname and s1.sid = w.sid and d.mainoffice = 'LuddyHall' and 
			exists (select 1 from student s2 where 
				   (s1.sid, s2.sid) in (select hf.sid1, hf.sid2 from hasfriend hf) and s2.homecity <> 'Bloomington'));


	


select s1.sid, s1.sname from student s1 where true = some (
	select d.deptname = w.deptname and s1.sid = w.sid and d.mainoffice = 'LuddyHall' and 
			true = some (select (s1.sid, s2.sid) in (select hf.sid1, hf.sid2 from hasfriend hf) and s2.homecity <> 'Bloomington' from student s2)		
				from department d, employedby w );




select s1.sid, s1.sname from student s1 where not true=all (
	select d.deptname <> w.deptname or s1.sid <> w.sid or d.mainoffice <> 'LuddyHall' or not
			exists (select 1 from student s2 where 
				   (s1.sid, s2.sid) in (select hf.sid1, hf.sid2 from hasfriend hf) and s2.homecity <> 'Bloomington') from department d, employedby w );








\qecho 'Problem 14'

select s1.sid from student s1 where not exists (
	select 1 from student s2 where (s1.sid, s2.sid) in (select hf.sid1, hf.sid2 from hasfriend hf) and
		not exists (select 1 from studentmajor sm1, studentmajor sm2 where sm1.sid = s1.sid and sm2.sid = s2.sid and sm1.major = sm2.major
				   and sm1.sid <> sm2.sid));


-- the sql below use the logic "true = all()"
select s1.sid from student s1 where true =all (
	select (s1.sid, s2.sid) not in (select hf.sid1, hf.sid2 from hasfriend hf)  or 
		 exists (select 1 from studentmajor sm1, studentmajor sm2 where sm1.sid = s1.sid and sm2.sid = s2.sid and sm1.major = sm2.major
				   and sm1.sid <> sm2.sid) from student s2 );
				   
				   
				   

-- sql below replace exists. with true= some()"
select s1.sid from student s1 where not true = some (
	select (s1.sid, s2.sid) in (select hf.sid1, hf.sid2 from hasfriend hf) and
		not true = some (select sm1.sid = s1.sid and sm2.sid = s2.sid and sm1.major = sm2.major
				   and sm1.sid <> sm2.sid from studentmajor sm1, studentmajor sm2) from student s2);






\qecho 'Problem 15'



select s1.sid, s2.sid from student s1, student s2 where s1.sid <> s2.sid and not exists(
	select 1 from hasfriend f1 where s1.sid = f1.sid1 and not exists(
		select 1 from hasfriend f2 where f2.sid1 = s2.sid and f1.sid2 = f2.sid2));



select s1.sid, s2.sid from student s1, student s2 where s1.sid <> s2.sid and not true=some(
	select s1.sid = f1.sid1 and not true=some (
		select f2.sid1 = s2.sid and f1.sid2 = f2.sid2 from hasfriend f2) from hasfriend f1);



select s1.sid, s2.sid from student s1, student s2 where s1.sid <> s2.sid and true=all(
	select s1.sid <> f1.sid1 or true=some (
		select f2.sid1 = s2.sid and f1.sid2 = f2.sid2 from hasfriend f2)
		from hasfriend f1);


\qecho 'Problem 22.b'
-- Some major has fewer than 2 students with that major.



select exists (select m from major m where (select count(*) from studentmajor sm where sm.major = m.major) < 2);

\qecho 'Problem 23.b'
-- Each student who works for a department has a friend who also works
-- for that department and who earns the same salary


select true = all (
	select true = some (select hf.sid1 = e1.sid and 
		(select true = some(select e2.deptname = e1.deptname and e1.salary = e2.salary and e2.sid = hf.sid2 from employedby e2))		
		from hasfriend hf)
	from employedby e1);



\qecho 'Problem 24.b'
-- All students working in a same department share a major and earn the
-- same salary.

-- 

select true = all(select true = all(select true=all(
				select (e1.deptname = e2.deptname and e1.salary = e2.salary ) from employedBy e1, employedBy e2 where e1.sid <>e2.sid and e1.sid = j1.sid and e2.sid = j2.sid)
			from studentmajor j2 where j1.major = j2.major and j1.sid <> j2.sid)
		from studentmajor j1)
								  

		
		
-- Connect to default database
-- \c postgres;

-- Drop database created for this assignment
-- DROP DATABASE dirkassignment;





