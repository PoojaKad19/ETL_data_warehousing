# ETL_data_warehousing

This project is about analyzing Global online Sales Data along with global population income Statistics using data warehousing.

## Business Questions

1. Analyze the profitability of sales in different income categories. Determine if certain income categories contribute more to overall profit.
2. Identify and rank countries based on their sales performance OR Total sales in all years for all quarters country wise.
3. Find the sales profit across market segments.
4. Analyze sales performance for different product categories in high-income versus low-income countries. Identify which products perform well in specific income brackets.
5. Examine the relationship between shipping costs, order priority. Identify if there's a correlation between faster shipping methods, higher order priority.

## Data Flow

![image](https://github.com/user-attachments/assets/f8602bba-2622-4733-9dd4-9b2273da8b62)


## Star schema – dimensional model

![image](https://github.com/user-attachments/assets/d9477f8b-4545-45ca-8266-db5c092bdf93)


![image](https://github.com/user-attachments/assets/3194f768-d042-432c-90b4-19bc0fbd0197)

![image](https://github.com/user-attachments/assets/c165216c-d320-41dd-92a9-c22dbdca7bb7)

![image](https://github.com/user-attachments/assets/f4656d86-a546-4d6e-b763-0c8315d29f51)

![image](https://github.com/user-attachments/assets/62a5b7f4-5b79-4566-a491-468f812bdbac)

## Data Analysis and Visualization

1. Analyze the profitability of sales in different income categories. Determine if certain income categories contribute more to overall profit. (SalesCumFact + PopIncomeDim  + LocationDim + MonthDim/YearDim)

   ![image](https://github.com/user-attachments/assets/68b572d3-ef19-42c6-935a-a7b5f46f4c36)

2. Identify and rank countries based on their sales performance OR Total sales in all years for all quarters country wise (SalesCumFact, MonthDim + LocationDim)

   ![image](https://github.com/user-attachments/assets/28550206-9c0a-477d-b1ad-808f4a19571b)

3. Find the sales profit across market segments (SalesFact + MarketDim)

   ![image](https://github.com/user-attachments/assets/b7f1137c-f0a6-4624-bd39-5de4c80e055e)

4. Analyze sales performance for different product categories in high-income versus low-income countries. Identify which products perform well in specific income brackets. (PopIncomeDim, ProductDim, SalesFact + LocationDim)

   ![image](https://github.com/user-attachments/assets/725937eb-5890-4f21-84a6-ab522c87085b)

5. Examine the relationship between shipping costs, order priority. Identify if there's a correlation between faster shipping methods, higher order priority (ShipmentFact + OrderDim, ShipmentDim)

   ![image](https://github.com/user-attachments/assets/7ffefcf6-d7d5-4b4a-8d70-02050b2fda1b)



