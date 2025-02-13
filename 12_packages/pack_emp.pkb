-- CREATE the PACKAGE BODY
CREATE OR REPLACE
PACKAGE BODY pack_emp AS
    PROCEDURE inc_sal AS 
    BEGIN
        FOR c IN c_emp LOOP
            UPDATE emp
            SET salary= salary + (v_sal_inc_rate);
        END LOOP;
    END;
    
    FUNCTION get_avg_sal (p_dept_id INT)
    RETURN NUMBER AS
        v_avg_sal NUMBER := 0;
    BEGIN
        SELECT AVG(salary) INTO v_avg_sal
        FROM emp WHERE department_id = p_dept_id;
        RETURN v_avg_sal;
    END;
END pack_emp;
/
