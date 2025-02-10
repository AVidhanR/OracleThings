-- run the below SET command once
SET serveroutput ON;

DECLARE
    -- user defined TYPE RECORD
	TYPE t_edu IS RECORD (
		primary_school VARCHAR2(100),
		high_school VARCHAR2(100),
		university VARCHAR2(100),
    	uni_graduate_date DATE    	 
    );

	-- custome TYPE RECORD with existing objects
	TYPE t_emp IS RECORD (
        first_name hr.employees.first_name%TYPE,
        last_name hr.employees.last_name%TYPE,
        salary hr.employees.salary%TYPE NOT NULL DEFAULT 1000,
        hire_date DATE,
        dept_id hr.employees.department_id%TYPE,
        dept hr.departments%ROWTYPE,
        education t_edu
    );

	-- <record_name> <record_type>
	emp_rec t_emp;
BEGIN
    -- from employees TABLE
	SELECT 
    	first_name, 
    	last_name, 
    	salary, 
    	hire_date, 
    	department_id
    INTO
    	emp_rec.first_name, 
    	emp_rec.last_name, 
    	emp_rec.salary, 
    	emp_rec.hire_date, 
    	emp_rec.dept_id
	FROM
		hr.employees
	WHERE
		employee_id = '146';

	-- from 'departments' TABLE
	SELECT * INTO emp_rec.dept
    FROM hr.departments
    WHERE department_id = emp_rec.dept_id;

	emp_rec.education.high_school := 'SSEM';
	emp_rec.education.university:= 'REC';
    emp_rec.education.uni_graduate_date := '01-APR-25';

	dbms_output.put_line(emp_rec.first_name || ' ' || emp_rec.last_name || ' with salary ' ||
        emp_rec.salary || ' hired on ' || emp_rec.hire_date);

	dbms_output.put_line(emp_rec.first_name || ' graduated from ' || emp_rec.education.university || ' on ' ||
        emp_rec.education.uni_graduate_date);

	dbms_output.put_line(emp_rec.first_name || ' department is ' || emp_rec.dept.department_name);
END;
/
