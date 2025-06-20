CREATE DATABASE titanic_db;
USE titanic_db;
CREATE TABLE titanic (
    PassengerId INT PRIMARY KEY,
    Survived TINYINT,
    Pclass TINYINT,
    Name VARCHAR(100),
    Sex VARCHAR(10),
    Age FLOAT,
    SibSp TINYINT,
    Parch TINYINT,
    Ticket VARCHAR(50),
    Fare FLOAT,
    Cabin VARCHAR(50),
    Embarked CHAR(1)
);

SELECT * FROM titanic LIMIT 20;

SELECT DISTINCT Age FROM titanic ORDER BY Age;
SELECT DISTINCT Embarked FROM titanic;
SELECT DISTINCT Cabin FROM titanic LIMIT 20;

-- Checking Missing Values
SELECT COUNT(*) FROM titanic
WHERE Age IS NULL OR Age = ''; -- 0 MISSING VALUES

-- Chescking missing cabin values
SELECT COUNT(*) AS MissingCabin FROM titanic WHERE Cabin IS NULL or Cabin = ''; -- 529 empty strings = null

-- Check missing Embarked values
SELECT COUNT(*) AS MissingEmbarked FROM titanic WHERE Embarked IS NULL or Embarked = ''; -- 2 empty strings = null

SET SQL_SAFE_UPDATES = 0;

-- Convert Cabin empty strings to NULL
-- Update Cabin empty strings to NULL (safe with PassengerId)
UPDATE titanic
SET Cabin = NULL
WHERE (Cabin = '' OR Cabin IS NULL)
AND PassengerId IS NOT NULL;

-- Update Embarked empty strings to NULL (safe with PassengerId)
UPDATE titanic
SET Embarked = NULL
WHERE (TRIM(Embarked) = '' OR Embarked IS NULL)
AND PassengerId IS NOT NULL;

SET SQL_SAFE_UPDATES = 1;

-- Checking for Duplicates
SELECT 
    PassengerId,
    COUNT(*) AS DuplicateCount
FROM titanic
GROUP BY PassengerId
HAVING COUNT(*) > 1; -- No Duplicates
 

-- What is the Survival rate?
SELECT ROUND(AVG(Survived) *100, 2) AS SurvivalRate
FROM titanic; -- 40.62

SELECT 
    Sex,
    COUNT(*) AS Total,
    SUM(Survived) AS Survived,
    ROUND(AVG(Survived) * 100, 2) AS SurvivalRate_Percentage
FROM titanic
GROUP BY Sex;


-- Survival by Class 
SELECT 
Pclass,
    COUNT(*) AS Total,
    SUM(Survived) AS Survived,
    ROUND(AVG(Survived) * 100, 2) AS SurvivalRate_Percentage
FROM titanic
GROUP BY Pclass;


-- Average age of Survivers vs Non-Survivers
SELECT 
    Survived,
    COUNT(*) AS Total,
    ROUND(AVG(Age), 2) AS AvgAge
FROM titanic
WHERE Age IS NOT NULL
GROUP BY Survived;

-- Most Common Embarkation port
SELECT 
    Embarked,
    COUNT(*) AS Total
FROM titanic
GROUP BY Embarked
ORDER BY Total DESC
LIMIT 1;

-- Counting Null values for Age, Cabin, Embarked
SELECT
SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS MissingAge,
SUM(CASE WHEN Cabin IS NULL THEN 1 ELSE 0 END) AS MissingCabin,
SUM(CASE WHEN Embarked IS NULL THEN 1 ELSE 0 END) AS MissingEmbarked
FROM titanic;







