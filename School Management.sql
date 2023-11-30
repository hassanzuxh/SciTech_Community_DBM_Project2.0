DROP DATABASE IF EXISTS School;
CREATE DATABASE School;
USE School;

CREATE TABLE Students ( 
student_id INT PRIMARY KEY, 
First_name varchar(50), 
Last_name varchar(50),
date_of_birth DATE
);

CREATE TABLE Courses (
course_id INT PRIMARY KEY,
course_name varchar(50)
);

CREATE TABLE Teachers (
teacher_id INT PRIMARY KEY,
First_name varchar(50), 
Last_name varchar(50)
);

CREATE TABLE Classes (
class_id INT PRIMARY KEY,
teacher_id INT,
course_id INT,
Semester varchar(50),
CONSTRAINT FOREIGN KEY (teacher_id)  REFERENCES Teachers(teacher_id),
CONSTRAINT FOREIGN KEY (course_id)  REFERENCES Courses(course_id)
);

CREATE TABLE Enrollments (
Enrolment_id INT PRIMARY KEY,
student_id INT,
course_id INT,
CONSTRAINT FOREIGN KEY (student_id)  REFERENCES Students(student_id),
CONSTRAINT FOREIGN KEY (course_id)  REFERENCES Courses(course_id)
);

-- Insert dummy data into Students table
INSERT INTO Students (student_id, first_name, last_name, date_of_birth)
VALUES
    (1, 'John', 'Doe', '1995-03-15'),
    (2, 'Jane', 'Smith', '1998-07-22'),
    (3, 'Alex', 'Johnson', '1997-01-10'),
    (4, 'Emily', 'Brown', '1996-09-05'),
    (5, 'Michael', 'Taylor', '1999-04-30'),
    (6, 'Sophia', 'Williams', '1994-11-20'),
    (7, 'Daniel', 'Miller', '1998-12-12'),
    (8, 'Olivia', 'Moore', '1997-06-18'),
    (9, 'David', 'Jones', '1996-08-25'),
    (10, 'Grace', 'Anderson', '1999-02-28');

-- Insert dummy data into Courses table
INSERT INTO Courses (course_id, course_name)
VALUES
    (101, 'Mathematics'),
    (102, 'History'),
    (103, 'Biology'),
    (104, 'Computer Science'),
    (105, 'English'),
    (106, 'Physics'),
    (107, 'Chemistry'),
    (108, 'Art'),
    (109, 'Economics'),
    (110, 'Psychology');

-- Insert dummy data into Teachers table
INSERT INTO Teachers (teacher_id, first_name, last_name)
VALUES
    (201, 'Professor', 'Johnson'),
    (202, 'Dr.', 'Williams'),
    (203, 'Mrs.', 'Smith'),
    (204, 'Mr.', 'Davis'),
    (205, 'Ms.', 'Anderson'),
    (206, 'Professor', 'Brown'),
    (207, 'Dr.', 'Moore'),
    (208, 'Mrs.', 'Taylor'),
    (209, 'Mr.', 'Clark'),
    (210, 'Ms.', 'Martin');

-- Insert dummy data into Classes table
INSERT INTO Classes (class_id, course_id, teacher_id, semester)
VALUES
    (301, 101, 201, 'Fall 2023'),
    (302, 102, 202, 'Spring 2023'),
    (303, 103, 203, 'Fall 2023'),
    (304, 104, 204, 'Spring 2023'),
    (305, 105, 205, 'Fall 2023'),
    (306, 106, 206, 'Spring 2023'),
    (307, 107, 207, 'Fall 2023'),
    (308, 108, 208, 'Spring 2023'),
    (309, 109, 209, 'Fall 2023'),
    (310, 110, 210, 'Spring 2023');

-- Insert dummy data into Enrollments table
INSERT INTO Enrollments (enrolment_id, student_id, course_id)
VALUES
    (401, 1, 101),
    (402, 1, 102),
    (403, 3, 104),
    (404, 4, 104),
    (405, 5, 105),
    (406, 6, 101),
    (407, 4, 107),
    (408, 5, 108),
    (409, 7, 109),
    (410, 5, 107);

-- Implement a query to find all students enrolled in a specific course
SELECT  S.student_id, S.first_name, S.last_name, C.Course_name
FROM Students S
LEFT JOIN Enrollments E
	USING (student_id)
LEFT JOIN Courses C
	USING (course_id)
WHERE course_name='Mathematics';

-- Implement a query to find the average grade of a student across all courses
DROP TABLE IF EXISTS grades;
CREATE TABLE grades (
student_id INT, 
course_id INT,
grades DECIMAL(4,2),
CONSTRAINT FOREIGN KEY (student_id) REFERENCES Students(student_id),
CONSTRAINT FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


INSERT INTO grades (student_id, course_id, grades)
VALUES
    (1,101, 20.2),
    (1, 102, 30.4),
    (2, 104, 40.6),
    (3, 104, 34.5),
    (2, 105, 92.7),
    (6, 101, 82.7),
    (7, 107, 88.9),
    (5, 108, 91.8),
    (5, 109, 87.0),
    (3, 107, 79.4);
    
SELECT student_id, AVG(grades) AS Average_Grades 
FROM grades
GROUP BY student_id