-- run only once
SET serveroutput ON;

BEGIN <<outer>>
DECLARE
    v_outer VARCHAR2(20) := 'Outer';
	v_text VARCHAR2(20) := 'Outer text';
BEGIN
    DECLARE
    	v_inner VARCHAR2(20) := 'Inner';

		-- same name but, in different scope!
		v_text VARCHAR2(20) := 'Inner Text';
    BEGIN
        dbms_output.put_line('Inner variable: ' || v_inner);
        dbms_output.put_line('Outer variable inside inner scope: ' || v_outer);
		dbms_output.put_line('---');
        dbms_output.put_line('Outer variable inside inner scope (same var): ' || outer.v_text);
		dbms_output.put_line('Inne variable (same name): ' || v_text);
    END;
	-- dbms_output.put_line('Inner variable: ' || v_inner); - cannot access it here! use your head!
    dbms_output.put_line('Outer variable: ' || v_outer);
	dbms_output.put_line('---');
dbms_output.put_line('Outer variable (same name): ' || v_text);
END;
END outer;
