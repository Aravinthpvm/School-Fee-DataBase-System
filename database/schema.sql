-- School Fee Database System - Database Schema
-- Database: school_fee_db

CREATE DATABASE IF NOT EXISTS school_fee_db;
USE school_fee_db;

-- academic_years
CREATE TABLE academic_years (
    year_id INT NOT NULL AUTO_INCREMENT,
    year_name VARCHAR(10) DEFAULT NULL,
    start_date DATE DEFAULT NULL,
    end_date DATE DEFAULT NULL,
    is_current VARCHAR(5) DEFAULT NULL,
    PRIMARY KEY (year_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- teachers
CREATE TABLE teachers (
    teacher_id INT NOT NULL AUTO_INCREMENT,
    teacher_name VARCHAR(100) DEFAULT NULL,
    subject VARCHAR(50) DEFAULT NULL,
    phone VARCHAR(15) DEFAULT NULL,
    class_incharge VARCHAR(10) DEFAULT NULL,
    PRIMARY KEY (teacher_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- classes
CREATE TABLE classes (
    class_id INT NOT NULL AUTO_INCREMENT,
    class_name VARCHAR(10) DEFAULT NULL,
    section VARCHAR(5) DEFAULT NULL,
    teacher_id INT DEFAULT NULL,
    total_students INT DEFAULT NULL,
    PRIMARY KEY (class_id),
    KEY teacher_id (teacher_id),
    CONSTRAINT classes_ibfk_1 FOREIGN KEY (teacher_id) REFERENCES teachers (teacher_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- students
CREATE TABLE students (
    student_id INT NOT NULL AUTO_INCREMENT,
    student_name VARCHAR(100) DEFAULT NULL,
    class VARCHAR(10) DEFAULT NULL,
    section VARCHAR(5) DEFAULT NULL,
    gender VARCHAR(10) DEFAULT NULL,
    phone VARCHAR(15) DEFAULT NULL,
    city VARCHAR(50) DEFAULT NULL,
    join_date DATE DEFAULT NULL,
    PRIMARY KEY (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- parents
CREATE TABLE parents (
    parent_id INT NOT NULL AUTO_INCREMENT,
    student_id INT DEFAULT NULL,
    parent_name VARCHAR(100) DEFAULT NULL,
    relation VARCHAR(20) DEFAULT NULL,
    phone VARCHAR(15) DEFAULT NULL,
    email VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (parent_id),
    KEY student_id (student_id),
    CONSTRAINT parents_ibfk_1 FOREIGN KEY (student_id) REFERENCES students (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- fee_category
CREATE TABLE fee_category (
    category_id INT NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(50) DEFAULT NULL,
    description VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- fee_structure
CREATE TABLE fee_structure (
    fee_id INT NOT NULL AUTO_INCREMENT,
    class VARCHAR(10) DEFAULT NULL,
    category_id INT DEFAULT NULL,
    amount DECIMAL(10,2) DEFAULT NULL,
    academic_year VARCHAR(10) DEFAULT NULL,
    PRIMARY KEY (fee_id),
    KEY category_id (category_id),
    CONSTRAINT fee_structure_ibfk_1 FOREIGN KEY (category_id) REFERENCES fee_category (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- due_dates
CREATE TABLE due_dates (
    due_id INT NOT NULL AUTO_INCREMENT,
    fee_id INT DEFAULT NULL,
    term VARCHAR(10) DEFAULT NULL,
    due_date DATE DEFAULT NULL,
    penalty_per_day DECIMAL(5,2) DEFAULT NULL,
    PRIMARY KEY (due_id),
    KEY fee_id (fee_id),
    CONSTRAINT due_dates_ibfk_1 FOREIGN KEY (fee_id) REFERENCES fee_structure (fee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- payments
CREATE TABLE payments (
    payment_id INT NOT NULL AUTO_INCREMENT,
    student_id INT DEFAULT NULL,
    fee_id INT DEFAULT NULL,
    amount_paid DECIMAL(10,2) DEFAULT NULL,
    payment_date DATE DEFAULT NULL,
    payment_mode VARCHAR(20) DEFAULT NULL,
    receipt_no VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY (payment_id),
    KEY student_id (student_id),
    KEY fee_id (fee_id),
    CONSTRAINT payments_ibfk_1 FOREIGN KEY (student_id) REFERENCES students (student_id),
    CONSTRAINT payments_ibfk_2 FOREIGN KEY (fee_id) REFERENCES fee_structure (fee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- receipts
CREATE TABLE receipts (
    receipt_id INT NOT NULL AUTO_INCREMENT,
    payment_id INT DEFAULT NULL,
    issued_date DATE DEFAULT NULL,
    issued_by VARCHAR(100) DEFAULT NULL,
    PRIMARY KEY (receipt_id),
    KEY payment_id (payment_id),
    CONSTRAINT receipts_ibfk_1 FOREIGN KEY (payment_id) REFERENCES payments (payment_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- discounts
CREATE TABLE discounts (
    discount_id INT NOT NULL AUTO_INCREMENT,
    student_id INT DEFAULT NULL,
    discount_type VARCHAR(50) DEFAULT NULL,
    discount_amt DECIMAL(10,2) DEFAULT NULL,
    academic_year VARCHAR(10) DEFAULT NULL,
    PRIMARY KEY (discount_id),
    KEY student_id (student_id),
    CONSTRAINT discounts_ibfk_1 FOREIGN KEY (student_id) REFERENCES students (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- complaints
CREATE TABLE complaints (
    complaint_id INT NOT NULL AUTO_INCREMENT,
    student_id INT DEFAULT NULL,
    complaint_msg VARCHAR(200) DEFAULT NULL,
    raised_date DATE DEFAULT NULL,
    status VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY (complaint_id),
    KEY student_id (student_id),
    CONSTRAINT complaints_ibfk_1 FOREIGN KEY (student_id) REFERENCES students (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- penalty_log
CREATE TABLE penalty_log (
    penalty_id INT NOT NULL AUTO_INCREMENT,
    payment_id INT DEFAULT NULL,
    student_id INT DEFAULT NULL,
    days_late INT DEFAULT NULL,
    penalty_amt DECIMAL(10,2) DEFAULT NULL,
    logged_date DATE DEFAULT NULL,
    PRIMARY KEY (penalty_id),
    KEY payment_id (payment_id),
    KEY student_id (student_id),
    CONSTRAINT penalty_log_ibfk_1 FOREIGN KEY (payment_id) REFERENCES payments (payment_id),
    CONSTRAINT penalty_log_ibfk_2 FOREIGN KEY (student_id) REFERENCES students (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- monthly_summary
CREATE TABLE monthly_summary (
    summary_id INT NOT NULL AUTO_INCREMENT,
    month_year VARCHAR(10) DEFAULT NULL,
    total_collected DECIMAL(12,2) DEFAULT NULL,
    total_students INT DEFAULT NULL,
    created_at DATE DEFAULT NULL,
    PRIMARY KEY (summary_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- transport
CREATE TABLE transport (
    transport_id INT NOT NULL AUTO_INCREMENT,
    student_id INT DEFAULT NULL,
    route_name VARCHAR(50) DEFAULT NULL,
    pickup_point VARCHAR(100) DEFAULT NULL,
    bus_no VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY (transport_id),
    KEY student_id (student_id),
    CONSTRAINT transport_ibfk_1 FOREIGN KEY (student_id) REFERENCES students (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
