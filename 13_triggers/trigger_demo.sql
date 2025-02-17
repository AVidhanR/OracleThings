-- run the below SET command once
SET serveroutput ON;

-- run the below things before experimenting futhur
/*
CREATE TABLE students (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    grade NUMBER
);

CREATE TABLE student_count (
    count_id NUMBER PRIMARY KEY,
    total_students NUMBER
);

-- Initialize the student count
INSERT INTO student_count (count_id, total_students) VALUES (1, 0);
*/

CREATE OR REPLACE TRIGGER trg_student_count
AFTER INSERT OR DELETE ON students
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE student_count
        SET total_students = total_students + 1
        WHERE count_id = 1;
    ELSIF DELETING THEN
        UPDATE student_count
        SET total_students = total_students - 1
        WHERE count_id = 1;
    END IF;
END;
/

-- testing the TRIGGER
INSERT INTO students (student_id, name, grade) VALUES (1, 'John Doe', 90);
-- Check the student count
SELECT total_students FROM student_count WHERE count_id = 1;

DELETE FROM students WHERE student_id = 1;
-- Check the student count
SELECT total_students FROM student_count WHERE count_id = 1;
