-- run the below SET comand once
SET serveroutput ON;

DECLARE
	CURSOR c_emp(p_dept_id NUMBER, p_job_id VARCHAR2) IS (
    	SELECT
    		first_name,
			last_name,
    		department_name
    	FROM
    		hr.employees JOIN hr.departments
    		USING(department_id)
    	WHERE
    		department_id = p_dept_id AND
    		job_id = p_job_id
    );
BEGIN
	FOR c IN c_emp(80, 'SA_MAN') LOOP
    	dbms_output.put_line('The employee in department of ' || 
    	c.department_name || ' is ' || c.first_name || ' ' || c.last_name);
	END LOOP;
END;
/
