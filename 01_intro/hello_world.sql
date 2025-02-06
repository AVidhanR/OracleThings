SET SERVEROUTPUT ON; -- run once

DECLARE
    -- declaration field
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, World!');
    -- nested block
    BEGIN
        DBMS_OUTPUT.PUT_LINE('PL/SQL');
    END;
END;
