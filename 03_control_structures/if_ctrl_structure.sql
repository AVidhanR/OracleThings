-- run the below SET command once
SET serveroutput ON;

DECLARE
	v_num NUMBER := 20;
BEGIN
	IF (MOD(v_num, 2) = 0) AND (v_num IS NOT NULL) THEN
		dbms_output.put_line(v_num || ' is even.');
	ELSIF (MOD(v_num, 2) <> 0) AND (v_num IS NOT NULL) THEN
		dbms_output.put_line(v_num || ' is odd.');
	ELSE
		dbms_output.put_line('Please enter a valid number.');
	END IF;
END;
/