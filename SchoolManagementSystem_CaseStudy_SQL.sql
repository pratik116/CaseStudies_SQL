CREATE DATABASE SCHOOL;
USE SCHOOL;

-- CREATING THE TABLES CourseMaster,StudentMaster,EnrollmentMaster
CREATE TABLE CourseMaster(
CID INT PRIMARY KEY,
CourseName VARCHAR(40) NOT NULL,
Category CHAR(1) CHECK(Category IN('B','M','A')),
Fee Smallmoney NOT NULL CHECK(Fee>=0)
);

CREATE TABLE StudentMaster(
SID TinyInt PRIMARY KEY,
StudentName VARCHAR(40) NOT NULL,
Origin Char(1) NOT NULL CHECK(Origin IN('L','F')),
Type Char(1) NOT NULL CHECK(Type IN('U','G'))
);

CREATE TABLE EnrollmentMaster(
CID INT NOT NULL,
SID Tinyint NOT NULL,
DOE DateTime NOT NULL,
FWF Bit NOT NULL,
Grade Char(1) CHECK(Grade IN('O','A','B','C')),
FOREIGN KEY(CID) REFERENCES CourseMaster(CID) ON DELETE CASCADE,
FOREIGN KEY(SID) REFERENCES StudentMaster(SID) ON DELETE CASCADE
);

--NOW INSERTING THE RANDOM RECORDS IN TABLES
INSERT INTO CourseMaster (CID,CourseName,Category,Fee) 
VALUES (1,'PYTHON','M',2000),
(2,'JAVA','A',2000),
(3,'C++','B',3000),
(4,'HTML','A',1500),
(5,'JAVASCRIPT','M',2000),
(6,'SQL','B',1000),
(7,'RUBY','A',3000),
(8,'CSS','M',1500),
(9,'PHP','B',2000),
(10,'SWIFT','A',1000);

SELECT * FROM CourseMaster;
 
INSERT INTO StudentMaster (SID,StudentName,Origin,Type) 
VALUES (11,'Pratik','L','G'), (12,'Suhana','F','G'),
(13,'Arjun','L','U'), (14,'Ananya','F','G'),
(15,'Aryan','L','U'), (16,'Isha','F','G'),
(17,'Kabir','L','U'), (18,'Avani','F','G'),
(19,'Vihaan','L','U'), (20,'Zara','F','G'),
(21,'Reyansh','L','U'), (22,'Aisha','F','G'),
(23,'Advait','L','U'), (24,'Saisha','F','G'), 
(25,'Rohan','L','U'), (26,'Ishita','F','G'), 
(27,'Vivaan','L','U'),(28,'Anika','F','G'), 
(29,'Kian','F','U'), (30,'Aanya','F','G');

SELECT * FROM StudentMaster;

INSERT INTO EnrollmentMaster ( SID,CID,DOE,FWF,Grade) 
VALUES (11,2,'2022-02-12',1,'A'),
(11,9,'2022-02-13',0,'B'),
(12,7,'2022-03-05',0,'B'),
(13,4,'2022-04-18',1,'O'),
(14,10,'2022-05-22',0, 'C'),
(15,5,'2022-06-10',1,'A'),
(16,9,'2022-07-15',0,'B'),
(17,3,'2022-08-29',1,'O'),
(18,6,'2022-09-14',0,'C'),
(17,9,'2022-08-29',1,'A'),
(19,8,'2022-10-08',1,'A'),
(20,1,'2022-11-03',0,'B'),
(21,10,'2022-12-19',1,'O'),
(22,5,'2023-01-25',0,'C'),
(23,3,'2023-02-08',1,'A'),
(24,7, '2023-03-12', 0,'B'),
(30,2, '2023-04-06', 1,'O');

SELECT CID,COUNT(*) FROM EnrollmentMaster GROUP BY CID;

-- QUESTIONS 
--1)
--HERE I AM INTENTIOALLY ENROLLING SOEM FORIEGN STUDENTS IN SPECIFIC COURSE SO THAT I WILL HAVE AT LEAST 1 RECORD FOR THIS QUERY
INSERT INTO EnrollmentMaster ( SID,CID,DOE,FWF,Grade) VALUES 
(12,4,'2022-03-05',0,'A'),
(14,4,'2023-03-05',0,'O'),
(16,4,'2023-03-10',1,'A'),
(18,4,'2023-10-05',1,'C'),
(20,4,'2023-11-15',0,'A'),
(22,4,'2022-07-25',1,'A'),
(24,4,'2022-03-15',0,'A'),
(26,4,'2022-11-09',1,'B'),
(28,4,'2022-01-05',0,'C'),
(30,4,'2022-02-05',1,'A'),
(14,6,'2022-06-15', 0,'O');

SELECT * FROM EnrollmentMaster;

SELECT [dbo].[EnrollmentMaster].[CID], COUNT(*) AS TOTAL_NO_OF_STUDENT
FROM [dbo].[EnrollmentMaster] INNER JOIN [dbo].[StudentMaster]
ON [dbo].[EnrollmentMaster].SID=[dbo].[StudentMaster].SID
GROUP BY [CID] HAVING COUNT(*)>10;

--2)
SELECT [dbo].[StudentMaster].StudentName  FROM [dbo].[StudentMaster] INNER JOIN [dbo].[EnrollmentMaster]
ON [dbo].[StudentMaster].SID=[dbo].[EnrollmentMaster].SID
WHERE [dbo].[EnrollmentMaster].CID NOT IN (( SELECT CID FROM [dbo].[CourseMaster] WHERE [CourseName]='JAVA'));

--3)
SELECT TOP(1) [dbo].[CourseMaster].CourseName, COUNT(*) AS_TOTAL FROM [dbo].[CourseMaster] INNER JOIN [dbo].[EnrollmentMaster]
ON ([dbo].[CourseMaster].CID=[dbo].[EnrollmentMaster].CID)
INNER JOIN [dbo].[StudentMaster] ON [dbo].[EnrollmentMaster].SID=[dbo].[StudentMaster].SID
WHERE [CourseMaster].[Category]='A' AND [dbo].[StudentMaster].Origin='F'
GROUP BY [dbo].[CourseMaster].CourseName;

--4)
--INTENTIONALLY INSERTING 1 RECORD FOR CURR MONTH ENROLLMENT IN BASIC COURSE
INSERT INTO EnrollmentMaster ( SID,CID,DOE,FWF,Grade) VALUES 
(12, 3, '2023-11-05', 0, 'A'); --CID=12 ( SUHANA )

SELECT [dbo].[StudentMaster].StudentName  FROM [dbo].[CourseMaster] INNER JOIN [dbo].[EnrollmentMaster]
ON ([dbo].[CourseMaster].CID=[dbo].[EnrollmentMaster].CID) INNER JOIN [dbo].[StudentMaster]
ON [dbo].[EnrollmentMaster].SID=[dbo].[StudentMaster].SID
WHERE [dbo].[CourseMaster].Category='B' AND MONTH([dbo].[EnrollmentMaster].DOE)=MONTH(GETDATE())
GROUP BY [dbo].[StudentMaster].StudentName;

--5)

INSERT INTO EnrollmentMaster ( SID,CID,DOE,FWF,Grade) VALUES 
(13, 3, '2023-10-05', 0, 'C');--ARJUN 

SELECT [dbo].[StudentMaster].StudentName  FROM [dbo].[CourseMaster] INNER JOIN [dbo].[EnrollmentMaster]
ON ([dbo].[CourseMaster].CID=[dbo].[EnrollmentMaster].CID)
INNER JOIN [dbo].[StudentMaster]
ON [dbo].[EnrollmentMaster].SID=[dbo].[StudentMaster].SID
WHERE [dbo].[StudentMaster].Type='U' AND [dbo].[StudentMaster].Origin='L' 
AND [dbo].[CourseMaster].Category='B' AND [dbo].[EnrollmentMaster].Grade='C'

--6)
-- THERE ARE AT LEAST 1 STUDENT IN ALL COURSE WHO HAS NOT ENROLLD IN MAY OF 2020 SO ALL COURSES WILL APPEAR IN RESULT
SELECT [dbo].[CourseMaster].CourseName
FROM [dbo].[CourseMaster] 
WHERE [dbo].[CourseMaster].CID IN (SELECT DISTINCT CID FROM [dbo].[EnrollmentMaster] 
WHERE SID IN 
(SELECT DISTINCT SID FROM [dbo].[EnrollmentMaster] 
WHERE MONTH([dbo].[EnrollmentMaster].DOE)<>'5' AND YEAR([dbo].[EnrollmentMaster].DOE)<>'2020'))


--7)
SELECT [dbo].[CourseMaster].CourseName,COUNT([dbo].[EnrollmentMaster].CID) AS NO_OF_ENROLLMENTS,
CASE
WHEN COUNT([dbo].[EnrollmentMaster].CID) >=50 THEN 'HIGH'
WHEN COUNT([dbo].[EnrollmentMaster].CID)BETWEEN 20 AND 50 THEN 'MEDIUM'
ELSE 'LOW'
END AS POPULAR
FROM  [dbo].[CourseMaster] JOIN [dbo].[EnrollmentMaster]
ON [dbo].[CourseMaster].CID=[dbo].[EnrollmentMaster].CID
GROUP BY [dbo].[CourseMaster].CourseName;

--8)

SELECT TOP(1) [dbo].[StudentMaster].StudentName,[dbo].[CourseMaster].CourseName,DATEDIFF(DAY, DOE, GETDATE()) AS AGE_OF_ER
FROM [dbo].[CourseMaster] INNER JOIN [dbo].[EnrollmentMaster]
ON ([dbo].[CourseMaster].CID=[dbo].[EnrollmentMaster].CID) INNER JOIN [dbo].[StudentMaster]
ON [dbo].[EnrollmentMaster].SID=[dbo].[StudentMaster].SID
ORDER BY DOE DESC;

--9)

INSERT INTO EnrollmentMaster ( SID,CID,DOE,FWF,Grade) VALUES 
(17, 6, '2023-11-05', 0, 'C'); --NOW KABIR ENROLL IN 3 BASIC COURSES AND HE IS LOCAL BOY


SELECT  [dbo].[StudentMaster].StudentName FROM [dbo].[CourseMaster] INNER JOIN [dbo].[EnrollmentMaster]
ON ([dbo].[CourseMaster].CID=[dbo].[EnrollmentMaster].CID)
INNER JOIN [dbo].[StudentMaster]
ON [dbo].[EnrollmentMaster].SID=[dbo].[StudentMaster].SID
WHERE [dbo].[StudentMaster].[Origin]='L' AND [dbo].[CourseMaster].Category='B'
GROUP BY [dbo].[StudentMaster].StudentName HAVING COUNT(*)=3;

--10)

SELECT [SID] FROM [dbo].[EnrollmentMaster] WHERE [CID]=4 ORDER BY SID
--SELECT * FROM [dbo].[StudentMaster]

--INTENTIONALLY ADDING ALL STUDENTS TO HTML COURSE ALREADY 11 STUDENTS ARE ENROLLED NOW WILL ADD REMAINING 

INSERT INTO EnrollmentMaster ( SID,CID,DOE,FWF,Grade) VALUES 
(11,4,'2023-11-05',1,'O'),
(15,4,'2023-10-15',0,'A'),
(17,4,'2020-01-05',1,'O'),
(19,4,'2023-11-05',1,'C'),
(21,4,'2022-01-05',0,'O'),
(23,4,'2023-11-05',1,'B'),
(25,4,'2023-08-05',1,'O'),
(27,4,'2021-11-05',0,'A'),
(29,4,'2023-11-05',1,'O');

SELECT [CourseName] FROM [dbo].[CourseMaster]
WHERE [CID] IN ( SELECT CID FROM [dbo].[EnrollmentMaster] GROUP BY CID 
HAVING COUNT([SID])=(SELECT COUNT(SID) FROM [dbo].[StudentMaster]))

--11)
SELECT DISTINCT [dbo].[StudentMaster].StudentName  FROM [dbo].[StudentMaster] INNER JOIN [dbo].[EnrollmentMaster]
ON [dbo].[StudentMaster].SID=[dbo].[EnrollmentMaster].SID
WHERE [Grade]='C' AND [FWF]=1;

--12)
INSERT INTO EnrollmentMaster ( SID,CID,DOE,FWF,Grade) VALUES 
(29, 6, '2023-11-05', 0, 'C');--foreign, undergraduate students who have got grade ‘C’ in any basic course(sql)//sudent name=kiran

SELECT  [dbo].[StudentMaster].StudentName
FROM [dbo].[CourseMaster] INNER JOIN [dbo].[EnrollmentMaster]
ON ([dbo].[CourseMaster].CID=[dbo].[EnrollmentMaster].CID)
INNER JOIN [dbo].[StudentMaster]
ON [dbo].[EnrollmentMaster].SID=[dbo].[StudentMaster].SID
WHERE [Origin]='F' AND [Type]='U' AND [Category]='B' AND [Grade]='C'

--13)
SELECT  [dbo].[CourseMaster].CourseName,COUNT(*) AS TOTAL_NO_OF_ENROLLMENTS
FROM [dbo].[CourseMaster] INNER JOIN [dbo].[EnrollmentMaster]
ON ([dbo].[CourseMaster].CID=[dbo].[EnrollmentMaster].CID)
WHERE MONTH(DOE)=MONTH(GETDATE())
GROUP BY [dbo].[CourseMaster].CourseName;