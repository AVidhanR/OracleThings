-- run the below SET command only once
SET serveroutput ON;

DECLARE
	v_name VARCHAR2(20);
	v_salary hr.employees.salary%TYPE;
	v_employee_id hr.employees.employee_id%TYPE := 100;
BEGIN
    -- only one record returns
	SELECT (first_name || ' ' || last_name), salary
	INTO v_name, v_salary
	FROM hr.employees
	WHERE employee_id = v_employee_id;

	dbms_output.put_line('The salary of ' || v_name || ' is: ' || v_salary);
END;
/
