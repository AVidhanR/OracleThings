--(HR Schema)
--1) Write procedure to display the number of department to the location_id as 'Number of Department in location id 50 is 5' 
-- by pass the argument to procedure as location_id with named as deptcount(loc number).If no department to location_id then raise the user exception to display "No department function in that Location"
create or replace PROCEDURE deptcount (loc_id IN NUMBER) AS
    v_count NUMBER := 0;
BEGIN
    SELECT COUNT(department_id)
    INTO v_count
    FROM dept
    WHERE location_id = loc_id;
    
    IF v_count > 0 THEN
        dbms_output.put_line('Number of Department in location id[' || loc_id ||' is ' || v_count);
    ELSE
        dbms_output.put_line('Enter a valid location id');
    END IF;
END;
/

SELECT * FROM dept;

BEGIN
    deptcount(1800);
END;
/

--2) Write the procedure to copy the manager record from employees table and move records to managers table. 
-- Procedure is named with mgremp and display the "Number of record is copied is" if not then "No record insert into manager" using the basic loop with cursor.
create TABLE mgremp (
    empid		number,
	first_name	varchar2(30),
	job_id		varchar2(30),
	department_id	number
);

SELECT * FROM mgremp;

SELECT * FROM tab;

create or replace PROCEDURE p_mgremp AS
    CURSOR c_emp IS (
        SELECT
            employee_id, 
            first_name, 
            job_id, 
            department_id    
        FROM emp
        WHERE employee_id IN (
            SELECT DISTINCT manager_id 
            FROM emp 
            WHERE manager_id IS NOT NULL)
    );
    v_count NUMBER := 0;
    r_c c_emp%ROWTYPE;
BEGIN
    -- cursor using basic loop
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO r_c;
        EXIT WHEN c_emp%NOTFOUND;
        INSERT INTO mgremp
        VALUES r_c;
        v_count := v_count + 1;
    END LOOP;
    CLOSE c_emp;
    
    IF v_count > 0 THEN
        dbms_output.put_line('Number of record is copied is ' || v_count);
    ELSE
        dbms_output.put_line('No record insert into manager');
    END IF;
END;
/
	
BEGIN
    p_mgremp;
END;
/

delete mgremp;


--3) Write a function to calculate the total salary by salary*commission and  deduction of professional tax of 6% from total salary 
-- if total salary is greater than or equal to $15000 and less than 15000 is 2.5%. function named as salcal with two parameter of salary and commission.
SELECT * FROM emp;

create or replace FUNCTION salcal (sal IN emp.salary%TYPE, comm emp.commission_pct%TYPE)
RETURN NUMBER AS
    v_total_sal NUMBER := 0;
BEGIN
    v_total_sal := sal + NVL(comm, 0);
    IF v_total_sal >= 15000 THEN
        v_total_sal := v_total_sal - (v_total_sal * 0.6);
    ELSIF v_total_sal < 15000 THEN
        v_total_sal := v_total_sal - (v_total_sal * 0.25);
    END IF;
    
    RETURN v_total_sal;
END;
/

DECLARE
    v_sal NUMBER;
    v_comm NUMBER;
BEGIN
    SELECT salary, commission_pct
    INTO v_sal, v_comm
    FROM emp
    WHERE employee_id = 100;
    
    dbms_output.put_line(salcal(v_sal, v_comm));
END;
/


--4) Write trigger on emp table for the event of update to column of salary. when the salary is 
-- update to emp table stored old salary into empoldsal table. Display 'Record is inserted into empoldsal'.
-- already done in plsql_practice_hr.sql


--5) write the package named as PKG_dept_info which contains the two procedure. 
--    a)Procedure named EmpCount where to display the department_name and number of employee in each department.
--    b)Procedure name SalDept where to display the departmentname, total_salary  and average_salary of each departments
create or replace PACKAGE pkg_dept_info AS
    PROCEDURE EmpCount;
    PROCEDURE SalDept;
END;
/

create or replace PACKAGE BODY pkg_dept_info AS
    PROCEDURE EmpCount AS
        CURSOR c_emp IS (
            SELECT
                department_name,
                COUNT(employee_id) AS no_emp
            FROM
                emp JOIN dept
                USING (department_id) 
            group by department_name  
        );
    BEGIN
        FOR c IN c_emp LOOP
            dbms_output.put_line(c.department_name || ' '|| c.no_emp);
        END LOOP;
    END;
    
    PROCEDURE SalDept AS
    BEGIN
        FOR c IN (
            SELECT
                department_name,
                SUM(salary) AS total_sal,
                AVG(salary) AS average_sal
            FROM
                dept JOIN emp
                USING (department_id)
            GROUP BY
                department_name
        ) LOOP
            dbms_output.put_line(c.department_name || ' ' || c.total_sal || ' ' || c.average_sal);
        END LOOP;
    END;
END;

BEGIN
    pkg_dept_info.empcount;
    dbms_output.put_line('--------------------');
    pkg_dept_info.saldept;
END;
/


--SQL
----------
--
--1 ) Display the employees, with employeeid, firstname, job_id, salary and hike_salary, where 
--hike_salary is 20% hike from there salary and display only emp who get salary >10000 after salary hiked
-- already done
--2) Display the employee_id, first_name, department_name, job_id and city. Only from department_id of 30,50,70,90 and sort based on firstname of employee 
-- already done
--3) Display the all departments with department_name and number of employees from each department 
--      as 'NO_Emp'. Irrespective of  department have employee or not. sort based on no_emp as descending order. 
-- already done 
--4) Display the jobid and number of employees as No_Emps. display only  the jobId which has maximum no_emps number employees  sort record based on job_id 
SELECT
   e. job_id,
    COUNT(e.employee_id) AS no_emps
FROM emp e
GROUP BY job_id
HAVING COUNT(e.employee_id) >=all (
    SELECT
    COUNT(e.employee_id) AS no_emps
    FROM emp e
    GROUP BY job_id
)
ORDER BY job_id ASC;

--5) write sql query to display the employee_id, first_name, job_id and salary , who is working in the department name of "IT"
-- already done
--
--6) Write the SQL query to display the managers with there employee_id as Manager_id ,first_nameas Manager_NAme, 
-- job_id and department_id and sort by manager_id.
-- already done
SELECT
    employee_id AS manager_id,
    first_name AS manager_name,
    job_id,
    department_id
FROM emp
WHERE employee_id IN (
    SELECT manager_id FROM emp WHERE manager_id IS NOT NULL
)
ORDER BY manager_id ASC;

