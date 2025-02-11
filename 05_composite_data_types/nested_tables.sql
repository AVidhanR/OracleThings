-- run the below SET comand once
SET serveroutput ON;

DECLARE
	TYPE emp_table IS TABLE OF VARCHAR(50);
	emp emp_table;
BEGIN
	emp := emp_table('Vidhan', 'Vin', 'Reddy');

	-- nested TABLE is unbounded
	emp.extend;
	emp(4) := 'Koti';

	emp.extend;
	emp(5) := 'Manohar';

	-- mutable 
	emp(2) := 'Ram';

	FOR i IN 1..emp.count() LOOP
		dbms_output.put_line(emp(i));
	END LOOP;
END;
/

DECLARE
	TYPE emp_table IS TABLE OF VARCHAR2(30);
	emp_names emp_table := emp_table();
	idx NUMBER := 1;
BEGIN
	FOR i IN 100..110 LOOP
    	emp_names.extend;
		SELECT first_name INTO emp_names(idx)
		FROM hr.employees
    	WHERE employee_id = i;
		idx := idx + 1;
	END LOOP;

	FOR i IN 1..emp_names.last() LOOP
        dbms_output.put_line(emp_names(i));
	END LOOP;
END;
/
