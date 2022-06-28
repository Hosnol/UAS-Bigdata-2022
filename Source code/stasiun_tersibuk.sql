SELECT
  id,
  week_number,
  rental_count,
  SUM(rental_count) OVER(order by week_number)cumulative_sum
FROM (
  SELECT
    id,
    extract(week
    from
      ch.start_date)week_number,
    count(rental_id)rental_count
  from (
    select
      cs.id,
      count(ch.rental_id)rental_count,
      rank() over(order by count(ch.rental_id) desc)rank
    from
      `bigquery-public-data.london_bicycles.cycle_stations` cs
    JOIN
      `bigquery-public-data.london_bicycles.cycle_hire` ch
    on
      cs.id = ch.start_station_id
    where
      start_date between '2015-01-01 00:00:00' and '2015-12-31 23:59:59'
    group by
      1)t1
  join
    `bigquery-public-data.london_bicycles.cycle_hire` ch
  on
    ch.start_station_id=t1.id
    and ch.start_date between '2016-01-01 00:00:00' and '2016-12-31 23:59:59'
  where
    rank=3
  group by
    1,2)t2