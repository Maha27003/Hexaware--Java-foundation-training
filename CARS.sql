CREATE DATABASE CARS;
USE CARS;

drop table if exists Reports;
drop table if exists Evidence;
drop table if exists Incidents;
drop table if exists Suspects;
drop table if exists Victims;
drop table if exists Officers;
drop table if exists LawEnforcementAgencies;
CREATE TABLE LawEnforcementAgencies (
    AgencyID INT AUTO_INCREMENT PRIMARY KEY,
    AgencyName VARCHAR(100) NOT NULL,
    Jurisdiction VARCHAR(100),
    ContactInfo VARCHAR(150)
);

CREATE TABLE Officers (
    OfficerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BadgeNumber VARCHAR(20) UNIQUE,
    Ranking VARCHAR(50),
    ContactInfo VARCHAR(150),
    AgencyID INT,
    CONSTRAINT fk_officer_agency FOREIGN KEY (AgencyID)
        REFERENCES LawEnforcementAgencies(AgencyID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Victims (
    VictimID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    ContactInfo VARCHAR(150)
);

CREATE TABLE Suspects (
    SuspectID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    ContactInfo VARCHAR(150)
);

CREATE TABLE Incidents (
    IncidentID INT AUTO_INCREMENT PRIMARY KEY,
    IncidentType VARCHAR(100),
    IncidentDate DATETIME,
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6),
    Description TEXT,
    Status ENUM('Open', 'Closed', 'Under Investigation') DEFAULT 'Open',
    VictimID INT,
    SuspectID INT,
    OfficerID INT,
    CONSTRAINT fk_incident_victim FOREIGN KEY (VictimID)
        REFERENCES Victims(VictimID) ON DELETE SET NULL,
    CONSTRAINT fk_incident_suspect FOREIGN KEY (SuspectID)
        REFERENCES Suspects(SuspectID) ON DELETE SET NULL,
    CONSTRAINT fk_incident_officer FOREIGN KEY (OfficerID)
        REFERENCES Officers(OfficerID) ON DELETE SET NULL
);

CREATE TABLE Evidence (
    EvidenceID INT AUTO_INCREMENT PRIMARY KEY,
    Description TEXT,
    LocationFound VARCHAR(150),
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    IncidentID INT NOT NULL,
    CONSTRAINT fk_evidence_incident FOREIGN KEY (IncidentID)
        REFERENCES Incidents(IncidentID) ON DELETE CASCADE
);

CREATE TABLE Reports (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    IncidentID INT,
    ReportingOfficer INT,
    ReportDate DATETIME,
    ReportDetails TEXT,
    Status ENUM('Draft', 'Finalized') DEFAULT 'Draft',
    CONSTRAINT fk_report_incident FOREIGN KEY (IncidentID)
        REFERENCES Incidents(IncidentID) ON DELETE CASCADE,
    CONSTRAINT fk_report_officer FOREIGN KEY (ReportingOfficer)
        REFERENCES Officers(OfficerID) ON DELETE SET NULL
);
USE cars;

INSERT INTO LawEnforcementAgencies (AgencyName, Jurisdiction, ContactInfo) 
VALUES
('Metro Police Department', 'Downtown', 'metro.police@gmail.com'),
('City Crime Bureau', 'Uptown', 'crime.bureau@gmail.com'),
('Highway Patrol Unit', 'Highways', 'highway.patrol@gmailcom'),
('Cyber Crime Cell', 'Online Crimes', 'cybercrime@gmail.com'),
('Coastal Security Force', 'Coastal Area', 'coastal.force@gmail.com');

select *from LawEnforcementAgencies;

INSERT INTO Officers (FirstName, LastName, BadgeNumber, Ranking, ContactInfo, AgencyID) 
VALUES
('John', 'Smith', 'BN1001', 'Sergeant', 'john.smith@metro.com', 1),
('Emily', 'Clark', 'BN1002', 'Lieutenant', 'emily.clark@crime.com', 2),
('Robert', 'Brown', 'BN1003', 'Captain', 'robert.brown@highway.com', 3),
('Sophia', 'Lee', 'BN1004', 'Inspector', 'sophia.lee@cyber.com', 4),
('James', 'Walker', 'BN1005', 'Chief', 'james.walker@coastal.com', 5);

INSERT INTO Victims (FirstName, LastName, DateOfBirth, Gender, ContactInfo) 
VALUES
('Alice', 'Johnson', '1990-04-12', 'Female', 'alice.j@gmail.com'),
('David', 'Miller', '1985-07-23', 'Male', 'david.m@gmail.com'),
('Olivia', 'Davis', '1992-01-15', 'Female', 'olivia.d@gmail.com'),
('Liam', 'Wilson', '1988-10-09', 'Male', 'liam.w@gmailcom'),
('Emma', 'Moore', '1995-06-30', 'Female', 'emma.m@gmail.com');
 
 INSERT INTO Suspects (FirstName, LastName, DateOfBirth, Gender, ContactInfo)
 VALUES
('Michael', 'Taylor', '1980-03-22', 'Male', 'michael.t@gmail.com'),
('Sophia', 'Anderson', '1989-11-17', 'Female', 'sophia.a@gmail.com'),
('Ethan', 'Thomas', '1991-05-12', 'Male', 'ethan.t@gmail.com'),
('Isabella', 'Martin', '1993-08-25', 'Female', 'isabella.m@gmail.com'),
('Noah', 'Jackson', '1986-12-05', 'Male', 'noah.j@gmail.com');

INSERT INTO Incidents (IncidentType, IncidentDate, Latitude, Longitude, Description, Status, VictimID, SuspectID, OfficerID)
VALUES
('Theft', '2023-04-10', 34.052235, -118.243683, 'Bike theft at park', 'Open', 1, 1, 1),
('Fraud', '2023-05-15', 40.712776, -74.005974, 'Online banking fraud', 'Under Investigation', 3, 2, 4),
('Assault', '2023-06-20', 41.878113, -87.629799, 'Street altercation', 'Closed', 2, 3, 2),
('Burglary', '2023-07-01', 29.760427, -95.369804, 'Break-in at apartment', 'Under Investigation', 4, 4, 3),
('Robbery', '2023-08-05', 37.774929, -122.419418, 'Armed robbery in store', 'Open', 5, 5, 5);

INSERT INTO Evidence (Description, LocationFound, IncidentID) 
VALUES
('CCTV footage from park', 'Central Park Gate', 1),
('IP address logs', 'ISP Data Center', 2),
('Blood stains on pavement', '5th Avenue', 3),
('Broken window glass', 'Apartment 14B', 4),
('Cash bag and fingerprints', 'Downtown Store', 5);

INSERT INTO Reports (IncidentID, ReportingOfficer, ReportDate, ReportDetails, Status) 
VALUES
(1, 1, '2023-04-11', 'Preliminary report on theft', 'Draft'),
(2, 4, '2023-05-16', 'Fraud case forwarded to cyber cell', 'Finalized'),
(3, 2, '2023-06-21', 'Assault investigation completed', 'Finalized'),
(4, 3, '2023-07-02', 'Burglary report - evidence collected', 'Draft'),
(5, 5, '2023-08-06', 'Robbery incident confirmed', 'Finalized');

select *from officers;

select *from victims;

select *from suspects;

select *from incidents;

select *from evidence;

select *from reports;

