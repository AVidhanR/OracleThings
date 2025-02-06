-- run only once
SET SERVEROUTPUT ON 

DECLARE
    v_text VARCHAR2(50) NOT NULL := 'Hello All!';
    v_number NUMBER(4,2) NOT NULL := 17.19;
    v_bin_int BINARY_INTEGER NOT NULL := 2025;
    v_date DATE NOT NULL := SYSDATE;
    v_bool BOOLEAN NOT NULL := true;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_text || ', This is Vidhan!' 
    || ' Number: ' || v_number || ' Binary Integer: ' || v_bin_int);
    DBMS_OUTPUT.PUT_LINE('Date: ' || v_date);
    -- cannot use BOOLEAN values to print but as a conditional
    -- checkers in if-else or loops or in any other cases
END;
