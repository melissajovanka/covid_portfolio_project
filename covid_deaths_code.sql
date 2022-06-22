-- Global Death Percentage:

WITH gobal_deaths (total_infections, total_deaths)
AS(
SELECT 
    SUM(new_cases) AS total_infections,
    SUM(new_deaths) AS total_deaths
FROM
    public.covid_death
WHERE
    continent IS NOT NULL
ORDER BY total_infections
	)
	SELECT *, (total_deaths / total_infections)*100 AS global_death_percentage
	FROM gobal_deaths;


-- Death Rates over time:

-- Death Rates per Continent:

-- Death Rates per Country:

-- Comorbidity Related Deaths:

-- Deaths per Age Globally:

-- Deaths per Age per Continent: 

