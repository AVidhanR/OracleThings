-- run the below SET command once
SET serveroutput ON;

DECLARE
	emp_rec hr.employees%ROWTYPE;
BEGIN
	SELECT * INTO emp_rec
	FROM hr.employees
	WHERE employee_id = '101';

	dbms_output.put_line(emp_rec.employee_id);
END;
/
