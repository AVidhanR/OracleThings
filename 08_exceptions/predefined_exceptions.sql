-- run the below SET command once
SET serveroutput ON;

DECLARE
	v_name hr.employees.first_name%TYPE;
	v_dept_id hr.departments.department_id%TYPE;
BEGIN
    -- inner EXCEPTION 
	BEGIN
    	SELECT first_name INTO v_name
    	FROM hr.employees
    	WHERE employee_id = 100;
    	dbms_output.put_line('My name is ' || v_name);
	EXCEPTION
        WHEN NO_DATA_FOUND THEN
			dbms_output.put_line('There''s no data found');
		WHEN OTHERS THEN
            dbms_output.put_line(v_name || ' is not available');
	END;

	SELECT department_id INTO v_dept_id
    FROM hr.employees
    WHERE employee_id = 90;
	dbms_output.put_line('department id is ' || v_dept_id);
EXCEPTION
	WHEN TOO_MANY_ROWS THEN
        dbms_output.put_line('There''s too many rows');
	WHEN OTHERS THEN
        dbms_output.put_line('There''s an exception here');
		dbms_output.put_line(sqlcode || ' -----> ' || sqlerrm);
END;
/
