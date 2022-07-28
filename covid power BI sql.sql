-- Queries used for PowerBI project

select * 
from portfolioproject.coviddeaths;

# Global Death Percentage

Select sum(new_cases) as total_cases, sum(cast(new_deaths as unsigned)) as total_deaths, sum(cast(new_deaths as unsigned))/sum(new_cases) *100 as DeathPercentage
from portfolioproject.coviddeaths
where continent !=""
order by 1,2;

# Total Death Count by Continent

select continent, sum(cast(new_deaths as unsigned)) as TotalDeathCount
from portfolioproject.coviddeaths
where Continent != ''
group by continent
order by TotalDeathCount desc;

-- Select location, SUM(cast(new_deaths as unsigned)) as TotalDeathCount
-- From PortfolioProject.CovidDeaths
-- Where continent = ''
-- and location not in ('World', 'European Union', 'International','High income','Low income')
-- Group by location
-- order by TotalDeathCount desc;

# Percentage Population infected by Location

select Location, Population, max(total_cases) as HighInfectionCount, max((total_cases)/population) *100 as PercentPopulationInfected
from portfolioproject.coviddeaths
group by Location, Population
order by PercentPopulationInfected desc;

# Percent Population Infected by Date and Location

select Location, Population, Date, max(total_cases) as HighInfectionCount, max((total_cases)/Population) *100 as PercentPopulationInfected
from portfolioproject.coviddeaths
group by Location, Population, date
order by PercentPopulationInfected desc;

# Rolling People Vaccinated by Location

select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(convert(cv.new_vaccinations, unsigned)) over (partition by cd.location order by cd.location, cd.date) as RollingPeopleVaccinated
from portfolioproject.coviddeaths as cd
Join portfolioproject.covidvaccinations as cv
    on cd.location = cv.location 
    and cd.date = cv.date
where cd.continent != ""
order by 2,3;

