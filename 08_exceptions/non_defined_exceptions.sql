-- run the below SET command once
SET serveroutput ON;

-- CREATE a dummy TABLE for practice!
CREATE TABLE emp AS SELECT * FROM hr.employees;

DECLARE
	CANNOT_UPDATE_WITH_NULL EXCEPTION;
	PRAGMA EXCEPTION_INIT(CANNOT_UPDATE_WITH_NULL, -71014);
BEGIN
    UPDATE emp
    SET email = NULL
    WHERE employee_id = '100';
EXCEPTION
	WHEN CANNOT_UPDATE_WITH_NULL THEN
        dbms_output.put_line('There''s too many rows');
	WHEN OTHERS THEN
        dbms_output.put_line('There''s an exception here. That is, ');
		dbms_output.put_line(sqlcode || ' -----> ' || sqlerrm);
END;
/
