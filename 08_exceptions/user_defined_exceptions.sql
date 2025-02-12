-- run the below SET command once
SET serveroutput ON;

-- CREATE a dummy TABLE for practice!
CREATE TABLE emp AS SELECT * FROM hr.employees;

DECLARE
	v_sal_check emp.salary%TYPE;
	SALARY_TOO_HIGH EXCEPTION;
BEGIN
    SELECT salary INTO v_sal_check
    FROM emp
    WHERE employee_id = 100;

	-- One can RAISE any type of EXCEPTION
	IF (v_sal_check > 20000) THEN
        RAISE SALARY_TOO_HIGH;
	END IF;
EXCEPTION
	WHEN SALARY_TOO_HIGH THEN
        dbms_output.put_line('Salary is too high!');
		-- can also do the below! (only in the EXCEPTION block)
		-- RAISE;
	WHEN OTHERS THEN
        dbms_output.put_line('There''s an exception here. That is, ');
		dbms_output.put_line(sqlcode || ' -----> ' || sqlerrm);
END;
/
