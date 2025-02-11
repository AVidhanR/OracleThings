-- run the below SET comand once
SET serveroutput ON;

-- One should provide ADMIN -> USER privileges
DECLARE
    CURSOR c_emp IS (
        	SELECT
    			employee_id,
        		first_name,
    			last_name,
        		department_name
        	FROM
        		hr.employees JOIN hr.departments
        		USING(department_id)
        	WHERE
        		employee_id IN (100, 101, 102)
        ) FOR UPDATE;
BEGIN
	FOR c IN c_emp LOOP
		UPDATE hr.employees 
    	SET phone_number = '111.111.1111'
		WHERE employee_id = c.employee_id;
	END LOOP;
END;
/

SELECT * FROM hr.employees;
