-- The most used composite datatype in PL/SQL
-- run the below SET comand once
SET serveroutput ON;

DECLARE
	TYPE emp_array IS TABLE OF hr.employees.first_name%TYPE
	INDEX BY PLS_INTEGER;
	emp EMP_ARRAY;
	emp_demo EMP_ARRAY;
	idx PLS_INTEGER := 0;
BEGIN
	FOR i IN 100..110 LOOP
		SELECT first_name INTO emp(i)
		FROM hr.employees WHERE employee_id = i;
	END LOOP;

	-- not a recommended approach as we have no idea where the index 
	-- runs to
	FOR i IN emp.first()..emp.last() LOOP
		dbms_output.put_line(emp(i));
	END LOOP;

	emp_demo(100) := 'Bob';
	emp_demo(120) := 'Suse';
	idx := emp_demo.first();

	-- recommended approach
	WHILE (emp_demo.exists(idx) OR idx IS NOT NULL) LOOP
        dbms_output.put_line(emp_demo(idx));
		idx := emp_demo.next(idx);
	END LOOP;
END;
/

DECLARE
	TYPE emp_array IS TABLE OF hr.employees.first_name%TYPE
	INDEX BY hr.employees.email%TYPE;
	emp_email EMP_ARRAY;
	idx hr.employees.email%TYPE;
	v_email hr.employees.email%TYPE;
	v_first_name hr.employees.first_name%TYPE;
BEGIN
	FOR i IN 100..110 LOOP
		SELECT first_name, email INTO v_first_name, v_email
		FROM hr.employees WHERE employee_id = i;
		emp_email(v_email) := v_first_name;
	END LOOP;

	idx := emp_email.first();

	WHILE (emp_email.exists(idx)) LOOP
		dbms_output.put_line('The email of ' || emp_email(idx) || ' is ' || idx);
		idx := emp_email.next(idx);
	END LOOP;
END;
/
