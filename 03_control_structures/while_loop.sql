-- run only once
SET serveroutput ON;

DECLARE
    v_counter NUMBER(2) := 1;
BEGIN
	WHILE (v_counter <= 10) LOOP
    	dbms_output.put_line('The count is: ' || v_counter);
		v_counter := v_counter + 1;
	END LOOP;
END;
