\qecho 'question 1'
-- question 1
-- Test case 1: uniform mass function
create table p(outcome integer,
			  probablity real,
			  primary key (outcome));

insert into p values
(1,0.125),
(2,0.125),
(3,0.125),
(4,0.125),
(5,0.125),
(6,0.125),
(7,0.125),
(8,0.125);

create or replace function
BinaryRelation(n int, l_1 int, u_1 int)
returns table (x int, y real) as
$$
select floor(random() * (u_1-l_1+1) + l_1)::int as x,
random()::real as y
from generate_series(1,n);
$$ language sql;


create or replace function
RelationOverProbabilityFunction(n int, l_1 int, u_1 int, l_2 int, u_2 int)
returns table (x int, y int) as
$$
with distribution as
(select p2.outcome, sum(p1.probablity)-p2.probablity as low, sum(p1.probablity) as up
from p p2, p p1
where p1.outcome<=p2.outcome
group by p2.outcome)

select br.x as x, d.outcome as y
from BinaryRelation(n,l_1,u_1) br, distribution d
where br.y>d.low and br.y<d.up;
$$ language sql;

select * from RelationOverProbabilityFunction(100, 1, 150, 1, 8);


-- Test case 2: non-uniform function
drop table p;

create table p(outcome integer,
			  probablity real,
			  primary key (outcome));

insert into p values
(1,0.25),
(2,0.05),
(3,0.10),
(4,0.10),
(5,0.15),
(6,0.05),
(7,0.10),
(8,0.20);

create or replace function
BinaryRelation(n int, l_1 int, u_1 int)
returns table (x int, y real) as
$$
select floor(random() * (u_1-l_1+1) + l_1)::int as x,
random()::real as y
from generate_series(1,n);
$$ language sql;


create or replace function
RelationOverProbabilityFunction(n int, l_1 int, u_1 int, l_2 int, u_2 int)
returns table (x int, y int) as
$$
with distribution as
(select p2.outcome, sum(p1.probablity)-p2.probablity as low, sum(p1.probablity) as up
from p p2, p p1
where p1.outcome<=p2.outcome
group by p2.outcome)

select br.x as x, d.outcome as y
from BinaryRelation(n,l_1,u_1) br, distribution d
where br.y>d.low and br.y<d.up;
$$ language sql;

select * from RelationOverProbabilityFunction(100, 1, 150, 1, 8);

\qecho 'question 2'
-- question 2
-- Test case1

create table skill(skill text,
				  primary key(skill));

insert into skill values
('AI'),
('Databases'),
('Networks'),
('OperatingSystems'),
('Programming');

drop table p;

create table p(outcome integer,
			  probablity real,
			  primary key (outcome));

insert into p values
(1,0.25),
(2,0.10),
(3,0.40),
(4,0.10),
(5,0.15);

create or replace function
RelationOverProbabilityFunction(n int, l_1 int, u_1 int, l_2 int, u_2 int)
returns table (x int, y int) as
$$
with distribution as
(select p2.outcome, sum(p1.probablity)-p2.probablity as low, sum(p1.probablity) as up
from p p2, p p1
where p1.outcome<=p2.outcome
group by p2.outcome)

select br.x as x, d.outcome as y
from BinaryRelation(n,l_1,u_1) br, distribution d
where br.y>d.low and br.y<d.up;
$$ language sql;


create or replace function GeneratepersonSkillRelation(n int, l int, u int)
returns table (pid int, skill text) as
$$
with skillNumber(skill, index) as (select skill, row_number() over (order by skill)
from Skill),
pS as (select x, y
from RelationOverProbabilityFunction(n,l,u,1, (select count(1) from Skill)::int))
select x as pid, skill
from pS join skillNumber on y = index
group by (x, skill) order by 1,2;
$$ language sql;

select * from GeneratepersonSkillRelation(10,1,15);

\qecho 'question 5'

-- create tables
create table Student (sid text, sname text, major text, byear integer, primary key(sid));
create table Enroll (sid text, cno text, grade character, primary key(sid, cno));

insert into Student values
('s100', 'Eric', 'CS', 1988),
('s101', 'Nick', 'Math', 1991),
('s102', 'Chris', 'Biology', 1977),
('s103', 'Dinska', 'CS', 1978),
('s104', 'Zanna', 'Math', 2001),
('s105', 'Vince', 'CS', 2001);

insert into Enroll values
('s100', 'c200', 'A'),
('s100', 'c201', 'B'),
('s100', 'c202', 'A'),
('s101', 'c200', 'B'),
('s101', 'c201', 'A'),
('s101', 'c202', 'A'),
('s101', 'c301', 'C'),
('s101', 'c302', 'A'),
('s102', 'c200', 'B'),
('s102', 'c202', 'A'),
('s102', 'c301', 'B'),
('s102', 'c302', 'A'),
('s103', 'c201', 'A'),
('s104', 'c201', 'D');

-- add tid for Enroll
create or replace view Enroll2 as
select row_number() over (order by sid) as tid, sid, cno, grade
from Enroll;

-- construct indexes
create or replace view IndexOnCno as
select c.cno, array_agg(e.tid) as records
from (select distinct cno from Enroll2 order by cno) c, enroll2 e
where c.cno=e.cno
group by c.cno;
select * from IndexOnCno;

create or replace view IndexOnGrade as
select g.grade, array_agg(e.tid) as records
from (select distinct grade from Enroll2 order by grade)g, enroll2 e
where g.grade=e.grade
group by g.grade;
select * from IndexOnGrade;

-- construct function FindStudents
create or replace function FindStudents (booleanOperation text, cno1 text, grade1 text)
returns table (sid text, sname text, major text, byear integer) as
$$
BEGIN
if booleanOperation = 'and' then
    return query
	with filter as (
	    select unnest(records) as ind from IndexOnGrade where grade=grade1
        intersect
	    select unnest(records) as ind from IndexOnCno where cno=cno1
	)
	select *
	from Student s
	where s.sid in (select e.sid from enroll2 e, filter f where e.tid=f.ind)
end if;

if booleanOperation = 'or' then
    return query
	with filter as (
	    select unnest(records) as ind from IndexOnGrade where grade=grade1
        union
	    select unnest(records) as ind from IndexOnCno where cno=cno1
	)
	select *
	from Student s
	where s.sid in (select e.sid from enroll2 e, filter f where e.tid=f.ind)
end if;

if booleanOperation = 'and not' then
    return query
	with filter as (
	    select unnest(records) as ind from IndexOnCno where cno=cno1
        except
	    select unnest(records) as ind from IndexOnGrade where grade=grade1
	)
	select *
	from Student s
	where s.sid in (select e.sid from enroll2 e, filter f where e.tid=f.ind)
end if;

END;
$$ language plpgsql;

-- TEST CASE
\qecho 'question 5(a)'
select * from FindStudents('and', 'c202', 'A');
\qecho 'question 5(b)'
select * from FindStudents('or', 'c202', 'A');
\qecho 'question 5(c)'
select * from FindStudents('and not', 'c202', 'A');


\qecho 'question 6'
-- construct indexes
create table bitmapIndexOnCno (cno text, ind boolean[]);
create table bitmapIndexOnGrade (grade character, ind boolean[]);

with UniqueCno as(
	select distinct cno
	from Enroll
	order by cno
)
insert into bitmapIndexOnCno (cno, ind)
select uc.cno, array_agg(uc.cno=e.cno)
from UniqueCno uc, Enroll e 
group by uc.cno;

with UniqueGrade as(
	select distinct grade
	from Enroll
	order by grade
)
insert into bitmapIndexOnGrade (grade, ind)
select ug.grade, array_agg(ug.grade=e.grade)
from UniqueGrade ug, Enroll e
group by ug.grade;

create or replace view EnrollWithRow as
select row_number() over (order by sid) as rownum, sid, cno, grade
from Enroll;

create or replace function FindStudents (booleanOperation text, cno1 text, grade1 text)
returns table (sid text, sname text, major text, byear integer) as
$$
begin			  
if booleanOperation = 'and' then
	return query
	with a as(
		select unnest(ind) as ind
		from bitmapIndexOnCno bic
		where bic.cno = cno1
	),
	b as (
		select unnest(ind) as ind
		from bitmapIndexOnGrade big
		where big.grade = grade1
	),
	cnofilter as (
		select row_number() over(order by 1) as rn, ind
		from a
	),
	gradefilter as (
		select row_number() over(order by 1) as rn, ind
		from b
	),
	boolvec as (
		select cnofilter.ind and gradefilter.ind as ind, row_number() over (order by 1) as rownum
		from cnofilter, gradefilter
		where cnofilter.rn = gradefilter.rn
	)
	select *
	from Student s
	where s.sid in (select ewr.sid 
				  from EnrollWithRow ewr, boolvec bv
				  where ewr.rownum=bv.rownum and bv.ind=true);
end if;
if booleanOperation = 'or' then
	return query
	with a as(
		select unnest(ind) as ind
		from bitmapIndexOnCno bic
		where bic.cno = cno1
	),
	b as (
		select unnest(ind) as ind
		from bitmapIndexOnGrade big
		where big.grade = grade1
	),
	cnofilter as (
		select row_number() over(order by 1) as rn, ind
		from a
	),
	gradefilter as (
		select row_number() over(order by 1) as rn, ind
		from b
	),
	boolvec as (
		select cnofilter.ind or gradefilter.ind as ind, row_number() over (order by 1) as rownum
		from cnofilter, gradefilter
		where cnofilter.rn = gradefilter.rn
	)
	select *
	from Student s
	where s.sid in (select ewr.sid 
				  from EnrollWithRow ewr, boolvec bv
				  where ewr.rownum=bv.rownum and bv.ind=true);
end if;
if booleanOperation = 'and not' then
	return query
	with a as(
		select unnest(ind) as ind
		from bitmapIndexOnCno bic
		where bic.cno = cno1
	),
	b as (
		select unnest(ind) as ind
		from bitmapIndexOnGrade big
		where big.grade = grade1
	),
	cnofilter as (
		select row_number() over(order by 1) as rn, ind
		from a
	),
	gradefilter as (
		select row_number() over(order by 1) as rn, ind
		from b
	),
	boolvec as (
		select cnofilter.ind and not gradefilter.ind as ind, row_number() over (order by 1) as rownum
		from cnofilter, gradefilter
		where cnofilter.rn = gradefilter.rn
	)
	select *
	from Student s
	where s.sid in (select ewr.sid 
				  from EnrollWithRow ewr, boolvec bv
				  where ewr.rownum=bv.rownum and bv.ind=true);
end if;
end;
$$ language plpgsql;

-- test cases
select * from FindStudents('and', 'c202', 'A');
select * from FindStudents('or', 'c202', 'A');
select * from FindStudents('and not', 'c202', 'A');
