-- The below data is for practice purposes only.
-- Customers Table
CREATE TABLE Customers_v (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(100)
);

-- Products Table
CREATE TABLE Products_v (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(100),
    price NUMBER(10, 2)
);

-- Sales Table
CREATE TABLE Sales_v (
    sale_id NUMBER PRIMARY KEY,
    customer_id NUMBER REFERENCES Customers_v(customer_id),
    product_id NUMBER REFERENCES Products_v(product_id),
    quantity NUMBER,
    sale_date DATE
);

-- Insert Sample Data
INSERT INTO Customers_v VALUES (101, 'Alice Smith');
INSERT INTO Customers_v VALUES (102, 'Bob Johnson');
INSERT INTO Customers_v VALUES (103, 'Charlie Brown');
INSERT INTO Customers_v VALUES (104, 'Diana Miller');
INSERT INTO Customers_v VALUES (105, 'Eve Davis');
INSERT INTO Customers_v VALUES (106, 'Frank White');
INSERT INTO Customers_v VALUES (107, 'Grace Black');
INSERT INTO Customers_v VALUES (108, 'Henry Green');

INSERT INTO Products_v VALUES (201, 'Laptop', 1200.00);
INSERT INTO Products_v VALUES (202, 'Mouse', 25.00);
INSERT INTO Products_v VALUES (203, 'Keyboard', 75.00);
INSERT INTO Products_v VALUES (204, 'Monitor', 300.00);
INSERT INTO Products_v VALUES (205, 'Webcam', 50.00);
INSERT INTO Products_v VALUES (206, 'Headphones', 100.00);

-- After committing, the tables will be populated with the above data.
COMMIT;

-- Sales Data (more sales for top customers)
INSERT INTO Sales_v VALUES (1, 101, 201, 1, TO_DATE('2025-01-05', 'YYYY-MM-DD'));
INSERT INTO Sales_v VALUES (2, 101, 202, 2, TO_DATE('2025-01-06', 'YYYY-MM-DD')); -- Alice - Mouse
INSERT INTO Sales_v VALUES (3, 101, 203, 1, TO_DATE('2025-01-07', 'YYYY-MM-DD')); -- Alice - Keyboard
INSERT INTO Sales_v VALUES (4, 101, 204, 1, TO_DATE('2025-02-10', 'YYYY-MM-DD')); -- Alice - Monitor
INSERT INTO Sales_v VALUES (5, 101, 201, 1, TO_DATE('2025-02-15', 'YYYY-MM-DD')); -- Alice - Laptop

INSERT INTO Sales_v VALUES (6, 102, 201, 1, TO_DATE('2025-01-10', 'YYYY-MM-DD')); -- Bob - Laptop
INSERT INTO Sales_v VALUES (7, 102, 203, 1, TO_DATE('2025-01-12', 'YYYY-MM-DD')); -- Bob - Keyboard
INSERT INTO Sales_v VALUES (8, 102, 205, 3, TO_DATE('2025-03-01', 'YYYY-MM-DD')); -- Bob - Webcam

INSERT INTO Sales_v VALUES (9, 103, 204, 2, TO_DATE('2025-01-15', 'YYYY-MM-DD')); -- Charlie - Monitor
INSERT INTO Sales_v VALUES (10, 103, 202, 5, TO_DATE('2025-04-01', 'YYYY-MM-DD')); -- Charlie - Mouse

INSERT INTO Sales_v VALUES (11, 104, 206, 1, TO_DATE('2025-02-01', 'YYYY-MM-DD')); -- Diana - Headphones
INSERT INTO Sales_v VALUES (12, 104, 201, 1, TO_DATE('2025-02-05', 'YYYY-MM-DD')); -- Diana - Laptop

INSERT INTO Sales_v VALUES (13, 105, 203, 2, TO_DATE('2025-03-10', 'YYYY-MM-DD')); -- Eve - Keyboard
INSERT INTO Sales_v VALUES (14, 105, 205, 1, TO_DATE('2025-03-12', 'YYYY-MM-DD')); -- Eve - Webcam

INSERT INTO Sales_v VALUES (15, 106, 202, 1, TO_DATE('2025-04-15', 'YYYY-MM-DD')); -- Frank - Mouse
INSERT INTO Sales_v VALUES (16, 107, 206, 1, TO_DATE('2025-05-01', 'YYYY-MM-DD')); -- Grace - Headphones
INSERT INTO Sales_v VALUES (17, 108, 201, 1, TO_DATE('2025-06-01', 'YYYY-MM-DD')); -- Henry - Laptop

COMMIT;

-- Check the data
SELECT * FROM Customers_v;
SELECT * FROM Products_v;
SELECT * FROM Sales_v;


-- Temporary table for top customers (data cleared on commit)
CREATE GLOBAL TEMPORARY TABLE temp_top_customers (
    customer_id NUMBER,
    customer_name VARCHAR2(100),
    total_sales_amount NUMBER(10, 2)
) ON COMMIT DELETE ROWS;

-- Temporary table for product sales by top customers (data cleared on commit)
CREATE GLOBAL TEMPORARY TABLE temp_customer_product_sales (
    customer_id NUMBER,
    product_id NUMBER,
    product_name VARCHAR2(100),
    total_product_sales NUMBER(10, 2)
) ON COMMIT DELETE ROWS;


-- Insert top customers into the temporary table
-- This query calculates the total sales amount for each customer and inserts the top 5 into the temporary table
INSERT INTO temp_top_customers (customer_id, customer_name, total_sales_amount)
SELECT
    c.customer_id,
    c.customer_name,
    SUM(s.quantity * p.price) AS total_sales_amount
FROM
    Customers_v c
JOIN
    Sales_v s ON c.customer_id = s.customer_id
JOIN
    Products_v p ON s.product_id = p.product_id
GROUP BY
    c.customer_id, c.customer_name
ORDER BY
    total_sales_amount DESC
FETCH FIRST 5 ROWS ONLY; -- Oracle 12c+ syntax for TOP N


INSERT INTO temp_customer_product_sales (customer_id, product_id, product_name, total_product_sales)
SELECT
    s.customer_id,
    p.product_id,
    p.product_name,
    SUM(s.quantity * p.price) AS total_product_sales
FROM
    Sales_v s
JOIN
    Products_v p ON s.product_id = p.product_id
WHERE
    s.customer_id IN (SELECT customer_id FROM temp_top_customers) -- Filter for top customers
GROUP BY
    s.customer_id, p.product_id, p.product_name;


-- join the temporary tables and use analytic functions to get the top 3 products for each top customer.
SELECT
    ttc.customer_name,
    tps.product_name,
    tps.total_product_sales,
    tps.product_rank
FROM
    temp_top_customers ttc
JOIN (
    SELECT
        customer_id,
        product_id,
        product_name,
        total_product_sales,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY total_product_sales DESC) AS product_rank
    FROM
        temp_customer_product_sales
) tps ON ttc.customer_id = tps.customer_id
WHERE
    tps.product_rank <= 3
ORDER BY
    ttc.total_sales_amount DESC, ttc.customer_name, tps.product_rank;

COMMIT;

-- Check the temporary tables
-- Note: The data in these temporary tables will be cleared on commit.
SELECT * FROM temp_top_customers;
SELECT * FROM temp_customer_product_sales;