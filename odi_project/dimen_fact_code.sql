-- run the below commands to create a new schema/user in oracle
CREATE USER omr IDENTIFIED BY omr;
GRANT DBA TO omr;

-- Dimension Tables
CREATE TABLE d_payments (
    payment_id   NUMBER,
    payment_type VARCHAR2(15),
    payment_date DATE,
    
    CONSTRAINT pk_payments 
        PRIMARY KEY (payment_id)
); -- complete

CREATE TABLE d_theatres (
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

CREATE TABLE d_customers (
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

CREATE TABLE d_movies (
    movie_id   NUMBER,
    movie_name VARCHAR2(50),
    genre      VARCHAR2(15),
    language   VARCHAR2(15),
    rating     NUMBER,
    CONSTRAINT pk_movies PRIMARY KEY ( movie_id )
); -- no change

CREATE TABLE d_date
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
                        currdate                                                   AS day_end_date,
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
 
CREATE TABLE f_movie_reservations (
    customer_id NUMBER,
    movie_id    NUMBER,
    theatre_id  NUMBER,
    payment_id  NUMBER,
    reserved_date  DATE,
    price       NUMBER,
    seat_no     NUMBER,
    
    FOREIGN KEY ( customer_id )
        REFERENCES d_customers ( customer_id ),
    FOREIGN KEY (movie_id) 
        REFERENCES d_movies (movie_id),
    FOREIGN KEY ( theatre_id )
        REFERENCES d_theatres ( theatre_id ),        
    FOREIGN KEY ( payment_id )
        REFERENCES d_payments (payment_id)
); -- last complete
