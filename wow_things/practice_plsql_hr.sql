-- run the below SET command once
SET serveroutput ON;

-- run the below CREATE commands before 
CREATE TABLE emp AS SELECT * FROM employees WHERE 1 = 1;
CREATE TABLE dept AS SELECT * FROM departments WHERE 1 = 1;

--------------------------------------------------------------- PROCEDURE
--1.Create a plsql procedure, that copy the all record of department_id, department_name and
--location_id of all departments that located in country_id of "US" to a table called "Department_US" using the
--cursor with basic loop.
--Display how many rows were copied , if not then display the message "NO RECORDS FOUND".
--
--Note :create a table Department_US with
--structure ((HR SCHEME)
--Field Name Datatype
------------------- -------------
--Department_Id number
--Department_name varchar2(40)
--Location_id number
create TABLE Department_US (
    department_id NUMBER,
    department_name VARCHAR2(40),
    location_id NUMBER
);
--select * from locations;
create or replace PROCEDURE insertIntoDeptUS AS
    CURSOR c_dept_us IS (
        SELECT
            d.department_id,
            d.department_name,
            d.location_id
        FROM dept d JOIN locations l
        ON d.location_id = l.location_id
        WHERE l.country_id = 'US'
    );
    r_dept c_dept_us%ROWTYPE;
BEGIN
    OPEN c_dept_us;
    LOOP
        FETCH c_dept_us INTO r_dept;
        EXIT WHEN c_dept_us%NOTFOUND;
        INSERT INTO Department_US VALUES r_dept;
    END LOOP;
    CLOSE c_dept_us;
END;
/

BEGIN
    insertIntoDeptUS;
END;
/

SELECT * FROM Department_US;
/
----------------------------------------------------------------------------
--2. Create a procedure named as "deleteemp( depit in number) " that delete rows from the employees table. 
-- It should accept 1 parameter, departmentId; only delete the employee records belonging to that departmentid. 
-- Display how many employees were deleted else raise"DeptIDNotFound"  and print the message 'No Records Found' (HR SCHEME)
-- select * from dept;

create or replace PROCEDURE deleteemp (departmentId IN NUMBER) AS
      DeptIDNotFound EXCEPTION;
      v_count NUMBER := 0;
BEGIN
    
    DELETE FROM emp
    WHERE department_id = departmentId
    RETURNING COUNT(*) INTO v_count;
    
    -- get the deleted rows count
    dbms_output.put_line(v_count || ' ' || sql%rowcount);
    IF v_count = 0 THEN
        RAISE DeptIDNotFound;
    ELSE 
        dbms_output.put_line(v_count || ' are deleted');
    END IF;
EXCEPTION
    WHEN DeptIDNotFound THEN
        dbms_output.put_line('No Records Found');
END;
/

BEGIN
    deleteemp(110);
END;
/

SELECT * from emp;
/

rollback;
/
------------------------------------------------------------------
--3. create a proedurce that gives all employees in IT job_id, with  22 % pay increase in there salary 
-- Display a message how many Employees were give salary hike the increase. 
-- If no employee found then print the message 'No Records Found' ((HR SCHEME))
create or replace PROCEDURE getITEmployees (eid IN emp.employee_id%TYPE) AS
v_count NUMBER := 0;
BEGIN
    SELECT COUNT(employee_id)
    INTO v_count
    FROM emp e
    WHERE e.job_id LIKE 'IT%' AND
    e.employee_id = eid;
    
    IF v_count > 0 THEN
        dbms_output.put_line(v_count);
    ELSE
        dbms_output.put_line('No Records Found');
    END IF;
END;
/
SET serveroutput ON;

BEGIN
    getITEmployees(103);
END;
/

SELECT * FROM emp;
/
---------------------------------------------------------------------------
--4. Write a procedure to perform salary hike operation that only permits a hike , if there is salary is less than  8000, 
--then update the  salary  with employee table and print the message 'Salary Hike is successful' else print 'Salary is greater than 8000'.
--((HR SCHEME))  procedure named as salhike(hike  as number)
create or replace PROCEDURE salhike (hike IN NUMBER) AS
    CURSOR c_emp IS (
        SELECT employee_id, salary 
        FROM emp
    );
BEGIN    
    FOR c IN c_emp LOOP
        IF (c.salary < 8000) THEN
            UPDATE emp
            SET salary = salary + hike
            WHERE employee_id = c.employee_id;
            dbms_output.put_line('Salary Hike is successful');
        ELSE
            dbms_output.put_line('Salary is greater than 8000');
        END IF;
    END LOOP;
END;
/

SELECT * FROM emp;

BEGIN
    salhike(1000);
END;
/

ROLLBACK;

--------------------------------------------------------------------------
-- 5.Write procedure to display the number of department to the location_id as 
-- 'Number of Department in location id[50] is [25]' by pass the argument to procedure as location_id with named as deptcount(loc number).
create or replace PROCEDURE deptcount (loc_id IN NUMBER) AS
    v_count NUMBER := 0;
BEGIN
    SELECT COUNT(department_id)
    INTO v_count
    FROM dept
    WHERE location_id = loc_id;
    
    IF v_count > 0 THEN
        dbms_output.put_line('Number of Department in location id[' || loc_id ||'] is [' || v_count ||']');
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
------------------------------------------------------------------------
--6.Write the procedure to copy the manager record from employees table and move records to managers table. 
-- Procedure is named with mgremp and display the "Number of record is copied is" 
-- if not then "No record insert into manager" using the basic loop with cursor.
--Note: create a table mgremp with stucture
--	empid		number,
--	first_name	varchar2(30);
--	job_id		varchar2(30);
--	department_id	number..
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
        WHERE manager_id IS NOT NULL
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



---------------------------------------------------------------- FUNCTIONS -----
--  1. Write a PLSQL user defined function as empname to concatenate firstname and lastname of an employee. 
--Pass employee id as an input to the functions
--empname  Output of function returns :-  Mr/Mrs. Sam Peter
create or replace FUNCTION empname (eid IN emp.employee_id%TYPE)
RETURN VARCHAR2 AS
    v_first_name emp.first_name%TYPE;
    v_last_name emp.last_name%TYPE;
BEGIN
    SELECT first_name, last_name
    INTO v_first_name, v_last_name
    FROM emp
    WHERE employee_id = eid;
    
    RETURN ('Mr/Mrs. ' || v_first_name || ' ' || v_last_name);
EXCEPTION
    WHEN no_data_found THEN
        RETURN (eid || ' not found.');
END;
/

BEGIN
    dbms_output.put_line(empname(110));
END;
/

SELECT * FROM emp;

------------------------------------------------------------------------
--2. Write user define function as deptloc to return departmentname-city-Country_name example 
--"IT-NewYork-USA".Function is passed with department_id as an input
SELECT * FROM dept;
SELECT * FROM locations;
SELECT * FROM countries;
SELECT * FROM tab;

create or replace FUNCTION deptloc (dept_id dept.department_id%TYPE)
RETURN VARCHAR2 AS

--    The below CURSOR imple' is a costly opertion 
--    avoid it!
--    CURSOR c_deptloc IS (
--        SELECT
--            d.department_name,
--            l.city,
--            c.country_name
--        FROM
--            (dept d JOIN locations l
--            ON d.location_id = l.location_id) JOIN
--            countries c ON l.country_id = c.country_id
--        WHERE
--            d.department_id = dept_id
--    );

    v_dept_name dept.department_name%TYPE;
    v_city locations.city%TYPE;
    v_country_name countries.country_name%TYPE;

    v_dept_id dept.department_id%TYPE := NULL;
    v_loc_id locations.location_id%TYPE;
    v_country_id locations.country_id%TYPE;
BEGIN
    SELECT department_id, department_name, location_id
    INTO v_dept_id, v_dept_name, v_loc_id
    FROM dept
    WHERE department_id = dept_id;

    SELECT city, country_id
    INTO v_city, v_country_id
    FROM locations
    WHERE location_id = v_loc_id;
    
    SELECT country_name
    INTO v_country_name
    FROM countries
    WHERE country_id = v_country_id;
    
    RETURN (v_dept_name||'-'||v_city||'-'||v_country_name);

--    FOR c IN c_deptloc LOOP
--        RETURN (c.department_name||'-'||c.city||'-'||c.country_name);
--    END LOOP;
EXCEPTION
    WHEN no_data_found THEN
        RETURN (dept_id||' not found');
END;
/

BEGIN
    dbms_output.put_line(deptloc(100));
END;
/
---------------------------------------------------------------------------
--3. Write function as empexp( empid number) which returns the experence of the employee, 
--When function is passed as input of employee_id return as experence of that employee.
create or replace FUNCTION empexp (eid emp.employee_id%TYPE)
RETURN NUMBER AS
    v_hire_date emp.hire_date%TYPE;
BEGIN
    SELECT hire_date
    INTO v_hire_date
    FROM emp
    WHERE employee_id = eid;

    RETURN TRUNC(MONTHS_BETWEEN(sysdate, v_hire_date)/12);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Employee id: ' || eid || ' not found');
        RETURN NULL;
END;
/

BEGIN
    dbms_output.put_line(empexp(101));
END;
/
-----------------------------------------------------------------------------------
--4.Write a function to calculate the total salary by salary commission and  deduction of 
--professional tax of 6% from total salary if total salary is greater than or equal to $15000 and less than 15000 is 2.5%. 
--function named as salcal with two parameter of salary and commission.
SELECT * FROM emp;

create or replace FUNCTION salcal (sal IN emp.salary%TYPE, comm emp.commission_pct%TYPE)
RETURN NUMBER AS
    v_total_sal NUMBER := 0;
BEGIN
    v_total_sal := sal + NVL(comm, 0);
    IF v_total_sal >= 15000 THEN
        v_total_sal := v_total_sal * 0.6;
    ELSIF v_total_sal < 15000 THEN
        v_total_sal := v_total_sal * 0.25;
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


------------------------------------------------------------------- TRIGGERS ---
--1. Write the trigger to the employee  table when the deleted event happened. 
--so that when an employee record is deleted the record details need to be inserted into  an table called X_Emp along  with deleted date
--
--Note : Assume X_emp  table is existing  with 
--
--Field Name      datatype
----------------------------------
--Employee_ID	number
--First_name	Varchar2(30)
--department_id	number
--deleted_date	date
create TABLE x_emp (
    Employee_ID	number,
    first_name	Varchar2(30),
    department_id	number,
    deleted_date	date
);

create or replace TRIGGER emp_log AFTER DELETE ON emp FOR EACH ROW
DECLARE
BEGIN
    INSERT INTO x_emp
    VALUES (:old.employee_id, :old.first_name||' '||:old.last_name, :old.department_id, sysdate);
END;
/

SELECT * FROM x_emp;
SELECT * FROM emp;

DELETE FROM emp
WHERE employee_id = 106;

ROLLBACK;
---------------------------------------------------------------------------------
--2. Create a tigger to display the message "Place a order for the Product <product_name>",
-- when ever a item quantity reached 10 and below in product table when  updating or inserting an item in order table.
--Products  table 
-------------------------
--Pid	ProductName	Qty
--100	Mouse		50
--101	  Keyboard	32
--102	Pendrive	5
--103	RAM		12

--Order Table
--------------------
--Oid 	Pid  	 qty
--1000	100	45
--1001	101	2
--1003	102	25
--
--Output:
--"Place a Order for the product Mouse"
create TABLE products (
    pid NUMBER PRIMARY KEY,
    product_name VARCHAR2(50),
    qty NUMBER
);

create TABLE orders (
    order_id NUMBER PRIMARY KEY,
    pid NUMBER,
    qty NUMBER,
    FOREIGN KEY (pid) REFERENCES products(pid)
);

INSERT ALL
    INTO products VALUES (100, 'Mouse', 50)
    INTO products VALUES (101, 'Keyboard', 32)
    INTO products VALUES (102, 'Pendrive', 5)
    INTO products VALUES (103, 'RAM', 12)
SELECT * FROM DUAL;

SELECT * FROM products;
SELECT * FROM orders;

create or replace TRIGGER prod_notifier 
BEFORE UPDATE OR INSERT ON orders FOR EACH ROW
DECLARE
    v_qty NUMBER;
    v_pname VARCHAR2(50);
BEGIN
    SELECT qty
    INTO v_qty
    FROM products
    WHERE pid = :new.pid;
    CASE
        WHEN (:new.qty <= v_qty) THEN
            UPDATE products
            SET qty = qty - :new.qty
            WHERE pid = :new.pid;
            
            SELECT qty
            INTO v_qty
            FROM products
            WHERE pid = :new.pid;
            IF (v_qty <= 10) THEN
                GOTO product_less;
            END IF;
        ELSE
            GOTO product_less;
    END CASE;
    
    <<product_less>>
    SELECT product_name
    INTO v_pname
    FROM products
    WHERE pid = :new.pid;
    dbms_output.put_line('Place an order for the Product ' || v_pname);
END;
/
delete products;
delete orders;

-- to trigger the above
INSERT ALL
    INTO orders VALUES (1, 100, 40)
    INTO orders VALUES (2, 101, 23)
    INTO orders VALUES (3, 102, 12)
    INTO orders VALUES (4, 103, 6)
SELECT * FROM dual;

--------------------------------------------------------------------------------------------
--3. Create trigger on the employee table when the update is happened to employee's salary field. 
--wirte the action to trigger to  Insert the employee's old salary in 	empoldsal table
--
--  empoldsal  table
------------------------------
--Field Name 	datatype

--empid		number
--firstname	varchar2(30)
--Oldsalary	  number

create TABLE empoldsal (
    empid NUMBER,
    firstname VARCHAR2(30),
    oldsalary NUMBER
);

SELECT * FROM emp;

create or replace trigger trigger_old_sal 
BEFORE UPDATE ON emp FOR EACH ROW 
BEGIN
    INSERT INTO empoldsal
    VALUES (:old.employee_id, :old.first_name, :old.salary);
    dbms_output.put_line('trigger complete');
END;
/

UPDATE emp
SET salary = salary + 1000
WHERE employee_id = 106;

SELECT * FROM empoldsal;

drop table empoldsal;
drop trigger trigger_old_sal;
--------------------------------------------------------------------------------------------
--4.Write trigger on emp table for the event of update to column of salary.
-- when the salary is update to emp table stored old salary into empoldsal table. Display 'Record is inserted into empoldsal'.
create table empoldsal AS SELECT * FROM emp WHERE 1=2;

create or replace TRIGGER emp_sal_log
BEFORE UPDATE ON emp FOR EACH ROW
BEGIN
    INSERT INTO empoldsal
    VALUES (
        :old.employee_id, 
        :old.first_name, 
        :old.last_name, 
        :old.email, 
        :old.phone_number, 
        :old.hire_date, 
        :old.job_id, 
        :old.salary, 
        :old.commission_pct,
        :old.manager_id, 
        :old.department_id
    );
    dbms_output.put_line('Record is inserted into empoldsal');
END;
/

UPDATE emp
SET salary = salary + 1000
WHERE employee_id = 106;

SELECT * FROM empoldsal;

SELECT * FROM emp;

delete empoldsal;
