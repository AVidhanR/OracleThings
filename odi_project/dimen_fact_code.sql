-- run the below commands to create a new schema/user in oracle
CREATE USER omr IDENTIFIED BY omr;
GRANT DBA TO omr;

CREATE TABLE omr.d_payments (
    payment_id   NUMBER,
    payment_type VARCHAR2(15),
    
    CONSTRAINT pk_payment
        PRIMARY KEY (payment_id)
); -- complete

CREATE TABLE omr.d_theatres (
    theatre_id   NUMBER,
    screen_no    NUMBER,
    theatre_name VARCHAR2(20),
    address      VARCHAR2(50),
    state        VARCHAR2(50),
    city         VARCHAR2(50),
    pincode      NUMBER,
    show_timing  TIMESTAMP,
 
    CONSTRAINT pk_theatre
        PRIMARY KEY (theatre_id)
);-- complete

CREATE TABLE omr.d_customers (
    name        VARCHAR2(50),
    customer_id NUMBER,
    login_id    NUMBER,
    email       VARCHAR2(30),
    phone_no    VARCHAR2(12),
    gender      CHAR,
    age         NUMBER,
    
    CONSTRAINT pk_customer 
        PRIMARY KEY ( customer_id )
); -- complete

CREATE TABLE omr.d_movies (
    movie_id   NUMBER,
    movie_name VARCHAR2(50),
    genre      VARCHAR2(15),
    language   VARCHAR2(15),
    rating     NUMBER,
    
    CONSTRAINT pk_movie 
        PRIMARY KEY ( movie_id )
); -- complete

CREATE TABLE omr.d_date
    AS
        SELECT
            *
        FROM
            (
                WITH base_calender AS (
                    SELECT
                        1                                                          AS day_id,
                        initcap(rtrim(to_char(currdate, 'MONTH')))
                        || ' '
                        || to_char(currdate, 'DD')
                        || ', '
                        || rtrim(to_char(currdate, 'YYYY'))                        AS day_name,
                        1                                                          AS num_days_in_day,
                        to_date(currdate, 'DD-MM-RR')                              AS day_end_date,
                        to_char(currdate, 'Day')                                   AS week_day_full,
                        to_char(currdate, 'DY')                                    AS week_day_short,
                        TO_NUMBER(TRIM(LEADING '0' FROM to_char(currdate, 'D')))   AS day_num_of_week,
                        TO_NUMBER(TRIM(LEADING '0' FROM to_char(currdate, 'DD')))  AS day_num_of_month,
                        TO_NUMBER(TRIM(LEADING '0' FROM to_char(currdate, 'DDD'))) AS day_num_of_year,
                        initcap(to_char(currdate, 'Mon')
                                || '-'
                                || to_char(currdate, 'YY'))                                AS month_id,
                        to_char(currdate, 'Month')                                 AS month_name,
                        to_char(currdate, 'Mon')
                        || ' '
                        || to_char(currdate, 'YYYY')                               AS month_short_desc,
                        rtrim(to_char(currdate, 'Month'))
                        || ' '
                        || to_char(currdate, 'YYYY')                               AS month_long_desc,
                        to_char(currdate, 'Mon')                                   AS month_short,
                        to_char(currdate, 'Month')                                 AS month_long,
                        TO_NUMBER(TRIM(LEADING '0' FROM to_char(currdate, 'MM')))  AS month_num_of_year,
                        'Q'
                        || upper(to_char(currdate, 'Q')
                                 || to_char(currdate, 'YYYY'))                              AS quarter_id,
                        'Q'
                        || upper(to_char(currdate, 'Q'))                           AS quarter_name,
                        TO_NUMBER(to_char(currdate, 'Q'))                          AS quarter_num_of_year,
                        CASE
                            WHEN TO_NUMBER(to_char(currdate, 'Q')) <= 2 THEN
                                1
                            ELSE
                                2
                        END                                                        AS half_num_of_year,
                        CASE
                            WHEN TO_NUMBER(to_char(currdate, 'Q')) <= 2 THEN
                                'H'
                                || 1
                                || '-'
                                || to_char(currdate, 'YYYY')
                            ELSE
                                'H'
                                || 2
                                || '-'
                                || to_char(currdate, 'YYYY')
                        END                                                        AS half_of_year_id,
                        to_char(currdate, 'YYYY')                                  AS year_id,
                        to_char(currdate, 'Year')                                  AS year_name
                    FROM
                        (
                            SELECT
                                level                                                               n,
                -- Calendar starts at the day after this date.
                                TO_DATE('31/12/2023', 'DD/MM/YYYY') + numtodsinterval(level, 'DAY') currdate
                            FROM
                                dual
             -- Change for the number of days to be added to the table.
                            CONNECT BY
                                level <= 1461
                        )
                )
                SELECT
                    ROWNUM                        AS day_id,
                    day_name,
                    num_days_in_day,
                    day_end_date,
                    day_num_of_week               AS day_number_in_week,
                    day_num_of_month              AS day_number_in_month,
                    day_num_of_year               AS day_number_in_year,
                    month_id,
                    month_name,
                    COUNT(*)
                        OVER(PARTITION BY month_id)   AS month_time_span,
                    MAX(day_id)
                        OVER(PARTITION BY month_id)   AS month_end_date,
                    month_num_of_year             AS month_number_in_year,
                    quarter_id,
                    quarter_name,
                    COUNT(*)
                        OVER(PARTITION BY quarter_id) AS quarter_time_span,
                    MAX(day_id)
                        OVER(PARTITION BY quarter_id) AS quarter_end_date,
                    quarter_num_of_year           AS quarter_number_in_year,
                    year_id,
                    year_name,
                    COUNT(*)
                        OVER(PARTITION BY year_id)    AS num_days_in_year,
                    MAX(day_id)
                        OVER(PARTITION BY year_id)    AS year_end_date
                FROM
                    base_calender
                ORDER BY
                    day_id
            ); -- complete

DESC d_date;

ALTER TABLE omr.d_date ADD CONSTRAINT pk_date PRIMARY KEY (day_end_date);

-- below 2 commands are for Oracle DB Cloud instance
-- ALTER USER OMR QUOTA UNLIMITED ON DATA;
-- GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE PROCEDURE TO OMR;

SELECT * FROM omr.d_date;

CREATE TABLE OMR.f_movie_reservations (
    customer_id NUMBER,
    movie_id    NUMBER,
    theatre_id  NUMBER,
    payment_id  NUMBER,
    reserved_date  DATE,
    price       NUMBER,
    seat_no     NUMBER,
    
    FOREIGN KEY ( customer_id )
        REFERENCES omr.d_customers ( customer_id ),
    FOREIGN KEY (movie_id) 
        REFERENCES omr.d_movies (movie_id),
    FOREIGN KEY ( theatre_id )
        REFERENCES omr.d_theatres ( theatre_id ),        
    FOREIGN KEY ( payment_id )
        REFERENCES omr.d_payments (payment_id),
    FOREIGN KEY ( reserved_date )
        REFERENCES omr.d_date (day_end_date)
); -- last complete

select * from tab;

Insert into OMR.D_CUSTOMERS (NAME,CUSTOMER_ID,LOGIN_ID,EMAIL,PHONE_NO,GENDER,AGE) values ('Alice Smith',1,101,'alice.smith@example.com','1234567890','F',30);
Insert into OMR.D_CUSTOMERS (NAME,CUSTOMER_ID,LOGIN_ID,EMAIL,PHONE_NO,GENDER,AGE) values ('Bob Johnson',2,102,'bob.johnson@example.com','9876543210','M',25);
Insert into OMR.D_CUSTOMERS (NAME,CUSTOMER_ID,LOGIN_ID,EMAIL,PHONE_NO,GENDER,AGE) values ('Charlie Brown',3,103,'charlie.brown@example.com','5551234567','M',40);
Insert into OMR.D_CUSTOMERS (NAME,CUSTOMER_ID,LOGIN_ID,EMAIL,PHONE_NO,GENDER,AGE) values ('Diana Miller',4,104,'diana.miller@example.com','1112223333','F',35);
Insert into OMR.D_CUSTOMERS (NAME,CUSTOMER_ID,LOGIN_ID,EMAIL,PHONE_NO,GENDER,AGE) values ('Ethan Davis',5,105,'ethan.davis@example.com','4445556666','M',28);
Insert into OMR.D_CUSTOMERS (NAME,CUSTOMER_ID,LOGIN_ID,EMAIL,PHONE_NO,GENDER,AGE) values ('Fiona Wilson',6,106,'fiona.wilson@example.com','7778889999','F',45);
Insert into OMR.D_CUSTOMERS (NAME,CUSTOMER_ID,LOGIN_ID,EMAIL,PHONE_NO,GENDER,AGE) values ('George Garcia',7,107,'george.garcia@example.com','1010101010','M',32);
Insert into OMR.D_CUSTOMERS (NAME,CUSTOMER_ID,LOGIN_ID,EMAIL,PHONE_NO,GENDER,AGE) values ('Hannah Rodriguez',8,108,'hannah.rodriguez@example.com','2020202020','F',29);
Insert into OMR.D_CUSTOMERS (NAME,CUSTOMER_ID,LOGIN_ID,EMAIL,PHONE_NO,GENDER,AGE) values ('Ian Martinez',9,109,'ian.martinez@example.com','3030303030','M',38);
Insert into OMR.D_CUSTOMERS (NAME,CUSTOMER_ID,LOGIN_ID,EMAIL,PHONE_NO,GENDER,AGE) values ('Julia Anderson',10,110,'julia.anderson@example.com','4040404040','F',31);
commit;

Insert into OMR.D_MOVIES (MOVIE_ID,MOVIE_NAME,GENRE,LANGUAGE,RATING) values (2001,'Leo','Action','Tamil',9);
Insert into OMR.D_MOVIES (MOVIE_ID,MOVIE_NAME,GENRE,LANGUAGE,RATING) values (2002,'Bahubali','Fantasy','Telugu',10);
Insert into OMR.D_MOVIES (MOVIE_ID,MOVIE_NAME,GENRE,LANGUAGE,RATING) values (2003,'Iron Man','Sci-Fi','English',9);
Insert into OMR.D_MOVIES (MOVIE_ID,MOVIE_NAME,GENRE,LANGUAGE,RATING) values (2004,'Wonder Women','Sci-Fi','English',6);
Insert into OMR.D_MOVIES (MOVIE_ID,MOVIE_NAME,GENRE,LANGUAGE,RATING) values (2005,'Jawan','Motivation','Hindi',9);
Insert into OMR.D_MOVIES (MOVIE_ID,MOVIE_NAME,GENRE,LANGUAGE,RATING) values (2006,'Mahanati','Biography','Telugu',9);
commit;

Insert into OMR.D_PAYMENTS (PAYMENT_ID,PAYMENT_TYPE) values (9001,'UPI');
Insert into OMR.D_PAYMENTS (PAYMENT_ID,PAYMENT_TYPE) values (9002,'Net Banking');
Insert into OMR.D_PAYMENTS (PAYMENT_ID,PAYMENT_TYPE) values (9003,'Credit Card');
commit;

Insert into OMR.D_THEATRES (THEATRE_ID,SCREEN_NO,THEATRE_NAME,ADDRESS,STATE,CITY,PINCODE,SHOW_TIMING) values (3001,3,'PVR Cinemas','RT Nagar','Telengana','Hyderabad',509106,to_timestamp('18-03-25 3:30:00.000000000 PM','DD-MM-RR fmHH12:fmMI:SSXFF AM'));
Insert into OMR.D_THEATRES (THEATRE_ID,SCREEN_NO,THEATRE_NAME,ADDRESS,STATE,CITY,PINCODE,SHOW_TIMING) values (3002,6,'Sathyam Cinemas','Anna Salai','Tamil Nadu','Chennai',600202,to_timestamp('18-03-25 9:00:00.000000000 AM','DD-MM-RR fmHH12:fmMI:SSXFF AM'));
Insert into OMR.D_THEATRES (THEATRE_ID,SCREEN_NO,THEATRE_NAME,ADDRESS,STATE,CITY,PINCODE,SHOW_TIMING) values (3003,4,'Prasad IMAX','AT Nagar','Telengana','Hyderabad',107896,to_timestamp('18-03-25 10:30:00.000000000 PM','DD-MM-RR fmHH12:fmMI:SSXFF AM'));
Insert into OMR.D_THEATRES (THEATRE_ID,SCREEN_NO,THEATRE_NAME,ADDRESS,STATE,CITY,PINCODE,SHOW_TIMING) values (3004,2,'SVC Cinemas','CT Nagar','Andhra Pradesh','Visakhapatnam',535591,to_timestamp('18-03-25 6:30:00.000000000 PM','DD-MM-RR fmHH12:fmMI:SSXFF AM'));
commit;

Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (1,2001,3001,9001,to_date('15-03-25','DD-MM-RR'),200,1);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (1,2001,3002,9002,to_date('15-03-25','DD-MM-RR'),200,2);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (3,2004,3003,9003,to_date('15-03-25','DD-MM-RR'),200,3);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (4,2003,3004,9003,to_date('15-03-25','DD-MM-RR'),200,4);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (6,2002,3002,9002,to_date('15-03-25','DD-MM-RR'),200,5);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (7,2005,3001,9001,to_date('16-03-25','DD-MM-RR'),200,6);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (7,2006,3003,9002,to_date('17-03-25','DD-MM-RR'),200,7);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (9,2002,3004,9001,to_date('16-03-25','DD-MM-RR'),200,8);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (10,2002,3004,9001,to_date('18-03-25','DD-MM-RR'),200,9);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (3,2002,3003,9002,to_date('18-03-25','DD-MM-RR'),200,10);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (2,2004,3002,9001,to_date('18-03-25','DD-MM-RR'),200,11);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (2,2003,3002,9001,to_date('19-03-25','DD-MM-RR'),200,12);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (5,2001,3001,9001,to_date('17-03-25','DD-MM-RR'),200,13);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (8,2002,3004,9002,to_date('16-03-25','DD-MM-RR'),200,14);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (5,2002,3003,9003,to_date('17-03-25','DD-MM-RR'),200,15);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (8,2003,3003,9003,to_date('16-03-25','DD-MM-RR'),200,16);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (9,2006,3004,9002,to_date('20-03-25','DD-MM-RR'),200,17);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (1,2006,3001,9001,to_date('17-03-25','DD-MM-RR'),200,18);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (10,2004,3002,9002,to_date('20-03-25','DD-MM-RR'),200,19);
Insert into OMR.F_MOVIE_RESERVATIONS (CUSTOMER_ID,MOVIE_ID,THEATRE_ID,PAYMENT_ID,RESERVED_DATE,PRICE,SEAT_NO) values (1,2003,3003,9001,to_date('20-03-25','DD-MM-RR'),200,20);
commit;

select * from omr.D_CUSTOMERS;
select * from omr.D_MOVIES;
select * from omr.D_THEATRES;
select * from omr.D_PAYMENTS;
select * from omr.D_DATE;
select * from omr.F_MOVIE_RESERVATIONS;
