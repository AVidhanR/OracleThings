-- run the below SET command once
SET serveroutput ON;

DECLARE
	v_inner NUMBER NOT NULL := 1;
BEGIN
    <<outer_loop>>
	FOR v_outer IN 1..10 LOOP
		dbms_output.put_line('The outer loop var: ' || v_outer);
		v_inner := 1;

		<<inner_loop>>
		WHILE (v_inner * v_outer < 15) LOOP
			v_inner := v_inner + 1;
			CONTINUE WHEN (MOD(v_inner * v_outer, 3) = 0);
			dbms_output.put_line(' The inner loop var: ' || v_inner);
		END LOOP inner_loop;
	END LOOP outer_loop;
END;
/

-- using label in CONTINUE statement
DECLARE
	v_inner NUMBER NOT NULL := 1;
BEGIN
    <<outer_loop>>
	FOR v_outer IN 1..10 LOOP
		dbms_output.put_line('The outer loop var: ' || v_outer);
		v_inner := 1;

		<<inner_loop>>
		WHILE (v_inner * v_outer < 15) LOOP
			v_inner := v_inner + 1;
			CONTINUE outer_loop WHEN v_inner = 10;
			dbms_output.put_line(' The inner loop var: ' || v_inner);
		END LOOP inner_loop;
	END LOOP outer_loop;
END;
/
