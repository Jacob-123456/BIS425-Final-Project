import sqlite3

conn = sqlite3.connect("school.db")
cursor = conn.cursor()

# Create tables (based on your ERD)


cursor.execute("""
CREATE TABLE IF NOT EXISTS usertable (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE,
    password TEXT,
    account_type TEXT,
    security_question_answer TEXT   
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    user_id INTEGER,
               
    foreign key(user_id) references usertable(user_id)
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS subjects (
    subject_id TEXT PRIMARY KEY,
    name TEXT
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS assignments (
    assignment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INTEGER,
    title TEXT,
    max_score REAL,
    FOREIGN KEY(class_id) REFERENCES classes(class_id)
        
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS results (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER,
    assignment_id INTEGER,
    real_score REAL,
    letter TEXT,
    max_score REAL,
    percentage_score REAL,
    FOREIGN KEY(student_id) REFERENCES students(student_id),
    FOREIGN KEY(assignment_id) REFERENCES assignments(assignment_id)
               
)
""")


cursor.execute("""
CREATE TABLE IF NOT EXISTS teachers (
    teacher_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    user_id INTEGER,
    foreign key(user_id) references usertable(user_id)        
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS faculty (
    faculty_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    user_id INTEGER,
    foreign key(user_id) references usertable(user_id)        
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS classes (
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    teacher_id INTEGER,
    subject_id TEXT,
    FOREIGN KEY(teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY(subject_id) REFERENCES subjects(subject_id)
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS class_students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INTEGER,
    student_id INTEGER,
    FOREIGN KEY(class_id) REFERENCES classes(class_id),
    FOREIGN KEY(student_id) REFERENCES students(student_id)
)
""")



conn.commit()
conn.close()
