-- Ocean View Resort Database Schema
CREATE DATABASE IF NOT EXISTS oceanview_db;
USE oceanview_db;

-- Table for User Authentication (Admin/Staff)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Staff') DEFAULT 'Staff'
);

-- Table for Guest Management
CREATE TABLE guests (
    guest_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    nic_passport VARCHAR(20) UNIQUE NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    check_in_date DATE,
    check_out_date DATE,
    room_number INT,
    total_bill DECIMAL(10, 2) DEFAULT 0.00
);

-- Insert sample Admin user
INSERT INTO users (username, password, role) VALUES ('admin', 'admin123', 'Admin');
