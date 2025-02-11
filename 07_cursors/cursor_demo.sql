-- run the below SET command once
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
    
DECLARE
	CURSOR c_emp IS (
        SELECT first_name, last_name, department_name
        FROM hr.employees JOIN hr.departments
    	USING(department_id)
    	WHERE department_id BETWEEN 30 AND 60
    );
	v_first_name hr.employees.first_name%TYPE;
	v_last_name hr.employees.last_name%TYPE;
	v_department_name hr.departments.department_name%TYPE;
BEGIN
	OPEN c_emp;
	FETCH c_emp INTO v_first_name, v_last_name, v_department_name;
	dbms_output.put_line(v_first_name || ' ' || v_last_name || ' in dept: ' || v_department_name);
	FETCH c_emp INTO v_first_name, v_last_name, v_department_name;
	dbms_output.put_line(v_first_name || ' ' || v_last_name || ' in dept: ' || v_department_name);
	CLOSE c_emp;
END;
/
