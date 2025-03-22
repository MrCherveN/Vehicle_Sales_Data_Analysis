SELECT
  COUNTIF(year IS NULL) AS year_missing,
  COUNTIF(make IS NULL) AS make_missing,
  COUNTIF(model IS NULL) AS model_missing,
  COUNTIF(trim IS NULL) AS trim_missing,
  COUNTIF(body IS NULL) AS body_missing,
  COUNTIF(transmission IS NULL) AS transmission_missing,
  COUNTIF(vin IS NULL) AS vin_missing,
  COUNTIF(state IS NULL) AS state_missing,
  COUNTIF(condition IS NULL) AS condition_missing,
  COUNTIF(odometer IS NULL) AS odometer_missing,
  COUNTIF(color IS NULL) AS color_missing,
  COUNTIF(interior IS NULL) AS interior_missing,
  COUNTIF(seller IS NULL) AS seller_missing,
  COUNTIF(mmr IS NULL) AS mmr_missing,
  COUNTIF(sellingprice IS NULL) AS sellingprice_missing,
  COUNTIF(saledate IS NULL) AS saledate_missing
FROM
  `vehicle-sales-data-453815.vehicle_sales_data.car_prices_cleaned`;