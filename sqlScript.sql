CREATE DATABASE IF NOT EXISTS school;
USE school;

#i wouldn't exactly do this in a real db but for debugging this is pretty necessary.
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE results;
TRUNCATE TABLE assignment_submissions;
TRUNCATE TABLE class_students;
TRUNCATE TABLE assignments;
TRUNCATE TABLE classes;
TRUNCATE TABLE students;
TRUNCATE TABLE teachers;
TRUNCATE TABLE faculty;
TRUNCATE TABLE subjects;
TRUNCATE TABLE usertable;
SET SQL_SAFE_UPDATES = 1;
SET FOREIGN_KEY_CHECKS = 1;

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
    subject_id VARCHAR(50) PRIMARY KEY, #this should be auto increment but i fear I already have code in python file that works around this and i do not want to find and change that.
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

CREATE TABLE IF NOT EXISTS assignment_submissions (
		id INTEGER AUTO_INCREMENT PRIMARY KEY,
		assignment_id INTEGER,
		student_id INTEGER,
		submitted BOOLEAN DEFAULT FALSE,
		FOREIGN KEY(assignment_id) REFERENCES assignments(assignment_id),
		FOREIGN KEY(student_id) REFERENCES students(student_id)
            );

##----------------- sample  -------------
#i know i should've just built some function or something to build sample data instead of defining it 1 by 1. but i'm tired.

USE school;


-- 1. STUDENT (jacob)

SET @input = 'jacob';

INSERT IGNORE INTO usertable (username, password, account_type, security_question_answer)
VALUES (@input, @input, 'Student', @input);

SELECT user_id INTO @uid
FROM usertable
WHERE username = @input;

INSERT INTO students (name, user_id)
VALUES (@input, @uid);



-- 2. TEACHER (paul)

SET @input = 'paul';

INSERT IGNORE INTO usertable (username, password, account_type, security_question_answer)
VALUES (@input, @input, 'Teacher', @input);

SET @uid = LAST_INSERT_ID();

INSERT INTO teachers (name, user_id)
VALUES (@input, @uid);



-- 3. FACULTY (Chris)

SET @input = 'chris';

INSERT INTO usertable (username, password, account_type, security_question_answer)
VALUES (@input, @input, 'Faculty', @input);

SET @uid = LAST_INSERT_ID();

INSERT INTO faculty (name, user_id)
VALUES (@input, @uid);



-- 4. FACULTY (Obama)

SET @input = 'obama';

INSERT IGNORE INTO usertable (username, password, account_type, security_question_answer)
VALUES (@input, @input, 'Faculty', @input);



INSERT IGNORE INTO faculty (name, user_id)
VALUES (@input, @uid);


-- 5. SUBJECTS

INSERT IGNORE INTO subjects (subject_id, name)
VALUES (1, 'math');

