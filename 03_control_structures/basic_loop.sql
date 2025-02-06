-- run only once
SET serveroutput ON;

DECLARE
    v_counter NUMBER(2) := 1;
BEGIN
	LOOP
    	dbms_output.put_line('The count is: ' || v_counter);
		v_counter := v_counter + 1;
		EXIT WHEN v_counter >= 11;
	END LOOP;
END;
