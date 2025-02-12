-- run the below SET command once
SET serveroutput ON;

DECLARE
    -- strong REF CURSOR as it is having a RETURN TYPE
	TYPE rct_emp IS REF CURSOR return hr.employees%ROWTYPE;
	rc_emp RCT_EMP;
	r_emp hr.employees%ROWTYPE;
BEGIN
	OPEN rc_emp FOR SELECT * FROM hr.employees;
	LOOP
		FETCH rc_emp INTO r_emp;
		EXIT WHEN rc_emp%NOTFOUND;
		dbms_output.put_line(r_emp.first_name || ' ' || r_emp.last_name);
	END LOOP;
	CLOSE rc_emp;
END;
/
