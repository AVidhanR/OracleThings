-- The most used composite datatype in PL/SQL
-- run the below SET comand once
SET serveroutput ON;

DECLARE
	TYPE emp_array IS TABLE OF hr.employees.first_name%TYPE
	INDEX BY PLS_INTEGER;
	emp emp_array;
BEGIN
	FOR i IN 100..110 LOOP
		SELECT first_name INTO emp(i)
		FROM hr.employees WHERE employee_id = i;
	END LOOP;

	FOR i IN emp.first()..emp.last() LOOP
		dbms_output.put_line(emp(i));
	END LOOP;
END;
/
