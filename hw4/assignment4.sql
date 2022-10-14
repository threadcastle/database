-- Script for Assignment 4
\qecho TEAM 37
\qecho Jia Wang, Xiao Wang, Yiyin Jiang, Yu Mo
-- Creating database with full name

CREATE DATABASE dvgassignment4;

-- Connecting to database 
\c dvgassignment4

-- Relation schemas and instances for assignment 4

CREATE TABLE Person(pid integer,
                    pname text
					);

CREATE TABLE Company(cname text,
                     city text
                    );

CREATE TABLE worksFor(pid integer,
                      cname text
                     );


CREATE TABLE Knows(pid1 integer,
                   pid2 integer
                  );


\qecho 'Problem 1'

-- primary key constraint for Person
create or replace function check_person_primary_action()
returns trigger as
$$
begin
	if new.pid in (select pid from Person) then
		raise exception 'pid already exists';
	end if;
	return new;
end;
$$ language plpgsql;

create trigger check_person_primary_definition
	before insert on Person
	for each row execute procedure check_person_primary_action();


-- primary key constraint for Knows
create or replace function check_knows_primary_action()
returns trigger as
$$
begin
	if (new.pid1, new.pid2) in (select pid1, pid2 from Knows) then
		raise exception 'pid1, pid2 already exists';
	end if;
	return new;
end;
$$ language plpgsql;

create trigger check_knows_primary_definition
	before insert on Knows
	for each row execute procedure check_knows_primary_action();


-- foreign key constraint for Knows: insert case
create or replace function check_knows_foreign_insert_action()
returns trigger as
$$
begin
	if new.pid1 not in (select pid from Person) and new.pid2 not in (select pid from Person) then
		raise exception 'both pid1 and pid2 are not present in the Person relation';
	end if;
	if new.pid1 not in (select pid from Person) then
		raise exception 'pid1 is not present in the Person relation';
	end if;
	if new.pid2 not in (select pid from Person) then
		raise exception 'pid2 is not present in the Person relation';
	end if;
	return new;
end;
$$ language plpgsql;

create trigger check_knows_foreign_insert_definition
	before insert on Knows
	for each row execute procedure check_knows_foreign_insert_action();


-- foreign key constraint for Person and Knows: delete case
create or replace function person_knows_foreign_delete_action()
returns trigger as
$$
begin
	if old.pid in (select pid1 from Knows union select pid2 from Knows) then
		delete from Knows where Knows.pid1=old.pid or Knows.pid2=old.pid;
	end if;
	return old;
end;
$$ language plpgsql;

create trigger person_knows_foreign_delete_definition
	before delete on Person
	for each row execute procedure person_knows_foreign_delete_action();


-- test case for primary key constraint of Person
insert into Person values (1001, 'Jean');
insert into Person values (1002, 'Vidya');
insert into Person values (1001, 'Emily');

-- test case for primary key constraint of Knows
insert into Knows values (1001, 1002);
insert into Knows values (1002, 1001);
insert into Knows values (1001, 1002);

-- test case for foreign key constraint of Knows: insert case
insert into Knows values (1003, 1001);
insert into Knows values (1001, 1003);
insert into Knows values (1003, 1004);

-- test case for foreign key constraint of Person and Knows: delete case
-- When deleting 1001 from Person, the Knows table will become empty.
delete from Person where pid=1001;
select * from Person;
select * from Knows;


\qecho 'Problem 2'
-- check insert
create or replace function check_foreign_key_constraint_insert_action()
returns TRIGGER as 
$$
BEGIN
if new.cname not in (select c.cname from company c) THEN
raise exception 'cname is not present in the Company relation';
end if;
return new;
end;
$$language plpgsql;

create trigger check_foreign_key_insert_definition
before insert on worksfor
for each row execute procedure check_foreign_key_constraint_insert_action();

-- check delete
create or replace function check_foreign_key_constraint_delete_action()
returns trigger as
$$
BEGIN
if not exists(select 1 
			 from company c1,company c2 
			 where c1.cname=old.cname and c1.cname=c2.cname and c1.city<>c2.city) then
delete from worksfor where cname=old.cname;
end if;
return old;
end;
$$language plpgsql;

create trigger check_foreign_key_delect_definition
before delete on company
for each row execute procedure check_foreign_key_constraint_delete_action();



INSERT INTO Company VALUES
     ('Apple', 'Cupertino'),
     ('Apple', 'Seattle'),
     ('Google', 'MountainView');
select * from company;
insert into worksfor values (1001, 'Apple');
-- test case for foreign key constraint of worksFor: insert case
insert into worksfor values (1003,'Amazon');

-- test case for foreign key constraint of Company: delete case
delete from Company where cname='Apple' and city='Cupertino';
select * from worksfor;
select * from company;
delete from Company where cname='Apple' and city='Seattle';
select * from worksfor;
select * from company;



\qecho 'Problem 3'
DELETE FROM person WHERE true;
DELETE FROM knows WHERE true;

create table PersonKnowsNumberofPersons (pid integer,
                                         pname text,
                                         num integer);
                                        
-- insert value into Person
CREATE OR REPLACE FUNCTION PKNP_person_insert_action()
RETURNS trigger AS
$$
BEGIN
if new.pid not in (select pid from person) then
   insert into PersonKnowsNumberofPersons values (new.pid, new.pname, 0);
end if;
return new;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER PKNP_person_insert_definition
BEFORE INSERT ON Person
FOR EACH ROW EXECUTE PROCEDURE PKNP_person_insert_action();

-- delete value from Person
CREATE OR REPLACE FUNCTION PKNP_person_delete_action()
RETURNS trigger AS
$$
BEGIN
if old.pid in (select pid from person) then
   delete from PersonKnowsNumberofPersons PKNP where PKNP.pid=old.pid;
end if;
return old;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER PKNP_person_delete_definition
BEFORE DELETE ON Person
FOR EACH ROW EXECUTE PROCEDURE PKNP_person_delete_action();

-- insert value into Knows
CREATE OR REPLACE FUNCTION PKNP_knows_insert_action()
RETURNS trigger AS
$$
BEGIN
update PersonKnowsNumberofPersons 
set num = num + 1
where PersonKnowsNumberofPersons.pid = new.pid1 and (new.pid1, new.pid2) not in (select * from knows); 
return new;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER PKNP_knows_insert_definition
BEFORE INSERT ON Knows
FOR EACH ROW EXECUTE PROCEDURE PKNP_knows_insert_action();

-- delete value from Knows
CREATE OR REPLACE FUNCTION PKNP_knows_delete_action()
RETURNS trigger AS
$$
BEGIN
update PersonKnowsNumberofPersons 
set num = num - 1
where PersonKnowsNumberofPersons.pid = old.pid1 and (old.pid1, old.pid2) in (select * from knows); 
return null;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER PKNP_knows_delete_definition
BEFORE DELETE ON Knows
FOR EACH ROW EXECUTE PROCEDURE PKNP_knows_delete_action();

-- TEST CASE
\qecho 'insert value into Person'
INSERT INTO Person VALUES
     (1004,'Qin'),
     (1005,'Megan'),
     (1006,'Ryan'),
     (1007,'Danielle');
select * from PersonKnowsNumberofPersons;


\qecho 'insert existing value into Person'
INSERT INTO Person VALUES
     (1004,'Tim');
select * from PersonKnowsNumberofPersons;


\qecho 'delete from Person whose pid=1004'
delete from person where pid = 1004;
select * from PersonKnowsNumberofPersons;


\qecho 'delete value not in Person(pid=2004)'
delete from person where pid = 2004;
select * from PersonKnowsNumberofPersons;


\qecho 'insert values into Knows: (1005,1006), (1005,1007)'
INSERT INTO Knows VALUES
 (1005,1006),
 (1005,1007);
select * from PersonKnowsNumberofPersons;

\qecho 'insert existing values into Knows: (1005,1006)'
INSERT INTO Knows VALUES
 (1005,1006);
select * from PersonKnowsNumberofPersons;


\qecho 'delete from pair in Knows (1005,1006)'
delete from knows where pid1=1005 and pid2=1006;
select * from PersonKnowsNumberofPersons;


\qecho 'delete pair not in Knows (1005,2006)'
delete from knows where pid1=1005 and pid2=2006;
select * from PersonKnowsNumberofPersons;


drop table PersonKnowsNumberofPersons;




\qecho 'section 4'

--create tables

CREATE TABLE Student(sid integer,
                     sname text,
                     major text,
                     primary key (sid));




create table Course(cno integer,
				   	cname text, 
				   	total integer,
				   	max integer,
				   	primary key(cno));



create table Prerequisite(cno integer, 
						  prereq integer,
						  primary key (cno, prereq),
						  foreign key (cno) references Course (cno),
						  foreign key (prereq) references Course (cno));




create table hasTaken(sid integer,
					  cno integer,
					  primary key (sid, cno),
					  foreign key (cno) references Course (cno),
					  foreign key (sid) references Student (sid));



create table Enroll(sid integer,
					cno integer,
				    primary key (sid, cno),					
				   	foreign key (cno) references Course (cno),
				   	foreign key (sid) references Student (sid));




create table Waitlist(sid integer,
					  cno integer, 
					  position int,
					  primary key (sid, cno),
					  foreign key (cno) references Course (cno),
					  foreign key (sid) references Student (sid));





-- values


INSERT INTO Student VALUES
     (1001,'Jean','CS'),
     (1002,'Vidya', 'CS'),
     (1003,'Anna', 'Chemistry'),
     (1004,'Qin', 'Physics'),
     (1005,'Megan', 'History'),
     (1006,'Ryan', 'Math'),
     (1007,'Danielle','Chemistry'),
     (1008,'Emma', 'CS'),
     (1009,'Hasan', 'Econimics'),
     (1010,'Linda', 'Business');




Insert into Course values 
		(555, 'machine learning', 0, 60),
		(300, 'calculus', 0, 100),
		(600, 'derivative eqa', 0, 20),
		(630, 'statistics theory', 0, 50),
		(629, 'computer vision', 0, 90),
		(520, 'stats', 0, 58);
	
Insert into prerequisite VALUES
		(629, 300),
		(629, 520),	
		(555, 520);
	
		
Insert into hastaken VALUES
		(1001, 520);





\qecho 'section 4 Part 1'
-- part 1
-- 1.1
create or replace function check_cnoprerq_action()
returns trigger as
$$
BEGIN
	if not true = all(
		select pc.prereq in (select ht.cno from hasTaken ht where new.sid = ht.sid) htc
	from (select p.prereq from Prerequisite p where new.cno = p.cno) pc)
 	
	THEN raise exception 'sid does not take all the prereq courses of cno';
	
	end if;
	return new;
END;
$$ language plpgsql;


create trigger check_cnoprereq_def
	BEFORE insert on Enroll
	for each row execute procedure check_cnoprerq_action();


-- test for p1.1

insert into enroll values (1001, 629);
-- the result is:
-- ERROR:  sid does not take all the prereq courses of cno
-- because sid 1001 did not take all required prereq courses of 629


--2 

create or replace function maintain_number_course_action()
returns trigger as
$$
BEGIN
	update Course set total = total + 1 where Course.cno = new.cno;
	return null;
END;
$$ language plpgsql;



create trigger maintain_number_course_def
	AFTER insert on Enroll
	for each row execute procedure maintain_number_course_action();





-- p1.2 testing

-- add some values to table hastaken
insert into hastaken values 
		(1002, 300),
		(1002, 520);
		
select * from hastaken;

-- add some values to table enroll
insert into enroll VALUES
		(1002, 629);

insert into enroll VALUES
		(1002, 555);

select * from enroll;

select * from course where cno = 629;
-- the total number has already been incremented by 1, which is 1 !


insert into enroll VALUES
		(1002, 555);
		
		
\qecho 'section 4 Part 2'

select * from enroll;
select * from course;
select * from hastaken;
select * from prerequisite;

-- add some values into table courses for later test 
-- the course named "data mining" has reached max enroll number: 120
Insert into Course values (565, 'data mining', 120, 120);



-- add some values into table prerequisite for later test 
Insert into prerequisite VALUES
		(565, 300),	
		(565, 555);
	
-- add some values into table hastaken for later test 		
Insert into hastaken VALUES
		(1004, 600),
		(1004, 300),
		(1004, 555);





-- implement trigger when some student want to enroll to a max-enrolled courses, and adding the student to the waitlist
create or replace function update_wtlist_action()
returns trigger as
$$
BEGIN
	if (select c.total + 1 > c.max from course c where c.cno = new.cno) then	
		if not exists (select 1 from waitlist wl where wl.cno = new.cno) THEN
			insert into waitlist values (new.sid, new.cno, 1);			
					
		ELSE 		
		
		insert into waitlist values (new.sid, new.cno, (select max(wl2.position)+1 from waitlist wl2 where wl2.cno = new.cno));
		
		end if;
		return null;
	end if;
	
	return new;
		
END;
$$ language plpgsql;



create trigger update_wtlist_def
	before insert on Enroll
	for each row execute procedure update_wtlist_action();



-- Test

-- Test when the enroll number of a course is less than max
insert into enroll values (1001, 555);

-- Test when the enroll number of a course has been max
insert into enroll values (1004, 565);

-- since the enroll number of course 565 ha been max, sid 1004 is NOT enrolled
-- Sid 1004 is added to the waitlist

--select * from cqueue;
select * from enroll;

-- the position of sid 1004 in the waitlist of course 565 is 1
select * from waitlist;




-- let us test more case, eg. sid 1006 also wants to enroll to course 565 and is also added to the waitlist

Insert into hastaken VALUES
		(1006, 300),
		(1006, 555);

insert into enroll values (1006, 565);


select * from enroll;

-- the position of sid 1006 in the waitlist of course 565 is 2
select * from waitlist;






-- let us test one more case, eg. sid 1007 also wants to enroll to course 565 and is also added to the waitlist


Insert into hastaken VALUES
		(1007, 300),
		(1007, 555);

insert into enroll values (1007, 565);



select * from enroll;

-- the position of sid 1007 in the waitlist of course 565 is 3
select * from waitlist;


-- problem 4.3
-- DISENROLL from Waitlist
-- create trigger for the delete from enroll

create or replace function delete_enroll_action()
returns trigger as
$$
begin
	if not exists (select 1 from waitlist where waitlist.cno=old.cno) then
		update Course set total=total-1 where cno=old.cno;
	end if;
	if exists (select 1 from waitlist where waitlist.cno=old.cno) then
		update Course set total=total-1 where cno=old.cno;
		insert into enroll (sid, cno) select wl.sid, wl.cno from waitlist wl
								      where wl.position=(select min(wl2.position) from waitlist wl2 where wl.cno=old.cno);
	    delete from waitlist where cno=old.cno and position=(select min(wl2.position) from waitlist wl2);
	end if;
	return null;
end;
$$ language plpgsql;

create trigger delete_enroll_definition
	after delete on enroll
	for each row execute procedure delete_enroll_action();

-- TEST CASE
Insert into Course values (111, 'TEST', 0, 2);
insert into Enroll values (1001, 111), (1002, 111);
select * from Course;

-- into wl
insert into Enroll values (1003, 111), (1004, 111), (1005, 111);
select * from waitlist;

\qecho disenroll from waitlist
delete  from waitlist where sid = 1004 and cno=111;
select * from waitlist;

\qecho disenroll from enroll
delete from enroll where sid = 1002 and cno=111;
select * from waitlist;

-- drop table cqueue;

-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE dvgassignment4;
