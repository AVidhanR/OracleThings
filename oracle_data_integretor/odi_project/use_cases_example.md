### Use Case: Monthly Movie Reservation Analysis by Genre and Payment Type

#### Scenario:
The movie theater management wants to understand the monthly trends of movie reservations, focusing on which genres are most popular and how customers prefer to pay for their tickets. 
This analysis will help them optimize movie scheduling, marketing campaigns, and payment options.
#### Objective:
Generate a report that shows, for each month, the total number of movie reservations, broken down by movie genre and payment type.
```sql
CREATE TABLE monthly_reservation_summary (
    year_id VARCHAR(4),
    month_num VARCHAR2(15),
    month_name VARCHAR2(36),
    genre VARCHAR2(15),
    payment_type VARCHAR2(15),
    reservation_count NUMBER,
    load_date DATE,
    CONSTRAINT pk_monthly_res_summary PRIMARY KEY (year_id, month_num, genre, payment_type)
);

select * from monthly_reservation_summary;
```
