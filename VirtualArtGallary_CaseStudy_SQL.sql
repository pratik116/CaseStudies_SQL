CREATE DATABASE VIRTUAL_ART_GALLARY;
USE VIRTUAL_ART_GALLARY;

--CASE STUDY-VIRTUAL ART GALLARY
--CREATING THE TABLES

CREATE TABLE ARTIST(
ArtistID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Biography TEXT,
BirthDate DATE,
Nationality VARCHAR(40),
Website VARCHAR(50),
PhoneNo VARCHAR(13),
);


CREATE TABLE GALLERY(
GalleryID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Description TEXT,
Location VARCHAR(50),
CuratorID INT REFERENCES ARTIST(ArtistID) ON DELETE CASCADE,
OpeningHours VARCHAR(30)

);


CREATE TABLE ARTWORK(
ArtworkID INT PRIMARY KEY,
Title VARCHAR(50),
Description TEXT,
CreationDate DATE,
Medium VARCHAR(30),
ImageURL VARCHAR(30),
ArtistID INT,
GalleryID INT,
FOREIGN KEY(ArtistID) REFERENCES Artist(ArtistID) ,
FOREIGN KEY(GalleryID) REFERENCES GALLERY(GalleryID) ON DELETE CASCADE,

);

CREATE TABLE USERS(
UserID INT PRIMARY KEY,
Username VARCHAR(30) NOT NULL,
Password VARCHAR(30),
Email VARCHAR(30),
First_Name VARCHAR(30) NOT NULL,
Last_Name VARCHAR(30) NOT NULL,
Date_of_Birth DATE,
Profile_Picture BINARY,
FavoriteArtworkID INT REFERENCES ARTWORK(ArtworkID) ON DELETE CASCADE

);

--NOW INSERTING THE DUMMY RECORDS

INSERT INTO ARTIST (ArtistID, Name, Biography, BirthDate, Nationality, Website, PhoneNo)
VALUES  (1,'Amit Sharma','Sketch Artist','1980-05-15','Indian','http://www.amitsharma.com','9876543210'),
(2,'Priya Patel','Talented painter','1992-08-22','Indian','http://www.priyapatelart.com','8765432109'),
(3,'Rajiv Kapoor','Sculptor','1975-11-10','Indian','http://www.rajivkapoorstudio.com','7654321098'),
(4,'Meera Khan','Photographer','1988-03-28','Indian','http://www.meerakhanphotography.com','6543210987'),
(5,'Ananya Verma','Cubism Artist','1995-06-17','Indian','http://www.ananyavermaartistry.com','8765432101');

SELECT * FROM ARTIST;



INSERT INTO GALLERY (GalleryID, Name, Description, Location, CuratorID, OpeningHours)
VALUES(11,'Saraswati Art Gallery', 'Contemporary Indian art', 'Mumbai', 1, '10:00 AM - 6:00 PM'),
(12,'Ganesha Studios', 'Modern Indian art', 'Delhi', 3, '9:00 AM - 7:00 PM'),
(13,'Krishna Art Space', 'Diverse artworks', 'Bangalore', 2, '11:00 AM - 8:00 PM'),
(14,'Vishnu Gallery', 'Indian sculpture', 'Chennai', 4, '10:30 AM - 5:30 PM'),
(15,'Durga Fine Arts', 'Indian photography and Digital art', 'Kolkata', 5, '12:00 PM - 9:00 PM');


SELECT * FROM GALLERY;


INSERT INTO ARTWORK (ArtworkID, Title, Description, ArtistID, GalleryID, CreationDate, Medium)
VALUES (1,'Sunrise','Landscape capturing the sunrise',1,15,'2020-07-15','Canvas'),
 (2,'Beauty in Colors','Diverse Indian cultures', 2, 14,'2021-02-28','On Paper'),
 (3,'Sculpted Coolness','Sculpture of Indian art', 3, 13,'2019-11-05','Marble'),
 (4,'Travel The World','Photograph showcasing the life in India',4,11,'2022-04-10','Digital Print'),
 (5,'Expressions of Nature','A series of digital artworks',5,12,'2023-01-20','Digital Art');

SELECT * FROM ARTWORK;


INSERT INTO USERS (UserID, Username, Password, Email, First_Name, Last_Name, Date_of_Birth, Profile_Picture, FavoriteArtworkID)
VALUES (31,'Amit_1985','password@123','ab@gmail.com', 'Amit', 'Sharma', '2000-02-10', NULL, 1),
(32,'PriyaArtLover','secu@repass','bc@yahoo.com', 'Priya', 'Patel', '2001-12-18', NULL, 2),
 (33,'RajivSculptor','pass@1234','cv@hotmail.com', 'Rajiv', 'Kapoor', '2002-03-25', NULL, 3),
(34,'MeeraPhotoPro','my@secret','vb@gmail.com', 'Meera', 'Khan', '1999-05-03', NULL, 4),
(35,'ArtExplorer123','@exploreart','dt@gmail.com', 'Ananya', 'Verma', '1987-09-20', NULL, 5),
(36,'NYCArtFan','123@nyfan123','mt@gmail.com', 'John', 'Snow', '1980-01-15', NULL, 4),
(37,'Californian','dreamer45','dr@yahoo.com', 'Emily', 'Cena', '1992-06-08', NULL, 5);


