-- run the below SET command once
SET serveroutput ON;

VARIABLE var_text VARCHAR2(20);
VARIABLE var_num NUMBER;

DECLARE
	v_text VARCHAR2(20);
BEGIN
	:var_text := 'Hello, This is Vidhan.';

	 -- can assign to other vars
	v_text := :var_text;

	:var_num := 17;
	dbms_output.put_line('Bind Variables: ' || :var_text || ' ' || :var_num);
	dbms_output.put_line('Variables under DECLARE: ' || v_text);
END;
/
/*
NOTE:
  - Cannot run the above code in the Oracle LIVE SQL.
  - Try to run it on the local machine.
*/
