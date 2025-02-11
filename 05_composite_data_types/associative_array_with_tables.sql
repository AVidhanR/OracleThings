-- run the below SET comand once
SET serveroutput ON;

CREATE TABLE employee_salary_history AS
SELECT * FROM hr.employees WHERE 1 = 2;

ALTER TABLE employee_salary_history
ADD insert_date DATE;
/

DECLARE 
	TYPE emp_array IS TABLE OF employee_salary_history%ROWTYPE
	INDEX BY PLS_INTEGER;

	emp EMP_ARRAY;
	idx PLS_INTEGER := 0;
BEGIN
	FOR i IN 100..110 LOOP
		SELECT e.*, SYSDATE INTO emp(i)
		FROM hr.employees e WHERE employee_id = i;
	END LOOP;

	idx := emp.first();

	WHILE (emp.exists(idx)) LOOP
        emp(idx).salary := emp(idx).salary + emp(idx).salary * 0.2; 
		INSERT INTO employee_salary_history
		VALUES emp(idx);
		dbms_output.put_line(emp(idx).first_name || ' ' || emp(idx).last_name 
            || ' earns ' || emp(idx).salary || ' insertion date is ' || emp(idx).insert_date);
		idx := emp.next(idx);
	END LOOP;
END;
/
