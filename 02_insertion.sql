-- STUDENT RESULT MANAGEMENT SYSTEM
-- 02_insertion.sql
-- Inserts the sample data.

USE student_result_management;

-- Students
INSERT INTO Students (StudentID, Name, Branch, Year)
VALUES
(101, 'Rahul', 'CSE', 2),
(102, 'Priya', 'CSE', 2),
(103, 'Kiran', 'ECE', 2);

-- Subjects
INSERT INTO Subjects (SubjectID, SubjectName, Credits)
VALUES
('CS301', 'DBMS', 4),
('CS302', 'JAVA', 3),
('CS303', 'PYTHON', 3);

-- Marks
INSERT INTO Marks (StudentID, SubjectID, Marks)
VALUES
(101, 'CS301', 82),
(101, 'CS302', 75),
(101, 'CS303', 91),
(102, 'CS301', 94),
(102, 'CS302', 87),
(103, 'CS301', 68);
