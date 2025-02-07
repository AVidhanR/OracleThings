-- run the below SET comand only once
SET serveroutput ON;

-- run the below CREATE command once
CREATE TABLE emp AS
    SELECT * FROM hr.employees;

DECLARE
	v_max_emp_id hr.employees.employee_id%TYPE := 0;
BEGIN
    -- getting the last employee_id as employee_id is NUMBER
	SELECT MAX(employee_id)
    INTO v_max_emp_id
    FROM hr.employees;

	FOR i IN v_max_emp_id..(v_max_emp_id + 10) LOOP
		INSERT INTO
			emp(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary)
		VALUES
			(i, 'Employee ' || i, ' temp', 'abc@oracle.com', '1234567890', SYSDATE, 'IT_PROG', 100*i);
	END LOOP;
END;
/
