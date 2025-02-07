-- run the below SET comand only once
SET serveroutput ON;

-- after the INSERT [UPDATE optional] demo run the below program
DECLARE
	v_salary_inc hr.employees.salary%TYPE := 100;
BEGIN
	FOR i IN 206..216 LOOP
		DELETE FROM emp
    	WHERE employee_id = i;
	END LOOP;
END;
/
