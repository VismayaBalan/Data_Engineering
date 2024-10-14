-- Databricks notebook source
-- MAGIC %md
-- MAGIC ## Dashboard for Insightful analysis on Uber/Lyft Cab Prices and Weather Impact on Surcharge

-- COMMAND ----------

-- MAGIC %python
-- MAGIC file_path = '/Volumes/azuredatabricks2239/default/cabrides/'

-- COMMAND ----------

-- MAGIC %python
-- MAGIC df = spark.read.parquet(file_path, header=True, inferSchema=True)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC df.show()

-- COMMAND ----------

-- MAGIC %python
-- MAGIC df.printSchema()

-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC ### Creating the materialized view 

-- COMMAND ----------

-- MAGIC %python
-- MAGIC df.createOrReplaceTempView("cabrides")

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Summary of Cab Rides

-- COMMAND ----------

SELECT count(*) AS Rides_Count
FROM cabrides



-- COMMAND ----------

SELECT count(*) AS Uber_Rides_Count
FROM cabrides
WHERE cab_type = "Uber"

-- COMMAND ----------

SELECT count(*) AS Lyft_Rides_Count
FROM cabrides
WHERE cab_type = "Lyft"

-- COMMAND ----------

SELECT ROUND(AVG(surge_multiplier),2) AS Average_Surge_Multiplier
FROM cabrides

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Most Expensive Ride type

-- COMMAND ----------

SELECT cab_type
FROM
(SELECT cab_type , AVG(price_per_mile) AS AVG_price
FROM cabrides
GROUP BY cab_type
ORDER BY AVG_price DESC
LIMIT 1) _ 



-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Most Expensive Cab Type

-- COMMAND ----------

SELECT name
FROM
(SELECT name , AVG(price_per_mile) AS AVG_price
FROM cabrides
GROUP BY name
ORDER BY AVG_price DESC
LIMIT 1) _ 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Most Affordable Cab Type

-- COMMAND ----------

SELECT name
FROM
(SELECT name , AVG(price_per_mile) AS AVG_price
FROM cabrides
GROUP BY name
ORDER BY AVG_price 
LIMIT 1) _ 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Average Price by Cab Type

-- COMMAND ----------

SELECT cab_type, AVG(price) as Average_price 
FROM cabrides
GROUP BY cab_type

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Average Price by Distance

-- COMMAND ----------

SELECT cab_type, distance, AVG(price) AS Average_Price
FROM cabrides
GROUP BY distance, cab_type
ORDER BY Average_Price

-- COMMAND ----------

-- MAGIC %md
-- MAGIC * We can observe that for long-distance trips, Lyft tends to have a higher price. Therefore, it is advisable to opt for Uber in such cases.
-- MAGIC * However, for short-distance trips, Uber can occasionally have higher costs.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Average Price for Uber by Vehicle Type

-- COMMAND ----------


SELECT name, AVG(price_per_mile) AS Avg_price_per_mile
FROM cabrides
WHERE cab_type = 'Uber'
GROUP BY name
ORDER BY Avg_price_per_mile;
    


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Average Price for Lyft by Vehicle Type

-- COMMAND ----------


SELECT name, AVG(price_per_mile) AS Avg_price_per_mile
FROM cabrides
WHERE cab_type = 'Lyft'
GROUP BY name
ORDER BY 
    CASE 
        WHEN name = 'Shared' THEN 1
        WHEN name = 'Lyft' THEN 2
        WHEN name = 'Lyft XL' THEN 3
        WHEN name = 'Lux' THEN 4
        WHEN name = 'Lux Black' THEN 5
        WHEN name = 'Lux Black XL' THEN 6
        ELSE 7
    END;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Average price by hour and day of the week - Uber

-- COMMAND ----------

-- Average price by hour and day of the week
SELECT time_period, 
       CASE day_of_week
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END AS day_of_week_name
, 
       AVG(price_per_mile) as avg_price
FROM cabrides
WHERE cab_type = "Uber"
GROUP BY time_period, day_of_week
ORDER BY day_of_week, 
         CASE time_period
             WHEN 'Morning' THEN 1
             WHEN 'Afternoon' THEN 2
             WHEN 'Evening' THEN 3
             WHEN 'Night' THEN 4
         END;



-- COMMAND ----------

-- MAGIC %md
-- MAGIC
-- MAGIC * The average price is fairly consistent throughout the week, with small fluctuations in prices across different days and time periods.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Average price by hour and day of the week - Lyft

-- COMMAND ----------


SELECT time_period, 
       CASE day_of_week
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        WHEN 7 THEN 'Saturday'
    END AS day_of_week_name
    , 
       AVG(price_per_mile) as avg_price
FROM cabrides
WHERE cab_type = "Lyft"
GROUP BY time_period, day_of_week
ORDER BY day_of_week, 
         CASE time_period
             WHEN 'Morning' THEN 1
             WHEN 'Afternoon' THEN 2
             WHEN 'Evening' THEN 3
             WHEN 'Night' THEN 4
         END;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Surge multipliers based on rain

-- COMMAND ----------


SELECT cab_type,rain, AVG(surge_multiplier) as avg_surge
FROM cabrides
GROUP BY cab_type,rain
HAVING rain > 0;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Surge multipliers based on wind

-- COMMAND ----------


SELECT cab_type,wind, AVG(surge_multiplier) as avg_surge
FROM cabrides
GROUP BY cab_type,wind
HAVING wind > 0;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Surge multipliers based on clouds

-- COMMAND ----------


SELECT cab_type,clouds, AVG(surge_multiplier) as avg_surge
FROM cabrides
GROUP BY cab_type,clouds
HAVING clouds > 0;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Surge multipliers based on temperature

-- COMMAND ----------


SELECT cab_type,temp, ROUND(AVG(surge_multiplier),2) as avg_surge
FROM cabrides
GROUP BY cab_type,temp;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Percentage of Surge Rides by Weather Condition

-- COMMAND ----------

SELECT 
    CASE 
        WHEN rain > 0 THEN 'Rainy'
        WHEN humidity > 80 THEN 'Humid'
        WHEN clouds > 50 THEN 'Cloudy'
        WHEN wind > 15 THEN 'Windy'
        WHEN temp > 85 THEN 'Hot'
        WHEN temp < 32 THEN 'Cold'
        ELSE 'Clear'
    END AS weather_condition,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS surge_percentage
FROM cabrides
WHERE surge_multiplier != 1 
GROUP BY weather_condition;



-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Correlation Between Weather Factors and Surge Pricing

-- COMMAND ----------

WITH surge_correlations AS (
    SELECT
        corr(temp, surge_multiplier) AS temp_corr,
        corr(humidity, surge_multiplier) AS humidity_corr,
        corr(wind, surge_multiplier) AS wind_corr,
        corr(clouds, surge_multiplier) AS clouds_corr,
        corr(rain, surge_multiplier) AS rain_corr
    FROM cabrides
    WHERE surge_multiplier != 1

)

SELECT 'Temperature' AS factor, temp_corr AS correlation FROM surge_correlations
UNION ALL
SELECT 'Humidity', humidity_corr FROM surge_correlations
UNION ALL
SELECT 'Wind', wind_corr FROM surge_correlations
UNION ALL
SELECT 'Clouds', clouds_corr FROM surge_correlations
UNION ALL
SELECT 'Rain', rain_corr FROM surge_correlations;




-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Average price per mile for each time period

-- COMMAND ----------

SELECT 
    cab_type,
    time_period,
    AVG(price_per_mile) AS average_price
FROM cabrides
GROUP BY cab_type, time_period
ORDER BY 
    CASE 
        WHEN time_period = 'Morning' THEN 1
        WHEN time_period = 'Afternoon' THEN 2
        WHEN time_period = 'Evening' THEN 3
        WHEN time_period = 'Night' THEN 4
    END;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Frequency of Cabs by Hour

-- COMMAND ----------


SELECT 
    cab_type,hour,
    COUNT(*) / (SELECT COUNT(DISTINCT date) FROM cabrides) AS ride_freq
FROM cabrides
GROUP BY cab_type,hour
ORDER BY hour;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Frequency of rides for each time period
-- MAGIC

-- COMMAND ----------

--   5 to 12 'Morning'
--   12 to 17 'Afternoon'
--   17 to 21 'Evening' 
--   21 to 5 'Night'

SELECT 
    cab_type, 
    time_period, 
    COUNT(*) / (SELECT COUNT(DISTINCT date) FROM cabrides) AS frequency_of_rides
FROM cabrides
GROUP BY cab_type, time_period
ORDER BY 
    CASE 
        WHEN time_period = 'Morning' THEN 1
        WHEN time_period = 'Afternoon' THEN 2
        WHEN time_period = 'Evening' THEN 3
        WHEN time_period = 'Night' THEN 4
    END;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Surge Pricing Analysis by Time Period

-- COMMAND ----------

SELECT 
    time_period, 
    surge_multiplier, 
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY time_period) AS surge_percentage
FROM cabrides
WHERE surge_multiplier != 1
GROUP BY time_period, surge_multiplier;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Average Surge Multiplier by Time Period

-- COMMAND ----------

SELECT 
    time_period, 
    AVG(surge_multiplier) AS average_surge_multiplier
FROM cabrides
WHERE surge_multiplier != 1
GROUP BY time_period
ORDER BY 
    CASE 
        WHEN time_period = 'Morning' THEN 1
        WHEN time_period = 'Afternoon' THEN 2
        WHEN time_period = 'Evening' THEN 3
        WHEN time_period = 'Night' THEN 4
    END;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Total Revenue Generated from Surge Pricing

-- COMMAND ----------

SELECT 
    cab_type,time_period, 
    SUM(price * (surge_multiplier - 1)) AS total_revenue_from_surge
FROM cabrides
WHERE surge_multiplier != 1
GROUP BY cab_type,time_period
ORDER BY 
    CASE 
        WHEN time_period = 'Morning' THEN 1
        WHEN time_period = 'Afternoon' THEN 2
        WHEN time_period = 'Evening' THEN 3
        WHEN time_period = 'Night' THEN 4
    END;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Surge Multiplier by Time Period and Location

-- COMMAND ----------

SELECT 
    source AS location, 
    time_period, 
    AVG(surge_multiplier) AS avg_surge_multiplier
FROM cabrides
GROUP BY source, time_period
ORDER BY location, 
    CASE 
        WHEN time_period = 'Morning' THEN 1
        WHEN time_period = 'Afternoon' THEN 2
        WHEN time_period = 'Evening' THEN 3
        WHEN time_period = 'Night' THEN 4
    END;



-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Frequency of Daily Rides by Cab Type and Source

-- COMMAND ----------

SELECT 
    cab_type,source, 
    COUNT(*) / (SELECT COUNT(DISTINCT date) FROM cabrides) AS freq_rides_per_day
FROM cabrides
GROUP BY cab_type,source;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Average Revenue per ride for each cab name

-- COMMAND ----------

SELECT 
    cab_type, 
    name, 
    AVG(price_per_mile) AS avg_revenue_per_ride
FROM cabrides
GROUP BY cab_type, name
ORDER BY avg_revenue_per_ride DESC;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC * From above figures, comparing the price differences for various vehicle types, even when opting for shared rides, Uber (UberPool) tends to be more expensive than Lyft (Shared).
-- MAGIC
-- MAGIC * If you're looking for a smaller vehicle type, Lyft (Lyft) is generally more affordable compared to Uber (UberX).
-- MAGIC
-- MAGIC * However, when considering larger vehicle types (XL), Uber (UberXL) typically comes with a higher price tag than Lyft (LyftXL).
-- MAGIC
-- MAGIC * For a premium service, it's recommended to choose Lyft (Lux).

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Top  10 Bussiest Route

-- COMMAND ----------

SELECT 
    source,
    destination,
    COUNT(*) AS total_rides,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS route_rank
FROM cabrides
GROUP BY source, destination
ORDER BY route_rank LIMIT 10;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Total Revenue generated by each cab type

-- COMMAND ----------

SELECT 
    cab_type, 
    SUM(price) AS total_revenue
FROM 
    cabrides
GROUP BY 
    cab_type
ORDER BY 
    total_revenue DESC;


-- COMMAND ----------


