-- Create the database and use it
CREATE DATABASE healthcare;
USE healthcare;

-- Creating Dimension Tables
CREATE TABLE DimPatients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender CHAR(1),
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15)
);

INSERT INTO DimPatients VALUES
(1, 'John Doe', 35, 'M', '123 Main St', '123-456-7890'),
(2, 'Jane Smith', 29, 'F', '456 Oak Ave', '987-654-3210'),
(3, 'Bob Johnson', 50, 'M', '789 Pine Rd', '555-666-7777'),
(4, 'Alice Green', 40, 'F', '101 Maple St', '321-654-0987'),
(5, 'Michael Brown', 60, 'M', '202 Birch St', '222-333-4444'),
(6, 'Nancy Wilson', 45, 'F', '303 Cedar St', '444-555-6666'),
(7, 'Kevin Black', 55, 'M', '404 Spruce St', '777-888-9999');

CREATE TABLE DimDoctors (
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR(100),
    Specialization VARCHAR(50),
    ContactNumber VARCHAR(15),
    Email VARCHAR(100)
);

INSERT INTO DimDoctors VALUES
(1, 'Dr. Alice Brown', 'Cardiology', '111-222-3333', 'alice.brown@hospital.com'),
(2, 'Dr. Chris White', 'Neurology', '444-555-6666', 'chris.white@hospital.com'),
(3, 'Dr. David Green', 'Orthopedics', '555-666-7777', 'david.green@hospital.com'),
(4, 'Dr. Emily Black', 'Pediatrics', '666-777-8888', 'emily.black@hospital.com'),
(5, 'Dr. Frank Blue', 'Oncology', '777-888-9999', 'frank.blue@hospital.com'),
(6, 'Dr. Grace Yellow', 'Dermatology', '888-999-0000', 'grace.yellow@hospital.com'),
(7, 'Dr. Henry Orange', 'Endocrinology', '999-000-1111', 'henry.orange@hospital.com');

CREATE TABLE DimDepartments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

INSERT INTO DimDepartments VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics'),
(4, 'Pediatrics'),
(5, 'Oncology'),
(6, 'Dermatology'),
(7, 'Endocrinology');

CREATE TABLE DimTreatments (
    TreatmentCode VARCHAR(10) PRIMARY KEY,
    TreatmentName VARCHAR(100),
    TreatmentDescription VARCHAR(255)
);

INSERT INTO DimTreatments VALUES
('T001', 'Bypass Surgery', 'Cardiac Bypass Surgery'),
('T002', 'MRI Scan', 'Magnetic Resonance Imaging'),
('T003', 'Knee Replacement', 'Surgical Knee Replacement'),
('T004', 'Vaccination', 'Routine Immunization'),
('T005', 'Chemotherapy', 'Cancer Treatment'),
('T006', 'Skin Biopsy', 'Dermatological Skin Examination'),
('T007', 'Insulin Therapy', 'Diabetes Treatment');

CREATE TABLE DimDiagnosis (
    DiagnosisCode VARCHAR(10) PRIMARY KEY,
    DiagnosisName VARCHAR(100),
    DiagnosisDescription VARCHAR(255)
);
INSERT INTO DimDiagnosis VALUES
('D001', 'Heart Attack', 'Myocardial Infarction'),
('D002', 'Migraine', 'Severe Headache'),
('D003', 'Arthritis', 'Joint Inflammation'),
('D004', 'Flu', 'Influenza Virus'),
('D005', 'Lung Cancer', 'Malignant Lung Tumor'),
('D006', 'Eczema', 'Chronic Skin Condition'),
('D007', 'Diabetes', 'Metabolic Disease');
-- Creating Fact Tables
CREATE TABLE FactPatientVisits (
    VisitID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    DepartmentID INT,
    VisitDate DATE,
    DiagnosisCode VARCHAR(10),
    TreatmentCode VARCHAR(10),
    FOREIGN KEY (PatientID) REFERENCES DimPatients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES DimDoctors(DoctorID),
    FOREIGN KEY (DepartmentID) REFERENCES DimDepartments(DepartmentID),
    FOREIGN KEY (DiagnosisCode) REFERENCES DimDiagnosis(DiagnosisCode),
    FOREIGN KEY (TreatmentCode) REFERENCES DimTreatments(TreatmentCode)
);
INSERT INTO FactPatientVisits VALUES
(1, 1, 1, 1, '2024-08-01', 'D001', 'T001'),
(2, 2, 2, 2, '2024-08-03', 'D002', 'T002'),
(3, 3, 3, 3, '2024-08-05', 'D003', 'T003'),
(4, 4, 4, 4, '2024-08-07', 'D004', 'T004'),
(5, 5, 5, 5, '2024-08-09', 'D005', 'T005'),
(6, 6, 6, 6, '2024-08-11', 'D006', 'T006'),
(7, 7, 7, 7, '2024-08-13', 'D007', 'T007');

CREATE TABLE FactBilling (
    BillingID INT PRIMARY KEY,
    PatientID INT,
    VisitID INT,
    TotalAmount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    BillingDate DATE,
    FOREIGN KEY (PatientID) REFERENCES DimPatients(PatientID),
    FOREIGN KEY (VisitID) REFERENCES FactPatientVisits(VisitID)
);

INSERT INTO FactBilling VALUES
(1, 1, 1, 50000.00, 'Credit Card', '2024-08-02'),
(2, 2, 2, 3000.00, 'Cash', '2024-08-04'),
(3, 3, 3, 45000.00, 'Insurance', '2024-08-06'),
(4, 4, 4, 200.00, 'Debit Card', '2024-08-08'),
(5, 5, 5, 150000.00, 'Bank Transfer', '2024-08-10'),
(6, 6, 6, 2500.00, 'Cash', '2024-08-12'),
(7, 7, 7, 10000.00, 'Insurance', '2024-08-14');