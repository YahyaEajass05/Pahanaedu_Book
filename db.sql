-- Create Database
CREATE DATABASE IF NOT EXISTS pahanaedu_shop;
USE pahanaedu_shop;

-- Create admin table
CREATE TABLE admin (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(50) UNIQUE NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customers (
                           customer_id INT PRIMARY KEY AUTO_INCREMENT,
                           name VARCHAR(100) NOT NULL,
                           email VARCHAR(100) UNIQUE NOT NULL,
                           phone VARCHAR(15) NOT NULL,
                           address TEXT NOT NULL,
                           membership_type ENUM('REGULAR', 'PREMIUM', 'VIP') DEFAULT 'REGULAR',
                           total_purchases DECIMAL(10,2) DEFAULT 0.00,
                           loyalty_points INT DEFAULT 0,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



-- Drop old bills table
DROP TABLE IF EXISTS bills;

-- Create new bills table
CREATE TABLE bills (
                       bill_id INT AUTO_INCREMENT PRIMARY KEY,
                       customer_id INT NOT NULL,
                       bill_number VARCHAR(50) UNIQUE NOT NULL,
                       subtotal DECIMAL(10,2) NOT NULL,
                       discount_amount DECIMAL(10,2) DEFAULT 0.00,
                       tax_amount DECIMAL(10,2) DEFAULT 0.00,
                       total_amount DECIMAL(10,2) NOT NULL,
                       payment_method ENUM('CASH', 'CARD', 'ONLINE') DEFAULT 'CASH',
                       payment_status ENUM('PAID', 'PENDING', 'CANCELLED') DEFAULT 'PAID',
                       loyalty_points_earned INT DEFAULT 0,
                       loyalty_points_redeemed INT DEFAULT 0,
                       bill_date DATETIME NOT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE RESTRICT
);

-- Create bill items table
CREATE TABLE bill_items (
                            bill_item_id INT AUTO_INCREMENT PRIMARY KEY,
                            bill_id INT NOT NULL,
                            item_id VARCHAR(20) NOT NULL,
                            quantity INT NOT NULL,
                            unit_price DECIMAL(10,2) NOT NULL,
                            total_price DECIMAL(10,2) NOT NULL,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            FOREIGN KEY (bill_id) REFERENCES bills(bill_id) ON DELETE CASCADE,
                            FOREIGN KEY (item_id) REFERENCES items(item_id) ON DELETE RESTRICT
);


CREATE TABLE items (
                       item_id VARCHAR(20) PRIMARY KEY,
                       item_name VARCHAR(100) NOT NULL,
                       price DECIMAL(10,2) NOT NULL,
                       stock INT NOT NULL DEFAULT 0,
                       category VARCHAR(50),
                       discount_percentage DECIMAL(5,2) DEFAULT 0.00,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Insert default admin
INSERT INTO admin (username, password) VALUES ('admin', 'admin123');


