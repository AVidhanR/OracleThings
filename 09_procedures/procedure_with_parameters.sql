-- run the below SET command once
SET serveroutput ON;

-- CREATE a copy TABLE for practice!
CREATE TABLE emp AS SELECT * FROM hr.employees;
/

-- CREATE a PROCEDURE without any parameters
CREATE OR REPLACE PROCEDURE INCREASE_SALARIES(
    v_salary_increase IN OUT emp.salary%TYPE,
    v_dept_id IN emp.department_id%TYPE,
    v_eff_emp_count OUT NUMBER
) AS
    CURSOR c_emps IS SELECT * FROM emp WHERE department_id = v_dept_id FOR UPDATE;
    -- v_salary_increase NUMBER := 1.10;
    v_old_salary NUMBER;
    v_sal_inc NUMBER := 0;
BEGIN
    FOR r_emp IN c_emps LOOP
        v_old_salary := r_emp.salary;
        r_emp.salary := r_emp.salary * v_salary_increase + r_emp.salary * nvl(r_emp.commission_pct,0);
        UPDATE emp SET ROW = r_emp WHERE CURRENT OF c_emps;
        dbms_output.put_line('The salary of : '|| r_emp.employee_id || ' is increased from '||v_old_salary||' to '||r_emp.salary);
        v_eff_emp_count := v_eff_emp_count + 1;
        v_sal_inc := v_sal_inc + v_salary_increase + NVL(r_emp.commission_pct, 0);
    END LOOP;
	-- cannot do the assignment using only the IN so, better to make a IN OUT
    v_salary_increase := v_sal_inc / v_eff_emp_count;
END;
/

DECLARE
    v_eff_emp_count NUMBER;

	-- cannot assign the values directly as it is a IN OUT parameter
	v_sal_inc NUMBER := 1.12;
BEGIN
    dbms_output.put_line('Increasing the salaries!...');
    INCREASE_SALARIES(v_sal_inc, 90, v_eff_emp_count);
    dbms_output.put_line('All the salaries are successfully increased!...');
	dbms_output.put_line('The number of emp who got salary increment: ' || v_eff_emp_count);
END;
/

-- for reference
SELECT * FROM emp;
