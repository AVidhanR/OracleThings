-- run the below SET command once
SET serveroutput ON;

-- STRONG CURSOR REF example (RESTRICTIVE CURSOR)
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

-- WEAK REF CURSOR example (NON-RESTRICTIVE CURSOR)
DECLARE
	-- custome RECORD TYPE
    TYPE rt_emp IS RECORD (
    	first_name hr.employees.first_name%TYPE,
    	last_name hr.employees.last_name%TYPE,
    	department_name hr.departments.department_name%TYPE
    );
    r_emp RT_EMP;

    -- weak REF CURSOR as it is has NO RETURN TYPE
	TYPE rct_emp IS REF CURSOR;
	rc_emp RCT_EMP;
	query VARCHAR2(200);
BEGIN
    query := 'SELECT first_name, last_name, department_name
    FROM hr.employees JOIN hr.departments
    USING (department_id)';

	-- One can write the above query directly in-place of the 
	-- query variable
	OPEN rc_emp FOR query;
	LOOP
		FETCH rc_emp INTO r_emp;
		EXIT WHEN rc_emp%NOTFOUND;
		dbms_output.put_line(r_emp.first_name || ' ' || r_emp.last_name ||
            ' under the deapartment ' || UPPER(r_emp.department_name));
	END LOOP;
	CLOSE rc_emp;
END;
/
