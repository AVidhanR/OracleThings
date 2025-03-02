## Let's practie an ODI implementation
- Initially create a source in `ODI_Src` user and a target table in `ODI_Target` user as below, as I'm performing `Oracle - Oracle`
```sql
-- to create a target user
CREATE USER ODI_Target IDENTIFIED BY odi_target;
GRANT DBA TO ODI_Target;

-- other things
CREATE TABLE target (
    src_id           NUMBER,
    src_name         VARCHAR2(100),
    src_phone_number NUMBER(10),
    src_address      VARCHAR2(150)
);
-- target table
SELECT
    *
FROM
    target;

-- source things
CREATE SEQUENCE s_src_id START WITH 1 INCREMENT BY 1;
CREATE TABLE source (
    src_id           NUMBER,
    src_name         VARCHAR2(100),
    src_phone_number NUMBER(10),
    src_address      VARCHAR2(150)
);

INSERT INTO source VALUES ( s_src_id.NEXTVAL,
                            'Vidhan',
                            1231231231,
                            'SRC Colony, VZM' );

INSERT INTO source VALUES ( s_src_id.NEXTVAL,
                            'Vin',
                            4445556661,
                            'VK Colony, VJA' );

INSERT INTO source VALUES ( s_src_id.NEXTVAL,
                            'Reddy',
                            6667772212,
                            'SVC Colony, Vizag' );

INSERT INTO source VALUES ( s_src_id.NEXTVAL,
                            'Mukesh',
                            1231231213,
                            'Singh Colony, VZM' );

INSERT INTO source VALUES ( s_src_id.NEXTVAL,
                            'Vidhan',
                            3330002221,
                            'KP Colony, VZM' );

SELECT
    *
FROM
    source;
```
