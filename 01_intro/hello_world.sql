-- run the below SET command once
SET serveroutput ON; 

DECLARE
    -- declaration field
BEGIN
    -- operation field
    dbms_output.put_line('Hello, World!');
    -- nested block
    BEGIN
        dbms_output.put_line('PL/SQL');
    END;
END;
