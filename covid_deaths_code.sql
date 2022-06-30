/*
COVID-19 Deaths Code
    */

-- Global Death Percentage:

WITH gobal_deaths (total_cases, total_deaths)
AS(
SELECT 
    SUM(new_cases) AS total_infections,
    SUM(new_deaths) AS total_deaths
FROM
    public.covid_death
WHERE
    continent IS NOT NULL
ORDER BY total_cases
	)
	SELECT *, (total_deaths / total_infections)*100 AS global_death_percentage
	FROM gobal_deaths;

-- Global COVID-19 Deaths Over Time:

SELECT 
    date, MAX(total_deaths) AS total_deaths
FROM
    public.covid_death
WHERE
    continent IS NOT NULL
GROUP BY date
ORDER BY total_deaths DESC;

-- Global COVID-19 Deaths versus COVID-19 Infections Over Time:

SELECT 
    date, MAX(total_deaths) AS total_deaths, MAX(total_cases) AS total_infections
FROM
    public.covid_death
WHERE
    continent IS NOT NULL
GROUP BY date
ORDER BY total_deaths DESC;

-- Total COVID-19 Infection Percentage versus Total COVID-19 Death Percentage per Year:

WITH gobal_deaths (total_cases, total_deaths, highest_population, date)
AS(
SELECT 
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    MAX(population) AS highest_population,
    date
FROM
    public.covid_death
WHERE
    continent IS NOT NULL
	GROUP BY date
ORDER BY total_cases
	)
	SELECT date, (total_deaths / total_cases)*100 AS global_death_percentage, 
	(total_cases/ highest_population)*100 AS global_infection_percentage
	FROM gobal_deaths;

-- Total COVID-19 Deaths per Continent:

SELECT 
    continent, date, MAX(total_deaths) AS total_deaths
FROM
    public.covid_death
WHERE
    continent IS NOT NULL
GROUP BY continent, date
ORDER BY total_deaths DESC;

-- Total COVID-19 Deaths per Country:

SELECT 
    location,
    MAX(total_deaths) AS total_deaths
FROM
    public.covid_death
WHERE
    continent IS NOT NULL
GROUP BY location
ORDER BY total_deaths DESC;
