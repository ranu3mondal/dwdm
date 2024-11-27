drop database db3;  
CREATE DATABASE db3;
USE db3;

CREATE TABLE Student (
    SRN INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    DateOfBirth DATE
);
CREATE TABLE Department (
    DepartmentName VARCHAR(100) PRIMARY KEY,
    Location VARCHAR(100)
);
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT,
    FOREIGN KEY (DepartmentName) REFERENCES Department(DepartmentName),
    DepartmentName VARCHAR(100)
);

CREATE TABLE Registration (
    RegistrationID INT PRIMARY KEY AUTO_INCREMENT,
    StudentSRN INT,
    CourseID INT,
    Semester VARCHAR(20),
    YearOfEnrollment YEAR,
    FOREIGN KEY (StudentSRN) REFERENCES Student(SRN),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
); b,

CREATE TABLE Grade (
    GradeID INT PRIMARY KEY AUTO_INCREMENT,
    StudentSRN INT,
    Grade VARCHAR(20),
    FOREIGN KEY (StudentSRN) REFERENCES Student(SRN)
);



CREATE TABLE Teacher (
    TeacherID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100)
);

CREATE TABLE CourseTeacher (
    CourseID INT,
    TeacherID INT,
    PRIMARY KEY (CourseID, TeacherID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (TeacherID) REFERENCES Teacher(TeacherID)
);

INSERT INTO Student (SRN, Name, Email, DateOfBirth) VALUES
(1, 'Rajesh Kumar', 'rajesh@example.com', '1998-05-15'),
(2, 'Priya Sharma', 'priya@example.com', '1999-07-21'),
(3, 'Amit Patel', 'amit@example.com', '1997-12-03'),
(4, 'Anjali Gupta', 'anjali@example.com', '1998-09-08'),
(5, 'Suresh Singh', 'suresh@example.com', '1996-04-25'),
(6, 'Deepika Reddy', 'deepika@example.com', '1999-11-12'),
(7, 'Rahul Mehta', 'rahul@example.com', '1997-08-17'),
(8, 'Kavita Jain', 'kavita@example.com', '1998-03-29'),
(9, 'Vikram Yadav', 'vikram@example.com', '1997-06-20'),
(10, 'Neha Sharma', 'neha@example.com', '1999-02-14');


INSERT INTO Course (CourseID, CourseName, Credits) VALUES
(1, 'Mathematics', 4),
(2, 'Physics', 3),
(3, 'Computer Science', 5),
(4, 'Chemistry', 3),
(5, 'Biology', 4),
(6, 'History', 3),
(7, 'English', 3),
(8, 'Economics', 4),
(9, 'Geography', 3),
(10, 'Political Science', 4);

INSERT INTO Department (DepartmentName, Location) VALUES
('Mathematics Department', 'Building A'),
('Physics Department', 'Building B'),
('Computer Science Department', 'Building C'),
('Chemistry Department', 'Building D'),
('Biology Department', 'Building E'),
('History Department', 'Building F'),
('English Department', 'Building G'),
('Economics Department', 'Building H'),
('Geography Department', 'Building I'),
('Political Science Department', 'Building J');


INSERT INTO Teacher (Name, Email) VALUES
('Dr. Ramesh Kumar', 'ramesh@example.com'),
('Dr. Priya Sharma', 'priya@example.com'),
('Prof. Amit Patel', 'amit@example.com'),
('Prof. Anjali Gupta', 'anjali@example.com'),
('Dr. Suresh Singh', 'suresh@example.com'),
('Prof. Deepika Reddy', 'deepika@example.com'),
('Dr. Rahul Mehta', 'rahul@example.com'),
('Prof. Kavita Jain', 'kavita@example.com'),
('Dr. Vikram Yadav', 'vikram@example.com'),
('Prof. Neha Sharma', 'neha@example.com');


INSERT INTO CourseTeacher (CourseID, TeacherID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

SELECT * FROM Student;


SELECT * FROM Course;

SELECT * FROM Registration;

SELECT * FROM Grade;


SELECT * FROM Department;


SELECT * FROM Teacher;


SELECT * FROM CourseTeacher;
show tables;

(SELECT SRN FROM Student)
UNION
(SELECT DepartmentName FROM Department);

(SELECT CourseId FROM Course)
INTERSECT
(SELECT RegistrationID FROM Registration);

(SELECT GradeID FROM Grade)
UNION ALL
(SELECT TeacherID FROM Teacher);

(SELECT SRN FROM Student)
EXCEPT
(SELECT CourseID FROM CourseTeacher);


SELECT * 
FROM Student
INNER JOIN Registration ON Student.SRN = Registration.StudentSRN;


SELECT * 
FROM Course
LEFT JOIN CourseTeacher ON Course.CourseID = CourseTeacher.CourseID;


SELECT * 
FROM Course
RIGHT JOIN Department ON Course.DepartmentName = Department.DepartmentName;



SELECT *
FROM CourseTeacher
LEFT JOIN Teacher ON CourseTeacher.TeacherID = Teacher.TeacherID
UNION

SELECT *
FROM CourseTeacher
RIGHT JOIN Teacher ON CourseTeacher.TeacherID = Teacher.TeacherID
WHERE CourseTeacher.TeacherID IS NULL;