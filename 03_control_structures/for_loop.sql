-- run the below SET command once 
SET serveroutput ON;

BEGIN
	FOR i IN 1..3 LOOP
		dbms_output.put_line(i);
	END LOOP;
END;
/
-- o/p: 1 2 3
	
BEGIN
	FOR i IN REVERSE 1..3 LOOP
		dbms_output.put_line(i);
	END LOOP;
END;
/
-- o/p: 3 2 1
