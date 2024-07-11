
DROP TABLE SalesFact;
CREATE TABLE SalesFact (
    Sales DECIMAL(10, 2),
    Quantity BIGINT,
    Discount DECIMAL(4, 2),
    Profit DECIMAL(10, 2),
    Unit_Price DECIMAL(10, 2),
    ProdDim_Id BIGINT,
    customerId BIGINT,
    shipment_id BIGINT,
    Market_Id BIGINT,
    OrderId BIGINT,
    Location_Id BIGINT,
    DateDim_Id BIGINT,
	PopIncome_Id BIGINT,
	FOREIGN KEY (ProdDim_Id) REFERENCES ProductDim(ProdDim_Id),
    FOREIGN KEY (customerId) REFERENCES CustomerDim(customerId),
    FOREIGN KEY (shipment_id) REFERENCES ShipmentDim(shipment_id),
    FOREIGN KEY (Market_Id) REFERENCES MarketDim(Market_Id),
    FOREIGN KEY (OrderId) REFERENCES OrderDim(OrderId),
    FOREIGN KEY (Location_Id) REFERENCES LocationDim(Location_Id),
    FOREIGN KEY (DateDim_Id) REFERENCES DateDim(DateDim_Id),
	FOREIGN KEY (PopIncome_Id) REFERENCES PopIncomeDim(PopIncome_Id)
);

DROP TABLE IncomeFact;
CREATE TABLE IncomeFact (
    PopIncome_Id BIGINT,
    Year_id BIGINT,
    GDP_PPC_USD2011 DECIMAL(20, 6),
    Population BIGINT,
    Gini_coeff DECIMAL(10, 9),
    Net_Income DECIMAL(10, 9),
	FOREIGN KEY (PopIncome_Id) REFERENCES PopIncomeDim(PopIncome_Id),
    FOREIGN KEY (Year_id) REFERENCES YearDim(Year_id)
);
SELECT * FROM IncomeFact;

DROP TABLE SalesCumFact;
CREATE TABLE SalesCumFact (
    Sales_avg DECIMAL(18, 6),
    Profit_avg DECIMAL(18, 6),
    Quantity_avg DECIMAL(18, 6),
    Discount_avg DECIMAL(18, 6),
    ProdDim_Id BIGINT,
    customerId BIGINT,
    shipment_id BIGINT,
    Market_Id BIGINT,
    OrderId BIGINT,
    Location_Id BIGINT,
    MonthId BIGINT,
	PopIncome_Id BIGINT,
	FOREIGN KEY (ProdDim_Id) REFERENCES ProductDim(ProdDim_Id),
    FOREIGN KEY (customerId) REFERENCES CustomerDim(customerId),
    FOREIGN KEY (shipment_id) REFERENCES ShipmentDim(shipment_id),
    FOREIGN KEY (Market_Id) REFERENCES MarketDim(Market_Id),
    FOREIGN KEY (OrderId) REFERENCES OrderDim(OrderId),
    FOREIGN KEY (Location_Id) REFERENCES LocationDim(Location_Id),
    FOREIGN KEY (MonthId) REFERENCES MonthDim(MonthId),
	FOREIGN KEY (PopIncome_Id) REFERENCES PopIncomeDim(PopIncome_Id)
);

CREATE TABLE ShipmentFact (
    Shipping_Cost DECIMAL(18, 6),
    shipment_date DATE,
    ProdDim_Id BIGINT,
    customerId BIGINT,
    DateDim_Id BIGINT,
    Location_Id BIGINT,
    shipment_id BIGINT,
    OrderId BIGINT,
	FOREIGN KEY (ProdDim_Id) REFERENCES ProductDim(ProdDim_Id),
    FOREIGN KEY (customerId) REFERENCES CustomerDim(customerId),
    FOREIGN KEY (shipment_id) REFERENCES ShipmentDim(shipment_id),
    FOREIGN KEY (OrderId) REFERENCES OrderDim(OrderId),
    FOREIGN KEY (Location_Id) REFERENCES LocationDim(Location_Id),
    FOREIGN KEY (DateDim_Id) REFERENCES DateDim(DateDim_Id)
);

