-- run the below SET comand once
SET serveroutput ON;

DECLARE
	CURSOR c_emp IS (
    	SELECT *
    	FROM hr.employees
    	WHERE department_id = 30
    );

	r_emp c_emp%ROWTYPE;
BEGIN
	OPEN c_emp;
	LOOP
		FETCH c_emp INTO r_emp;
		EXIT WHEN c_emp%NOTFOUND;
		dbms_output.put_line(r_emp.employee_id || ' ' || r_emp.first_name || ' ' || r_emp.last_name);
	END LOOP;
	CLOSE c_emp;

	dbms_output.put_line('---');

	OPEN c_emp;
	FETCH c_emp INTO r_emp;
	WHILE c_emp%FOUND LOOP
        FETCH c_emp INTO r_emp;
		dbms_output.put_line(r_emp.employee_id || ' ' || r_emp.first_name || ' ' || r_emp.last_name);
	END LOOP;
	CLOSE c_emp;

	dbms_output.put_line('---');

	-- no need to OPEN or CLOSE CURSOR here!
    -- no need to CREATE a designated RECORD either!
	FOR c IN c_emp LOOP
        dbms_output.put_line(c.employee_id || ' ' || c.first_name || ' ' || c.last_name);
	END LOOP;

	dbms_output.put_line('---');

	-- not recommended
	FOR c IN (
        SELECT *
    	FROM hr.employees
    	WHERE department_id = 30
    ) LOOP
        dbms_output.put_line(c.employee_id || ' ' || c.first_name || ' ' || c.last_name);
	END LOOP;
END;
/
