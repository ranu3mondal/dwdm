DROP DATABASE dwdm4;
CREATE DATABASE dwdm4;
USE dwdm4;

-- Property Dimension Table
CREATE TABLE Property (
    Property_ID INT PRIMARY KEY,
    Property_Type VARCHAR(50),
    Bedrooms INT,
    Bathrooms INT,
    Square_Feet INT,
    Year_Built INT,
    Furnished BOOLEAN,
    Owner_ID INT
);
INSERT INTO Property VALUES 
(1, 'Apartment', 3, 2, 1500, 2010, TRUE, 1),
(2, 'House', 4, 3, 2500, 2005, FALSE, 2);

-- Tenant Dimension Table
CREATE TABLE Tenant (
    Tenant_ID INT PRIMARY KEY,
    Tenant_Name VARCHAR(100),
    Contact_Info VARCHAR(100),
    Occupation VARCHAR(50),
    Rental_History VARCHAR(255)
);
INSERT INTO Tenant VALUES 
(1, 'John Doe', 'john@example.com', 'Software Engineer', 'Previously rented an apartment.'),
(2, 'Jane Smith', 'jane@example.com', 'Doctor', 'Previously rented a house.');

-- Owner Dimension Table
CREATE TABLE Owner (
    Owner_ID INT PRIMARY KEY,
    Owner_Name VARCHAR(100),
    Contact_Info VARCHAR(100),
    Number_of_Properties INT
);
INSERT INTO Owner VALUES 
(1, 'Michael Johnson', 'michael@owner.com', 3),
(2, 'Sarah Brown', 'sarah@owner.com', 5);

-- Agent Dimension Table
CREATE TABLE Agent (
    Agent_ID INT PRIMARY KEY,
    Agent_Name VARCHAR(100),
    Agency VARCHAR(100),
    Commission_Rate DECIMAL(5, 2)
);
INSERT INTO Agent VALUES 
(1, 'Alice Williams', 'Top Realty', 5.00),
(2, 'Bob Johnson', 'Prime Property', 4.50);

-- Time Dimension Table
CREATE TABLE Time (
    Time_ID INT PRIMARY KEY,
    Day INT,
    Month INT,
    Quarter INT,
    Year INT
);
INSERT INTO Time VALUES 
(1, 15, 9, 3, 2024),
(2, 1, 10, 4, 2024);

-- Geography Dimension Table
CREATE TABLE Geography (
    Geography_ID INT PRIMARY KEY,
    City VARCHAR(50),
    Region VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50)
);
INSERT INTO Geography VALUES 
(1, 'New York', 'Northeast', 'NY', 'USA'),
(2, 'Los Angeles', 'West Coast', 'CA', 'USA');

-- Rental Transactions Fact Table
CREATE TABLE Rental_Transactions_Fact (
    Rental_Transaction_ID INT PRIMARY KEY,
    Property_ID INT,
    Tenant_ID INT,
    Owner_ID INT,
    Agent_ID INT,
    Time_ID INT,
    Geography_ID INT,
    Rental_Amount DECIMAL(10, 2),
    Security_Deposit DECIMAL(10, 2),
    Commission DECIMAL(10, 2),
    Maintenance_Cost DECIMAL(10, 2),
    Lease_Start_Date DATE,
    Lease_End_Date DATE,
    Rental_Status VARCHAR(50),
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID),
    FOREIGN KEY (Tenant_ID) REFERENCES Tenant(Tenant_ID),
    FOREIGN KEY (Owner_ID) REFERENCES Owner(Owner_ID),
    FOREIGN KEY (Agent_ID) REFERENCES Agent(Agent_ID),
    FOREIGN KEY (Time_ID) REFERENCES Time(Time_ID),
    FOREIGN KEY (Geography_ID) REFERENCES Geography(Geography_ID)
);
INSERT INTO Rental_Transactions_Fact VALUES 
(1, 1, 1, 1, 1, 1, 1, 3000.00, 500.00, 150.00, 100.00, '2024-09-15', '2025-09-15', 'Rented'),
(2, 2, 2, 2, 2, 2, 2, 4000.00, 700.00, 180.00, 150.00, '2024-10-01', '2025-10-01', 'Available');
