drop database DWDM_C2P2_1;
create database DWDM_C2P2_1;
use DWDM_C2P2_1;

CREATE TABLE Dim_Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Product_Description TEXT,
    Category VARCHAR(50),
    Brand VARCHAR(50),
    Price DECIMAL(10, 2)
);

INSERT INTO Dim_Products (Product_ID, Product_Name, Product_Description, Category, Brand, Price) VALUES
	(1, 'Product A', 'Small Product', 'Cosmetics', 'A',100 ),
	(2, 'Product B', 'Large Product', 'Laundary', 'B', 200),
	(3, 'Product C', 'Good Product', 'Bakery', 'A', 500),
	(4, 'Product D', 'Expensive', 'Study', 'B', 100),
	(5, 'Product E', 'Cheep', 'Laundary', 'A', 500);	

CREATE TABLE Dim_Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Customer_Address TEXT,
    Customer_Contact VARCHAR(50),
    Customer_Type VARCHAR(50)
);

INSERT INTO Dim_Customers (Customer_ID, Customer_Name, Customer_Address, Customer_Contact, Customer_Type)  VALUES 
	(1, 'Customer X','XYZ', '7234567890', 'Regular'),
    (2, 'Customer Y','PQR', '9987654321', 'Loyal'),
    (3, 'Customer Z','ABC', '6543210987', 'Regular'),
    (4, 'Customer P','EFG', '9321567890', 'Family'),
    (5, 'Customer Q','BCD', '8765432109', 'Loyal');

CREATE TABLE Dim_Return_Dates (
    Return_Date_ID INT PRIMARY KEY,
    Return_Date DATE,
    Return_Week INT,
    Return_Month VARCHAR(50),
    Return_Year INT,
    Return_Quarter INT
);

INSERT INTO Dim_Return_Dates (Return_Date_ID, Return_Date, Return_Week, Return_Month, Return_Year, Return_Quarter) VALUES 
	(1, '2023-06-24', 01, 'June', 2023,01),
    (2, '2023-03-15', 02, 'March', 2023,02),
    (3, '2023-08-06', 01, 'August', 2023,04),
    (4, '2023-12-29', 03, 'December', 2023,01),
    (5, '2023-01-11', 01, 'January', 2023,02);

CREATE TABLE Dim_Refund_Status (
    Refund_Status_ID INT PRIMARY KEY,
    Refund_Status VARCHAR(50)
);

INSERT INTO Dim_Refund_Status (Refund_Status_ID, Refund_Status) VALUES 
	(1, 'Pending'),
    (2, 'Paid'),
    (3, 'Paid'),
    (4, 'Pending'),
    (5, 'Pending');

CREATE TABLE Fact_Returns (
    Return_ID INT PRIMARY KEY,
    FK_Product_ID INT,
    FK_Customer_ID INT,
    FK_Return_Date_ID INT,
    FK_Refund_Status_ID INT,
    Refund_Amount DECIMAL(10, 2),
    Return_Quantity TEXT,
    Return_Reason TEXT,
    FOREIGN KEY (FK_Product_ID) REFERENCES Dim_Products(Product_ID),
    FOREIGN KEY (FK_Customer_ID) REFERENCES Dim_Customers(Customer_ID),
    FOREIGN KEY (FK_Return_Date_ID) REFERENCES Dim_Return_Dates(Return_Date_ID),
    FOREIGN KEY (FK_Refund_Status_ID) REFERENCES Dim_Refund_Status(Refund_Status_ID)
);

INSERT INTO Fact_Returns (Return_ID, FK_Product_ID, FK_Customer_ID, FK_Return_Date_ID, FK_Refund_Status_ID, Refund_Amount, Return_Quantity, Return_Reason) VALUES
	(1, 1, 1, 1, 1, 220.2, 'Good', 'no reason'),
    (2, 2, 2, 2, 2, 510, 'Worst', 'Defected product'),
    (3, 3, 3, 3, 3, 354, 'Avg', 'Bad Quality'),
    (4, 4, 4, 4, 4, 852, 'Good', 'Personal openion'),
    (5, 5, 5, 5, 5, 795, 'Avg', 'Faulty peice');

-- Example Query:
-- Find the total refund amount for a specific product
SELECT SUM(Fact_Returns.Refund_Amount)
FROM Fact_Returns
INNER JOIN Dim_Products ON Fact_Returns.FK_Product_ID = Dim_Products.Product_ID
WHERE Dim_Products.Product_Name = 'Product A';

SELECT Return_Quantity, COUNT(*) AS Return_Count
FROM Fact_Returns
GROUP BY Return_Quantity;
