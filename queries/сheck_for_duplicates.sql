SELECT
  vin,
  make,
  model,
  trim,
  body,
  transmission,
  condition,
  odometer,
  color,
  interior,
  seller,
  mmr,
  sellingprice,
  saledate,
  COUNT(*) AS duplicates
FROM
  `vehicle-sales-data-453815.vehicle_sales_data.car_prices_cleaned`
GROUP BY
  vin,
  make,
  model,
  trim,
  body,
  transmission,
  condition,
  odometer,
  color,
  interior,
  seller,
  mmr,
  sellingprice,
  saledate
HAVING
  COUNT(*) > 1;