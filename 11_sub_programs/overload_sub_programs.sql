-- run the below SET command once
SET serveroutput ON;

-- CREATE a skeleton TABLE
CREATE TABLE emp AS 
    SELECT * FROM hr.employees WHERE 1 = 2;

-- SUB-PROGRAM example
DECLARE
  	PROCEDURE insert_high_paid_emp(p_emp hr.employees%ROWTYPE) IS
    	r_emp hr.employees%ROWTYPE;
		-- origin FUNCTION
		FUNCTION get_emp(emp_num hr.employees.employee_id%TYPE) 
    	RETURN hr.employees%ROWTYPE IS
        BEGIN
        	SELECT * INTO r_emp FROM hr.employees WHERE employee_id = emp_num;
        	RETURN r_emp;
        END;

		--  FUNCTION overloading with different TYPE 
		FUNCTION get_emp(emp_email hr.employees.email%TYPE) 
    	RETURN hr.employees%ROWTYPE IS
        BEGIN
        	SELECT * INTO r_emp FROM hr.employees WHERE email = emp_email;
        	RETURN r_emp;
        END;

		--  FUNCTION overloading with different TYPE 
		FUNCTION get_emp(
            emp_fn hr.employees.first_name%TYPE,
            emp_ln hr.employees.last_name%TYPE
        ) RETURN hr.employees%ROWTYPE IS
        BEGIN
        	SELECT * INTO r_emp 
            FROM hr.employees 
            WHERE first_name = emp_fn AND last_name = emp_ln;
        	RETURN r_emp;
        END;
    BEGIN
        r_emp := get_emp(p_emp.employee_id);
        INSERT INTO emp VALUES r_emp;
		r_emp := get_emp(p_emp.email);
		INSERT INTO emp VALUES r_emp;
		r_emp := get_emp(
            emp_fn => p_emp.first_name,
            emp_ln => p_emp.last_name
        );
		INSERT INTO emp VALUES r_emp;
    END;
BEGIN
    FOR r_emp IN (SELECT * FROM hr.employees) LOOP
        IF r_emp.salary > 15000 THEN
            insert_high_paid_emp(r_emp);
        END IF;
    END LOOP;
END;
/

-- check the results
SELECT * FROM emp;

-- [OPTIONAL] DROP it after the usage
DELETE emp;
