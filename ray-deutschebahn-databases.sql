USE ironhack_db;

-- View Tables

SELECT * FROM arrive;
SELECT * FROM trips;
SELECT * FROM stops;

-- Check Tables

SELECT * FROM trips WHERE depart_id IS NULL;

-- Create a Trips table for routes

CREATE TABLE trips AS
SELECT DISTINCT station_depart, station_arrive
FROM arrive;


-- Create Arrive/Depart IDs into Trips

ALTER TABLE trips
ADD arrive_id INT,
ADD depart_id INT;

-- Add 'arrive_id' to Trips table to match 'station_arrive' names

UPDATE trips t
JOIN stops s ON t.station_arrive = s.stop_name
SET t.arrive_id = s.stop_id;

-- Add 'depart_id' to 'trips' table to match 'station_depart' names

UPDATE trips t
JOIN stops s ON t.station_depart = s.stop_name
SET t.depart_id = s.stop_id;

-- Add latitude/longitude columns to 'trips' table

ALTER TABLE trips
ADD COLUMN arrive_lat FLOAT,
ADD COLUMN arrive_lon FLOAT,
ADD COLUMN depart_lat FLOAT,
ADD COLUMN depart_lon FLOAT;

-- Update 'arrive_lat' and 'arrive_lon' in 'trips' table

UPDATE trips t
JOIN stops s ON t.arrive_id = s.stop_id
SET
  t.arrive_lat = s.stop_lat,
  t.arrive_lon = s.stop_lon;

-- Update 'depart_lat' and 'depart_lon' in 'trips' table

UPDATE trips t
JOIN stops s ON t.depart_id = s.stop_id
SET
  t.depart_lat = s.stop_lat,
  t.depart_lon = s.stop_lon;

-- The 20 routes have the most frequent delays (for delays >= 5)
-- Included the average delay, percentage of total trips on route

SELECT
    station_arrive,
    station_depart,
    COUNT(*) AS total_trips,
    SUM(CASE WHEN delay >= 5 THEN 1 ELSE 0 END) AS delay_frequency,
    ROUND((SUM(CASE WHEN delay >= 5 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS delay_percentage,
	ROUND(AVG(CASE WHEN delay >= 5 THEN delay ELSE NULL END), 2) AS avg_delay
FROM arrive
GROUP BY station_arrive, station_depart
ORDER BY delay_frequency DESC
LIMIT 20;

-- The 20 trains and departures with most frequent delays (for delays >= 5)
-- Included the average delay, percentage of total trips on route

SELECT
    train_type, train_num,
    station_depart,
    SUM(CASE WHEN delay >= 5 THEN 1 ELSE 0 END) AS delay_frequency,
    ROUND((SUM(CASE WHEN delay >= 5 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS delay_percentage,
    COUNT(*) AS total_trips,
    ROUND(AVG(CASE WHEN delay >= 5 THEN delay ELSE NULL END), 2) AS avg_delay
FROM arrive
GROUP BY train_type, train_num, station_depart
ORDER BY delay_frequency DESC
LIMIT 20;

-- The 20 most impacted stations with late arrivals  (for delays >= 5)
-- Included the average delay, percentage of total trips on route

SELECT
    station_arrive,
    SUM(CASE WHEN delay >= 5 THEN 1 ELSE 0 END) AS delay_frequency,
    ROUND((SUM(CASE WHEN delay >= 5 THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS delay_percentage,
    COUNT(*) AS total_trips,
    ROUND(AVG(CASE WHEN delay >= 5 THEN delay ELSE NULL END), 2) AS avg_delay
FROM arrive
GROUP BY station_arrive
ORDER BY delay_frequency DESC
LIMIT 20;



