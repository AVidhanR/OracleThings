-- run the below SET comand only once
SET serveroutput ON;

-- creating an empty TABLE
CREATE TABLE retired_employees AS
    SELECT * FROM hr.employees
	WHERE 1 = 2;
/
    
DECLARE
	emp_rec hr.employees%ROWTYPE;
BEGIN
	SELECT * INTO emp_rec 
    FROM hr.employees
    WHERE employee_id = 104;

	emp_rec.salary := 0;
	emp_rec.commission_pct := 0;

	INSERT INTO retired_employees
	VALUES emp_rec;

	-- UPDATE operation using the new ROW keyword
	UPDATE retired_employees
    SET ROW = emp_rec
    WHERE employee_id = 101;

	-- DELETE operation [JUST FOR DEMO - OPTIONAL]
	DELETE FROM retired_employees
    WHERE employee_id = emp_rec.employee_id AND commission_pct IS NULL;
END;
/

-- check the table
SELECT * FROM retired_employees;

-- final cleanup 
DROP TABLE retired_employees;
