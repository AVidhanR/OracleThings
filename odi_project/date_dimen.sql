-- DATE DIMENSION
WITH base_calendar AS
 (
    SELECT
        currdate                                                                                                             AS day_id,
        INITCAP(RTRIM(TO_CHAR(currdate,'MONTH'))) ||' ' || TO_CHAR(currdate,'DD') || ', ' || RTRIM(TO_CHAR(currdate,'YYYY')) AS day_name,
        1                                                                                                                    AS num_days_in_day,
        currdate                                                                                                             AS day_end_date,
        TO_CHAR(currdate,'Day')                                                                                              AS week_day_full,
        TO_CHAR(currdate,'DY')                                                                                               AS week_day_short,
        to_number(TRIM(LEADING '0' FROM TO_CHAR(currdate,'D')))                                                              AS day_num_of_week,
        to_number(TRIM(LEADING '0' FROM TO_CHAR(currdate,'DD')))                                                             AS day_num_of_month,
        to_number(TRIM(LEADING '0' FROM TO_CHAR(currdate,'DDD')))                                                            AS day_num_of_year,
        initcap(TO_CHAR(currdate,'Mon') || '-' || TO_CHAR(currdate,'YY'))                                                    AS month_id,
        TO_CHAR(currdate,'Mon') || ' ' || TO_CHAR(currdate,'YYYY')                                                           AS month_short_desc,
        rtrim(TO_CHAR(currdate,'Month')) || ' ' || TO_CHAR(currdate,'YYYY')                                                  AS month_long_desc,
        TO_CHAR(currdate,'Mon')                                                                                              AS month_short,
        TO_CHAR(currdate,'Month')                                                                                            AS month_long,
        to_number(TRIM(LEADING '0' FROM TO_CHAR(currdate,'MM')))                                                             AS month_num_of_year,
        'Q' || upper(TO_CHAR(currdate,'Q') || TO_CHAR(currdate,'YYYY'))                                                      AS quarter_id,
        'Q' || upper(TO_CHAR(currdate,'Q') || '-' || TO_CHAR(currdate,'YYYY'))                                               AS quarter_name,
        to_number(TO_CHAR(currdate,'Q') ) AS quarter_num_of_year,
        CASE
            WHEN to_number(TO_CHAR(currdate,'Q') ) <= 2 THEN 1
                ELSE 2
            END                                                                                                              AS half_num_of_year,
        CASE
           WHEN to_number(TO_CHAR(currdate,'Q') ) <= 2
                  THEN 'H' || 1 || '-' || TO_CHAR(currdate,'YYYY')
                  ELSE 'H' || 2 || '-' || TO_CHAR(currdate,'YYYY')
            END                                                                                                              AS half_of_year_id,
        TO_CHAR(currdate,'YYYY')                                                                                             AS year_id
    FROM
        (
            SELECT
                level n,
                -- Calendar starts at the day after this date.
                TO_DATE('31/12/2023','DD/MM/YYYY') + numtodsinterval(level,'DAY') currdate
            FROM
                dual
             -- Change for the number of days to be added to the table.
            CONNECT BY
                level <= 1461
        )
) SELECT
    day_id                                    AS day_id,
    day_name                                  AS day_name,
    num_days_in_day                           AS num_days_in_day,
    day_end_date                              AS day_end_date,
    day_num_of_week                           AS day_num_of_week,
    day_num_of_month                          AS day_num_of_month,
    day_num_of_year                           AS day_number_in_year,
    day_num_of_month                          AS day_number_in_month,
    day_num_of_week                           AS day_number_in_week,
    month_id                                  AS month_id,
    month_id                                  AS month_name,
    COUNT(*) OVER(PARTITION BY month_id)      AS month_time_span,
    MAX(day_id) OVER(PARTITION BY month_id)   AS month_end_date,
    month_num_of_year                         AS month_number_in_year,
    quarter_id                                AS quarter_id,
    quarter_name                              AS quarter_name,
    COUNT(*) OVER(PARTITION BY quarter_id)    AS quarter_time_span,
    MAX(day_id) OVER(PARTITION BY quarter_id) AS quarter_end_date,
    quarter_num_of_year                       AS quarter_number_in_year,
    year_id                                   AS year_id,
    year_id                                   AS year_name,
    COUNT(*) OVER(PARTITION BY year_id)       AS num_days_in_year,
    MAX(day_id) OVER(PARTITION BY year_id)    AS year_end_date
  FROM
    base_calendar
ORDER BY
    day_id;
    
