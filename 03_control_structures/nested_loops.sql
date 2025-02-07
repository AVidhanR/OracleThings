-- the below command, run only once
SET serveroutput ON;

DECLARE
    v_inner NUMBER NOT NULL := 1;
BEGIN
    <<outer_loop>>
    FOR v_outer IN 1..5 LOOP
    	dbms_output.put_line('The outer loop var: ' || v_outer);

    	<<inner_loop>>
    	LOOP
    		dbms_output.put_line(' The inner loop var: ' || v_inner);
    		v_inner := v_inner + 1;
    		EXIT outer_loop WHEN (v_inner * v_outer >= 16);
    		-- optional: specification of the label, inner_loop
    		EXIT WHEN (v_inner * v_outer >= 15);
    	END LOOP inner_loop;

    END LOOP outer_loop;
END;
