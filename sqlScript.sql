CREATE DATABASE IF NOT EXISTS school;
USE school;

CREATE TABLE IF NOT EXISTS usertable (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    account_type VARCHAR(50),
    security_question_answer VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    user_id INT,
    FOREIGN KEY(user_id) REFERENCES usertable(user_id)
);

CREATE TABLE IF NOT EXISTS subjects (
    subject_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS teachers (
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    user_id INT,
    FOREIGN KEY(user_id) REFERENCES usertable(user_id)
);

CREATE TABLE IF NOT EXISTS faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    user_id INT,
    FOREIGN KEY(user_id) REFERENCES usertable(user_id)
);

CREATE TABLE IF NOT EXISTS classes (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    teacher_id INT,
    subject_id VARCHAR(50),
    FOREIGN KEY(teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY(subject_id) REFERENCES subjects(subject_id)
);

CREATE TABLE IF NOT EXISTS assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    class_id INT,
    title VARCHAR(255),
    max_score FLOAT,
    FOREIGN KEY(class_id) REFERENCES classes(class_id)
);

CREATE TABLE IF NOT EXISTS results (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    assignment_id INT,
    real_score FLOAT,
    letter VARCHAR(2),
    max_score FLOAT,
    percentage_score FLOAT,
    FOREIGN KEY(student_id) REFERENCES students(student_id),
    FOREIGN KEY(assignment_id) REFERENCES assignments(assignment_id)
);

CREATE TABLE IF NOT EXISTS class_students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    class_id INT,
    student_id INT,
    FOREIGN KEY(class_id) REFERENCES classes(class_id),
    FOREIGN KEY(student_id) REFERENCES students(student_id)
);