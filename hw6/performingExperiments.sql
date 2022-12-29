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


-- Example:  SCANNING
-- Average execution times to analyze scanning a set S of increasing size
-- using the SQL statement  'SELECT x FROM S' statement.

select s as "size of relation S", e as "Average execution time for SELECT x FROM S"
from   experiment(5,1,7,5,'SELECT x FROM S');


/*
 size of relation S | Average execution time for SELECT x FROM S 
--------------------+--------------------------------------------
                 10 |                                      0.008
                100 |                                      0.023
               1000 |                                      0.142
              10000 |                                      1.352
             100000 |                                     13.343
            1000000 |                                    133.687
           10000000 |                                   1377.334
          100000000 |                                  14040.783
(8 rows)
*/

-- These execution times makes sense since scanning a relation is O(|S|).


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


-- Example: SCANNING using the SQL statement 'SELECT x FROM S'

-- Average execution times to analyze scanning a set S of increasing
-- size


select s as "size of relation S", e as "Average execution time for SELECT x FROM S"
from   experiment(5,1,8,5,'SELECT x FROM S');


/*
 size of relation S | Average execution time for SELECT x FROM S 
--------------------+--------------------------------------------
                 10 |                                      0.009
                100 |                                      0.019
               1000 |                                      0.144
              10000 |                                      1.334
             100000 |                                     13.435
            1000000 |                                    133.561
           10000000 |                                   1381.552
          100000000 |                                  14509.639
(8 rows)
*/


-- SORTING using statement 'select x from S order by 1;'

select s as "size of relation S", e as "Average execution time for SELECT x FROM S"
from   experiment(5,1,8,5,'SELECT x FROM S ORDER BY 1');

/*
 size of relation S | Average execution time for SELECT x FROM S 
--------------------+--------------------------------------------
                 10 |                                      0.023
                100 |                                      0.069
               1000 |                                      0.561
              10000 |                                      5.799
             100000 |                                     74.518
            1000000 |                                    520.981
           10000000 |                                   6413.851
          100000000 |                                  56885.527
*/


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


select s as "size of relation S", 
       t1 as "avg execution time to scan S",
       t2 as "avg execution time to scan S"
from experiment_scanning_sorting(3,1,8,3,'SELECT x FROM S', 'SELECT x FROM S ORDER BY 1');

set work_mem = '4MB';
set max_parallel_workers = 0;


 size of relation S | avg execution time to scan S | avg execution time to scan S 
--------------------+------------------------------+------------------------------
                 10 |                        0.009 |                        0.015
                100 |                        0.020 |                        0.044
               1000 |                        0.150 |                        0.384
              10000 |                        1.334 |                        3.668
             100000 |                       13.323 |                       47.916
            1000000 |                      135.008 |                      528.670
           10000000 |                     1387.183 |                     6376.019
          100000000 |                    13985.228 |                    95999.630
(8 rows)


set work_mem = '64kB';

size of relation S | avg execution time to scan S | avg execution time to sort S 
--------------------+------------------------------+------------------------------
                 10 |                        0.008 |                        0.015
                100 |                        0.020 |                        0.044
               1000 |                        0.149 |                        0.771
              10000 |                        1.337 |                        5.479
             100000 |                       13.371 |                       61.023
            1000000 |                      135.514 |                      858.248
           10000000 |                     1382.106 |                     9819.487
          100000000 |                    14136.311 |                   115182.103
(8 rows)

set work_mem = '1GB';


size of relation S | avg execution time to scan S | avg execution time to sort S 
--------------------+------------------------------+------------------------------
                 10 |                        0.008 |                        0.013
                100 |                        0.018 |                        0.039
               1000 |                        0.133 |                        0.343
              10000 |                        1.342 |                        3.657
             100000 |                       13.600 |                       42.376
            1000000 |                      133.697 |                      494.129
           10000000 |                     1382.028 |                     5512.165
          100000000 |                    14074.251 |                    64347.063


--- 



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
                                            (select runexperiment(n,'insert into indexedS select x from S order by 1')),
                                            (select runexperiment(n,'select x from indexedS where x between 1 and floor(power(10,'||k||'))::int')));
    end loop;
   end loop;
   return query select size::int, round(avg(time1)::numeric,3), round(avg(time2)::numeric,3) 
                from   executionTimeTable
                group by(size) order by 1;
end;
$$ language plpgsql;

select s as "size S",
       t1 as "create time for index (in ms)",
       t2 as "time for range query (in ms)"
from experiment_scanning_indexSort(3,1,7,3);


select s as "size of relation S", 
       t1 as "avg execution time to create index indexedS (in ms)",
       t2 as "avg execution time to range query (in ms)"
from experiment_scanning_indexSort(3,1,7,3);

set work_mem = '4MB';

 size of relation S | avg execution time to create index indexedS (in ms) | avg execution time to range query (in ms) 
--------------------+-----------------------------------------------------+-------------------------------------------
                 10 |                                               0.169 |                                     0.013
                100 |                                               0.264 |                                     0.026
               1000 |                                               1.931 |                                     0.181
              10000 |                                              18.500 |                                     1.714
             100000 |                                             363.177 |                                    17.819
            1000000 |                                            3532.803 |                                   176.709
           10000000 |                                           33818.144 |                                  1923.139
          100000000 |                                          354823.185 |                                 33047.220
(8 rows)




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


select s as "size S",
       t1 as "create time for index (in ms)",
       t2 as "time for range query (in ms)"
from experiment_scanning_indexSort(3,1,7,3);

 size of relation S | avg execution time to create index indexedS (in ms) | avg execution time to range query (in ms) 
--------------------+-----------------------------------------------------+-------------------------------------------
                 10 |                                               0.207 |                                     0.021
                100 |                                               0.231 |                                     0.026
               1000 |                                               1.945 |                                     0.189
              10000 |                                              18.778 |                                     1.724
             100000 |                                             373.851 |                                    18.884
            1000000 |                                            4452.451 |                                   186.479
           10000000 |                                           52823.166 |                                  2260.612





-- Function 'worksFor' makes a relation relation with persons whose
-- pid is in the range [1..p] and who work for a randomly selected
-- company with cname in range [1..c] and who have a randomly selected
-- salary in the range [1..s]*10000.


create or replace function worksFor(p int, c int, s int)
   returns table (pid int, cname int, salary int) as
$$
 select * from (
   select x as pid, floor(random() * c + 1)::int as cname, floor(random() * s +1)*10000 as salary
   from   generate_series(1,p) x order by random()) q;
$$ language sql;
