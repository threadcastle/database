-- Script for B561 Fall 2022 Assignment 7

create database dvgassignment7;

\c dvgassignment7


\qecho 'Problem 8'

\qecho 'question 8.a'



--- Topological sort
create table V(node int);
create table E(source int, target int);


insert into V values
   (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12);

insert into E values
   (1,2),
   (1,3),
   (1,4),
   (2,5),
   (2,6),
   (3,7),
   (4,8),
   (5,9),
   (7,10),
   (7,11),
   (9,12);





create or replace function adja()
returns table (node int, adj int[]) as 
$$
select source, array_agg(target)
from E
group by (source);

$$ language sql;


-- TO reverse a array, the reference is from
-- https://wiki.postgresql.org/wiki/Array_reverse
CREATE OR REPLACE FUNCTION array_reverse(anyarray) RETURNS anyarray AS $$
SELECT ARRAY(
    SELECT $1[i]
    FROM generate_subscripts($1,1) AS s(i)
    ORDER BY i DESC
);
$$ LANGUAGE 'sql' STRICT IMMUTABLE;




--select v.jud from vis v where v.i = mmmmmm;
--UPDATE vis SET jud = jjjjj WHERE i = nnnnnn;

create or replace function topo(v int)
returns void as $$
declare
x int;
A int[];

BEGIN

--visit[v] := visit[v] + 1;
UPDATE vis SET jud = 1 WHERE i = v;


A := array(select unnest(g.adj) from graph g where g.n = v);

--insert into tempt
--select A;

foreach x in array A loop

	--if visit[x] = 0 THEN 
	if (select v.jud from vis v where v.i = x) = 0 THEN 
	perform topo(x);	
	
	end if;
	 
end loop;

--perform array_append(stack, v);
--insert into tempt 
--select * from array_append(stack, v);

insert into toposort
select v;

end;
$$ language plpgsql;




create or replace function someTopologicalSort()
returns int [] as $$

declare
i int;
--visit int[] := array_fill(0, array[12]);
--stack int[];
sf int[];
tt int[];
nodes int[] := array(select * from V);

BEGIN

DROP TABLE IF EXISTS graph;
create table graph(n int, adj int[]);
insert into graph
select * from adja();


DROP TABLE IF EXISTS vis;
create table vis(i int, jud int);
insert into vis values (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0);


DROP TABLE IF EXISTS toposort;
create table toposort(tt int);

for ii in 1..array_length(nodes, 1) loop
	if (select v.jud from vis v where v.i = ii) = 0 THEN
		perform topo(ii);
	
	end if;

end loop;



sf := array_reverse(array(select * from toposort));
--FOR I IN REVERSE array_length(nodes, 1)..1 LOOP
	
	--insert into tempt 
	--select array_append(sf, stack[I]);
--	perform array_append(tt, array[sf[I]]);
	
	--insert into tempt values(stack);

--end loop;



return sf;
end;
$$ language plpgsql;



select someTopologicalSort();


drop table V cascade;
drop table E cascade;
drop table GRAPH cascade;
drop table toposort cascade;
drop table vis cascade;




\qecho 'Problem 9'
-- Dijkstra Algorithm

drop table if exists Graph;
create table Graph(source int,
                   target int,
                   weight int);

insert into Graph values
  (0,1,2),
  (1,0,2),
  (0,4,10),
  (4,0,10),
  (1,3,3),
  (3,1,3),
  (1,4,7),
  (4,1,7),
  (2,3,4),
  (3,2,4),
  (3,4,5),
  (4,3,5),
  (4,2,6),
  (2,4,6);
  
create or replace function new_pairs()
returns table(source integer, target integer, weight integer) as
$$
begin
return query(
(select Dijk.source, Graph.target, Dijk.weight+Graph.weight
from Dijk join Graph on Dijk.target=Graph.source)
except
(select * from Dijk));
end;
$$language plpgsql;

create or replace function Dijkstra(s integer)
returns table(target integer, weight integer) as
$$
declare j integer;
begin
drop table if exists Dijk;
create table Dijk(source integer, target integer, weight integer);
insert into Dijk select * from Graph where Graph.source=s;
insert into Dijk values(s, s, 0);
j := (select count(*) from Graph);
while (j>0)
loop
insert into Dijk select * from new_pairs();
j = j-1;
end loop;
return query(select Dijk.target, min(Dijk.weight) from Dijk group by Dijk.source, Dijk.target);
end;
$$language plpgsql;

select * from Dijkstra(0) order by target;



\qecho 'Problem 10'

drop table if exists partSubPart;
drop table if exists basicPart;
create table partSubpart(pid int, sid int, quantity int);
create table basicPart(pid int, weight int);

insert into partSubpart values 
   (1,2,1),
   (1,3,3),
   (1,4,2),
   (2,5,1),
   (2,6,4),
   (3,7,2),
   (4,8,1),
   (5,9,2),
   (7,10,2),
   (7,11,3),
   (9,12,5);

insert into basicPart values
  (6,  1),
  (8,  4),
  (10, 1),
  (11, 5),
  (12, 3);

\qecho 'Problem 10.a'

-- Write a {\bf recursive} function {\tt recursiveAggregatedWeight(p
-- integer)} that returns the aggregated weight of a part {\tt p}.

create or replace function RecursiveAggregatedWeight(p integer)
returns int as
$$
begin
DROP TABLE IF EXISTS partweight;
create table partweight(pid int,weight int);
insert into partweight select * from basicpart;
if exists(select pw.weight from partweight pw where pw.pid=p) then
return (select pw.weight from partweight pw where pw.pid=p);
else
return (select sum(recursiveAggregatedWeight(psp.sid)*psp.quantity)
		from partsubpart psp
		where psp.pid=p);
end if;
end;
$$language plpgsql;

select * from recursiveAggregatedWeight(1);
select * from recursiveAggregatedWeight(2);
select * from recursiveAggregatedWeight(3);
select * from recursiveAggregatedWeight(4);
select * from recursiveAggregatedWeight(5);
select * from recursiveAggregatedWeight(6);
select * from recursiveAggregatedWeight(7);
select * from recursiveAggregatedWeight(8);
select * from recursiveAggregatedWeight(9);
select * from recursiveAggregatedWeight(10);
select * from recursiveAggregatedWeight(11);
select * from recursiveAggregatedWeight(12);

\qecho 'Problem 10.b'

-- Write a {\bf non-recursive} function {\tt
-- nonRecursiveAggregatedWeight(p integer)} that returns the aggregated
-- weight of a part {\tt p}.  Test your function.

create table partweight(pid int,weight int);
create or replace function new_partweight()
returns table (pid int,weight int) as
$$
(select psp.pid, pw.weight*psp.quantity
from partsubpart psp join partweight pw on psp.sid=pw.pid)
EXCEPT
(select pw.pid,pw.weight
from partweight pw);
$$language sql;

create or replace function nonrecursiveAggregatedWeight(p integer)
returns int as
$$
begin
DROP TABLE IF EXISTS partweight;
create table partweight(pid int,weight int);
insert into partweight select * from basicpart;
-- DECLARE weight integer;
WHILE EXISTS (SELECT distinct * FROM new_partweight())
LOOP
INSERT INTO partweight SELECT distinct * FROM new_partweight();
END LOOP;
return
(select pwf.weight
from(select pw.pid as pid,sum(pw.weight) as weight
	from partweight pw
	group by pw.pid) pwf
where pwf.pid=p);
end;
$$language plpgsql;



select * from nonrecursiveAggregatedWeight(1);
select * from nonrecursiveAggregatedWeight(2);
select * from nonrecursiveAggregatedWeight(3);
select * from nonrecursiveAggregatedWeight(4);
select * from nonrecursiveAggregatedWeight(5);
select * from nonrecursiveAggregatedWeight(6);
select * from nonrecursiveAggregatedWeight(7);
select * from nonrecursiveAggregatedWeight(8);
select * from nonrecursiveAggregatedWeight(9);
select * from nonrecursiveAggregatedWeight(10);
select * from nonrecursiveAggregatedWeight(11);
select * from nonrecursiveAggregatedWeight(12);
\qecho 'Problem 11'

-- Write a PostgreSQL program frequentSets(t int) that returns the sets
-- of all t-frequent sets.

drop table if exists personSkills;
create table personSkills(doc int, words text[]);

insert into personSkills values
  (1, '{"A", "B", "C", "D", "E"}'),
  (2, '{"A", "B", "C", "E", "F"}'),
  (3, '{"A", "E", "F"}'),
  (4, '{"E", "A"}');

drop view if exists skills;

create view skills as
(select distinct unnest(d.words) as word
        from   personSkills d);

CREATE OR REPLACE FUNCTION combo(anyarray) RETURNS SETOF anyarray AS $$
WITH RECURSIVE
    items AS (
            SELECT row_number() OVER (ORDER BY item) AS rownum, item
            FROM (SELECT unnest($1) AS item) unnested
    ),
    q AS (
            SELECT 1 AS j, $1[1:0] arr
            UNION ALL
            SELECT (j+1), CASE x
                    WHEN 1 THEN array_append(q.arr,(SELECT item FROM items WHERE rownum = j))
                    ELSE q.arr END
            FROM generate_series(0,1) x CROSS JOIN q WHERE j <= array_upper($1,1)
    )
SELECT q.arr AS mods
FROM q WHERE j = array_upper($1,1)+1;
$$ LANGUAGE 'sql';



drop table if exists temp;

create table temp as
select combo(array_agg(word)) from skills;

drop function if exists frequentsets;

CREATE OR REPLACE FUNCTION frequentSets(t int)
RETURNS table(frequentset text[]) AS $$

declare j record;
begin


drop table if exists op;
create table op(sets text[], threshold int);


for j in (select * from temp)
loop

insert into op
select j.combo,count(1)
from personSkills d
where j.combo<@ d.words;

end loop;
  return query (select r.sets from op r where threshold >= t);
end;
$$ LANGUAGE plpgsql;

-- Tests:
--0
select * from frequentSets(0);
--1
select * from frequentSets(1);
--2
select * from frequentSets(2);
--3
select * from frequentSets(3);
--4
select * from frequentSets(4);
--5
select * from frequentSets(5);

\qecho 'Problem 12' 
-- Hamiltonian

\qecho 'Problem 12.a'

-- Write a {\bf recursive} function {\tt recursiveHamiltonian()} that
-- returns {\tt true} if the graph stored in {\tt Graph} is
-- Hamiltonian, and {\tt false} otherwise.

drop table if exists Path;
create table Path(vertex int, ord int);
insert into Path values(1, 1);

create or replace function adjacent(v int, pos int)
returns bool as
$$
begin
if (pos, v) not in (select source, target from Graph) then
	return false;
end if;
if v in (select vertex from Path) then
	return false;
end if;
return true;
end;
$$ language plpgsql;

create or replace function recursiveHamiltonian()
returns bool as
$$
declare count_path int;
declare count_total int;
declare v1 int;
declare v2 int;
declare new_v int;
declare pos int;
declare num int;
begin
	count_path := (select count(*) from Path);
	count_total := (select count(*) from (select source from graph union select target from graph)p);
	if count_path = count_total then
		v1 := (select vertex from Path where ord=count_path);
		v2 := (select vertex from Path where ord=1);
		if (v1, v2) in (select source, target from Graph) then
			return true;
		else
			return false;
		end if;
	end if;
	for new_v in 2..count_total
	loop
		pos := (select max(ord) from Path);
		if (select adjacent(new_v, pos)) = true then
			num := (select count(*) from Path);
			insert into Path values(new_v, num+1);
			if (select recursiveHamiltonian())=true then
				return true;
			else
				delete from Path where vertex=new_v;
			end if;
		end if;
	end loop;
	return false;
end;
$$ language plpgsql;

drop table Graph;
create table Graph(source int, target int);


-- Test your function on the following graphs.


-- delete from Graph;
-- insert into Graph values (1,2), (2,3), (3,1);

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,1);

select recursiveHamiltonian();

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,1),
 (4,5),
 (5,4);

select recursiveHamiltonian();

\qecho 'Problem 12.b'

-- Write a {\bf non-recursive} function {\tt nonRecursiveHamiltonian}
-- that returns {\tt true} if the graph stored in {\tt Graph} is
-- Hamiltonian, and {\tt false} otherwise. 

create or replace function iterative_permutations(elements int[])
returns table ("permutation" int[]) as
$$
declare
i int;
ct_elements int := cardinality(elements);
begin
drop table if exists element;
create table element(element int);
drop table if exists permutation;
create table permutation (permutation int[]);
insert into element (select unnest(elements));
insert into permutation values ('{}');
for i in 1..ct_elements loop
insert into permutation
select array_append(p.permutation, element)
from permutation p, element
where element not in (select unnest(p.permutation)) and
cardinality(p.permutation) = i-1;
end loop;
return query select p.permutation
from permutation p
where cardinality(p.permutation) = ct_elements;
end;
$$ language plpgsql;


create or replace function nonRecursiveHamiltonian()
returns bool as
$$
declare
my_array int[];
iter_permute record;
i int;
count_edge int;
begin
my_array := array(select source from graph union select target from graph);
drop table if exists permute;
create table permute(nums int[]);
insert into permute select * from iterative_permutations(my_array);
for iter_permute in select * from permute
loop
	count_edge := 0;
	for i in 1..(array_length(my_array,1)-1)
	loop
		if (iter_permute.nums[i], iter_permute.nums[i+1]) in (select source, target from Graph) then
			count_edge := count_edge+1;
		end if;
	end loop;
	if (iter_permute.nums[array_length(my_array,1)], iter_permute.nums[1]) in (select source, target from Graph) then
		count_edge := count_edge+1;
	end if;
	if count_edge = array_length(my_array,1) then
		return true;
	end if;
end loop;
return false;
end;
$$ language plpgsql;

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,1);

select nonRecursiveHamiltonian();

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,1),
 (4,5),
 (5,4);

select nonRecursiveHamiltonian();

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,5),
 (5,6),
 (6,7),
 (7,8),
 (8,9),
 (9,10),
 (10,1);


-- select nonRecursiveHamiltonian();

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,5),
 (5,6),
 (6,7),
 (7,8),
 (8,9),
 (9,10);

-- select nonRecursiveHamiltonian();


\qecho 'Problem 13'

drop table if exists color;
create table color(vertex int, col int);
insert into color values(1, 1);

create or replace function isok(cur int, i int)
returns bool as
$$
declare pre int;
begin
	if cur=2 then
		if ((2,1) in (select source, target from Graph) or (1,2) in (select source, target from graph)) and (1, i) in (select * from color) then
			return false;
		else
			return true;
		end if;
	end if;
	for pre in 1..(cur-1)
	loop
		if ((cur, pre) in (select source, target from Graph) or (pre, cur) in (select source, target from graph)) and (pre, i) in (select * from color) then
			return false;
		end if;
	end loop;
	return true;
end;
$$ language plpgsql;

create or replace function threeColorable()
returns bool as
$$
declare v int;
declare total int;
declare i int;
begin
	total := (select count(*) from (select source from graph union select target from graph)p);
	v := (select max(vertex) from color);
	v := v+1;
	if v > total then
		return true;
	end if;
	for i in 1..3
	loop
		if isok(v, i)=true then
			insert into color values(v, i);
			return threeColorable();
		end if;
	end loop;
	return false;
end;
$$ language plpgsql;

delete from Graph;

insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,5),
 (5,1);


-- select threeColorable();


delete from Graph;

insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,5),
 (5,1);


select threeColorable();


delete from color where vertex<>1;
delete from Graph;
insert into Graph values
 (1,2),
 (2,1),
 (1,3),
 (3,1),
 (1,4),
 (4,1),
 (2,3),
 (3,2),
 (2,4),
 (4,2),
 (3,4),
 (4,3);


select threeColorable();


\qecho 'Problem 14'

create table dataSet(p integer, x float, y float);

insert into dataSet values
 (1, 1, 1),
 (2, 1, 2),
 (3, 1, 3),
 (4, 1, 4),
 (5, 1, 5),
 (6, 1, 6),
 (7, 1, 7),
 (8, 1, 8),
 (9, 1, 9),
 (10, 1, 10),
 (11, 2, 1),
 (12, 2, 2),
 (13, 2, 3),
 (14, 2, 4),
 (15, 2, 5),
 (16, 2, 6),
 (17, 2, 7),
 (18, 2, 8),
 (19, 2, 9),
 (20, 2, 10),
 (21, 3, 1),
 (22, 3, 3),
 (23, 3, 4),
 (24, 3, 5),
 (25, 3, 6),
 (26, 3, 7),
 (27, 3, 8),
 (28, 3, 9),
 (29, 4, 1),
 (30, 4, 2),
 (31, 4, 4),
 (32, 4, 5),
 (33, 4, 6),
 (34, 4, 7),
 (35, 4, 8),
 (36, 4, 9),
 (37, 4, 10),
 (38, 5, 2),
 (39, 5, 4),
 (40, 5, 5),
 (41, 5, 6),
 (42, 5, 8),
 (43, 5, 9),
 (44, 5, 10),
 (45, 6, 2),
 (46, 6, 3),
 (47, 6, 4),
 (48, 6, 5),
 (49, 6, 6),
 (50, 6, 7),
 (51, 6, 8),
 (52, 6, 9),
 (53, 6, 10),
 (54, 7, 2),
 (55, 7, 3),
 (56, 7, 5),
 (57, 7, 6),
 (58, 7, 7),
 (59, 7, 8),
 (60, 7, 9),
 (61, 7, 10),
 (62, 8, 2),
 (63, 8, 3),
 (64, 8, 4),
 (65, 8, 5),
 (66, 8, 6),
 (67, 8, 7),
 (68, 8, 8),
 (69, 8, 9),
 (70, 9, 2),
 (71, 9, 3),
 (72, 9, 4),
 (73, 9, 5),
 (74, 9, 7),
 (75, 9, 8),
 (76, 9, 9),
 (77, 9, 10),
 (78, 10, 2),
 (79, 10, 3),
 (80, 10, 4),
 (81, 10, 5),
 (82, 10, 6),
 (83, 10, 7),
 (84, 10, 8);


create or replace function findcenter()
returns int AS
$$
declare res int;
declare meanx float:=
(select avg(gn.x)
from memberInk gn);
declare meany float:=
(select avg(gn.y)
from memberInk gn);
begin


res := (select * from findnearest(meanx,meany));
return res;
end;
$$language plpgsql;


create or replace function findnearest(nodex float,nodey float)
returns int as
$$
begin
DROP TABLE IF EXISTS dis;
CREATE TABLE dis(p int, diss float);
INSERT INTO dis SELECT s.p as p,(s.x-nodex)*(s.x-nodex)+(s.y-nodey)*(s.y-nodey) as diss from center s;

return (select d.p
		from dis d
		where d.diss=(select min(d2.diss)
					 from dis d2));
end;
$$language plpgsql;

select * from findnearest(10,8);


create or replace function kMeans(k integer)
returns table(p integer, x float, y float) as
$$
declare i int;
declare j int;
declare point record;
declare nearp int;
declare newcenter int;
BEGIN
drop table if exists center;
create table center(p integer, x float, y float);
insert into center select * from dataset limit k;

drop table if exists assign;
create table assign(p integer, x float, y float, num integer);
insert into assign select ds.p, ds.x, ds.y, 1 from dataset ds;

for i in 1..10
loop
	for point in (select * from dataset)
	loop
		nearp := (select * from findnearest(point.x, point.y));
		update assign set num=nearp where assign.p=point.p;
		if i<10 then
			delete from center;
		end if;
	end loop;
	for j in 1..k
	loop
		drop table if exists memberInk;
		create table memberInk(p integer, x float, y float);
		insert into memberInk select assign.p, assign.x, assign.y from assign where assign.num=j;
		newcenter := findcenter();
		insert into center select * from dataset where dataset.p=newcenter;
	end loop;
	
end loop;
return query(select * from center);
end;
$$language plpgsql;


-- select * from kMeans(1);

-- select * from kMeans(2);

-- select * from kMeans(3);

-- select * from kMeans(4);


 



 




\c postgres
drop database dvgassignment7;

