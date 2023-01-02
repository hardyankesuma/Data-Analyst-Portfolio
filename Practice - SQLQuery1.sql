--Creating Own Table
CREATE TABLE EmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

CREATE TABLE EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int)

--Filling the Tables
INSERT INTO EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

--Select Statement such as Top, Distinct, Count, As, Max, Min, Avg

--Selecting First and Last Name Columns
SELECT FirstName, LastName FROM EmployeeDemographics

--Selecting just the TOP 5 of all columns
SELECT TOP 5 * FROM EmployeeDemographics

--Selecting Distinct Values from a particular column
SELECT DISTINCT(Age) FROM EmployeeDemographics

--Giving number of rows of values in a column and give that particular column a name
SELECT COUNT(Gender) AS GenderCount
FROM EmployeeDemographics

--Giving the number of distict values in a column (Male and Female = 2)
SELECT COUNT(DISTINCT(Gender)) AS DistictGenderCount
FROM EmployeeDemographics

--Finding maximum/avg/min value in a column
SELECT MAX(Salary) AS MaxSalary
FROM EmployeeSalary

--WHERE STATEMENTS 
--=,<>,<,>,And,Or,Like,Null,Not Null,In

--Selecting all first name with Jim
SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim'
--Use <> for not equal

--Selecting all with age larger than 30 and Male
SELECT *
FROM EmployeeDemographics
WHERE Age > 30 AND Gender = 'Male'

--Uses LIKE (Last Name starts with S)
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%'

--Uses LIKE (Last Name has S in anywhere)
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE '%S%'

--Uses LIKE (Last Name has S in the end)
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE '%S'

--Uses LIKE (Last Name starts with S with o following)
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%o%'

--Uses IN (Some kind of multiple = statements)
--Selecting several first names
SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Michael')

--GROUP BY AND ORDER BY
--Group by gender and counts the number of each gender type available
SELECT Gender, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
GROUP BY Gender

--Group by gender and last name which has S inside
SELECT Gender, LastName, COUNT(Gender) AS PersonCount
FROM EmployeeDemographics
WHERE LastName LIKE '%s%'
GROUP BY Gender, LastName

--Group by gender and age more than 30
SELECT Gender, COUNT(Gender) AS PersonCount
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender

--Ordered by the number of person count
SELECT Gender, COUNT(Gender) AS PersonCount
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY PersonCount DESC

--Order by 2 columns 
SELECT *
FROM EmployeeDemographics
ORDER BY Age, Gender