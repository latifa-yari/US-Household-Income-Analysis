#US Household Income Exploratory Data Analysis 

-- Step 1: Identify missing or invalid land area values
-- This checks for land area (ALand) values that are zero, empty, or NULL

SELECT ALand, AWater
FROM US_Project.US_Household_Income
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL)
;

-- Step 2: Explore the full dataset of US Household Income
-- Helps to get a sense of data structure, column names, and sample values

SELECT *
FROM US_Project.US_Household_Income
;

-- Step 3: Explore the US Household Income Statistics table
-- Review summary statistics (mean, median, stdev, etc.) by state

SELECT *
FROM US_Project.US_Household_Income_Statistics
;

-- Step 4: Analyze total land and water area by state
-- This aggregates ALand and AWater values by State_Name
-- Sorts by total land area in descending order and limits to top 10 states

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM US_Project.US_Household_Income
GROUP BY State_Name
ORDER by 2 DESC
LIMIT 10
;


-- Step 5: Join both datasets on the 'id' column
-- This merges household income and summary statistics for deeper analysis

SELECT *
FROM US_Project.US_Household_Income u
JOIN US_Project.US_Household_Income_Statistics us
	ON u.id = us.id
;

-- Step 6: Use INNER JOIN to keep only matched records and exclude entries with zero mean income
-- Useful for filtering out irrelevant or incomplete income data

SELECT *
FROM US_Project.US_Household_Income u
INNER  JOIN US_Project.US_Household_Income_Statistics us
	ON u.id = us.id
WHERE Mean <> 0
;

-- Step 7: Select and preview key columns for EDA
-- Focus on location (State, County), area Type, Primary status, and income metrics (Mean, Median)

SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM US_Project.US_Household_Income u
INNER  JOIN US_Project.US_Household_Income_Statistics us
	ON u.id = us.id
WHERE Mean <> 0
;

-- Step 8: Analyze average Mean and Median income by State
-- Aggregates by State and identifies states with the highest average Mean income

SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM US_Project.US_Household_Income u
INNER  JOIN US_Project.US_Household_Income_Statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10
;


-- Step 9: Analyze average income by Type and count how many entries per Type
-- Helps determine which area types (e.g., Track, Borough, City) are most common and affluent
SELECT Type, COUNT(Type),ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM US_Project.US_Household_Income u
INNER  JOIN US_Project.US_Household_Income_Statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1 
ORDER BY 3 DESC
LIMIT 20
;


-- Step 10: Filter income statistics by Type, excluding outliers
-- Focus only on area types that appear more than 100 times
-- This helps ensure averages aren't skewed by rarely occurring area types

SELECT Type, COUNT(Type),ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM US_Project.US_Household_Income u
INNER  JOIN US_Project.US_Household_Income_Statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1 
HAVING COUNT(Type) > 100
ORDER BY 3 DESC
LIMIT 20
;

-- Step 11: Explore average Mean and Median income by State and City
-- Useful for identifying high-income cities within each state
-- Helps uncover geographic trends in income levels at a more granular level

SELECT u.State_Name, City, ROUND(AVG(Mean),1),  ROUND(AVG(Median),1)
FROM US_Project.US_Household_Income u
JOIN US_Project.US_Household_Income_Statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC
;












