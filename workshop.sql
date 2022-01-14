-- kill other connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'week1_workshop' AND pid <> pg_backend_pid();
-- (re)create the database
DROP DATABASE IF EXISTS week1_workshop;
CREATE DATABASE week1_workshop;
-- connect via psql
\c week1_workshop

-- database configuration
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;


---
--- CREATE tables
---

CREATE TABLE products (
    product_id SERIAL,
    product_name TEXT NOT NULL,
    discontinued BOOLEAN NOT NULL,
    supplier_id INT,
    category_id INT,
    PRIMARY KEY(product_id)
);

CREATE TABLE categories (
    category_id SERIAL,
    category_name TEXT UNIQUE NOT NULL,
    category_description TEXT,
    category_picture TEXT,
    PRIMARY KEY(category_id)
);
-- TASK 1
CREATE TABLE suppliers (
    supplier_id SERIAL,
    supplier_name TEXT NOT NULL,
    PRIMARY KEY(supplier_id)
);
-- TASK 2
CREATE TABLE customers (
    customer_id SERIAL,
    company_name TEXT NOT NULL,
    PRIMARY KEY(customer_id)
);
-- TASK 3
CREATE TABLE employees (
    employee_id SERIAL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    PRIMARY KEY(employee_id)
);
-- TASK 4
CREATE TABLE orders (
    order_id SERIAL,
    order_date DATE,
    customer_id INT,
    employee_id INT,
    PRIMARY KEY(order_id)
);
-- TASK 5
CREATE TABLE orders_products (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    discontinued BOOLEAN NOT NULL,
    quantity INT NOT NULL,
    discount NUMERIC NOT NULL,
    PRIMARY KEY(order_id, product_id)    
);
-- TASK 6
CREATE TABLE territories (
    territory_id SERIAL,
    territory_description TEXT NOT NULL,
    PRIMARY KEY(territory_id)
);
-- TASK 7
CREATE TABLE employees_territories (
    employee_id INT NOT NULL,
    territory_id INT NOT NULL,    
    PRIMARY KEY(employee_id, territory_id)
);
-- TASK 8
CREATE TABLE offices (
    office_id SERIAL,
    address_line_id INT NOT NULL,
    territory_id INT UNIQUE NOT NULL,
    PRIMARY KEY(office_id)
);
-- TASK 9
CREATE TABLE us_states (
    us_states_id SERIAL,
    us_states_name TEXT NOT NULL UNIQUE,
    us_states_abbreviation CHAR(2) NOT NULL UNIQUE,
    PRIMARY KEY(us_states_id)
);
-- TASK 10
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id)
REFERENCES customers;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_employees
FOREIGN KEY (employee_id)
REFERENCES employees;
-- TASK 11
ALTER TABLE products
ADD CONSTRAINT fk_products_supplier
FOREIGN KEY (supplier_id)
REFERENCES suppliers;

ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (category_id)
REFERENCES categories;
-- TASK 12
ALTER TABLE orders_products
ADD CONSTRAINT fk_orders_products_orders
FOREIGN KEY (order_id)
REFERENCES orders;

ALTER TABLE orders_products
ADD CONSTRAINT fk_orders_products_products
FOREIGN KEY (product_id)
REFERENCES products;
-- TASK 13
ALTER TABLE employees_territories
ADD CONSTRAINT fk_employees_territories_territories
FOREIGN KEY (territory_id)
REFERENCES territories;

ALTER TABLE employees_territories
ADD CONSTRAINT fk_employees_territories_employees
FOREIGN KEY (employee_id)
REFERENCES employees;
-- TASK 14
ALTER TABLE offices
ADD CONSTRAINT fk_offices_territories
FOREIGN KEY(territory_id)
REFERENCES territories;
