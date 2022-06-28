SELECT
  rental_id,
  bike_id,
  duration/60 AS duration_minute,
  start_station_name,
  end_station_name
FROM
  `bigquery-public-data.london_bicycles.cycle_hire`
WHERE
  bike_id = 9
  AND end_station_name = start_station_name