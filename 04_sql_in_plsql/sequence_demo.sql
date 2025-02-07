-- run the below SET command only once
SET serveroutput ON;

-- run the below DROP command only once
DROP TABLE emp;

-- run the below CREATE command once
CREATE TABLE emp AS
    SELECT * FROM hr.employees;

-- run the below SEQUENCE command once
CREATE SEQUENCE emp_id_seq
    START WITH 207
    INCREMENT BY 1;

BEGIN
	FOR i IN 1..10 LOOP
		INSERT INTO
			emp(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary)
		VALUES
			(emp_id_seq.nextval, 'Employee ' || emp_id_seq.nextval, ' temp', 'abc@oracle.com', '1234567890', SYSDATE, 'IT_PROG', 1000+emp_id_seq.nextval);
	END LOOP;
END;
/
