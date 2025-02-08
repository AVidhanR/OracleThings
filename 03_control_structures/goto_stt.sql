-- run the below SET command once
SET serveroutput ON;

DECLARE
	v_num NUMBER NOT NULL := 17;
	v_is_prime BOOLEAN := true;
BEGIN
	IF (v_num <= 1) THEN
    	dbms_output.put_line('Enter a valid number');
	END IF;

	FOR i IN 2..(v_num-1) LOOP
		IF (v_num MOD i = 0) THEN
			v_is_prime := false;
			dbms_output.put_line(v_num || ' is not a prime number.');
			GOTO end_point;
		END IF;
	END LOOP;

	IF (v_is_prime) THEN
        dbms_output.put_line(v_num || ' is a prime number.');
	END IF;

	<<end_point>>
	dbms_output.put_line('Check complete.');
END;
/
