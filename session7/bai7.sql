create database bt7;
use bt7;
-- tao bang
CREATE TABLE Student (
    RN INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(20) NOT NULL UNIQUE,
    Age TINYINT NOT NULL
);
CREATE TABLE Test (
    TestID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(20) NOT NULL UNIQUE
);
CREATE TABLE StudentTest (
    RN INT NOT NULL,
    TestID INT NOT NULL,
    Date DATE,
    Mark FLOAT,
    PRIMARY KEY(RN, TestID),
    FOREIGN KEY(RN) REFERENCES Student(RN),
    FOREIGN KEY(TestID) REFERENCES Test(TestID)
);
-- chen du lieu
INSERT INTO Student (RN, Name, Age) VALUES 
(1, 'Nguyen Hong Ha', 20),
(2, 'Trung Ngoc Anh', 30),
(3, 'Tuan Minh', 25),
(4, 'Dan Truong', 22);
INSERT INTO Test (TestID, Name) VALUES 
(1, 'EPC'),
(2, 'DWMX'),
(3, 'SQL1'),
(4, 'SQL2');

INSERT INTO StudentTest (RN, TestID, Date, Mark) 
VALUES 
(1, 1, '2006-07-17', 8),
(1, 2, '2006-07-18', 5),
(1, 3, '2006-07-19', 7),
(2, 1, '2006-07-17', 7),
(2, 2, '2006-07-18', 4),
(2, 3, '2006-07-19', 2),
(3, 1, '2006-07-17', 10),
(3, 2, '2006-07-18', 1);
-- su dung alter de sua doi
ALTER TABLE Student
ADD CONSTRAINT chk_age CHECK (Age BETWEEN 15 AND 55);

ALTER TABLE StudentTest
ALTER COLUMN Mark SET DEFAULT 0;

ALTER TABLE StudentTest
ADD PRIMARY KEY (RN, TestID);

ALTER TABLE Test
ADD CONSTRAINT unique_test_name UNIQUE (Name);

SHOW CREATE TABLE Test;
ALTER TABLE Test
DROP INDEX unique_test_name;
-- 1
SELECT S.RN, S.Name AS StudentName, T.Name AS TestName, ST.Mark, ST.Date
FROM Student S
JOIN StudentTest ST ON S.RN = ST.RN
JOIN Test T ON ST.TestID = T.TestID;
-- 2
SELECT S.RN, S.Name AS StudentName
FROM Student S
LEFT JOIN StudentTest ST ON S.RN = ST.RN
WHERE ST.RN IS NULL;
-- 3
SELECT S.Name AS StudentName, T.Name AS TestName, ST.Mark
FROM Student S
JOIN StudentTest ST ON S.RN = ST.RN
JOIN Test T ON ST.TestID = T.TestID
WHERE ST.Mark < 5;
-- 4
SELECT S.Name AS StudentName, AVG(ST.Mark) AS AverageMark
FROM Student S
JOIN StudentTest ST ON S.RN = ST.RN
GROUP BY S.Name
ORDER BY AverageMark DESC;
-- 5
SELECT S.Name AS StudentName, AVG(ST.Mark) AS AverageMark
FROM Student S
JOIN StudentTest ST ON S.RN = ST.RN
GROUP BY S.Name
HAVING AVG(ST.Mark) = (
    SELECT MAX(AvgMark)
    FROM (
        SELECT AVG(Mark) AS AvgMark FROM StudentTest GROUP BY RN
    ) AS AvgMarks
);
-- 6
SELECT T.Name AS TestName, MAX(ST.Mark) AS HighestMark
FROM Test T
JOIN StudentTest ST ON T.TestID = ST.TestID
GROUP BY T.Name
ORDER BY T.Name;
-- 7
SELECT S.Name AS StudentName, T.Name AS TestName
FROM Student S
LEFT JOIN StudentTest ST ON S.RN = ST.RN
LEFT JOIN Test T ON ST.TestID = T.TestID;
-- 8
UPDATE Student
SET Age = Age + 1;
ALTER TABLE Student
ADD Status VARCHAR(10);
-- 9
UPDATE Student
SET Status = CASE
    WHEN Age < 30 THEN 'Young'
    ELSE 'Old'
END;

SELECT * FROM Student;
-- 10
SELECT S.Name AS StudentName, ST.Mark, ST.Date
FROM Student S
JOIN StudentTest ST ON S.RN = ST.RN
ORDER BY ST.Date ASC;
-- 11
SELECT S.Name AS StudentName, S.Age, AVG(ST.Mark) AS AverageMark
FROM Student S
JOIN StudentTest ST ON S.RN = ST.RN
WHERE S.Name LIKE 'T%' 
GROUP BY S.Name, S.Age
HAVING AVG(ST.Mark) > 4.5;
-- 12
SELECT S.RN, S.Name AS StudentName, S.Age, AVG(ST.Mark) AS AverageMark,
       RANK() OVER (ORDER BY AVG(ST.Mark) DESC) AS Rank1
FROM Student S
JOIN StudentTest ST ON S.RN = ST.RN
GROUP BY S.RN, S.Name, S.Age;
-- 13
ALTER TABLE Student MODIFY Name NVARCHAR(255);
-- 14
UPDATE Student
SET Name = CONCAT('Old ', Name)
WHERE Age > 20;

-- 15
UPDATE Student
SET Name = CONCAT('Young ', Name)
WHERE Age <= 20;
-- 16
DELETE FROM Test
WHERE TestID NOT IN (SELECT DISTINCT TestID FROM StudentTest);
-- 17
DELETE FROM StudentTest
WHERE Mark < 5;




