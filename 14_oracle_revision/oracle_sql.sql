-- created a new profile named 'avr_revision'
-- day 1
select * from tab;
create table "demoTable" as (select * from hr.employees);

select * from "demoTable";
drop table "demoTable";

-- day 2
create table demo (username varchar2(10));
insert into demo values ('Vinz');

create table practiceTable as select * from EMPLOYEES;
select * from PRACTICETABLE;

select * from emp;

-- day 3
SELECT * FROM
(
  SELECT first_name, department_id
  FROM emp
)
PIVOT
(
  COUNT(department_id)
  FOR department_id IN (10, 30, 50, 60, 90, 100, 110)
)
ORDER BY first_name;
    
-- day 4
SELECT
    department_id, first_name, last_name, salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary ) rn
FROM employees;

SELECT NULLif(1,1) FROM dual;
-- gives NULL

select add_months(sysdate, 3) from dual;
-- add 3 months

select first_value(salary) over (partition by department_id order by salary) as fv,
last_value(salary) over (partition by department_id order by salary) as lv,
department_id from emp;

select
    rank() over (partition by department_id order by salary) as rk, salary
from emp
order by salary;

select first_name,
FIRST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY hire_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS first_hired_salary,
FIRST_VALUE(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS first_hired_salary_notbounded
from emp;
