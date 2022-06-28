SELECT
  b.year,
  b.week_number,
  b.start_station_name,
  b.count_bike
FROM (
  SELECT
    FORMAT_TIMESTAMP('%Y',end_date) AS year,
    EXTRACT(WEEK
    FROM
      DATE(end_date)) AS week_number,
    start_station_name,
    COUNT(DISTINCT bike_id) AS count_bike
  FROM
    `bigquery-public-data.london_bicycles.cycle_hire`
  GROUP BY
    1,
    2,
    3) AS b
WHERE
  count_bike = (
  SELECT
    MAX(count_bike)
  FROM (
    SELECT
      FORMAT_TIMESTAMP('%Y',end_date) AS year,
      EXTRACT(WEEK
      FROM
        DATE(end_date)) AS week_number,
      start_station_name,
      COUNT(DISTINCT bike_id) AS count_bike
    FROM
      `bigquery-public-data.london_bicycles.cycle_hire`
    GROUP BY
      1,
      2,
      3))