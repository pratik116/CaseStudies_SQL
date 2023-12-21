CREATE DATABASE CrimeReportingSystem;
USE CrimeReportingSystem;
--CASE STUDY-CRIME REPORTING SYSTEM
--CREATING TABELS



CREATE TABLE VICTIMS(
VictimID INT PRIMARY KEY,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
DateOfBirth DATE,
Gender CHAR(1) CHECK(Gender IN('M','F','O')),
PhoneNumber VARCHAR(10),
Address VARCHAR(50)

);

CREATE TABLE SUSPECTS(
SuspectID INT PRIMARY KEY,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
DateOfBirth DATE,
Gender CHAR(1) CHECK(Gender IN('M','F','O')),
PhoneNumber VARCHAR(10),
Address VARCHAR(50)

);

CREATE TABLE LAW_ENFORCEMENT_AGENCIES(
AgencyID INT PRIMARY KEY,
AgencyName VARCHAR(20) NOT NULL,
Jurisdiction VARCHAR(40),
Address VARCHAR(50),
Email VARCHAR(20),
)

CREATE TABLE INCIDENTS(
IncidentID INT PRIMARY KEY,
IncidentType VARCHAR(50),
IncidentDate DATE,
Location VARCHAR(50),
Description TEXT,
Status VARCHAR(20) CHECK(Status IN('Open', 'Closed', 'Under Investigation')),
VictimID INT,
SuspectId INT,
AgencyID INT,
FOREIGN KEY(VictimID) REFERENCES VICTIMS(VictimID) ON DELETE CASCADE,
FOREIGN KEY(SuspectId) REFERENCES SUSPECTS(SuspectID) ON DELETE CASCADE,
FOREIGN KEY(AgencyID) REFERENCES LAW_ENFORCEMENT_AGENCIES(AgencyID) ON DELETE CASCADE,

);

CREATE TABLE OFFICERS(
OfficerID INT PRIMARY KEY,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
BadgeNumber INT NOT NULL,
Rank VARCHAR(30) NOT NULL,
PhoneNumber VARCHAR(10),
Address VARCHAR(50),
AgencyID INT,
FOREIGN KEY(AgencyID) REFERENCES LAW_ENFORCEMENT_AGENCIES(AgencyID) ON DELETE CASCADE
);

CREATE TABLE EVIDENCE(
EvidenceID INT PRIMARY KEY,
Description TEXT,
Location_Found VARCHAR(30),
IncidentID INT,
FOREIGN KEY(IncidentID) REFERENCES INCIDENTS(IncidentID) ON DELETE CASCADE
);

CREATE TABLE REPORTS(
ReportID INT PRIMARY KEY,
IncidentID INT,
ReportingOfficerID INT,
ReportDate DATE,
FOREIGN KEY(IncidentID) REFERENCES INCIDENTS(IncidentID) ,
FOREIGN KEY(ReportingOfficerID) REFERENCES OFFICERS(OfficerID)

)

--NOW INSERTING DUMMY VALUES IN IT 

-- Insert 5 records with fictional Indian information
INSERT INTO VICTIMS (VictimID, FirstName, LastName, DateOfBirth, Gender, PhoneNumber, Address)
VALUES (1,'Pratik','Wani','2002-03-10','M','78901234','Star Street, Bangalore'),
(2,'Priya','Singh','1988-05-25','F','89012345','Moonrise Road, Kolkata'),
(3,'Rahul','Patil','1995-07-17','M','90123456','Rainbow Avenue, Pune'),
(4,'Deepika','Nair','1980-11-30','F','78945612','Sunrise Plaza, Chennai'),
(5,'Raj','Gupta','1998-03-12','M','98765403','Galaxy Lane, Hyderabad');

select * from VICTIMS;


INSERT INTO SUSPECTS (SuspectID, FirstName, LastName, DateOfBirth, Gender, PhoneNumber, Address)
VALUES(11,'Neha','Sharma','1990-09-18','F','87654321','Cloud Street, Mumbai'),
(12,'Vikram','Malhotra','1985-04-22','M','90876543','Silver Avenue, Delhi'),
(13,'Pooja','Joshi','1993-07-15','F','76543210','Sunshine Road, Kolkata'),
(14,'Arun','Chopra','1982-12-05','M','98765432','Starlight Lane, Bangalore'),
(15,'Sneha','Rajput','1997-02-28','F','87654321','Moonbeam Plaza, Pune');

select * from SUSPECTS;

INSERT INTO LAW_ENFORCEMENT_AGENCIES (AgencyID, AgencyName, Jurisdiction, Address, Email)
VALUES (21, 'City Police','Citywide','Main Street, Mumbai','citypolice@email.com'),
(22,'County Sheriff','Countywide','County Road, Chennai','csheriff@email.com'),
(23,'Highway Patrol','Statewide','State Avenue, Nashik','patrol@email.com'),
(24,'FBI','National','FBI Plaza, Delhi','fbi@email.com'),
(25,'Drug Enforcement','National','DEA Building, Nagpur','dea@email.com');

select * from LAW_ENFORCEMENT_AGENCIES;

INSERT INTO OFFICERS (OfficerID, FirstName, LastName, BadgeNumber, Rank, PhoneNumber, Address, AgencyID)
VALUES(31,'Amit','Patel',1617,'Inspector','7890123456','Ganges Street, Mumbai',21),
   (32,'Priya','Sharma',1819,'Sub-Inspector','8901234567','Yamuna Road, Delhi',22),
   (33,'Rahul','Gupta',2021,'Sergeant','9012345678','Brahmaputra Avenue, Kolkata',23),
    (34,'Deepa','Singh',2223,'Detective','9876543210','Jhelum Plaza, Chennai',24),
    (35,'Rajat','Kumar',2425,'Special Agent','8765432109','Jamuna Lane, Bangalore',25);

select * from OFFICERS;

INSERT INTO INCIDENTS (IncidentID, IncidentType, IncidentDate, Location, Description, Status, VictimID, SuspectID, AgencyID)
VALUES
(41,'Robbery','2022-01-15','Market Street, Mumbai','Robbery at a Bank','Closed', 1, 11, 21),
(42,'Assault','2020-02-22','City Park, Delhi','Assault in the park','Open', 2, 13, 23),
(43,'Kidnapping','2022-10-10','Shopping Mall,Kolkata','Child Kidnapping','Under Investigation', 3, 12,22),
(44,'Cybercrime','2023-10-05','Online Street, Chennai','Identity theft and hacking','Open', 4, 15, 24),
(45,'DrugS','2023-05-12','City Road, Bangalore','Illegal drug operation','Closed', 5, 14, 25);


select * from INCIDENTS;


INSERT INTO EVIDENCE (EvidenceID, Description, Location_Found, IncidentID)
VALUES (51,'Lipprints on a glass','Go-Down',41), (52,'FootPrints','Bedroom',42),
(53,'Knife','Kitchen',43), (54,'CCTV footage','Parking Lot',44), (55,'Drugs','Hall',45);

select * from EVIDENCE;

INSERT INTO REPORTS (ReportID, IncidentID, ReportingOfficerID, ReportDate)
VALUES (61,43,33,'2023-11-20'), (62,42,32,'2023-08-28'), (63,41,35,'2023-07-15'),
    (64,44,34,'2023-09-10'),(65,45,32,'2023-08-25');

select * from REPORTS;

