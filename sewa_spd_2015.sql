SELECT
  year_month,
  count_bike
FROM (
  SELECT
    CONCAT(FORMAT_TIMESTAMP('%Y-%m',start_date))AS year_month,
    COUNT(DISTINCT bike_id) AS count_bike
  FROM
    `bigquery-public-data.london_bicycles.cycle_hire`
  GROUP BY
    1
  ORDER BY
    1) AS Y
WHERE
  year_month LIKE '2015%'