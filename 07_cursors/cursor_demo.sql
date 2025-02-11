-- run the below SET comand once
SET serveroutput ON;

DECLARE
	CURSOR c_emp IS (
        SELECT first_name, last_name
        FROM hr.employees
    );
	v_first_name hr.employees.first_name%TYPE;
	v_last_name hr.employees.last_name%TYPE;
BEGIN
	OPEN c_emp;
	FETCH c_emp INTO v_first_name, v_last_name;
	dbms_output.put_line(v_first_name || ' ' || v_last_name);
	FETCH c_emp INTO v_first_name, v_last_name;
	dbms_output.put_line(v_first_name || ' ' || v_last_name);
	CLOSE c_emp;
END;
/
