-- run the below SET command only once
SET serveroutput ON;

-- after the INSERT [UPDATE optional] demo run the below program
BEGIN
	FOR i IN 206..216 LOOP
		DELETE FROM emp
    	WHERE employee_id = i;
	END LOOP;
END;
/
