-- run the below SET command once
SET serveroutput ON;

-- CREATE a skeleton TABLE
CREATE TABLE emp AS 
SELECT * FROM hr.employees WHERE 1 = 2;

-- SUB-PROGRAM example
DECLARE
    -- FUNCTIONz, variables and PRCODEURE
    -- only avilable in this scope!
  	FUNCTION get_emp(emp_num hr.employees.employee_id%type) 
	RETURN hr.employees%rowtype IS
    	r_emp hr.employees%rowtype;
    BEGIN
    	SELECT * INTO r_emp FROM hr.employees WHERE employee_id = emp_num;
    	RETURN r_emp;
    END;
  	PROCEDURE insert_high_paid_emp(emp_id hr.employees.employee_id%type) IS
    	r_emp hr.employees%ROWTYPE;
    BEGIN
        r_emp := get_emp(emp_id);
        INSERT INTO emp VALUES r_emp;
    END;
BEGIN
    FOR r_emp IN (SELECT * FROM hr.employees) LOOP
        IF r_emp.salary > 15000 THEN
            insert_high_paid_emp(r_emp.employee_id);
        END IF;
    END LOOP;
END;
/

-- check the results
SELECT * FROM emp;

-- [OPTIONAL] DELETE it after the usage or even DROP it
DELETE emp;
