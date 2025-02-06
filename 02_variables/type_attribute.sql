-- run only once
SET serveroutput ON;

DECLARE
	v_emp_job_id hr.employees.job_id%TYPE;
	v_emp_demo v_emp_job_id%TYPE;
	v_emp_fn hr.employees.first_name%TYPE NOT NULL := 'Hello'; 
BEGIN
    v_emp_job_id := 'IT_PROG';
	v_emp_demo := NULL;
	v_emp_fn := 'AVidhanR'; -- can't assign NULL as the variable is NOT NULL irrespective of the column
	DBMS_OUTPUT.PUT_LINE(v_emp_job_id);
	DBMS_OUTPUT.PUT_LINE(v_emp_demo || 'Can assign NULL to a NOT NULL col attribute. If you don''t want to then explicitly keep NOT NULL to the variable as well');
	DBMS_OUTPUT.PUT_LINE('My name is: ' || v_emp_fn);
END;
