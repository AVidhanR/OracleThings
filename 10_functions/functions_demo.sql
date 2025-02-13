-- run the below SET command
SET serveroutput ON;

CREATE OR REPLACE FUNCTION get_avg_sal (
    p_dept_id hr.departments.department_id%TYPE
) RETURN NUMBER AS
v_avg_sal NUMBER;
BEGIN
	SELECT AVG(salary) INTO v_avg_sal
	FROM hr.employees
	WHERE department_id = p_dept_id;

	RETURN v_avg_sal;
END;
/

DECLARE
    v_avg_sal NUMBER;
BEGIN
	v_avg_sal := get_avg_sal(90);
	dbms_output.put_line(ROUND(v_avg_sal, 0));
END;
/
