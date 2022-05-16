--Overview of the CovidDeaths Data with the needed columns
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM SQLPortfolio.dbo.CovidDeaths
ORDER BY location, date

--Death Probability if got infected by Covid in Indonesia
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Percentage
FROM SQLPortfolio.dbo.CovidDeaths
WHERE location = 'Indonesia'
ORDER BY location, date DESC

--Total cases of Covid vs Population in Indonesia
SELECT location, date, population, total_cases, (total_cases/population)*100 AS Covid_Percentage
FROM SQLPortfolio.dbo.CovidDeaths
WHERE location = 'Indonesia'
ORDER BY location, date

--Top countries with highest infection rates (More than 5 million population and >20% case)
SELECT location, population, MAX(total_cases) AS Highest_Case, MAX(total_cases/population)*100 AS Highest_Covid_Percentage
FROM SQLPortfolio.dbo.CovidDeaths
WHERE population > 10000000
GROUP BY location, population
HAVING MAX(total_cases/population)*100 > 20
ORDER BY Highest_Covid_Percentage DESC

--Top countries with highest death count (Convert total_deaths into int since the database set it into varchar)
SELECT location, MAX(cast(total_deaths as int)) AS HighestDeathCount
FROM SQLPortfolio.dbo.CovidDeaths
--It is needed to get rid of locations which are considered as groupings of countries such as EUROPE, WORLD, etc.
WHERE continent is NOT NULL
GROUP BY location
ORDER BY HighestDeathCount DESC

--Top continents with highest death count
SELECT location, MAX(cast(total_deaths as int)) AS HighestDeathCount
FROM SQLPortfolio.dbo.CovidDeaths
WHERE continent is NULL and location NOT IN ('World', 'Upper middle income', 'High income', 'Lower middle income', 'European Union', 'Low income', 'International')
GROUP BY location
ORDER BY HighestDeathCount DESC

--Daily Global Case, Global Deaths and its Death percentage
SELECT date, SUM(new_cases) AS DailyGlobalCase, SUM(cast(new_deaths as int)) AS DailyGlobalDeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS DailyDeathPercentage
FROM SQLPortfolio.dbo.CovidDeaths
WHERE continent is NOT NULL
GROUP BY date
ORDER BY date

--Joining Both Tables (Total population vs New Vaccinated)
SELECT Dth.continent, Dth.location, Dth.date, Dth.population, Vac.new_vaccinations
FROM SQLPortfolio.dbo.CovidDeaths AS Dth
INNER JOIN SQLPortfolio.dbo.CovidVaccinations AS Vac
ON Dth.location = Vac.location AND Dth.date = Vac.date
WHERE Dth.continent is NOT NULL
ORDER BY 1,2,3

--Total population vs Total Vaccinated day by day (Increment) for each country
--Use CTE for the created table
WITH PopulationVsVaccinated(Continent, Location, Date, Population, New_Vaccinations, IncrementNumberOfVaccinations)
AS 
(SELECT Dth.continent, Dth.location, Dth.date, Dth.population, Vac.new_vaccinations,
SUM(cast(Vac.new_vaccinations as bigint)) OVER (PARTITION BY Dth.location ORDER BY Dth.location, Dth.date) AS IncrementNumberOfVaccinations
FROM SQLPortfolio.dbo.CovidDeaths AS Dth
INNER JOIN SQLPortfolio.dbo.CovidVaccinations AS Vac
ON Dth.location = Vac.location AND Dth.date = Vac.date
WHERE Dth.continent is NOT NULL
)

SELECT *, (IncrementNumberOfVaccinations/Population)*100 AS VaccinePercentage
FROM PopulationVsVaccinated



--CREATE VIEWS TO SAVE THE TABLES
--Continent Death Count View
CREATE VIEW ContinentDeathCount AS
SELECT location, MAX(cast(total_deaths as int)) AS HighestDeathCount
FROM SQLPortfolio.dbo.CovidDeaths
WHERE continent is NULL and location NOT IN ('World', 'Upper middle income', 'High income', 'Lower middle income', 'European Union', 'Low income', 'International')
GROUP BY location

SELECT *
FROM ContinentDeathCount

