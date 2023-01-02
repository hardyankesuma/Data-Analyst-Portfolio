--Joins, inner join, full/left/right outer joins
SELECT *
FROM SQLPractice.dbo.EmployeeDemographics

SELECT *
FROM SQLPractice.dbo.EmployeeSalary

--Adding rows values into the table
INSERT INTO SQLPractice.dbo.EmployeeDemographics(EmployeeID, FirstName, LastName, Age, Gender)
VALUES(1011, 'Ryan', 'Howard', 26, 'Male'), (NULL, 'Holly', 'Flax', NULL, NULL), (1013, 'Darryl', 'Philbin', NULL, 'Male')

INSERT INTO SQLPractice.dbo.EmployeeSalary(EmployeeID, JobTitle, Salary)
VALUES(1010, NULL, 47000), (NULL, 'Salesman', 43000)

--Join combines based on common column (In this case, EmployeeID)
--Inner join combines all common values
--Left Outer Join combines all values that are in the first table
--Right Outer Join combines all values that are in the second table
--Full Outer Join combines all values in both tables regardless its values
SELECT *
FROM SQLPractice.dbo.EmployeeDemographics
Inner Join SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM SQLPractice.dbo.EmployeeDemographics
Left Outer Join SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT *
FROM SQLPractice.dbo.EmployeeDemographics
Full Outer Join SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--Selecting several columns after join
--Finding the average salary of salesmen
SELECT JobTitle, AVG(Salary) AS AverageSalary
FROM SQLPractice.dbo.EmployeeDemographics
INNER JOIN SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

CREATE TABLE SQLPractice.dbo.WareHouseEmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

INSERT INTO SQLPractice.dbo.WareHouseEmployeeDemographics
VALUES (1050, 'Roy', 'Anderson', 31, 'Male'), (1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'), (1052, 'Val', 'Johnson', 31, 'Female'), (1013, 'Darryl', 'Philbin', NULL, 'Male')

--UNION similar to join, but same columns will be directly joined together + Removing duplicates, whereas UNION ALL still has duplicates
--UNION ONLY WORKS FOR TABLES WITH THE SAME COLUMNS
SELECT *
FROM SQLPractice.dbo.EmployeeDemographics
UNION
SELECT *
FROM SQLPractice.dbo.WareHouseEmployeeDemographics

--Case Statement (Like if statement)
SELECT FirstName, LastName, Age,
CASE
	WHEN Age > 30 THEN 'Old'
	WHEN Age BETWEEN 27 AND 30 THEN 'Quite Young'
	ELSE 'Young'
END AS AgeCategory
FROM SQLPractice.dbo.EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

SELECT FirstName, LastName, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * 0.1)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * 0.05)
	WHEN JobTitle = 'HR' THEN Salary + (Salary * 0.01)
	ELSE Salary + (Salary * 0.03)
END AS NewSalary
FROM SQLPractice.dbo.EmployeeDemographics
INNER JOIN SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
ORDER BY NewSalary DESC

--Having Clause
SELECT JobTitle, COUNT(JobTitle) AS JobTitleCount
FROM SQLPractice.dbo.EmployeeDemographics
INNER JOIN SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1
ORDER BY JobTitleCount DESC
--Having is like WHERE, but WHERE cannot run for aggregated values (From GROUP BY function)
--Having is used after the GROUP BY function

--UPDATE/DELETING DATA
UPDATE SQLPractice.dbo.EmployeeDemographics
SET EmployeeID = 1012, Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly'

SELECT *
FROM SQLPractice.dbo.EmployeeDemographics

--Delete is to remove an entire row/rows
DELETE FROM SQLPractice.dbo.EmployeeDemographics
WHERE EmployeeID = 1005

--ALIASING
SELECT FirstName + ' ' + LastName AS FullName, Sal.Salary
FROM SQLPractice.dbo.EmployeeDemographics AS Demo
JOIN SQLPractice.dbo.EmployeeSalary AS Sal
ON Demo.EmployeeID = Sal.EmployeeID

--PARTITION BY
--Quite similar with group by, but PARTITION BY can aggregate only 1 function without making the others affected
SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM SQLPractice.dbo.EmployeeDemographics AS Demo
JOIN SQLPractice.dbo.EmployeeSalary AS Sal
ON Demo.EmployeeID = Sal.EmployeeID