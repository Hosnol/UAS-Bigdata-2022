SELECT
  start.install_date AS no_install_date,
  `end`.install_date,
  COUNT(DISTINCT bike_id) count_bike,
  SUM(
  IF
    (`end`.id IS NOT NULL,
      1,
      0)) sum_bike_end,
  SUM(
  IF
    (`end`.id IS NOT NULL,
      1,
      0))/COUNT(DISTINCT bike_id) percentage_end
FROM
  `bigquery-public-data.london_bicycles.cycle_stations` start
JOIN
  `bigquery-public-data.london_bicycles.cycle_hire` ch
ON
  start.id = ch.start_station_id
  AND start.install_date IS NULL
LEFT JOIN
  `bigquery-public-data.london_bicycles.cycle_stations` `end`
ON
  `end`.id = ch.end_station_id
  AND `end`.install_date IS NOT NULL
GROUP BY
  `end`.install_date,
  start.install_date