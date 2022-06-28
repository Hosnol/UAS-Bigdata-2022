SELECT
  *
FROM
  ML.PREDICT(MODEL `automatic-curve-347603.bike_model.model`,
    (
    SELECT
      duration,
      start_station_name,
      CAST(EXTRACT(dayofweek
        FROM
          start_date) AS STRING) AS dayofweek,
      CAST(EXTRACT(hour
        FROM
          start_date) AS STRING) AS hourofday
    FROM
      `bigquery-public-data`.london_bicycles.cycle_hire
    WHERE
      start_station_name = 'Euston Road, Euston'))