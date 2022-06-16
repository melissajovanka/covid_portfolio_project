/*

COVID-19 Infections Code

    */


-- Global COVID-19 Incidence Rate:

SELECT 
    SUM(new_cases) AS total_cases,
    SUM(new_cases) / MAX(population) * 100 AS incidence_rate
FROM
    public.covid_death
WHERE
    continent IS NOT NULL
ORDER BY total_cases;

--COVID-19 Cases By Continent:

SELECT 
    location, SUM(new_cases) AS total_count
FROM
    public.covid_death
WHERE
    continent IS NULL
        AND location NOT ILIKE ('%income')
        AND location NOT IN ('World' , 'European Union', 'International')
GROUP BY location
ORDER BY total_count DESC;

--Highest Percentage of Population Infected by COVID-19 Per Country:

SELECT 
    location,
    population,
    MAX((total_cases / population) * 100) AS infected_population_percentage
FROM
    public.covid_death
WHERE
    continent IS NOT NULL
GROUP BY location , population
ORDER BY infected_population_percentage DESC;

--COVID-19 Infection Rates Over Time Per Country:

SELECT 
    location,
    population,
    date,
    MAX(total_cases / population) * 100 AS infected_population
FROM
    public.covid_death
WHERE
    continent IS NOT NULL
        AND location NOT ILIKE ('%income')
        AND location NOT IN ('World' , 'European Union', 'International')
GROUP BY location , population , date
ORDER BY date DESC;
