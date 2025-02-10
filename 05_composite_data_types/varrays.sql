-- run the below SET comand once
SET serveroutput ON;

DECLARE
	TYPE emp_varray IS VARRAY(5) OF VARCHAR2(50);
	emp emp_varray;

	-- or, one can initialize here itself
	TYPE d_emp_varray IS VARRAY(5) OF NUMBER;
	emp_init d_emp_varray := d_emp_varray(1, 2, 3, 4, 5);
BEGIN
    emp := emp_varray('Vidhan', 'Koti', 'Manu', 'Sai', 'Vin');
	FOR i IN 1..5 LOOP
		dbms_output.put_line(emp(i));
	END LOOP;

	-- or, mostly used approach
	dbms_output.put_line('Using varray_name.count() function, ');
	FOR i IN 1..emp.count() LOOP
        dbms_output.put_line(emp(i));
	END LOOP;

	-- or, not entertained  'cause we already know the first value
	dbms_output.put_line('Using varray_name.first() and varray_name.last() functions, ');
	FOR i IN emp.first()..emp.last() LOOP
        dbms_output.put_line(emp(i));
	END LOOP;

	-- the old school approach
	dbms_output.put_line('Using varray.exists() function, ');
	FOR i IN 1..5 LOOP
        IF emp.exists(i) THEN
			dbms_output.put_line(emp(i));
		END IF;
	END LOOP;

	-- to find the allocated size of the varray,
	dbms_output.put_line(' ');
	dbms_output.put_line('The allocated size of varray is: ' || emp.limit());

	-- experimenting with d_emp_varray
	FOR i IN 1..emp_init.count() LOOP
        dbms_output.put_line(emp_init(i));
	END LOOP;
END;
/

DECLARE
	TYPE emp_varray IS VARRAY(15) OF VARCHAR2(50);
	emp emp_varray := emp_varray();
	idx NUMBER := 1;
BEGIN
	FOR i IN 100..110 LOOP
		-- as there are no values allocated we use extend
		-- to extend the allocation space
		emp.extend;
		SELECT first_name INTO emp(idx)
		FROM hr.employees
		WHERE employee_id = i;
		idx := idx + 1;
	END LOOP;

	FOR i IN 1..emp.count() LOOP
        dbms_output.put_line(emp(i));
	END LOOP;
END;
/
