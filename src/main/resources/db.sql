-- Create Database
CREATE DATABASE IF NOT EXISTS pahanaedu_shop_db;
USE pahanaedu_shop_db;

-- Create admin table
CREATE TABLE admin (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(50) UNIQUE NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create customers table
CREATE TABLE customers (
                           account_number VARCHAR(20) PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           address TEXT NOT NULL,
                           telephone VARCHAR(15) NOT NULL,
                           units_consumed INT DEFAULT 0,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create items table
CREATE TABLE items (
                       item_id VARCHAR(20) PRIMARY KEY,
                       item_name VARCHAR(100) NOT NULL,
                       price DECIMAL(10,2) NOT NULL,
                       stock INT NOT NULL DEFAULT 0,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create bills table
CREATE TABLE bills (
                       bill_id INT AUTO_INCREMENT PRIMARY KEY,
                       account_number VARCHAR(20),
                       total_units INT NOT NULL,
                       total_amount DECIMAL(10,2) NOT NULL,
                       bill_date DATE NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (account_number) REFERENCES customers(account_number) ON DELETE CASCADE
);

-- Insert default admin
INSERT INTO admin (username, password) VALUES ('admin', 'admin123');

-- Insert sample data for testing
INSERT INTO customers (account_number, name, address, telephone, units_consumed) VALUES
                                                                                     ('CUST001', 'John Silva', '123 Galle Road, Colombo 03', '0112345678', 15),
                                                                                     ('CUST002', 'Mary Fernando', '456 Kandy Road, Colombo 07', '0117654321', 25);

INSERT INTO items (item_id, item_name, price, stock) VALUES
                                                         ('BOOK001', 'Mathematics Grade 10', 850.00, 50),
                                                         ('BOOK002', 'Science Grade 11', 950.00, 30),
                                                         ('BOOK003', 'English Literature', 750.00, 25);
