-- run the below SET command once
SET serveroutput ON;

DECLARE
    -- contains all the fields from hr.employees TABLE
	emp_rec hr.employees%ROWTYPE;

	-- custom fields RECORD TYPE
	TYPE t_emp IS RECORD (
        first_name hr.employees.first_name%TYPE,
        last_name hr.employees.last_name%TYPE,
        salary hr.employees.salary%TYPE,
        hire_date DATE
    );

	t_emp_rec t_emp;
BEGIN
	SELECT * INTO emp_rec
	FROM hr.employees
	WHERE employee_id = '101';

	dbms_output.put_line(emp_rec.employee_id);

	-- manual assignment of values
	t_emp_rec.first_name := 'Vidhan';
	t_emp_rec.salary := 25000;
	t_emp_rec.hire_date := '10-FEB-23';
	dbms_output.put_line(t_emp_rec.first_name || ' ' || t_emp_rec.last_name || ' with salary ' 
        || t_emp_rec.salary || ' hired on ' || t_emp_rec.hire_date);

	-- or, get them using the SELECT statement by specifying the fields
	SELECT first_name, last_name, salary, hire_date INTO t_emp_rec
        FROM hr.employees
        WHERE employee_id = '101';
	dbms_output.put_line('Using SELECT statement, ');
	dbms_output.put_line(t_emp_rec.first_name || ' ' || t_emp_rec.last_name || ' with salary ' 
        || t_emp_rec.salary || ' hired on ' || t_emp_rec.hire_date);
END;
/
