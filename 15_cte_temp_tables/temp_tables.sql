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
