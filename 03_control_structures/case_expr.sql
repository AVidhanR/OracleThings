-- run only once
SET serveroutput ON;

DECLARE
    v_job_id VARCHAR2(10) := 'IT_PROG';
	v_sal NUMBER := 10000;
	v_sal_inc NUMBER;
	v_total_sal NUMBER;
BEGIN
	v_sal_inc := (CASE v_job_id
    	WHEN 'IT_PROG' THEN 0.2
    	WHEN 'SA_REP' THEN 0.3
    	ELSE 0
    END);
	/* 
	-- or in the below style as well!
	(CASE 
    	WHEN v_job_id = 'SA_REP' THEN 0.3
    	WHEN v_job_id IN ('IT_PROG', 'SA_MAN') THEN 0.2
    	ELSE 0
    END);
	*/

	v_total_sal := (v_sal_inc * v_sal) + v_sal;
    dbms_output.put_line('Salary increement is: ' || (v_sal_inc * v_sal));
	dbms_output.put_line('Final salary for ' || v_job_id || ' is: ' || v_total_sal);
END;
