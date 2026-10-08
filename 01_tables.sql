-- STUDENT RESULT MANAGEMENT SYSTEM
-- 01_tables.sql
-- Creates the database and tables.

CREATE DATABASE IF NOT EXISTS student_result_management;
USE student_result_management;

DROP TABLE IF EXISTS Marks;
DROP TABLE IF EXISTS Subjects;
DROP TABLE IF EXISTS Students;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Branch VARCHAR(20) NOT NULL,
    Year INT NOT NULL
);

CREATE TABLE Subjects (
    SubjectID VARCHAR(10) PRIMARY KEY,
    SubjectName VARCHAR(50) NOT NULL,
    Credits INT NOT NULL
);

CREATE TABLE Marks (
    StudentID INT,
    SubjectID VARCHAR(10),
    Marks INT NOT NULL,
    PRIMARY KEY (StudentID, SubjectID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);
