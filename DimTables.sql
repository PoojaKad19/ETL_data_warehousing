-------------creating dimension tables-----------------
drop TABLE ProductDim;
CREATE TABLE ProductDim (
	ProdDim_Id INT PRIMARY KEY,
    Product_id VARCHAR(20) NOT NULL,
    Product_name VARCHAR(255) NOT NULL,
    Product_category VARCHAR(50),
    Product_subcategory VARCHAR(50),
    Effective_From DATE,
    Effective_To DATE,
    CurrentFlag BOOLEAN
);

CREATE TABLE ShipmentDim (
    shipment_id INT PRIMARY KEY,
    shipment_date DATE,
    shipment_mode VARCHAR(50),
    Effective_From DATE,
    Effective_To DATE,
    CurrentFlag BOOLEAN
);
drop TABLE OrderDim;
CREATE TABLE OrderDim (
	OrderId INT PRIMARY KEY,
    order_id VARCHAR(20),
    order_date DATE,
    order_priority VARCHAR(20)
);

CREATE TABLE MarketDim (
    Market_Id INT PRIMARY KEY,
    market_segment VARCHAR(50),
    market_category VARCHAR(50),
    market_region VARCHAR(50)
);
drop TABLE CustomerDim;
CREATE TABLE CustomerDim (
	customerId INT PRIMARY KEY,
    customer_id VARCHAR(20),
    customer_name VARCHAR(255),
    customer_city VARCHAR(50),
    customer_state VARCHAR(50),
    customer_country VARCHAR(50),
    Effective_From DATE,
    Effective_To DATE,
    CurrentFlag BOOLEAN
);
SELECT * FROM LocationDim;

CREATE TABLE LocationDim (
    Location_Id INT PRIMARY KEY,
    Region VARCHAR(50),
    City VARCHAR(255),
    State VARCHAR(50),
    Country VARCHAR(50)
);

CREATE TABLE DateDim (
    DateDim_Id INT PRIMARY KEY,
    Date DATE,
    Year INT,
    Month INT,
    Day_of_Week VARCHAR(20),
    Week_Number INT
);

CREATE TABLE YearDim (
    Year_id INT PRIMARY KEY,
    Year INT,
    _merge VARCHAR(20)
);

CREATE TABLE MonthDim (
    MonthId INT PRIMARY KEY,
    Month INT,
    Year INT,
    Quarter INT
);

CREATE TABLE PopIncomeDim (
    PopIncome_Id INT PRIMARY KEY,
    Income_Category VARCHAR(10),
    PopRegion_number INT,
    PopCountry VARCHAR(50),
    ISO VARCHAR(3),
    Effective_From DATE,
    Effective_To DATE,
    CurrentFlag BOOLEAN
);