\c hw7;
-- CODE for question 4
drop table if exists P, Q, R;
-------------------------------------------------------- hepler function

-- generate relation P or Q
create or replace function SetOfIntegers(n int, l int, u int)
returns table (x int) as
$$
select floor(random() * (u-l+1) + l)::int as x
from generate_series(1,n)
group by (x) order by 1
limit n;
$$ language sql;

-- generate relation R
create or replace function BinaryRelationOverIntegers(n int, l_1 int, u_1 int, l_2 int, u_2 int)
returns table (x int, y int) as
$$
select distinct
floor(random() * (u_1-l_1+1) + l_1)::int as x,
floor(random() * (u_2-l_2+1) + l_2)::int as y
from generate_series(1,n)
limit n;
$$ language sql;


-------------------------------------------------------- hepler function end
create table P (a int);
create table R (a int, b int);
create table Q (b int);


create or replace function RunQ5(n int)
returns table (queryPlanRow text) as
$$
begin
return query execute 'explain analyze ' || 
'select p.a 
 from P p 
 where p.a not in (
 select r.a  from R r where r.b not in (select q.b from Q q))';
end;
$$ language plpgsql;



create or replace function RunQ6(n int)
returns table (queryPlanRow text) as
$$
begin
return query execute 
'explain analyze
select p
from P p
except
(
select distinct p
from P p natural join (select distinct r.a as a from R r)r
except
select distinct p
from P p natural join ( select distinct r.a as a 
                        from (R r natural join (select distinct q.b as b from Q q)q)r
                      ) r
)';
end;
$$ language plpgsql;

\qecho "Problem 4"

\qecho "CASE1: size of P changes"
TRUNCATE P, Q, R;
insert into Q select * from SetOfIntegers(10000,1,10000) order by random();
insert into R select * from BinaryRelationOverIntegers(10000, 1, 1000, 1, 1000) order by random();


TRUNCATE P;
insert into P select * from SetOfIntegers(10000,1,10000) order by random();
select * from RunQ5(1);
select * from RunQ6(1);

TRUNCATE P;
insert into P select * from SetOfIntegers(100000,1,100000) order by random();
select * from RunQ5(1);
select * from RunQ6(1);

TRUNCATE P;
insert into P select * from SetOfIntegers(1000000,1,1000000) order by random();
select * from RunQ5(1);
select * from RunQ6(1);


\qecho "CASE2: size of R changes"
TRUNCATE P, Q, R;
insert into P select * from SetOfIntegers(10000,1,10000) order by random();
insert into Q select * from SetOfIntegers(10000,1,10000) order by random();

TRUNCATE R;
insert into R select * from BinaryRelationOverIntegers(10000, 1, 1000, 1, 1000) order by random();
select * from RunQ5(1);
select * from RunQ6(1);


TRUNCATE R;
insert into R select * from BinaryRelationOverIntegers(100000, 1, 1000, 1, 1000) order by random();
select * from RunQ5(1);
select * from RunQ6(1);

TRUNCATE R;
insert into R select * from BinaryRelationOverIntegers(1000000, 1, 1000, 1, 1000) order by random();
select * from RunQ5(1);
select * from RunQ6(1);


\qecho "CASE3: the `a' attribute in R is a foreign key referencing the `a' attribute in P"
\qecho "and size of R changes"
TRUNCATE P, Q, R;
ALTER TABLE P
    ADD CONSTRAINT a PRIMARY KEY (a);
ALTER TABLE R
    ADD CONSTRAINT a FOREIGN KEY (a) REFERENCES P (a);
insert into P select * from SetOfIntegers(10000,1,10000) order by random();
insert into Q select * from SetOfIntegers(10000,1,10000) order by random();


TRUNCATE R;
insert into R select * from RrefP_BinaryRelation(10000) order by random();
select * from RunQ5(1);
select * from RunQ6(1);

TRUNCATE R;
insert into R select * from RrefP_BinaryRelation(100000) order by random();
select * from RunQ5(1);
select * from RunQ6(1);

ALTER TABLE R DROP CONSTRAINT a;
ALTER TABLE P DROP CONSTRAINT a;
