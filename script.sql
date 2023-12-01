SHOW DATABASES;
drop database Suwapiyasa;

-- Creating the database
CREATE DATABASE Suwapiyasa;
USE Suwapiyasa;

-- Creating the tables
CREATE TABLE Staff(
    emp_no INT PRIMARY KEY,
    gender VARCHAR(50),
    phone VARCHAR(50) UNIQUE,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(50)
);
SELECT * FROM Staff;

CREATE TABLE Doctor (
    emp_no INT PRIMARY KEY,
    specialty VARCHAR(50),
    FOREIGN KEY (emp_no) REFERENCES Staff(emp_no) ON DELETE CASCADE
);
SELECT * FROM Doctor;

CREATE TABLE Head_Doctor (
    HD_no INT PRIMARY KEY,
    emp_no INT UNIQUE,
    FOREIGN KEY (emp_no) REFERENCES Staff(emp_no) ON DELETE CASCADE
);
SELECT * FROM Head_Doctor;

CREATE TABLE Surgeon (
    emp_no INT PRIMARY KEY,
    specialty VARCHAR(50),
    FOREIGN KEY (emp_no) REFERENCES Staff(emp_no) ON DELETE CASCADE
);
SELECT * FROM Surgeon;

CREATE TABLE Nurse (
    emp_no INT PRIMARY KEY,
    skill_type VARCHAR(50),
    experience VARCHAR(50),
    grade INT,
    FOREIGN KEY (emp_no) REFERENCES Staff(emp_no) ON DELETE CASCADE
);
SELECT * FROM Nurse;

CREATE TABLE Patient (
    patient_no INT PRIMARY KEY,
    name_initial VARCHAR(50),
    name_surname VARCHAR(50) NOT NULL,
    address VARCHAR(50),
    age INT CHECK (age >= 0),  -- Check age is non-negative
    phone_no VARCHAR(50) UNIQUE,
    blood_type VARCHAR(50) CHECK (blood_type IN ('A', 'B', 'AB', 'O')) -- Allow only specific blood types
);
SELECT * FROM Patient;

CREATE TABLE Allergies (
    allergy_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_no INT,
    allergies VARCHAR(50),
    FOREIGN KEY (patient_no) REFERENCES Patient(patient_no) ON DELETE CASCADE
);
SELECT * FROM Allergies;

CREATE TABLE Location (
    bed_no INT PRIMARY KEY,
    room_no INT,
    nursing_unit INT,
    patient_no INT,
    FOREIGN KEY (patient_no) REFERENCES Patient(patient_no) ON DELETE CASCADE
);
SELECT * FROM Location;

CREATE TABLE Medication (
    medication_code VARCHAR(50) PRIMARY KEY,
    name VARCHAR(50),
    cost INT,
    expiration_date DATE,
    quantity_ordered INT,
    quantity_on_hand INT CHECK (quantity_on_hand >= 0) -- Check quantity_on_hand is non-negative
);
SELECT * FROM Medication;

CREATE TABLE Patient_Reaction (
    reaction_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_no INT,
    medication_code VARCHAR(50),
    patient_reaction VARCHAR(50),
    FOREIGN KEY (patient_no) REFERENCES Patient(patient_no) ON DELETE CASCADE,
    FOREIGN KEY (medication_code) REFERENCES Medication(medication_code) ON DELETE CASCADE
);
SELECT * FROM Patient_Reaction;

CREATE TABLE Surgery (
    surgery_name VARCHAR(50),
    patient_no INT,
    date DATE,
    time TIME,
    category VARCHAR(50),
    PRIMARY KEY (surgery_name, patient_no),
    FOREIGN KEY (patient_no) REFERENCES Patient(patient_no) ON DELETE CASCADE
);
SELECT * FROM Surgery;

CREATE TABLE Theater (
    theater_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_no INT,
    surgery_name VARCHAR(50),
    FOREIGN KEY (patient_no) REFERENCES Patient(patient_no) ON DELETE CASCADE,
    FOREIGN KEY (surgery_name) REFERENCES Surgery(surgery_name) ON DELETE CASCADE
);
SELECT * FROM Theater;

CREATE TABLE Special_Needs_for_Surgery (
    surgery_name VARCHAR(50),
    patient_no INT,
    special_needs VARCHAR(50),
    PRIMARY KEY (surgery_name, patient_no),
    FOREIGN KEY (patient_no) REFERENCES Patient(patient_no) ON DELETE CASCADE,
    FOREIGN KEY (surgery_name) REFERENCES Surgery(surgery_name) ON DELETE CASCADE
);
SELECT * FROM Special_Needs_for_Surgery;

-- Inserting data into the Staff table
INSERT INTO Staff (emp_no, gender, phone, name, address)
VALUES (1, 'Male', '0714567890', 'Kasun Perera', '123 Main St'),
       (2, 'Female', '0776543210', 'Jayani Peiris', '456 School Ave'),
       (3, 'Male', '0755657812', 'Nimal Dias', '789 Nugegoda Rd'),
       (4, 'Female', '0776503210', 'Gayani Peiris', '432 High Level Rd'),
       (5, 'Female', '0775177802', 'Nadira Silva', '89 Nawala Rd'),
       (6, 'Male', '0712345678', 'Sunil Fernando', '567 Park Lane'),
       (7, 'Female', '0765432109', 'Rashmi Perera', '987 Lake View Rd'),
       (8, 'Male', '0723456781', 'Saman Jayawardena', '345 Forest Rd'),
       (9, 'Female', '0761234567', 'Anu Wijesuriya', '654 Mountain View Ave'),
       (10, 'Male', '0719876543', 'Ravi Silva', '876 River Side Rd'),
       (11, 'Male', '0754321987', 'Prasad Gunasekara', '234 Hillside Ave');
SELECT * FROM Staff;

-- Inserting data into the Doctor table
INSERT INTO Doctor (emp_no, specialty)
VALUES (1, 'Cardiology'),
       (2, 'Neurology'),
       (8, 'Dermatology');
SELECT * FROM Doctor;

-- Inserting data into the Head_Doctor table
INSERT INTO Head_Doctor (HD_no, emp_no)
VALUES (101, 1);
SELECT * FROM Head_Doctor;

-- Inserting data into the Surgeon table
INSERT INTO Surgeon (emp_no, specialty)
VALUES (3, 'Orthopedics'),
       (6, 'Cardiac Surgery'),
       (7, 'Neurosurgery');
SELECT * FROM Surgeon;

-- Inserting data into the Nurse table
INSERT INTO Nurse (emp_no, skill_type, experience, grade)
VALUES (4, 'ICU', '5 years', 3),
       (5, 'ER', '3 years', 2),
       (9, 'Pediatrics', '4 years', 2),
       (10, 'Operating Room', '6 years', 3),
       (11, 'Cardiology', '2 years', 1);
SELECT * FROM Nurse;

-- Inserting data into the Patient table
INSERT INTO Patient (patient_no, name_initial, name_surname, address, age, phone_no, blood_type)
VALUES (1001, 'S', 'Amal', '789 Samanala St', 35, '0715567190', 'A'),
       (1002, 'R', 'Viraj', '567 Pine Ave', 45, '0754587896', 'B'),
       (1003, 'L', 'Banuka', '321 flowers Ln', 28, '0781567190', 'AB'),
       (1004, 'T', 'Kamal', '456 Oak St', 50, '0712345678', 'O'),
       (1005, 'M', 'Saman', '123 Maple Ave', 32, '0767890123', 'A'),
       (1006, 'N', 'Kusum', '789 Rose Rd', 42, '0756789012', 'B'),
       (1007, 'S', 'Rani', '234 Cherry Ln', 38, '0790123456', 'O'),
       (1008, 'D', 'Nimali', '567 Elm St', 27, '0723456789', 'AB'),
       (1009, 'G', 'Sunil', '890 Birch Ave', 55, '0789012345', 'A'),
       (1010, 'R', 'Lalith', '678 Cedar Rd', 48, '0715678901', 'B'),
       (1011, 'P', 'Chathura', '345 Pine Ave', 30, '0761234567', 'O'),
       (1012, 'H', 'Aruna', '456 Oak St', 37, '0726789012', 'A'),
       (1013, 'K', 'Shanika', '123 Redwood Rd', 29, '0783456789', 'B');
SELECT * FROM Patient;

-- Inserting data into the Allergies table
INSERT INTO Allergies (patient_no, allergies)
VALUES (1001, 'Penicillin'),
       (1002, 'Peanuts'),
       (1003, 'Dust'),
       (1004, 'Shellfish'),
       (1005, 'Eggs'),
       (1006, 'Latex');
SELECT * FROM Allergies;

-- Inserting data into the Location table
INSERT INTO Location (bed_no, room_no, nursing_unit, patient_no)
VALUES (101, 1010, 2, 1002),
       (102, 2020, 1, 1003),
       (103, 3030, 3, 1004),
       (104, 4040, 2, 1005),
       (105, 5050, 1, 1006),
       (106, 6060, 3, 1007),
       (107, 7070, 2, 1008),
       (108, 8080, 1, 1009),
       (109, 9090, 3, 1010),
       (110, 10101, 2, 1011),
       (111, 11111, 1, 1012),
       (112, 12121, 3, 1013);
SELECT * FROM Location;

-- Inserting data into the Medication table
INSERT INTO Medication (medication_code, name, cost, expiration_date, quantity_ordered, quantity_on_hand)
VALUES ('MED001', 'Aspirin', 5, '2023-12-31', 100, 50),
       ('MED002', 'Ibuprofen', 8, '2024-06-30', 200, 100),
       ('MED003', 'Acetaminophen', 6, '2023-09-30', 150, 75),
       ('MED004', 'Amoxicillin', 10, '2024-03-15', 80, 40),
       ('MED005', 'Lisinopril', 7, '2023-11-30', 120, 60),
       ('MED006', 'Simvastatin', 9, '2023-10-31', 90, 45),
       ('MED007', 'Metformin', 5, '2024-02-28', 100, 50),
       ('MED008', 'Prednisone', 12, '2023-12-15', 70, 35),
       ('MED009', 'Levothyroxine', 8, '2024-01-31', 110, 55),
       ('MED010', 'Ciprofloxacin', 15, '2023-09-30', 60, 30),
       ('MED011', 'Diazepam', 7, '2024-05-31', 90, 45),
       ('MED012', 'Omeprazole', 6, '2024-04-30', 140, 70);
SELECT * FROM Medication;

-- Inserting data into the Patient_Reaction table
INSERT INTO Patient_Reaction (patient_no, medication_code, patient_reaction)
VALUES (1001, 'MED001', 'Mild headache'),
       (1002, 'MED001', 'Nausea'),
       (1003, 'MED002', 'Stomach upset'),
       (1004, 'MED003', 'No adverse reaction'),
       (1005, 'MED005', 'Dizziness');
SELECT * FROM Patient_Reaction;

-- Inserting data into the Surgery table
INSERT INTO Surgery (surgery_name, patient_no, date, time, category)
VALUES ('Appendectomy', 1002, '2023-08-10', '10:00:00', 'General'),
       ('Knee Replacement', 1003, '2023-09-15', '14:30:00', 'Orthopedic'),
       ('Hernia Repair', 1004, '2023-09-20', '09:45:00', 'General'),
       ('Spinal Fusion', 1005, '2023-10-05', '15:15:00', 'Orthopedic'),
       ('Gallbladder Removal', 1006, '2023-10-15', '11:30:00', 'General');
SELECT * FROM Surgery;

-- Inserting data into the Theater table
INSERT INTO Theater (theater_id, patient_no, surgery_name)
VALUES (01 , 1002, 'Appendectomy'),
       (02 , 1003, 'Knee Replacement'),
       (03, 1004, 'Hernia Repair'),
       (04, 1005, 'Spinal Fusion'),
       (05, 1006, 'Gallbladder Removal');
SELECT * FROM Theater;

-- Inserting data into the Special_Needs_for_Surgery table
INSERT INTO Special_Needs_for_Surgery (surgery_name, patient_no, special_needs)
VALUES ('Knee Replacement', 1003, 'Requires wheelchair'),
       ('Hernia Repair', 1004, 'None'),
       ('Spinal Fusion', 1005, 'Requires spinal brace'),
       ('Gallbladder Removal', 1006, 'None');
SELECT * FROM Special_Needs_for_Surgery;


-- Q1) Create the view
CREATE VIEW Patient_Surgery_View AS
SELECT
    p.patient_no,
    CONCAT(p.name_initial, ' ', p.name_surname) AS patient_name,
    CONCAT(l.bed_no, ', Room ', l.room_no) AS location,
    s.surgery_name,
    s.date AS surgery_date
FROM
    Patient p
JOIN
    Location l ON p.patient_no = l.patient_no
JOIN
    Surgery s ON l.patient_no = s.patient_no;
    
SELECT * FROM Patient_Surgery_View;

-- Q2) 
CREATE TABLE MedInfo (
    MedName VARCHAR(50) PRIMARY KEY,
    QuantityAvailable INT,
    ExpirationDate DATE
);
SELECT * FROM MedInfo;

-- insert 
DELIMITER //
CREATE TRIGGER Insert_Medication_Trigger
AFTER INSERT ON Medication
FOR EACH ROW
BEGIN
    INSERT INTO MedInfo (MedName, QuantityAvailable, ExpirationDate)
    VALUES (NEW.name, NEW.quantity_on_hand, NEW.expiration_date);
END;
//
DELIMITER ;

-- insert new value
INSERT INTO Medication (medication_code, name, cost, expiration_date, quantity_ordered, quantity_on_hand)
VALUES ('MED013', 'Celecoxib', 5, '2023-12-31', 110, 40);

SELECT * FROM MedInfo;

-- update
DELIMITER //
CREATE TRIGGER Update_Medication_Trigger
AFTER UPDATE ON Medication
FOR EACH ROW
BEGIN
    UPDATE MedInfo
    SET QuantityAvailable = NEW.quantity_on_hand, ExpirationDate = NEW.expiration_date
    WHERE MedName = NEW.name;
END;
//
DELIMITER ;

-- update MED013 with new data
UPDATE Medication
SET cost = 6, 
    expiration_date = '2024-12-31',
    quantity_ordered = 120,
    quantity_on_hand = 50
WHERE medication_code = 'MED013';

SELECT * FROM MedInfo;


-- delete
DELIMITER //
CREATE TRIGGER Delete_Medication_Trigger
AFTER DELETE ON Medication
FOR EACH ROW
BEGIN
    DELETE FROM MedInfo WHERE MedName = OLD.name;
END;
//
DELIMITER ;

-- delete the existing value (MED013)
DELETE FROM Medication
WHERE medication_code = 'MED013';

SELECT * FROM MedInfo;

-- Q3) - 421428941
-- Create the stored procedure
DELIMITER //
CREATE PROCEDURE Get_Medications_Count(
    IN patient_id INT,
    OUT medication_count INT
)
BEGIN
    SELECT COUNT(*) INTO medication_count
    FROM Patient_Reaction pr
    JOIN Medication m ON pr.medication_code = m.medication_code
    WHERE pr.patient_no = patient_id;
END;
//
DELIMITER ;

-- Execute the stored procedure and save the result in a session variable
SET @patient_id = 1003; 
CALL Get_Medications_Count(@patient_id, @medication_count);

-- Access the result from the session variable
SELECT @medication_count AS Medication_Count;

-- Q4) - 421428941
-- calculate remaining daus for expiration
DELIMITER //
CREATE FUNCTION DaysUntilExpiration(expiration_date DATE) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE days_remaining INT;
    SET days_remaining = DATEDIFF(expiration_date, CURDATE());
    RETURN days_remaining;
END;
//
DELIMITER ;

-- display information of which expiration date is less than 30 days
SELECT
    medication_code,
    name,
    cost,
    expiration_date,
    quantity_ordered,
    quantity_on_hand,
    DaysUntilExpiration(expiration_date) AS days_until_expiration
FROM
    Medication
WHERE
    DaysUntilExpiration(expiration_date) < 30;

-- Q5) - 421428941
-- Load Staff data from XML file
-- New data starting from emo_no 12 (12, 13, 14)
LOAD XML INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/staff_data.xml"
INTO TABLE Staff
ROWS IDENTIFIED BY '<row>';

-- Load Patient data from XML file
-- New data starting from patient_no 1014 (1014, 1015, 1015)
LOAD XML INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/patient_data.xml"
INTO TABLE Patient
ROWS IDENTIFIED BY '<row>';