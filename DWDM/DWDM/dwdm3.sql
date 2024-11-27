drop database dwdm3;
create database dwdm3;
use dwdm3;

create table Fact_BookManagement ( 
Author_Id int not null, 
Book_Id int not null,
Location_Id int not null, 
Publication_Id int not null, 
Cost int not null,
Quantity int not null, 
Profit int not null );

INSERT INTO Fact_BookManagement VALUES
('1', '7','2', '3', '1200', '3','1200'),
('2', '9','10', '5','1000', '2','650'),
('3', '6','5', '7','940', '1','200'),
('4', '1','8', '9','1150', '4','1600'),
('5', '10','7', '1','1300', '2','800'),
('6', '4','1', '10','1050', '5','1550'),
('7', '8','3', '8','930', '3','1090'),
('8', '2','4', '6','870', '1','170'),
('9', '5','6', '4','800', '2','600'),
('10', '3','9', '2','900', '3','900');

select * from Fact_BookManagement;

create table Dim_Author( 
Author_Id int not null,
Author_Name varchar(30) not null, 
Authour_Age int not null, 
Author_Country varchar(30) not null, 
primary key(Author_Id)
);

INSERT INTO Dim_Author VALUES
('1', 'Amit Garg','72','India'),
('2', 'JK Rowling','78','UK'),
('3', 'HC Verma','80','India'),
('4', 'Cao Xueqin','42','China'),
('5', 'RK Narayan','65','India'),
('6', 'Charles Dickens','59','UK'),
('7', 'CS Lewis','57','UK'),
('8', 'Sanjesh Pawale','48','India'),
('9', 'DC Pandey','76','India'),
('10', 'Dan Brown','63','USA');

select * from Dim_Author;

create table Dim_Location ( 
Location_Id int not null,
Location_Country varchar(30) not null, 
primary key(Location_Id)
);

INSERT INTO Dim_Location VALUES
('1', 'India'),
('2', 'UK'),
('3', 'USA'),
('4', 'India'),
('5', 'UK'),
('6', 'India'),
('7', 'USA'),
('8', 'USA'),
('9', 'India'),
('10', 'UK');

select * from Dim_Location;

create table Dim_Book ( 
Book_Id int not null,
Book_Type varchar(30) not null, 
primary key(Book_Id)
);

INSERT INTO Dim_Book VALUES
('1', 'Horror'),
('2', 'Fantasy'),
('3', 'Mystery'),
('4', 'Classics'),
('5', 'Fiction'),
('6', 'Adventure'),
('7', 'Educational'),
('8', 'Historical'),
('9', 'Poetry'),
('10', 'Comedy');

select * from Dim_Book;

create table Dim_Publication ( 
Publication_Id int not null,
Publication_Name varchar(30) not null, 
Publication_Country varchar(30) not null, 
Publication_Year int not null,
primary key(Publication_Id)
);

INSERT INTO Dim_Publication VALUES
('1', 'Readers Zone','UK', '2004'),
('2', 'Arihant','India', '1999'),
('3', 'Art Book','India', '2006'),
('4', 'Jaico Publishing House','India', '1995'),
('5', 'Course Technology','USA', '1993'),
('6', 'Pan Macmillan','India', '1991'),
('7', 'Penguin Books','UK', '2001'),
('8', 'HarperCollins','UK', '1994'),
('9', 'Simon & Schuster','USA', '1990'),
('10', 'Scholastic','USA', '2002');

select * from Dim_Publication;

SELECT Location_Country as 'Location- Country', Quantity, Profit 'Profit per Book Location' from Fact_BookManagement
join 
Dim_Location on Fact_BookManagement.Location_Id =
Dim_Location.Location_Id
group by Location_Country, Quantity, Profit;


SELECT Author_Name as 'Author Name', Quantity, Profit 'Profit per Book Author' from Fact_BookManagement join Dim_Author on Fact_BookManagement.Author_Id =
Dim_Author.Author_Id
group by Author_Name, Quantity, Profit;


SELECT Publication_Name as
'Publication Name', Quantity, Profit 'Profit per Book Publication' from Fact_BookManagement
join Dim_Publication on Fact_BookManagement.Publication_Id
= Dim_Publication.Publication_Id group by Publication_Name, Quantity, Profit;
