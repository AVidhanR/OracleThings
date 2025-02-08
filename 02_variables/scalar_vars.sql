-- run the below SET command once
SET serveroutput ON 

DECLARE
    v_text VARCHAR2(50) NOT NULL := 'Hello All!';
    v_number NUMBER(4,2) NOT NULL := 17.19;
    v_bin_int BINARY_INTEGER NOT NULL := 2025;
    v_date DATE NOT NULL := SYSDATE;
    v_bool BOOLEAN NOT NULL := true;
BEGIN
    dbms_output.put_line(v_text || ', This is Vidhan!' 
    || ' Number: ' || v_number || ' Binary Integer: ' || v_bin_int);
    dbms_output.put_line('Date: ' || v_date);
    -- cannot use BOOLEAN values to print but as a conditional
    -- checkers in if-else or loops or in any other cases
END;
/