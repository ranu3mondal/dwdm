drop database dwdm2;
create database dwdm2;
use dwdm2;

create table customer_dim(
	CustomerId int primary key,
    CustomerName varchar(20),
    ShippingAddress varchar(20),
    BillingAddress varchar(20),
    Currency varchar(20)
);

create table product_dim(
	ProductId int primary key,
    ProductName varchar(20),
    ProductCategory varchar(20),
    ProductPrice int
);

create table promotion_dim(
	PromotionId int primary key,
    PromotionName varchar(20),
    PromotionType varchar(20),
    PromotionStartDate date,
    PromotionEndDate date
);

create table sales_rep_dim(
	SalesRepId int primary key, 
    SalesRepRegion varchar(20),
    SalesRepName varchar(20)
);

create table date_dim(
	DateId int primary key,
    Date date,
    Year int,
    Quarter int,
    Month varchar(20),
    DayOfWeek varchar(20)
);

create table order_fact(
	OrderId int primary key,
    CustomerId INT,
    OrderDateId int,
    ProductId INT,
	PromotionId INT,
	SalesRepId INT,
    ShipDateId INT,
	Quantity INT,
	GrossAmount DECIMAL(15, 2),
	DiscountAmount DECIMAL(15, 2),
	NetAmount DECIMAL(15, 2),
	Currency VARCHAR(3),
	foreign key (CustomerId) references customer_dim(CustomerId),
    foreign key (ProductId) references product_dim(ProductId),
	foreign key (PromotionId) references promotion_dim(PromotionId),
	foreign key (SalesRepId) references sales_rep_dim(SalesRepId),
    foreign key (OrderDateId) references date_dim(DateId),
	foreign key (ShipDateId) references date_dim(DateId)
);

insert into customer_dim(CustomerId, CustomerName, ShippingAddress, BillingAddress, Currency)
values(1, 'Harsh', 'asasdvs', 'pudsbe', 'INR'),
	(2, 'asdasdsafaef', 'asadfcas', 'asdvsas', 'USD'),
    (3, 'aeefeggt','rdhgsdt','rgdgt','INR');

insert into product_dim(ProductId, ProductName, ProductCategory, ProductPrice)
values(1, 'Laptop', 'Electronics', 12000),
		(2, 'phone', 'Electronics', 3500);

insert into promotion_dim(PromotionId, PromotionName, PromotionType, PromotionStartDate, PromotionEndDate)
values (1, 'Holiday Sale', 'Discount', '2024-12-01', '2024-12-31'),
		   (2, 'Back to School', 'Discount', '2024-08-01', '2024-08-31');

insert into sales_rep_dim(SalesRepId, SalesRepName, SalesRepRegion)
values(1, 'Alice Johnson', 'North'),
		   (2, 'Bob Brown', 'South');

insert into date_dim(DateId, Date, Year, Quarter, Month, DayOfWeek)
values(1, '2024-07-01', 2024, 3, 7, 'Monday'),
		   (2, '2024-07-02', 2024, 3, 7, 'Tuesday');

insert into order_fact(OrderId, CustomerId, OrderDateId, ProductId, PromotionId, SalesRepId, ShipDateId, Quantity, GrossAmount, DiscountAmount, NetAmount, Currency)
VALUES (1, 1, 1, 1, 1, 1, 2, 2, 2000, 200, 1800, 'INR'),
			(3, 1, 1, 1, 1, 1, 2, 2, 2000, 200, 1800, 'INR'),
		   (2, 2, 2, 2, 2, 2, 2, 3, 1500, 150, 1350, 'LOL');

SELECT 
    od.OrderId,
    c.CustomerName,
    p.ProductName,
    pr.PromotionName,
    sr.SalesRepName,
    od.Quantity,
    od.GrossAmount,
    od.DiscountAmount,
    od.NetAmount,
    od.Currency,
    d.Date AS OrderDate,
    ds.Date AS ShipDate,
    -- Calculate performance metrics
    (od.NetAmount / od.GrossAmount) * 100 AS DiscountPercentage,
    DATEDIFF(ds.Date, d.Date) AS ShippingDays
FROM 
    order_fact od
JOIN 
    customer_dim c ON od.CustomerId = c.CustomerId
JOIN 
    product_dim p ON od.ProductId = p.ProductId
JOIN 
    promotion_dim pr ON od.PromotionId = pr.PromotionId
JOIN 
    sales_rep_dim sr ON od.SalesRepId = sr.SalesRepId
JOIN 
    date_dim d ON od.OrderDateId = d.DateId
JOIN 
    date_dim ds ON od.ShipDateId = ds.DateId
ORDER BY 
    od.OrderId;
