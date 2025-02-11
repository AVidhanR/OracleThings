-- run the below SET comand once
SET serveroutput ON;

DECLARE
	CURSOR c_emp IS (
    	SELECT *
    	FROM hr.employees
    	WHERE department_id = 30
    );

	r_emp C_EMP%ROWTYPE;
BEGIN
	IF NOT c_emp%ISOPEN THEN
		OPEN c_emp;
		dbms_output.put_line('Hello');
	END IF;

	dbms_output.put_line(c_emp%ROWCOUNT);
	FETCH c_emp INTO r_emp;
	dbms_output.put_line(c_emp%ROWCOUNT);
	FETCH c_emp INTO r_emp;
	dbms_output.put_line(c_emp%ROWCOUNT);
	FETCH c_emp INTO r_emp;
	dbms_output.put_line(c_emp%ROWCOUNT);
	FETCH c_emp INTO r_emp;
	CLOSE c_emp;

	OPEN c_emp;
	LOOP
		FETCH c_emp INTO r_emp;
		EXIT WHEN (c_emp%ROWCOUNT > 5 OR c_emp%NOTFOUND);
		dbms_output.put_line(c_emp%rowcount|| ' ' ||r_emp.first_name|| ' ' ||r_emp.last_name);
	END LOOP;
	CLOSE c_emp;
END;
/
