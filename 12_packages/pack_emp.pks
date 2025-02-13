-- CREATE the PACKAGE SPEC
CREATE OR REPLACE
PACKAGE pack_emp AS
    v_sal_inc_rate NUMBER := 0.057;
    
    CURSOR c_emp IS SELECT * FROM emp;
    
    PROCEDURE inc_sal;
    
    FUNCTION get_avg_sal (p_dept_id INT) 
    RETURN NUMBER;
END pack_emp;
/
