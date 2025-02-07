-- run the below SET command only once
SET serveroutput ON;

-- after the INSERT demo run the below program
DECLARE
	v_salary_inc hr.employees.salary%TYPE := 100;
BEGIN
	FOR i IN 206..216 LOOP
		UPDATE emp
    	SET salary = salary + v_salary_inc
		WHERE employee_id = i;
	END LOOP;
END;
/
