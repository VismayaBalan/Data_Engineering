-- Case Study – Green Taxi Trip



DECLARE @Databasename VARCHAR(128) = 'Tripdb';

-- Test condition to check if database exists
IF NOT EXISTS(SELECT 1 FROM sys.databases WHERE name = @Databasename)
BEGIN 
	DECLARE @sql NVARCHAR(MAX) = 'CREATE DATABASE' + QUOTENAME(@Databasename)
	EXEC sp_executesql @sql;
END

USE Tripdb;

CREATE TABLE taxi_trips (
    VendorID INT,
    lpep_pickup_datetime DATETIME,
    lpep_dropoff_datetime DATETIME,
    store_and_fwd_flag CHAR(1),
    RatecodeID INT,
    PULocationID INT,
    DOLocationID INT,
    passenger_count INT,
    trip_distance FLOAT,
    fare_amount FLOAT,
    extra FLOAT,
    mta_tax FLOAT,
    tip_amount FLOAT,
    tolls_amount FLOAT,
    ehail_fee FLOAT,
    improvement_surcharge FLOAT,
    total_amount FLOAT,
    payment_type INT,
    trip_type INT,
    congestion_surcharge FLOAT
);

BULK INSERT taxi_trips FROM 'D:/2021_Green_Taxi_Trip_Data.csv'
WITH 
(
	FIELDTERMINATOR = ',',	  -- '|',';','\t',' '
	ROWTERMINATOR = '0x0A' ,  --  Carriage & New line character - '\r\n','\n','\r','0x0a'(line feed)
	FIRSTROW = 2			  -- skip header from records
)



-- 1) Shape of the Table (Number of Rows and Columns)
		
		select count(*) as Row_Nos from taxi_trips;
		select count(*) as Column_Nos from INFORMATION_SCHEMA.COLUMNS;

-- 2) Show Summary of Green Taxi Rides – Total Rides, Total Customers, Total Sales
		select count(*) as Total_Rides, sum(passenger_count) as Total_Customers, sum(total_amount) as Total_sales
		from taxi_trips;

-- 3) Total Rides with Surcharge and its percentage
		select *,(improvement_surcharge + congestion_surcharge) / total_amount*100 as percentage_
		from taxi_trips where improvement_surcharge > 0 and congestion_surcharge > 0;
		
-- 4) Cumulative Sum of Total Fare Amount for Each Pickup Location
		SELECT PULocationID,total_amount, sum(total_amount) OVER(ORDER BY PULocationID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum 
		from taxi_trips ;

-- 5) 	Which Payment Type is Most Common in Each Drop-off Location

	WITH Payment_type_count AS (
	SELECT DOLocationID,payment_type,COUNT(*) AS payment_type_count
	FROM taxi_trips
	WHERE payment_type IS NOT NULL
	GROUP BY DOLocationID, payment_type
	)
	SELECT DOLocationID, payment_type, payment_type_count AS payment_count
	FROM (
	SELECT DOLocationID,payment_type, payment_type_count,
	RANK() OVER (PARTITION BY DOLocationID ORDER BY payment_type_count DESC) AS payment_rank
	FROM Payment_type_count
	) as _
	WHERE payment_rank = 1;
	

-- 6) Create a New Column for Trip Distance Band and Show Distribution

	ALTER TABLE taxi_trips ADD Trip_Distance_Band VARCHAR(30)

	UPDATE taxi_trips
	SET Trip_Distance_Band =
	CASE
		WHEN TILE = 1 THEN 'LONG DISTANCE'
		WHEN TILE = 2 THEN 'MEDIUM DISTANCE'
		ELSE 'SHORT DISTANCE'
	END
	FROM (
	SELECT trip_distance,
	NTILE(3) OVER(ORDER BY trip_distance DESC) as TILE
	FROM taxi_trips
	) AS _

-- 7) Find the Most Frequent Pickup Location (Mode) with rides fare greater than average of ride fare.
	SELECT TOP(1) PULocationID, COUNT(*) AS frequency
	FROM (SELECT PULocationID
    FROM taxi_trips
    WHERE fare_amount > (SELECT AVG(fare_amount) FROM taxi_trips)) as a
	GROUP BY PULocationID
	ORDER BY frequency DESC;

-- 8) Show the Rate Code with the Highest Percentage of Usage

	select TOP(1) RatecodeID , COUNT(*)*100/(select count(*) from taxi_trips) AS percentage_
	from taxi_trips 
	WHERE RatecodeID IS NOT NULL
	GROUP BY RatecodeID
	ORDER BY percentage_ DESC;

-- 9) Show Distribution of Tips, Find the Maximum Chances of Getting a Tip
	select trip_type, count(tip_amount) as tip_count
	from taxi_trips WHERE trip_type is not null
	GROUP BY trip_type
	ORDER BY tip_count;

-- 10) Calculate the Rank of Trips Based on Fare Amount within Each Pickup Location
	

	SELECT PULocationID, 
       fare_amount, 
       RANK() OVER (PARTITION BY PULocationID ORDER BY fare_amount ) AS Rank
	FROM taxi_trips
	ORDER BY Rank;


-- 11) Find Top 20 Most Frequent Rides Routes. 
	SELECT TOP(20) PULocationID,DOLocationID , count(*) as route_count
	FROM taxi_trips
	GROUP BY PULocationID,DOLocationID
	ORDER BY route_count DESC;
	

-- 12) Calculate the Average Fare of Completed Trips vs. Cancelled Trips
	

	SELECT AVG(fare_amount) as avg_fare_completed_trips
	FROM taxi_trips
	WHERE trip_distance>0 and fare_amount is not null;

	SELECT AVG(fare_amount) as avg_fare_cancelled_trips
	FROM taxi_trips
	WHERE trip_distance = 0 and fare_amount is not null;

	SELECT 
    AVG(CASE WHEN trip_distance > 0 THEN fare_amount END) AS avg_fare_completed_trips,
    AVG(CASE WHEN trip_distance = 0 THEN fare_amount END) AS avg_fare_cancelled_trips
	FROM taxi_trips
	WHERE fare_amount IS NOT NULL;





