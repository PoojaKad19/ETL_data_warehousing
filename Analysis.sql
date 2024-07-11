
-----------------Analyze the profitability of sales in different income categories. Determine if certain income categories contribute more to overall profit----------------

SELECT
    l.Country,
    m.Year,
    pi.Income_Category,
    COALESCE(SUM(sf.Profit_avg), 0) AS TotalProfit
FROM
    SalesCumFact sf
LEFT JOIN
    PopIncomeDim pi ON sf.ProdDim_Id = pi.PopIncome_Id
LEFT JOIN
    LocationDim l ON sf.Location_Id = l.Location_Id
LEFT JOIN
    MonthDim m ON sf.MonthId = m.MonthId
GROUP BY
    l.Country, m.Year, pi.Income_Category




---------------Total sales in all years for all quarters country wise------------------

	
SELECT
    cd.customer_country AS Country,
    md.Year,
    md.Quarter,
    SUM(scf.Sales_avg) AS total_sales_all_years
FROM
    SalesCumFact scf
JOIN
    MonthDim md ON scf.MonthId = md.MonthId
JOIN
    CustomerDim cd ON scf.customerId = cd.customerId
GROUP BY
    cd.customer_country, md.Year, md.Quarter
ORDER BY
    cd.customer_country, md.Year, md.Quarter;




------------------Find the total sales profit across market segments--------------------------------------


SELECT * FROM crosstab(
  'SELECT 
      COALESCE(row_number() OVER (), 0) AS rowid,
      MarketDim.market_segment, 
      SUM(SalesFact.Profit) AS total_profit
   FROM MarketDim
   JOIN SalesFact ON MarketDim.Market_Id = SalesFact.Market_Id
   GROUP BY MarketDim.market_segment
   ORDER BY 2,1',
  'VALUES (''Consumer''::text), (''Corporate''::text), (''Home Office''::text)'
) AS ct ("rowid" int, "Consumer" numeric, "Corporate" numeric, "Home Office" numeric);

----------Analyze sales performance for different product categories in high-income versus low-income countries. Identify which products perform well in specific income brackets.------------------- 

SELECT
    CASE
        WHEN pid.Income_Category IN ('d1', 'd2', 'd3') THEN 'High Income'
        WHEN pid.Income_Category IN ('d4', 'd5', 'd6', 'd7', 'd8') THEN 'Low Income'
        ELSE 'Other'
    END AS IncomeBracket,
    pd.Product_Category,
    COALESCE(SUM(sf.Sales), 0) AS TotalSales
FROM
    ProductDim pd
LEFT JOIN
    SalesFact sf ON pd.ProdDim_Id = sf.ProdDim_Id
LEFT JOIN
    LocationDim ld ON sf.Location_Id = ld.Location_Id
LEFT JOIN
    PopIncomeDim pid ON sf.PopIncome_Id = pid.PopIncome_Id
GROUP BY
    IncomeBracket, pd.Product_Category
ORDER BY
    IncomeBracket, TotalSales DESC;

---------------------Examine the relationship between shipping costs, order priority. Identify if there's a correlation between faster shipping methods, higher order priority --------------------

SELECT
    sd.shipment_mode,
    od.Order_Priority,
    AVG(sf.Shipping_Cost) AS AverageShippingCost
FROM
    ShipmentFact sf
JOIN
    OrderDim od ON sf.OrderId = od.OrderId
JOIN
    ShipmentDim sd ON sf.Shipment_Id = sd.Shipment_Id
GROUP BY
    sd.shipment_mode, od.Order_Priority
ORDER BY
    sd.shipment_mode, od.Order_Priority;








