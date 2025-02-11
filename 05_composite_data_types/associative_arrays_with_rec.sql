-- One must use the RECORD with collections
-- The most used composite datatype in PL/SQL
-- run the below SET comand once
SET serveroutput ON;

DECLARE
	TYPE emp_rec IS RECORD (
    	first_name hr.employees.first_name%TYPE,
    	last_name hr.employees.last_name%TYPE,
    	email hr.employees.email%TYPE
    );
    
    -- ASSOCIATIVE ARRAY with data type of RECORD
	TYPE emp_array IS TABLE OF hr.employees%ROWTYPE
	INDEX BY hr.employees.email%TYPE;

	emp_email EMP_ARRAY;
	idx hr.employees.email%TYPE;

    -- using the custom RECORD in ASSOCIATIVE ARRAY
	TYPE emp_custom IS TABLE OF emp_rec
    INDEX BY hr.employees.email%TYPE;

	emp_demo EMP_CUSTOM;
	idx_demo hr.employees.email%TYPE;
BEGIN
	FOR i IN 100..110 LOOP
		SELECT * INTO emp_email(i)
		FROM hr.employees WHERE employee_id = i;
	END LOOP;

	idx := emp_email.first();
	WHILE (emp_email.exists(idx)) LOOP
		dbms_output.put_line('The email of ' || emp_email(idx).first_name || ' ' 
        || emp_email(idx).last_name || ' is ' || emp_email(idx).email);
		idx := emp_email.next(idx);
	END LOOP;

	dbms_output.put_line('---');

	FOR i IN 100..110 LOOP
		SELECT first_name, last_name, email INTO emp_demo(i)
		FROM hr.employees WHERE employee_id = i;
	END LOOP;

	emp_demo.delete(100);

	-- DELETE emp elements in between index 101 to 104
	emp_demo.delete(101, 104);
	idx_demo := emp_demo.first();

	WHILE (emp_demo.exists(idx_demo)) LOOP
		dbms_output.put_line('The email of ' || emp_demo(idx_demo).first_name || ' ' 
        || emp_demo(idx_demo).last_name || ' is ' || emp_demo(idx_demo).email);
		idx_demo := emp_demo.next(idx_demo);
	END LOOP;

	-- print from last to first using prior() function
	dbms_output.put_line('Printing from last to first, ');
	idx_demo := emp_demo.last();

	WHILE (emp_demo.exists(idx_demo)) LOOP
        dbms_output.put_line('The email of ' || emp_demo(idx_demo).first_name || ' ' 
        || emp_demo(idx_demo).last_name || ' is ' || emp_demo(idx_demo).email);
		idx_demo := emp_demo.prior(idx_demo);
	END LOOP;
END;
/
