SELECT
  MIN(year) AS Min_Year,
  MAX(year) AS Max_Year,
  AVG(year) AS Avg_Year,
  
  MIN(condition) AS Min_Condition,
  MAX(condition) AS Max_Condition,
  AVG(condition) AS Avg_Condition,
  
  MIN(odometer) AS Min_Odometer,
  MAX(odometer) AS Max_Odometer,
  AVG(odometer) AS Avg_Odometer,
  
  MIN(mmr) AS Min_MMR,
  MAX(mmr) AS Max_MMR,
  AVG(mmr) AS Avg_MMR,
  
  MIN(sellingprice) AS Min_SellingPrice,
  MAX(sellingprice) AS Max_SellingPrice,
  AVG(sellingprice) AS Avg_SellingPrice
FROM `vehicle-sales-data-453815.vehicle_sales_data.car_prices_cleaned`
