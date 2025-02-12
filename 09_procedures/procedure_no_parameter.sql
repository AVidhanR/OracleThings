-- run the below SET command once
SET serveroutput ON;

-- CREATE a dummy TABLE for practice!
CREATE TABLE emp AS SELECT * FROM hr.employees;
/

-- CREATE a PROCEDURE without any parameters
CREATE OR REPLACE PROCEDURE INCREASE_SALARIES AS
    CURSOR c_emps IS SELECT * FROM emp FOR UPDATE;
    v_salary_increase NUMBER := 1.10;
    v_old_salary NUMBER;
BEGIN
    FOR r_emp IN c_emps LOOP
      v_old_salary := r_emp.salary;
      r_emp.salary := r_emp.salary * v_salary_increase + r_emp.salary * nvl(r_emp.commission_pct,0);
      UPDATE emp SET ROW = r_emp WHERE CURRENT OF c_emps;
      dbms_output.put_line('The salary of : '|| r_emp.employee_id 
                            || ' is increased from '||v_old_salary||' to '||r_emp.salary);
    END LOOP;
END;
/

BEGIN
  dbms_output.put_line('Increasing the salaries!...');
  INCREASE_SALARIES;
  INCREASE_SALARIES;
  INCREASE_SALARIES;
  INCREASE_SALARIES;
  dbms_output.put_line('All the salaries are successfully increased!...');
END;
/
