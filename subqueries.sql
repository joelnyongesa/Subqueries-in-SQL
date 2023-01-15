--Comparing the average number of bikes available to the number of bikes available at a station
SELECT
  station_id,
  num_bikes_available,
  (SELECT
    AVG(num_bikes_available)
  FROM `bigquery-public-data.new_york.citibike_stations`) AS avg_num_bikes_available
FROM `bigquery-public-data.new_york.citibike_stations`;

--Subqueries in FROM and WHERE statements.
--Using FROM statement to calculate number of rides that have started at each station over time.
SELECT
  station_id,
  name,
  num_of_rides AS number_of_rides_starting_at_station
FROM
  (
    SELECT
      start_station_id,
      COUNT(*) AS num_of_rides
    FROM
      `bigquery-public-data.new_york.citibike_trips`
      GROUP BY
        start_station_id
  )
  AS station_num_trips
  INNER JOIN
    `bigquery-public-data.new_york.citibike_stations`
    ON
      station_id = start_station_id
  ORDER BY
    num_of_rides DESC;

  --List of stations subscribers used
  SELECT
    station_id,
    name
  FROM
    `bigquery-public-data.new_york.citibike_stations`
  WHERE
    station_id IN
    (
      SELECT
        start_station_id
      FROM
        `bigquery-public-data..new_york.citibike_trips`
      WHERE
        usertype = 'Subscriber'
    )

--List of stations customers used.
SELECT
  station_id,
  name
FROM
  `bigquery-public-data.new_york.citibike_stations`
WHERE
  station_id IN
  (
    SELECT
      start_station_id
    FROM
      `bigquery-public-data.new_york.citibike_trips`
    WHERE
      usertype = "Customer"
  );