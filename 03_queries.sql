-- STUDENT RESULT MANAGEMENT SYSTEM
-- 03_queries.sql
-- SQL queries for the required tasks.

USE student_result_management;

-- ============================================================
-- 1. FIND THE TOPPER IN DBMS
-- ============================================================

SELECT
    s.StudentID,
    s.Name,
    s.Branch,
    m.Marks AS DBMS_Marks
FROM Students s
JOIN Marks m ON s.StudentID = m.StudentID
JOIN Subjects sub ON m.SubjectID = sub.SubjectID
WHERE sub.SubjectName = 'DBMS'
ORDER BY m.Marks DESC
LIMIT 1;


-- ============================================================
-- 2. FIND STUDENTS SCORING ABOVE 80 IN ALL SUBJECTS
-- ============================================================

SELECT
    s.StudentID,
    s.Name,
    s.Branch
FROM Students s
JOIN Marks m ON s.StudentID = m.StudentID
GROUP BY s.StudentID, s.Name, s.Branch
HAVING COUNT(DISTINCT m.SubjectID) = (SELECT COUNT(*) FROM Subjects)
   AND MIN(m.Marks) > 80;


-- ============================================================
-- 3. CALCULATE AVERAGE MARKS OF EACH SUBJECT
-- ============================================================

SELECT
    sub.SubjectID,
    sub.SubjectName,
    ROUND(AVG(m.Marks), 2) AS Average_Marks
FROM Subjects sub
LEFT JOIN Marks m ON sub.SubjectID = m.SubjectID
GROUP BY sub.SubjectID, sub.SubjectName
ORDER BY sub.SubjectID;


-- ============================================================
-- 4. FIND STUDENTS WHO FAILED
-- Assumption: marks below 40 = FAIL
-- ============================================================

SELECT DISTINCT
    s.StudentID,
    s.Name,
    s.Branch
FROM Students s
JOIN Marks m ON s.StudentID = m.StudentID
WHERE m.Marks < 40;


-- Display the failed subject also:
SELECT
    s.StudentID,
    s.Name,
    sub.SubjectName,
    m.Marks,
    'FAIL' AS Result
FROM Students s
JOIN Marks m ON s.StudentID = m.StudentID
JOIN Subjects sub ON m.SubjectID = sub.SubjectID
WHERE m.Marks < 40;


-- ============================================================
-- 5. DISPLAY CGPA
-- Grade-point assumption:
-- 90-100 = 10
-- 80-89  = 9
-- 70-79  = 8
-- 60-69  = 7
-- 50-59  = 6
-- 40-49  = 5
-- Below 40 = 0
-- ============================================================

SELECT
    s.StudentID,
    s.Name,
    ROUND(
        SUM(
            CASE
                WHEN m.Marks >= 90 THEN 10
                WHEN m.Marks >= 80 THEN 9
                WHEN m.Marks >= 70 THEN 8
                WHEN m.Marks >= 60 THEN 7
                WHEN m.Marks >= 50 THEN 6
                WHEN m.Marks >= 40 THEN 5
                ELSE 0
            END * sub.Credits
        ) / SUM(sub.Credits),
        2
    ) AS CGPA
FROM Students s
JOIN Marks m ON s.StudentID = m.StudentID
JOIN Subjects sub ON m.SubjectID = sub.SubjectID
GROUP BY s.StudentID, s.Name
ORDER BY CGPA DESC;


-- ============================================================
-- EXTRA QUERIES
-- ============================================================

-- 6. Display complete result
SELECT
    s.StudentID,
    s.Name,
    s.Branch,
    s.Year,
    sub.SubjectName,
    sub.Credits,
    m.Marks
FROM Students s
JOIN Marks m ON s.StudentID = m.StudentID
JOIN Subjects sub ON m.SubjectID = sub.SubjectID
ORDER BY s.StudentID, sub.SubjectID;


-- 7. Average marks of each student
SELECT
    s.StudentID,
    s.Name,
    ROUND(AVG(m.Marks), 2) AS Average_Marks
FROM Students s
JOIN Marks m ON s.StudentID = m.StudentID
GROUP BY s.StudentID, s.Name
ORDER BY Average_Marks DESC;


-- 8. Overall topper based on average marks
SELECT
    s.StudentID,
    s.Name,
    ROUND(AVG(m.Marks), 2) AS Average_Marks
FROM Students s
JOIN Marks m ON s.StudentID = m.StudentID
GROUP BY s.StudentID, s.Name
ORDER BY Average_Marks DESC
LIMIT 1;


-- 9. Highest marks in each subject
SELECT
    sub.SubjectName,
    MAX(m.Marks) AS Highest_Marks
FROM Subjects sub
JOIN Marks m ON sub.SubjectID = m.SubjectID
GROUP BY sub.SubjectID, sub.SubjectName;


-- 10. Lowest marks in each subject
SELECT
    sub.SubjectName,
    MIN(m.Marks) AS Lowest_Marks
FROM Subjects sub
JOIN Marks m ON sub.SubjectID = m.SubjectID
GROUP BY sub.SubjectID, sub.SubjectName;


-- 11. Count students in each branch
SELECT
    Branch,
    COUNT(*) AS Number_Of_Students
FROM Students
GROUP BY Branch;


-- 12. Display CSE students
SELECT *
FROM Students
WHERE Branch = 'CSE';


-- 13. Students who scored 80 or more in DBMS
SELECT
    s.StudentID,
    s.Name,
    m.Marks
FROM Students s
JOIN Marks m ON s.StudentID = m.StudentID
WHERE m.SubjectID = 'CS301'
  AND m.Marks >= 80
ORDER BY m.Marks DESC;


-- 14. Count subjects completed by each student
SELECT
    s.StudentID,
    s.Name,
    COUNT(m.SubjectID) AS Subjects_Completed
FROM Students s
LEFT JOIN Marks m ON s.StudentID = m.StudentID
GROUP BY s.StudentID, s.Name;


-- 15. Find students with missing subject marks
SELECT
    s.StudentID,
    s.Name,
    COUNT(DISTINCT m.SubjectID) AS Subjects_With_Marks,
    (SELECT COUNT(*) FROM Subjects) AS Total_Subjects
FROM Students s
LEFT JOIN Marks m ON s.StudentID = m.StudentID
GROUP BY s.StudentID, s.Name
HAVING COUNT(DISTINCT m.SubjectID) < (SELECT COUNT(*) FROM Subjects);
