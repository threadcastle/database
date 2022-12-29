-- The function queryPlan returns the query plan for the given sqlStatement

create or replace function queryPlan (sqlStatement text) 
returns table (queryPlanRow text) as
$$
begin
 return  query execute 'explain analyze ' || sqlStatement;
end;
$$ language plpgsql;

-- The function extractExecutionTime extracts the execution time of
-- the query plan for the given sqlStatement

create or replace function extractExecutionTime(sqlStatement text)
returns       float as
$$
   select substring(q.queryPlan,'([0-9.]+)')::float
   from   (select queryPlan from queryPlan(sqlStatement)) q
   where  q.queryPlan like '%Exec%';
$$ language sql;

-- The function runExperiment runs 'n' experiment for the
-- given queryStatement and returns their average execution time

create or replace function runExperiment(n int, queryStatement text) 
returns float as
$$
    select avg((select * from extractExecutionTime(queryStatement)))
    from   generate_series(1,n);
$$ language sql;

-- The 'experiment' function creates m relation S, with |S| = 10^k for k
-- in [k_1,k_2] and runs the (scan) query `SELECT x FROM S' n times.
-- Then the function returns the average execution times of these n
-- runs.

create or replace function experiment(m int, k_1 int, k_2 int, n int, sqlstatement text)
returns table(s int, e numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, executionTime    float);   
   
   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, (select runexperiment(n,sqlstatement)));
    end loop;
   end loop;
   return query select size::int, round(avg(executiontime)::numeric,3)
                from   executionTimeTable 
                group by(size) order by 1;
end;
$$ language plpgsql;





-- Sorting
-- The function queryPlan returns the query plan for the given sqlStatement                                                                  

create or replace function queryPlan (sqlStatement text)
returns table (queryPlanRow text) as
$$
begin
 return  query execute 'explain analyze ' || sqlStatement;
end;
$$ language plpgsql;

-- The function extractExecutionTime extracts the execution time of                                                                          
-- the query plan for the given sqlStatement                                                                                                 

create or replace function extractExecutionTime(sqlStatement text)
returns       float as
$$
   select substring(q.queryPlan,'([0-9.]+)')::float
   from   (select queryPlan from queryPlan(sqlStatement)) q
   where  q.queryPlan like '%Exec%';
$$ language sql;

-- The function runExperiment runs 'n' experiment for the                                                                                    
-- given queryStatement and returns their average execution time                                                                             

create or replace function runExperiment(n int, queryStatement text)
returns float as
$$
    select avg((select * from extractExecutionTime(queryStatement)))
    from   generate_series(1,n);
$$ language sql;

-- The 'experiment' function creates m relation S, with |S| = 10^k for k                                                                     
-- in [k_1,k_2] and runs the (scan) query `SELECT x FROM S' n times.                                                                         
-- Then the function returns the average execution times of these n                                                                          
-- runs.                                                                                                                                     

create or replace function experiment(m int, k_1 int, k_2 int, n int, sqlstatement text)
returns table(s int, e numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, executionTime    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, (select runexperiment(n,sqlstatement)));
    end loop;
   end loop;
   return query select size::int, round(avg(executiontime)::numeric,3)
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;


create or replace function experiment_scanning_sorting(m int, k_1 int, k_2 int, n int, sqlstatement1 text, sqlstatement2 text)
returns table(s int, t1 numeric, t2 numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, time1    float,  time2    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, 
                                            (select runexperiment(n,sqlstatement1)),
                                            (select runexperiment(n,sqlstatement2)));
    end loop;
   end loop;
   return query select size::int, round(avg(time1)::numeric,3), round(avg(time2)::numeric,3) 
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;

-- functions
create or replace function SetOfIntegers(n int, l int, u int)
returns table (x int) as
$$
select floor(random() * (u-l+1) + l)::int from generate_series(1,n);
$$ language sql;


create or replace function makeS (n integer)
returns void as
$$
begin
drop table if exists S;
create table S (x int);
insert into S select * from SetOfIntegers(n,1,n);
end;
$$ language plpgsql;

create or replace function experiment_scanning_indexSort(m int, k_1 int, k_2 int, n int)
returns table(s int, t1 numeric, t2 numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, time1    float,  time2    float);

   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
      

      drop table indexedS;

      create table indexedS(x integer);
      create index index_on_S on indexedS using btree(x);

      insert into executionTimeTable values(floor(power(10,k))::int, 
                                            (select runexperiment(n,'insert into indexedS select x from S')),
                                            (select runexperiment(n,'select true from indexedS where x between 1 and floor(power(10,'||k||'))::int')));
    end loop;
   end loop;
   return query select size::int, round(avg(time1)::numeric,3), round(avg(time2)::numeric,3) 
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;

\qecho 'question 3(a)'
-- question 3(a)
select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan S"
from experiment_scanning_sorting(5,1,8,5,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');
VACUUM FULL;

\qecho 'question 3(b)'
-- question 3(b)
set max_parallel_workers = 0;
set max_parallel_workers_per_gather  = 0;


-- work_mem = 64kB
\qecho '64kB'
set work_mem = '64kB';
select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan S"
from experiment_scanning_sorting(5,1,8,5,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');
VACUUM FULL;

\qecho '4MB'
-- work_mem = 4MB
set work_mem = '4MB';
select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan S"
from experiment_scanning_sorting(5,1,8,5,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');
VACUUM FULL;

\qecho '32MB'
-- work_mem = 32MB
set work_mem = '32MB';
select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan S"
from experiment_scanning_sorting(5,1,8,5,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');
VACUUM FULL;

\qecho '256MB'
-- work_mem = 256MB
set work_mem = '256MB';
select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan S"
from experiment_scanning_sorting(5,1,8,5,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');
VACUUM FULL;

\qecho 'question 3(c)'
set work_mem = '4MB';
create table indexedS (x integer);
create index on indexedS using btree (x);
insert into indexedS select x from S order by 1;

select s as "size S",
       t1 as "create time for index (in ms)",
       t2 as "time for range query (in ms)"
from experiment_scanning_indexSort(5,1,8,5);

\qecho 'question 4'

-- Problem 4.a
select s as "size of relation S", e as "Average execution time for SELECT x FROM S"
from   experiment(5,1,7,5,'SELECT distinct x FROM S');

select s as "size of relation S", e as "Average execution time for SELECT x FROM S"
from   experiment(5,1,7,5,'SELECT distinct x FROM S order by 1');

--Problem 4.b
select s as "size of relation S", e as "Average execution time for SELECT x FROM S"
from   experiment(5,1,7,5,'SELECT x FROM S group by x');

select s as "size of relation S", e as "Average execution time for SELECT x FROM S"
from   experiment(5,1,7,5,'SELECT x FROM S group by x order by 1');

--Problem 4.c
select makeS(10);
explain analyze SELECT distinct x FROM S;
explain analyze SELECT distinct x FROM S order by 1;
explain analyze SELECT x FROM S group by x;
explain analyze SELECT x FROM S group by x order by 1;


\qecho 'question 10' 
TRUNCATE Person CASCADE;
insert into Person(pid, pname)
select p.* as pid, (SELECT to_char(p.*, '99999999')) as pname from generate_series(1, 1000000) p;


-- TEST with SMALL dataset
TRUNCATE personSkill CASCADE;
insert into personSkill(pid, skill)
select pid, skill
from GeneratepersonSkillRelation(500, 1, 100)
order by random();
\qecho 'question 10 - SMALL dataset - without index'
drop table if exists ps;
create table ps(pid integer,skill text);
insert into ps (pid, skill) select * from personSkill;
explain analyze select pid from ps where skill='Databases';
\qecho 'question 10 - SMALL dataset - with index'
create index indexOnskill on ps (skill);
explain analyze select pid from ps where skill='Databases';
drop index indexOnskill;

-- TEST with MEDIUM dataset
TRUNCATE personSkill CASCADE;
insert into personSkill(pid, skill)
select pid, skill
from GeneratepersonSkillRelation(50000, 1, 10000)
order by random();
\qecho 'question 10 - MEDIUM dataset - without index'
drop table if exists ps;
create table ps(pid integer,skill text);
insert into ps (pid, skill) select * from personSkill;
explain analyze select pid from ps where skill='Databases';
\qecho 'question 10 - MEDIUM dataset - with index'
create index indexOnskill on ps (skill);
explain analyze select pid from ps where skill='Databases';
drop index indexOnskill;

-- TEST with LARGE dataset
TRUNCATE personSkill CASCADE;
insert into personSkill(pid, skill)
select pid, skill
from GeneratepersonSkillRelation(5000000, 1, 1000000)
order by random();
\qecho 'question 10 - LARGE dataset - without index'
drop table if exists ps;
create table ps(pid integer,skill text);
insert into ps (pid, skill) select * from personSkill;
explain analyze select pid from ps where skill='Databases';
\qecho 'question 10 - LARGE dataset - with index'
create index indexOnskill on ps (skill);
explain analyze select pid from ps where skill='Databases';
drop index indexOnskill;

\qecho 'question 11' 

-- Problem 11

create or replace function worksFor(p int, c int, s int)
   returns table (pid int, cname int, salary int) as
$$
 select * from (
   select x as pid, floor(random() * c + 1)::int as cname, floor(random() * s +1)*10000 as salary
   from   generate_series(1,p) x order by random()) q;
$$ language sql;


-- data size 10^6
create table wf(pid int, cname int, salary int);
insert into wf (pid, cname, salary) select * from worksFor(1000000, 1000, 100);
explain analyze select pid from wf where salary>=10000 and salary <=10000;
explain analyze select pid from wf where salary>=0 and salary <=500000;
explain analyze select pid from wf where salary>=0 and salary <=1000000;

create index salary_index on wf (salary);
explain analyze select pid from wf where salary>=10000 and salary <=10000;
explain analyze select pid from wf where salary>=0 and salary <=500000;
explain analyze select pid from wf where salary>=0 and salary <=1000000;

-- data size 10^7

drop table wf;
create table wf(pid int, cname int, salary int);
insert into wf (pid, cname, salary) select * from worksFor(10000000, 1000, 100);
explain analyze select pid from wf where salary>=10000 and salary <=10000;
explain analyze select pid from wf where salary>=0 and salary <=500000;
explain analyze select pid from wf where salary>=0 and salary <=1000000;

create index salary_index on wf (salary);
explain analyze select pid from wf where salary>=10000 and salary <=10000;
explain analyze select pid from wf where salary>=0 and salary <=500000;
explain analyze select pid from wf where salary>=0 and salary <=1000000;

-- data size 10^8
drop table wf;
create table wf(pid int, cname int, salary int);
insert into wf (pid, cname, salary) select * from worksFor(10000000, 1000, 100);
explain analyze select pid from wf where salary>=10000 and salary <=10000;
explain analyze select pid from wf where salary>=0 and salary <=500000;
explain analyze select pid from wf where salary>=0 and salary <=1000000;

create index salary_index on wf (salary);
explain analyze select pid from wf where salary>=10000 and salary <=10000;
explain analyze select pid from wf where salary>=0 and salary <=500000;
explain analyze select pid from wf where salary>=0 and salary <=1000000;



\qecho 'question 12'

create or replace function queryPlan (sqlStatement text) 
returns table (queryPlanRow text) as
$$
begin
 return  query execute 'explain analyze ' || sqlStatement;
end;
$$ language plpgsql;

-- The function extractExecutionTime extracts the execution time of
-- the query plan for the given sqlStatement

create or replace function extractExecutionTime(sqlStatement text)
returns       float as
$$
   select substring(q.queryPlan,'([0-9.]+)')::float
   from   (select queryPlan from queryPlan(sqlStatement)) q
   where  q.queryPlan like '%Exec%';
$$ language sql;

-- The function runExperiment runs 'n' experiment for the
-- given queryStatement and returns their average execution time

create or replace function runExperiment(n int, queryStatement text) 
returns float as
$$
    select avg((select * from extractExecutionTime(queryStatement)))
    from   generate_series(1,n);
$$ language sql;

-- The 'experiment' function creates m relation S, with |S| = 10^k for k
-- in [k_1,k_2] and runs the (scan) query `SELECT x FROM S' n times.
-- Then the function returns the average execution times of these n
-- runs.

create or replace function experiment(m int, k_1 int, k_2 int, n int, sqlstatement text)
returns table(s int, e numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, executionTime    float);   
   
   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makePS(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, (select runexperiment(n,sqlstatement)));
    end loop;
   end loop;
   return query select size::int, round(avg(executiontime)::numeric,3)
                from   executionTimeTable 
                group by(size) order by 1;
end;
$$ language plpgsql;

create or replace function
BinaryRelationOverIntegers(n int, l_1 int, u_1 int, l_2 int, u_2 int)
returns table (x int, y int) as
$$
select floor(random() * (u_1-l_1+1) + l_1)::int as x,
floor(random() * (u_2-l_2+1) + l_2)::int as y
from generate_series(1,n);
$$ language sql;

create or replace function GeneratepersonSkillRelation(n int, l int, u int)
returns table (pid int, skill text) as
$$
with skillNumber(skill, index) as (select skill, row_number() over (order by skill)
from Skill),
pS as (select x, y
from BinaryRelationOverIntegers(n,l,u,1, (select count(1) from Skill)::int))
select x as pid, skill
from pS join skillNumber on y = index
group by (x, skill) order by 1,2;
$$ language sql;

create or replace function makePS (n integer)
returns void as
$$
begin
drop table if exists PS;
create table PS (pid int,skill text);
insert into PS select * from GeneratepersonSkillRelation(n,1,n);
end;
$$ language plpgsql;

-- create table ps(pid integer,skill text);
-- insert into ps select * from GeneratepersonSkillRelation(1000000,1,100000000);

-- explain analyze select pid, skill
-- 				from ps
-- 				where pid = 9999 and skill = 'AI';
				

select s as "size of relation ps", e as "Average execution time"
from   experiment(3,5,7,3,'select pid, skill
				from ps
				where pid = 9999 and skill = ''AI''');
				
-- size of relation ps | Average execution time
-----------------------+------------------------
--              100000 |                 17.540
--             1000000 |                122.217
--            10000000 |                483.346

-- Add hash index
create or replace function makeindexPS (n integer)
returns void as
$$
begin
drop table if exists PS;
create table PS (pid int,skill text);
insert into PS select * from GeneratepersonSkillRelation(n,1,n);
create index pid_hash on ps using hash (pid);
end;
$$ language plpgsql;

create or replace function experiment2(m int, k_1 int, k_2 int, n int, sqlstatement text)
returns table(s int, e numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, executionTime    float);   
   
   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeindexPS(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, (select runexperiment(n,sqlstatement)));
    end loop;
   end loop;
   return query select size::int, round(avg(executiontime)::numeric,3)
                from   executionTimeTable 
                group by(size) order by 1;
end;
$$ language plpgsql;


select s as "size of relation ps", e as "Average execution time"
from   experiment2(3,5,7,3,'select pid, skill
				from ps
				where pid = 9999 and skill = ''AI''');

--  size of relation ps | Average execution time
-----------------------+------------------------
--              100000 |                  0.057
--             1000000 |                  0.066
--            10000000 |                  0.164

\qecho 'question 13'




drop table if exists skill cascade;
drop table if exists Person cascade;
drop table if exists personSkill cascade;

-- create table skill 
create table skill(skill text,
				  primary key(skill));

insert into skill values
('AI'),
('Databases'),
('Networks'),
('OperatingSystems'),
('Programming');



-- create table Person
create table Person(pid integer, pname text, primary key(pid));


-- insert data into Person
insert into Person(pid, pname)
select p.* as pid, (SELECT to_char(p.*, '99999999')) as pname from generate_series(1, 10000) p;


-- create table personSkill

create table personSkill(pid integer,skill text,
						 primary key(pid, skill), 
						 foreign key (pid) references Person (pid),
						 foreign key (skill) references skill (skill));


-- insert data of PS
insert into personSkill(pid, skill)

select pid, skill from generatepersonskillrelation(20000, 1, 10000);

--


-- (1) 10000 records in Person, and 16453 records in personSkill;
explain analyze select pid, pname from Person where pid in (select pid from personSkill where skill = 'Databases');

--"Hash Join  (cost=335.90..517.16 rows=3299 width=14) (actual time=2.826..5.735 rows=3299 loops=1)"
--"              Rows Removed by Filter: 13154"
--"Planning Time: 0.623 ms"
--"Execution Time: 5.989 ms"


explain analyze select pid, pname from Person where pid not in (select pid from personSkill where skill = 'Databases');

-- "Seq Scan on person  (cost=302.91..482.91 rows=5000 width=14) (actual time=1.822..3.387 rows=6701 loops=1)"
-- "          Rows Removed by Filter: 13154"
-- "Planning Time: 0.075 ms"
-- "Execution Time: 3.764 ms"

create index h_pid on Person(pid);

create index h_pidskill on personSkill(pid, skill);


-- explan after indexing
explain analyze select pid, pname from Person where pid in (select pid from personSkill where skill = 'Databases');
-- "Hash Join  (cost=335.90..517.16 rows=3299 width=14) (actual time=1.706..3.872 rows=3299 loops=1)"
-- "              Rows Removed by Filter: 13154"
-- "Planning Time: 0.438 ms"
-- "Execution Time: 4.065 ms"


explain analyze select pid, pname from Person where pid not in (select pid from personSkill where skill = 'Databases');

-- "Seq Scan on person  (cost=302.91..482.91 rows=5000 width=14) (actual time=1.552..3.150 rows=6701 loops=1)"
--"              Rows Removed by Filter: 13154"
-- "Planning Time: 0.438 ms"
-- "Execution Time: 4.065 ms"

drop index h_pid;
drop index h_pidskill;

drop table personskill cascade;
drop table person cascade;


-- (2) 

create table Person(pid integer, pname text, primary key(pid));


-- insert data into Person
insert into Person(pid, pname)
select p.* as pid, (SELECT to_char(p.*, '99999999')) as pname from generate_series(1, 100000) p;


-- create table personSkill

create table personSkill(pid integer,skill text,
						 primary key(pid, skill), 
						 foreign key (pid) references Person (pid),
						 foreign key (skill) references skill (skill));


-- insert data of PS
insert into personSkill(pid, skill)

select pid, skill from generatepersonskillrelation(300000, 1, 100000);


-- 100000 records in Person, and 225857 records in personSkill;

explain analyze select pid, pname from Person where pid in (select pid from personSkill where skill = 'Networks');

--"Hash Join  (cost=4599.99..6403.50 rows=44622 width=14) (actual time=25.738..53.019 rows=45095 loops=1)"
--"              Rows Removed by Filter: 180762"
--"Planning Time: 0.327 ms"
--"Execution Time: 56.031 ms"

explain analyze select pid, pname from Person where pid not in (select pid from personSkill where skill = 'Networks');

--"Seq Scan on person  (cost=4153.77..5944.77 rows=50000 width=14) (actual time=25.716..44.315 rows=54905 loops=1)"
--"          Rows Removed by Filter: 180762"
--"Planning Time: 0.062 ms"
--"Execution Time: 47.204 ms"

create index h_pid on Person(pid);

create index h_pidskill on personSkill(pid, skill);


-- explan after indexing
explain analyze select pid, pname from Person where pid in (select pid from personSkill where skill = 'Networks');

--"Hash Join  (cost=4599.99..6403.50 rows=44622 width=14) (actual time=30.727..55.969 rows=45095 loops=1)"
--"              Rows Removed by Filter: 180762"
--"Planning Time: 0.453 ms"
--"Execution Time: 59.332 ms"

explain analyze select pid, pname from Person where pid not in (select pid from personSkill where skill = 'Networks');

--"Seq Scan on person  (cost=4153.77..5944.77 rows=50000 width=14) (actual time=27.849..43.764 rows=54905 loops=1)"
--"          Rows Removed by Filter: 180762"
--"Planning Time: 0.065 ms"
--"Execution Time: 46.696 ms"

drop index h_pid;
drop index h_pidskill;

drop table personskill cascade;
drop table person cascade;

--(3)


create table Person(pid integer, pname text, primary key(pid));


-- insert data into Person
insert into Person(pid, pname)
select p.* as pid, (SELECT to_char(p.*, '99999999')) as pname from generate_series(1, 1000000) p;


-- create table personSkill

create table personSkill(pid integer,skill text,
						 primary key(pid, skill), 
						 foreign key (pid) references Person (pid),
						 foreign key (skill) references skill (skill));


-- insert data of PS
insert into personSkill(pid, skill)

select pid, skill from generatepersonskillrelation(3000000, 1, 100000);

-- 1000000 records in Person, and 498725 records in personSkill;

explain analyze select pid, pname from Person where pid in (select pid from personSkill where skill = 'Programming');

--"Merge Join  (cost=29.66..17125.51 rows=101025 width=14) (actual time=0.018..66.761 rows=99759 loops=1)"
--"Planning Time: 0.145 ms"
--"Execution Time: 72.099 ms"

explain analyze select pid, pname from Person where pid not in (select pid from personSkill where skill = 'Programming');

-- "Seq Scan on person  (cost=9181.62..27087.62 rows=500000 width=14) (actual time=62.887..311.732 rows=900241 loops=1)"
--"Planning Time: 0.062 ms"
--"Execution Time: 369.249 ms"

create index h_pid on Person(pid);

create index h_pidskill on personSkill(pid, skill);


-- explan after indexing
explain analyze select pid, pname from Person where pid in (select pid from personSkill where skill = 'Programming');

--"Merge Join  (cost=29.62..17109.51 rows=101025 width=14) (actual time=0.017..73.382 rows=99759 loops=1)"
--"Planning Time: 0.440 ms"
--"Execution Time: 78.412 ms"

explain analyze select pid, pname from Person where pid not in (select pid from personSkill where skill = 'Programming');

--"Seq Scan on person  (cost=9181.62..27087.62 rows=500000 width=14) (actual time=66.667..315.909 rows=900241 loops=1)"
--"Planning Time: 0.069 ms"
--"Execution Time: 373.367 ms"


drop index h_pid;
drop index h_pidskill;

drop table personskill cascade;
drop table person cascade;
drop table skill cascade;


\qecho 'question 14'   
create or replace function create_Knows(n int)
   returns table (pid1 int, pid2 int) as
$$
    with pid_list as (select * from generate_series(1,n) as pid order by pid)
    select p1.pid, p2.pid from pid_list p1, pid_list p2 where p1!=p2
    order by random();
$$ language sql;

create table Knows(pid1 int, pid2 int);

set work_mem = '32MB';

-- TEST WITH SMALL RELATION: 2e2 records in Knows
TRUNCATE knows;
insert into knows(pid1, pid2)
select * from create_Knows(15);
explain analyze select distinct k1.pid1, k3.pid2 from knows k1, knows k2, knows k3 where k1.pid2 = k2.pid1 and k2.pid2 = k3.pid1;

create index  knows_index on knows (pid1);
explain analyze select distinct k1.pid1, k3.pid2 from knows k1, knows k2, knows k3 where k1.pid2 = k2.pid1 and k2.pid2 = k3.pid1;
drop index knows_index;



-- TEST WITH MEDIUM RELATION: 2e4 records in Knows
TRUNCATE knows;
insert into knows(pid1, pid2)
select * from create_Knows(150);
explain analyze select distinct k1.pid1, k3.pid2 from knows k1, knows k2, knows k3 where k1.pid2 = k2.pid1 and k2.pid2 = k3.pid1;

create index  knows_index on knows (pid1);
explain analyze select distinct k1.pid1, k3.pid2 from knows k1, knows k2, knows k3 where k1.pid2 = k2.pid1 and k2.pid2 = k3.pid1;
drop index knows_index;


-- TEST WITH LARGE RELATION; 1e6 records in Knows
TRUNCATE knows;
insert into knows(pid1, pid2)
select * from create_Knows(1100);
explain analyze select distinct k1.pid1, k3.pid2 from knows k1, knows k2, knows k3 where k1.pid2 = k2.pid1 and k2.pid2 = k3.pid1;

create index  knows_index on knows (pid1);
explain analyze select distinct k1.pid1, k3.pid2 from knows k1, knows k2, knows k3 where k1.pid2 = k2.pid1 and k2.pid2 = k3.pid1;
drop index knows_index;
