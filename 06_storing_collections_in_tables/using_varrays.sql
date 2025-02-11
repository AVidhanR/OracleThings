-- run the below SET comand once
SET serveroutput ON;

CREATE OR REPLACE TYPE t_phone_no AS OBJECT (
    p_type VARCHAR2(10),
    p_number VARCHAR2(50)
);
CREATE OR REPLACE TYPE v_phone_no IS VARRAY(3) OF t_phone_no;
/

CREATE TABLE emp_with_phones (
    employee_id NUMBER,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    phone_no V_PHONE_NO
);

INSERT INTO emp_with_phones
VALUES (10, 'Vidhan', 'Reddy', v_phone_no(
    t_phone_no('Home', '111.111.1111'),
    t_phone_no('Work', '222.211.1211'),
    t_phone_no('Mobie', '333.131.1131')
));
INSERT INTO emp_with_phones
VALUES (10, 'Koti', 'Bro', v_phone_no(
    t_phone_no('Home', '211.222.1112'),
    t_phone_no('Work', '322.211.1211'),
    t_phone_no('Mobie', '333.232.1131')
));
    
SELECT * FROM emp_with_phones;
SELECT
    ewp.first_name,
    ewp.last_name,
    ewp.employee_id,
    p.p_type,
    p.p_number
FROM
    emp_with_phones ewp,
    TABLE(ewp.phone_no) p;

-- drop it after usage [OPTIONAL]
DROP TABLE emp_with_phones;
