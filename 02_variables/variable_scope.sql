-- run only once
SET serveroutput ON;

DECLARE
    v_outer VARCHAR2(20) := 'Outer';
BEGIN
    DECLARE
    	v_inner VARCHAR2(20) := 'Inner';
    BEGIN
        dbms_output.put_line('Inner variable: ' || v_inner);
        dbms_output.put_line('Outer variable: ' || v_outer);
    END;
	-- dbms_output.put_line('Inner variable: ' || v_inner); - cannot access it here! use your head!
    dbms_output.put_line(v_outer);
END;
