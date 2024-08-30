DECLARE @Databasename NVARCHAR(128) = 'TaxiDb'

-- Test Condition to check if database exists
IF NOT EXISTS(select 1 from sys.databases where name = @Databasename)
BEGIN
	DECLARE @SQL NVARCHAR(MAX)='CREATE DATABASE '+ QUOTENAME(@Databasename);
	EXEC sp_executesql @SQL;
END

USE TaxiDb;

-- Create table with precise data types
CREATE TABLE [dbo].TaxiTrips (

    VendorID INT,
    lpep_pickup_datetime DATETIME, -- Make sure this matches the format in your data
    lpep_dropoff_datetime DATETIME, -- Make sure this matches the format in your data
    store_and_fwd_flag CHAR(6), -- Assuming 'N' or 'Y'
    RatecodeID INT,
    PULocationID INT,
    DOLocationID INT,
    passenger_count INT,
    trip_distance DECIMAL(10, 2), -- Increased precision for distance
    fare_amount DECIMAL(17, 2), -- Increased precision for fare amount
    extra DECIMAL(17, 2), -- Increased precision for extra charges
    mta_tax DECIMAL(15, 2), -- Precision for MTA tax
    tip_amount DECIMAL(17, 2), -- Increased precision for tip amount
    tolls_amount DECIMAL(17, 2), -- Increased precision for tolls amount
    ehail_fee DECIMAL(17, 2) NULL, -- Allow NULLs
    improvement_surcharge DECIMAL(15, 2), -- Precision for improvement surcharge
    total_amount DECIMAL(18, 2), -- Increased precision for total amount
    payment_type INT,
    trip_type INT,
    congestion_surcharge DECIMAL(5, 2) -- Precision for congestion surcharge
);


-- Bulk insert command
BULK INSERT TaxiTrips
FROM 'D:/2021_Green_Taxi_Trip_Data.csv'
WITH
(
    FIELDTERMINATOR = ',',	-- Field terminated by '|',';','\t'
    ROWTERMINATOR = '0x0a', -- Carriage & New Line Character'\r\n','\n','0x0a'(line feed)
    FIRSTROW = 2			-- Skip the header from records
);

select top(5) * from TaxiTrips

--1. Shape of the Table (Number of Rows and Columns)
select count(*) as row_num from TaxiTrips
select count(*) as col_num from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'TaxiTrips'

--2. Show Summary of Green Taxi Rides – Total Rides, Total Customers, Total Sales, 
select count(*) Total_Rides,sum(passenger_count)Total_Customers,
sum(total_amount)Total_Amount from TaxiTrips
where total_amount > 0 and passenger_count > 0

--3. Total Rides with Surcharge and its percentage. 
select VendorID, trip_distance, (improvement_surcharge + congestion_surcharge) as total_surcharge,
ROUND((improvement_surcharge + congestion_surcharge) / total_amount * 100,2) as surcharge_percentage
from TaxiTrips
where total_amount > 0 and improvement_surcharge > 0

--4. Cumulative Sum of Total Fare Amount for Each Pickup Location
select PULocationID ,total_amount,
sum(total_amount) OVER(partition by PULocationID order by PULocationID asc
ROWS between UNBOUNDED preceding AND current row) as cumilative_amount
from TaxiTrips

--5. Which Payment Type is Most Common in Each Drop-off Location
WITH Payment_type_count AS (
SELECT DOLocationID,payment_type,COUNT(*) AS payment_type_count
FROM TaxiTrips
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

--6. Create a New Column for Trip Distance Band and Show Distribution
ALTER TABLE TaxiTrips ADD Trip_Distance_Band VARCHAR(30)

UPDATE TaxiTrips
SET Trip_Distance_Band =
CASE
	WHEN TILE = 1 THEN 'LONG DISTANCE'
	WHEN TILE = 2 THEN 'MEDIUM DISTANCE'
	ELSE 'SHORT DISTANCE'
END
FROM (
SELECT trip_distance,
NTILE(3) OVER(ORDER BY trip_distance DESC) as TILE
FROM TaxiTrips
) AS _


--7. Find the Most Frequent Pickup Location (Mode) with rides fare greater than average of ride fare.
WITH avg_fare_amount AS(
SELECT *
FROM TaxiTrips
WHERE fare_amount > 0 AND
fare_amount > (SELECT AVG(fare_amount) FROM TaxiTrips)
)

SELECT TOP(1) PULocationID,COUNT(*) AS loc_count
FROM avg_fare_amount
GROUP BY PULocationID
ORDER BY loc_count DESC

--8. Show the Rate Code with the Highest Percentage of Usage
SELECT TOP(1) RatecodeID,COUNT(*) AS percent_count
FROM TaxiTrips
WHERE RatecodeID IS NOT NULL
GROUP BY RatecodeID
ORDER BY percent_count DESC

--9. Show Distribution of Tips, Find the Maximum Chances of Getting a Tip
SELECT trip_type,COUNT(tip_amount) AS tip_count
FROM TaxiTrips
WHERE trip_type IS NOT NULL
GROUP BY trip_type
ORDER BY tip_count DESC


--10.Calculate the Rank of Trips Based on Fare Amount within Each Pickup Location
SELECT PULocationID,fare_amount,
DENSE_RANK() OVER(PARTITION BY PULocationID ORDER BY fare_amount)
AS fare_rank
FROM TaxiTrips

--11. Find Top 20 Most Frequent Rides Routes.
SELECT TOP(1) PULocationID,DOLocationID,COUNT(*) AS distance_count
FROM TaxiTrips
GROUP BY PULocationID,DOLocationID
ORDER BY distance_count DESC

--12. Calculate the Average Fare of Completed Trips vs. Cancelled Trips.
SELECT AVG(fare_amount) AS COMPLETED_FARE
FROM TaxiTrips
WHERE trip_distance > 0 AND fare_amount IS NOT NULL
SELECT AVG(fare_amount) AS CANCELLED_FARE
FROM TaxiTrips
WHERE trip_distance = 0 AND fare_amount IS NOT NULL

-- 12. Calculate the Average Fare of Completed Trips vs. Cancelled Trips
with cancelled_trip as(select avg(fare_amount)as tripcanceled from taxitrips where trip_distance=0),
completed_trip as(select avg(fare_amount)as completetrip from taxitrips where trip_distance!=0)
select (select completetrip from completed_trip)as trip_completed_avg ,(select tripcanceled from cancelled_trip) 
as trip_cancelled_avg ;

-- 13. Rank the Pickup Locations by Average Trip Distance and Average Total Amount.
select PULocationID, avg(trip_distance) as avg_trip_dist, avg(total_amount) as avg_total_amt,
dense_rank() over(order by avg(trip_distance) desc, avg(total_amount) desc) 
as PU_rank from taxitrips group by PULocationID;

-- 14. Find the Relationship Between Trip Distance & Fare Amount
select trip_distance,avg(fare_amount) as avg_fare from taxitrips 
group by trip_distance order by trip_distance;

-- 15. Identify Trips with Outlier Fare Amounts within Each Pickup Location
select PULocationID, max(total_amount) as total_amount
from taxitrips group by PULocationID order by total_amount desc;

-- 16. Categorize Trips Based on Distance Travelled
select trip_distance ,tile,
case
	when tile>=3 then 'large'
	when tile>=2 then 'medium'
	else 'low'
end as category
from(select trip_distance ,ntile(3) over
(order by trip_distance) as tile
from taxitrips)as TileCTE;

-- 17. Top 5 Busiest Pickup Locations, Drop Locations with Fare less than median total fare
with medianfare as (select PERCENTILE_CONT(0.5) within group (order by total_amount) over() 
as MedianPrice
from taxitrips)
select top(5) PULocationID, DOLocationID, total_amount 
from taxitrips where total_amount<(select max(MedianPrice) from medianfare) and total_amount>0 
order by total_amount desc;

-- 18. Distribution of Payment Types
select payment_type, count(*) as count_type from taxitrips group by(payment_type);

-- 19. Trips with Congestion Surcharge Applied and Its Percentage Count.
select PULocationID, congestion_surcharge,
case
	when total_amount>0 then (congestion_surcharge * 100.0 / total_amount)
	else 0
end as perc
from taxitrips where congestion_surcharge>0;

-- 20. Top 10 Longest Trip by Distance and Its summary about total amount.
select top(10) trip_distance,total_amount from taxitrips order by trip_distance desc;

-- 21. Trips with a Tip Greater than 20% of the Fare
select PULocationID, tip_amount,((tip_amount * 100.0 / total_amount)) as perc
from taxitrips where total_amount>0 and tip_amount>0 and (tip_amount * 100.0 / total_amount)>20;

-- 22. Average Trip Duration by Rate Code
select RatecodeID, avg(datediff(MINUTE,lpep_pickup_datetime,lpep_dropoff_datetime))as
avg_diff from taxitrips group by RatecodeID order by RatecodeID;

-- 23. Total Trips per Hour of the Day
select DATEPART(HOUR,lpep_pickup_datetime ) as newt,count(DATEPART(HOUR,lpep_pickup_datetime )) as counts 
from taxitrips group by DATEPART(HOUR,lpep_pickup_datetime ) order by counts desc;

-- 24. Show the Distribution about Busiest Time in a Day.
select CONVERT(VARCHAR(8),lpep_pickup_datetime,108) as newt,count( CONVERT(VARCHAR(8),lpep_pickup_datetime,108)) as counts 
from taxitrips group by lpep_pickup_datetime order by counts desc;