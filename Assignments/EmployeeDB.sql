DECLARE @Databasename VARCHAR(128) = 'HREmployeeDB';

-- Test condition to check if database exists
IF NOT EXISTS(SELECT 1 FROM sys.databases WHERE name = @Databasename)
BEGIN 
	DECLARE @sql NVARCHAR(MAX) = 'CREATE DATABASE' + QUOTENAME(@Databasename)
	EXEC sp_executesql @sql;
END

USE HREmployeeDB;

CREATE TABLE [dbo].EmployeeData (
    Attrition VARCHAR(20) NOT NULL,
    BusinessTravel VARCHAR(26) NOT NULL,
    CF_age_band VARCHAR(20) NOT NULL,
    CF_attrition_label VARCHAR(35) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    EducationField VARCHAR(50) NOT NULL,
    emp_no VARCHAR(20) PRIMARY KEY,
    EmployeeNumber INT NOT NULL,
    Gender VARCHAR(6) NOT NULL,
    JobRole VARCHAR(50) NOT NULL,
    MaritalStatus VARCHAR(10) NOT NULL,
    OverTime VARCHAR(3) NOT NULL,
    Over18 VARCHAR(3) NOT NULL,
    TrainingTimesLastYear INT NOT NULL,
    Age INT NOT NULL,
    CF_current VARCHAR(3) NOT NULL,
    DailyRate INT NOT NULL,
    DistanceFromHome INT NOT NULL,
    Education VARCHAR(20) NOT NULL,
    EmployeeCount INT NOT NULL,
    EnvironmentSatisfaction INT NOT NULL,
    HourlyRate INT NOT NULL,
    JobInvolvement INT NOT NULL,
    JobLevel INT NOT NULL,
    JobSatisfaction INT NOT NULL,
    MonthlyIncome INT NOT NULL,
    MonthlyRate INT NOT NULL,
    NumCompaniesWorked INT NOT NULL,
    PercentSalaryHike INT NOT NULL,
    PerformanceRating INT NOT NULL,
    RelationshipSatisfaction INT NOT NULL,
    StandardHours INT NOT NULL,
    StockOptionLevel INT NOT NULL,
    TotalWorkingYears INT NOT NULL,
    WorkLifeBalance INT NOT NULL,
    YearsAtCompany INT NOT NULL,
    YearsInCurrentRole INT NOT NULL,
    YearsSinceLastPromotion INT NOT NULL,
    YearsWithCurrentManager INT NOT NULL
);

BULK INSERT EmployeeData FROM 'D:/HR Employee.csv'
WITH 
(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0A' ,
	FIRSTROW = 2  -- skip header from records
)

-- a) Return the shape of the table
Select count(*) as Row_nos from EmployeeData;
Select count(*) as Col_nos from INFORMATION_SCHEMA.COLUMNS;

-- b) Calculate the cumulative sum of total working years for each department

select Department,TotalWorkingYears, sum(TotalWorkingYears) OVER(ORDER BY Department ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum 
from EmployeeData;

-- c) Which gender have higher strength as workforce in each department

select Department,Gender,count FROM
(select Department,Gender,count(*) as count, RANK() OVER(PARTITION BY Department ORDER BY count(*) DESC) as rank
from EmployeeData
group by Department,Gender) AS _ WHERE rank=1;


-- d) Create a new column AGE_BAND and Show Distribution of Employee's Age band group (Below 25, 25-34, 35-44, 45-55. ABOVE 55).
ALTER TABLE EmployeeData
ADD AGE_BAND_COUNT INT;

UPDATE EmployeeData
SET AGE_BAND_COUNT = (
    SELECT COUNT(*)
    FROM EmployeeData AS ed2
    WHERE ed2.CF_age_band = EmployeeData.CF_age_band
);

SELECT emp_no,AGE_BAND_COUNT FROM EmployeeData;
-- e) Compare all marital status of employee and find the most frequent marital status

SELECT TOP(1) MaritalStatus,count(*) as count, RANK() OVER(ORDER BY count(*) DESC ) AS rank
FROM EmployeeData
GROUP BY MaritalStatus;

SELECT TOP(1) MaritalStatus,count(*) as count
FROM EmployeeData
GROUP BY MaritalStatus
ORDER BY count DESC;

-- f) Show the Job Role with Highest Attrition Rate (Percentage)


select TOP(1) JobRole , (yes_count*100)/total_count as percentage_ from 
(SELECT JobRole,sum(CASE WHEN Attrition='Yes' THEN 1 END) as yes_count,count(*) as total_count
FROM EmployeeData
GROUP BY JobRole) as _
ORDER BY percentage_ DESC;

-- g) Show distribution of Employee's Promotion, Find the maximum chances of employee getting promoted.

SELECT JobRole,PerformanceRating,YearsInCurrentRole,YearsAtCompany,YearsSinceLastPromotion,
	JobInvolvement,TrainingTimesLastYear
FROM EmployeeData
GROUP BY Attrition,JobRole,PerformanceRating,YearsSinceLastPromotion,
	YearsInCurrentRole,YearsAtCompany,JobInvolvement,TrainingTimesLastYear
ORDER BY YearsAtCompany

-- h) Show the cumulative sum of total working years for each department.

select Department,TotalWorkingYears, sum(TotalWorkingYears) OVER(ORDER BY Department ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_sum 
from EmployeeData;

-- i) Find the rank of employees within each department based on their monthly income

SELECT Department, EmployeeNumber, MonthlyIncome FROM 
(SELECT Department, EmployeeNumber, MonthlyIncome,
RANK() OVER(PARTITION BY Department ORDER BY MonthlyIncome DESC) as rank
FROM EmployeeData) AS _
WHERE rank = 1
;

-- j) Calculate the running total of 'Total Working Years' for each employee within each department and age band.

SELECT emp_no,Department, CF_age_band, TotalWorkingYears,
SUM(TotalWorkingYears) OVER(PARTITION BY Department, CF_age_band ORDER BY TotalWorkingYears desc) as cumulative_sum
FROM EmployeeData;

--k) For each employee who left, calculate the number of years they worked before leaving and 
-- compare it with the average years worked by employees in the same department.
SELECT 
    emp_no, 
    Department, 
    YearsAtCompany, 
    (SELECT AVG(YearsAtCompany) 
     FROM EmployeeData 
     WHERE Department = e.Department) AS avg_years_in_dept
FROM 
    EmployeeData e
WHERE 
    Attrition = 'Yes'
ORDER BY 
    emp_no;



--l) Rank the departments by the average monthly income of employees who have left.
SELECT Department,AVG(MonthlyIncome) as avg_monthly_income, RANK() OVER(ORDER BY AVG(MonthlyIncome) DESC) AS rank
FROM EmployeeData
WHERE Attrition='Yes'
GROUP BY Department;


--m) Find the if there is any relation between Attrition Rate and Marital Status of Employee.
SELECT Attrition,MaritalStatus, count(*) as Marital_count
FROM EmployeeData
GROUP BY Attrition,MaritalStatus
ORDER BY Marital_count DESC;

-- Insight: Majority of the employees who left the company are single and employees who are working in the company are majorly married

--n) Show the Department with Highest Attrition Rate (Percentage)
select TOP(1) Department , (yes_count*100)/total_count as percentage_ from 
(SELECT Department,sum(CASE WHEN Attrition='Yes' THEN 1 END) as yes_count,count(*) as total_count
FROM EmployeeData
GROUP BY Department) as _
ORDER BY percentage_ DESC;

--o) Calculate the moving average of monthly income over the past 3 employees for each job role.

SELECT JobRole,MonthlyIncome, 
AVG(MonthlyIncome) OVER(ORDER BY MonthlyIncome ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as moving_avg_income
FROM EmployeeData;

--p) Identify employees with outliers in monthly income within each job role. [ Condition :
--Monthly_Income < Q1 - (Q3 - Q1) * 1.5 OR Monthly_Income > Q3 + (Q3 - Q1) ]

SELECT emp_no,JobRole, MonthlyIncome FROM 
(SELECT emp_no,JobRole, MonthlyIncome,
PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY MonthlyIncome) OVER() AS Q1,
PERCENTILE_CONT(0.50) WITHIN GROUP(ORDER BY MonthlyIncome) OVER() Q2,
PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY MonthlyIncome) OVER() AS Q3
FROM EmployeeData) AS _
WHERE MonthlyIncome < Q1 - (Q3 - Q1) * 1.5 OR MonthlyIncome > Q3 + (Q3 - Q1);

--q) Gender distribution within each job role, show each job role with its gender domination.
--[Male_Domination or Female_Domination]
SELECT JobRole,Gender FROM
(SELECT JobRole,Gender,RANK() OVER(PARTITION BY JobRole ORDER BY COUNT(*) DESC) AS rank
FROM EmployeeData
GROUP BY JobRole,Gender) as A 
WHERE rank = 1;



--r) Percent rank of employees based on training times last year

SELECT emp_no,TrainingTimesLastYear,
PERCENT_RANK() OVER(ORDER BY TrainingTimesLastYear) as training_percentage
FROM EmployeeData
ORDER BY training_percentage DESC;

--s) Divide employees into 5 groups based on training times last year [Use NTILE ()]

SELECT emp_no,TrainingTimesLastYear, 
NTILE(5) OVER(ORDER BY TrainingTimesLastYear) as training_tile
FROM EmployeeData;

--t) Categorize employees based on training times last year as - Frequent Trainee, Moderate
--Trainee, Infrequent Trainee.
SELECT emp_no,TrainingTimesLastYear,
CASE
	WHEN TrainingTimesLastYear > 4 THEN 'Frequent Trainee'
	WHEN TrainingTimesLastYear > 2 THEN 'Moderate Trainee'
	ELSE 'Infrequent Trainee'
END AS 'Training_Frequency'
FROM EmployeeData
ORDER BY TrainingTimesLastYear DESC;

--u) Categorize employees as 'High', 'Medium', or 'Low' performers based on their performance
--rating, using a CASE WHEN statement.

SELECT emp_no, PerformanceRating,
CASE
	WHEN PerformanceRating > 3 THEN 'High Performer'
	WHEN PerformanceRating > 1 THEN 'Medium Performer'
	ELSE 'Low Performer'
END AS Performance_Category
FROM EmployeeData
ORDER BY PerformanceRating;


--v) Use a CASE WHEN statement to categorize employees into 'Poor', 'Fair', 'Good', or 'Excellent'
--work-life balance based on their work-life balance score.

SELECT emp_no,WorkLifeBalance,
CASE
	WHEN WorkLifeBalance > 3 THEN 'Excellent WorkLifeBalance'
	WHEN WorkLifeBalance > 1 THEN 'Fair WorkLifeBalance'
	ELSE 'Poor WorkLife Balance'
END AS 'WorkLife_Balance_Ranking'
FROM EmployeeData
ORDER BY WorkLife_Balance_Ranking DESC;

--w) Group employees into 3 groups based on their stock option level using the [NTILE] function.
SELECT emp_no,StockOptionLevel, NTILE(3) OVER(ORDER BY StockOptionLevel) as Stock_tile
FROM EmployeeData;

--x) Find key reasons for Attrition in Company

SELECT JobRole,Department,
AVG(YearsAtCompany) Company_year_Count,
AVG(YearsSinceLastPromotion) year_since_promotion_Count,
AVG(WorkLifeBalance) worklife_avg,
AVG(PercentSalaryHike) hike_percent,
AVG(MonthlyIncome) income_avg,
AVG(EnvironmentSatisfaction) env_satisfaction,

COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)*100/ COUNT(*) Attrition_percent

FROM EmployeeData
GROUP BY JobRole,Department
ORDER BY Attrition_percent DESC

select * from EmployeeData;