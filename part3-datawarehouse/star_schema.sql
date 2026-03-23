
-- Drop tables if they already exist
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;

-- =========================================
-- Dimension Table: Date
-- =========================================
CREATE TABLE dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE NOT NULL,
    day_num INTEGER NOT NULL,
    month_num INTEGER NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    quarter_num INTEGER NOT NULL,
    year_num INTEGER NOT NULL
);

-- =========================================
-- Dimension Table: Store
-- =========================================
CREATE TABLE dim_store (
    store_key INTEGER PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_city VARCHAR(100) NOT NULL
);

-- =========================================
-- Dimension Table: Product
-- =========================================
CREATE TABLE dim_product (
    product_key INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

-- =========================================
-- Fact Table: Sales
-- =========================================
CREATE TABLE fact_sales (
    sales_key INTEGER PRIMARY KEY,
    transaction_id VARCHAR(20) NOT NULL,
    date_key INTEGER NOT NULL,
    store_key INTEGER NOT NULL,
    product_key INTEGER NOT NULL,
    customer_id VARCHAR(20),
    units_sold INTEGER NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_sales DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (store_key) REFERENCES dim_store(store_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);

-- =========================================
-- INSERT CLEANED DATA INTO DIMENSIONS
-- Cleaned Rules Applied:
-- 1. Dates standardized to YYYY-MM-DD
-- 2. Category standardized:
--    electronics -> Electronics
--    Grocery/Groceries -> Grocery
-- 3. NULL store_city filled from store_name mapping
-- =========================================

-- Date Dimension
INSERT INTO dim_date (date_key, full_date, day_num, month_num, month_name, quarter_num, year_num) VALUES
(20230829, '2023-08-29', 29, 8, 'August', 3, 2023),
(20231212, '2023-12-12', 12, 12, 'December', 4, 2023),
(20230205, '2023-02-05', 5, 2, 'February', 1, 2023),
(20230220, '2023-02-20', 20, 2, 'February', 1, 2023),
(20230115, '2023-01-15', 15, 1, 'January', 1, 2023),
(20230809, '2023-08-09', 9, 8, 'August', 3, 2023),
(20230331, '2023-03-31', 31, 3, 'March', 1, 2023),
(20231026, '2023-10-26', 26, 10, 'October', 4, 2023),
(20231208, '2023-12-08', 8, 12, 'December', 4, 2023),
(20230815, '2023-08-15', 15, 8, 'August', 3, 2023);

-- Store Dimension
INSERT INTO dim_store (store_key, store_name, store_city) VALUES
(1, 'Chennai Anna', 'Chennai'),
(2, 'Delhi South', 'Delhi'),
(3, 'Bangalore MG', 'Bangalore'),
(4, 'Pune FC Road', 'Pune'),
(5, 'Mumbai Central', 'Mumbai');

-- Product Dimension
INSERT INTO dim_product (product_key, product_name, category) VALUES
(1, 'Speaker', 'Electronics'),
(2, 'Tablet', 'Electronics'),
(3, 'Phone', 'Electronics'),
(4, 'Smartwatch', 'Electronics'),
(5, 'Atta 10kg', 'Grocery'),
(6, 'Jeans', 'Clothing'),
(7, 'Biscuits', 'Grocery'),
(8, 'Jacket', 'Clothing');

-- =========================================
-- INSERT CLEANED SAMPLE DATA INTO FACT TABLE
-- At least 10 fact rows
-- =========================================
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, customer_id, units_sold, unit_price, total_sales) VALUES
(1, 'TXN5000', 20230829, 1, 1, 'CUST045', 3, 49262.78, 147788.34),
(2, 'TXN5001', 20231212, 1, 2, 'CUST021', 11, 23226.12, 255487.32),
(3, 'TXN5002', 20230205, 1, 3, 'CUST019', 20, 48703.39, 974067.80),
(4, 'TXN5003', 20230220, 2, 2, 'CUST007', 14, 23226.12, 325165.68),
(5, 'TXN5004', 20230115, 1, 4, 'CUST004', 10, 58851.01, 588510.10),
(6, 'TXN5005', 20230809, 3, 5, 'CUST027', 12, 52464.00, 629568.00),
(7, 'TXN5006', 20230331, 4, 4, 'CUST025', 6, 58851.01, 353106.06),
(8, 'TXN5007', 20231026, 4, 6, 'CUST041', 16, 2317.47, 37079.52),
(9, 'TXN5008', 20231208, 3, 7, 'CUST030', 9, 27469.99, 247229.91),
(10, 'TXN5009', 20230815, 3, 4, 'CUST020', 3, 58851.01, 176553.03);