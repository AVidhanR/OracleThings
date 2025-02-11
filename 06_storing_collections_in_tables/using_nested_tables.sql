-- run the below SET comand once
SET serveroutput ON;

CREATE OR REPLACE TYPE t_phone_no AS OBJECT (
    p_type VARCHAR2(10),
    p_number VARCHAR2(50)
);
CREATE OR REPLACE TYPE nt_phone_no IS TABLE OF t_phone_no;
/

CREATE TABLE emp_with_phones (
    employee_id NUMBER,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    phone_no NT_PHONE_NO
) NESTED TABLE phone_no STORE AS phone_no_table;

INSERT INTO emp_with_phones
VALUES (10, 'Vidhan', 'Reddy', nt_phone_no(
    t_phone_no('Home', '111.111.1111'),
    t_phone_no('Work', '222.211.1211'),
    t_phone_no('Mobie', '333.131.1131')
));
INSERT INTO emp_with_phones
VALUES (11, 'Koti', 'Rao', nt_phone_no(
    t_phone_no('Home', '211.222.1112'),
    t_phone_no('Work', '322.211.1211'),
    t_phone_no('Mobie', '333.232.1131')
));
INSERT INTO emp_with_phones
VALUES (12, 'Manohar', 'Rao', nt_phone_no(
    t_phone_no('Home', '211.222.1112'),
    t_phone_no('Work', '322.211.1211'),
    t_phone_no('Mobie', '333.232.2222'),
    t_phone_no('Work2', '322.211.1111'),
    t_phone_no('Work3', '322.211.3333')
));

UPDATE emp_with_phones
SET phone_no = nt_phone_no(
    t_phone_no('Home', '211.222.2222'),
    t_phone_no('Work', '322.211.1211'),
    t_phone_no('Mobie', '333.232.2222'),
    t_phone_no('Work5', '999.211.1111'),
    t_phone_no('Work6', '322.211.3333')   
)
WHERE employee_id = 11;
    
SELECT * FROM emp_with_phones;

DECLARE
	p_num nt_phone_no;
BEGIN
    SELECT phone_no INTO p_num
    FROM emp_with_phones
    WHERE employee_id = 11;

	p_num.extend();
	p_num(p_num.count()) := t_phone_no('FAX', '999.999.9999');
	UPDATE emp_with_phones
	SET phone_no = p_num
    WHERE employee_id = 11;
END;
/

SELECT
    ewp.first_name,
    ewp.last_name,
    ewp.employee_id,
    p.p_type,
    p.p_number
FROM
    emp_with_phones ewp,
    TABLE(ewp.phone_no) p;
/

-- drop it after usage [OPTIONAL]
DROP TABLE emp_with_phones;
