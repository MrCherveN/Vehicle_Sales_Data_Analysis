-- Create a new table with filled missing values and cleaned data
CREATE OR REPLACE TABLE `vehicle-sales-data-453815.vehicle_sales_data.car_prices_cleaned` AS
WITH mode_values AS (
  -- Get the mode (most frequent value) for categorical columns
  SELECT 
    (SELECT make FROM `vehicle-sales-data-453815.vehicle_sales_data.car_prices` GROUP BY make ORDER BY COUNT(*) DESC LIMIT 1) AS mode_make,
    (SELECT model FROM `vehicle-sales-data-453815.vehicle_sales_data.car_prices` GROUP BY model ORDER BY COUNT(*) DESC LIMIT 1) AS mode_model,
    (SELECT body FROM `vehicle-sales-data-453815.vehicle_sales_data.car_prices` GROUP BY body ORDER BY COUNT(*) DESC LIMIT 1) AS mode_body,
    (SELECT trim FROM `vehicle-sales-data-453815.vehicle_sales_data.car_prices` GROUP BY trim ORDER BY COUNT(*) DESC LIMIT 1) AS mode_trim,
    (SELECT color FROM `vehicle-sales-data-453815.vehicle_sales_data.car_prices` GROUP BY color ORDER BY COUNT(*) DESC LIMIT 1) AS mode_color,
    (SELECT interior FROM `vehicle-sales-data-453815.vehicle_sales_data.car_prices` GROUP BY interior ORDER BY COUNT(*) DESC LIMIT 1) AS mode_interior,
    (SELECT transmission FROM `vehicle-sales-data-453815.vehicle_sales_data.car_prices` GROUP BY transmission ORDER BY COUNT(*) DESC LIMIT 1) AS mode_transmission
)
SELECT
  -- Fill missing categorical values with the mode
  IFNULL(year, 0) AS year,
  IFNULL(UPPER(make), UPPER(mode_values.mode_make)) AS make,
  IFNULL(UPPER(model), UPPER(mode_values.mode_model)) AS model,
  IFNULL(UPPER(trim), UPPER(mode_values.mode_trim)) AS trim,
  IFNULL(UPPER(body), UPPER(mode_values.mode_body)) AS body,
  IFNULL(UPPER(transmission), UPPER(mode_values.mode_transmission)) AS transmission,
  IFNULL(vin, 'Unknown') AS vin,
  IFNULL(state, 'Unknown') AS state,
  -- Numerical columns, fill missing values with average
  IFNULL(condition, (SELECT AVG(condition) FROM `vehicle-sales-data-453815.vehicle_sales_data.car_prices`)) AS condition,
  IFNULL(odometer, (SELECT AVG(odometer) FROM `vehicle-sales-data-453815.vehicle_sales_data.car_prices`)) AS odometer,
  IFNULL(color, mode_values.mode_color) AS color,
  IFNULL(interior, mode_values.mode_interior) AS interior,
  IFNULL(seller, 'Unknown') AS seller,
  IFNULL(mmr, (SELECT AVG(mmr) FROM `vehicle-sales-data-453815.vehicle_sales_data.car_prices`)) AS mmr,
  -- Selling price should not be null, drop rows if it's missing
  sellingprice,
  FORMAT_TIMESTAMP('%d.%m.%Y', PARSE_TIMESTAMP('%a %b %d %Y %H:%M:%S', REGEXP_REPLACE(saledate, r' GMT.*', ''))) AS saledate
FROM
  `vehicle-sales-data-453815.vehicle_sales_data.car_prices`,
  mode_values
WHERE
  -- Remove rows where saledate is missing or has invalid format or (< year) AND sellingprice > 1
  saledate IS NOT NULL AND REGEXP_CONTAINS(saledate, r'^[A-Za-z]{3} [A-Za-z]{3} \d{2} \d{4} \d{2}:\d{2}:\d{2}')
  AND  SAFE_CAST(FORMAT_DATE('%Y', DATE(PARSE_TIMESTAMP('%a %b %d %Y %H:%M:%S', REGEXP_REPLACE(saledate, r' GMT.*', '')))) AS INT64) >= year
  AND sellingprice > 1;


