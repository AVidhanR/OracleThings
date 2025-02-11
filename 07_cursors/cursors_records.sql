-- run the below SET comand once
SET serveroutput ON;


DECLARE
    -- not efficient (or) avoid it maximum
    TYPE r_emp IS RECORD (
    	v_first_name hr.employees.first_name%TYPE,
		v_last_name hr.employees.last_name%TYPE
    );
	CURSOR c_emp IS (
        SELECT first_name, last_name
        FROM hr.employees
    );

	emp_rec R_EMP;
BEGIN
	OPEN c_emp;
	FETCH c_emp INTO emp_rec;
	dbms_output.put_line(emp_rec.v_first_name || ' ' || emp_rec.v_last_name);
	CLOSE c_emp;
END;
/

DECLARE
	CURSOR c_emp_all IS (
        SELECT *
        FROM hr.employees
    );

	CURSOR c_emp IS (
        SELECT first_name, last_name
        FROM hr.employees
    );

	-- efficient way
	emp_rec hr.employees%ROWTYPE;

	-- all time effecient way
	emp_rec_cur c_emp%ROWTYPE;
BEGIN
	OPEN c_emp;
	FETCH c_emp INTO emp_rec_cur;
	dbms_output.put_line(emp_rec_cur.first_name || ' ' || emp_rec_cur.last_name);
	CLOSE c_emp;

	OPEN c_emp_all;
	FETCH c_emp_all INTO emp_rec;
	dbms_output.put_line(emp_rec.first_name || ' ' || emp_rec.last_name);
	CLOSE c_emp_all;
END;
/
