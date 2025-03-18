-- run the below commands to create a new schema/user in oracle
CREATE USER omr IDENTIFIED BY omr;
GRANT DBA TO omr;

-- Dimension tables
-- 1
CREATE TABLE d_customer (
    name        VARCHAR2(50),
    customer_id NUMBER,
    login_id    NUMBER,
    email       VARCHAR2(30),
    phone_no    VARCHAR2(12),
    gender      CHAR,
    age         NUMBER,
    CONSTRAINT pk_customer PRIMARY KEY ( customer_id )
);
 
-- 2
CREATE TABLE d_theatre (
    theatre_id   NUMBER,
    show_id      NUMBER,
    theatre_name VARCHAR2(20),
    address      VARCHAR2(50),
    state        VARCHAR2(50),
    city         VARCHAR2(50),
    pincode      NUMBER,
    show_timing  TIMESTAMP,
    screen_no    NUMBER,
    CONSTRAINT pk_theatre PRIMARY KEY ( theatre_id,
                                        show_id )
);
 
-- 3
CREATE TABLE d_movies (
    movie_id   NUMBER,
    movie_name VARCHAR2(50),
    genre      VARCHAR2(15),
    language   VARCHAR2(15),
    rating     NUMBER(10, 1),
    CONSTRAINT pk_movies PRIMARY KEY ( movie_id )
);
 
-- 4
CREATE TABLE d_payments (
    payment_id   NUMBER,
    customer_id  NUMBER,
    date_id      DATE,
    payment_type VARCHAR2(15),
    payment_date DATE,
    price        NUMBER,
    FOREIGN KEY ( customer_id )
        REFERENCES d_customer ( customer_id ),
    FOREIGN KEY ( date_id )
        REFERENCES d_date ( date_id ),
    CONSTRAINT pk_payment PRIMARY KEY ( payment_id )
);
 
-- 5
--CREATE TABLE d_date (
--    date_id     DATE,
--    day         NUMBER,
--    month       NUMBER,
--    year        NUMBER,
--    day_of_week VARCHAR2(15),
--    CONSTRAINT pk_date PRIMARY KEY ( date_id )
--);

DROP TABLE d_date CASCADE CONSTRAINTS;
 
-- fact table
-- 1
CREATE TABLE f_movie_reservation (
    customer_id NUMBER,
    movie_id    NUMBER,
    theatre_id  NUMBER,
    seat_no     NUMBER,
    show_id     NUMBER,
    date_id     DATE,
    payment_id  NUMBER,
    FOREIGN KEY ( customer_id )
        REFERENCES d_customer ( customer_id ),
    FOREIGN KEY ( movie_id )
        REFERENCES d_movies ( movie_id ),
        FOREIGN KEY ( theatre_id,
                      show_id )
            REFERENCES d_theatre ( theatre_id,
                                   show_id ),
    FOREIGN KEY ( date_id )
        REFERENCES d_date ( date_id ),
    FOREIGN KEY ( payment_id )
        REFERENCES d_payments ( payment_id )
);
