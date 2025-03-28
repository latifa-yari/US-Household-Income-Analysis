# US Household Income Data Cleaning

-- Step 1: Preview the main household income dataset
SELECT *
FROM US_Project.US_Household_Income
;

-- Step 2: Preview the supplementary income statistics dataset
SELECT *
FROM US_Project.US_Household_Income_Statistics
;

-- Step 3: Count total records in both datasets
SELECT COUNT(id)
FROM US_Project.US_Household_Income
;

SELECT COUNT(id)
FROM US_Project.US_Household_Income_Statistics
;

-- Step 4: Check for duplicate 'id' values in the US_Household_Income table
SELECT id, COUNT(id)
FROM US_Project.US_Household_Income
GROUP BY id
HAVING COUNT(id) > 1
;

-- Step 5: Identify duplicate rows using ROW_NUMBER to find duplicates by row_id
SELECT *
FROM (
	SELECT row_id, 
	       id, 
	       ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS row_num
	FROM US_Project.US_Household_Income
) duplicates
WHERE row_num > 1
;

-- Step 6: Delete duplicate records while retaining the first occurrence of each 'id'
DELETE FROM US_Household_Income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id, 
		       id, 
		       ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS row_num
		FROM US_Project.US_Household_Income
	) duplicates
	WHERE row_num > 1
)
;

-- Step 7: Check for duplicate 'id' values in US_Household_Income_Statistics
-- Result: No duplicates found
SELECT id, COUNT(id)
FROM US_Project.US_Household_Income_Statistics
GROUP BY id
HAVING COUNT(id) > 1
;

-- Step 8: Check for misspellings and inconsistencies in 'State_Name'
SELECT State_Name, COUNT(State_Name)
FROM US_Project.US_Household_Income
GROUP BY State_Name
;

-- Step 9: View distinct state names (check for typos, casing issues)
SELECT DISTINCT State_Name
FROM US_Project.US_Household_Income
ORDER BY 1
;

-- Step 10: Standardize 'State_Name' values by correcting misspellings
UPDATE US_Project.US_Household_Income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

UPDATE US_Project.US_Household_Income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;

-- Step 11: Explore distinct state abbreviations (State_ab)
SELECT DISTINCT State_ab
FROM US_Project.US_Household_Income
ORDER BY 1
;

-- Step 12: Check for NULL or missing values in the 'Place' column
SELECT *
FROM US_Project.US_Household_Income
WHERE Place IS NULL
ORDER BY 1
;

-- Step 13: View data for a specific county to inform manual cleaning
SELECT *
FROM US_Project.US_Household_Income
WHERE County = 'Autauga County'
ORDER BY 1
;

-- Step 14: Fix mismatched 'Place' values using County + City mapping
UPDATE US_Project.US_Household_Income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;

-- Step 15: Check for inconsistencies in the 'Type' column
SELECT Type, COUNT(Type)
FROM US_Project.US_Household_Income
GROUP BY Type
;

-- Step 16: Standardize naming in the 'Type' column
UPDATE US_Project.US_Household_Income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

-- Step 17: Identify missing, zero, or null values in 'ALand' and 'AWater'
SELECT ALand, AWater
FROM US_Project.US_Household_Income
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL)
;
