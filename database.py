import sqlite3

conn = sqlite3.connect("school.db")
cursor = conn.cursor()

# Create tables (based on your ERD)
cursor.execute("""
CREATE TABLE IF NOT EXISTS students (
    student_id TEXT PRIMARY KEY,
    name TEXT
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
    assignment_id TEXT PRIMARY KEY,
    subject_id TEXT,
    title TEXT
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS results (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id TEXT,
    assignment_id TEXT,
    real_score REAL,
    letter TEXT,
    max_score REAL,
    percentage_score REAL,
    FOREIGN KEY(student_id) REFERENCES students(student_id),
    FOREIGN KEY(assignment_id) REFERENCES assignments(assignment_id)
               
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS usertable (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id TEXT,
    username TEXT UNIQUE,
    password TEXT,
    account_type TEXT,
    security_question_answer TEXT,
    FOREIGN KEY(student_id) REFERENCES students(student_id)
        
               
)
""")

conn.commit()
conn.close()
