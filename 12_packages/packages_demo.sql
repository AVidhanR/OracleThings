-- run the below SET command once
SET serveroutput ON;

-- call the procedure using package_name.procedure_name
EXEC pack_emp.inc_sal;

-- let's call the FUNCTION
-- and the global varaible in the package
BEGIN
    dbms_output.put_line(pack_emp.get_avg_sal(50));
    dbms_output.put_line(pack_emp.v_sal_inc_rate);
    pack_emp.v_sal_inc_rate := 0.5;
    dbms_output.put_line(pack_emp.v_sal_inc_rate);
END;
/

/*
  NOTE:
    - whatever you want to call from the PACKAGE use,
      package_name.whatever_you_want_to_call_from_it
    - it can be a PROCEDURE, FUNCTION, VARIABLE, CURSOR
*/
