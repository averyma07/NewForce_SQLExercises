-- How many rows are in the athletes table?
SELECT COUNT(*)
FROM athletes;
-- 4216
-- How many distinct athlete ids?
SELECT COUNT(DISTINCT id)
FROM athletes;
-- 4215

-- Which years are represented in the summer_games, winter_games, and country_stats tables?
SELECT DISTINCT year
FROM summer_games;
-- 2016
SELECT DISTINCT year
FROM winter_games;
-- 2014
SELECT DISTINCT year
FROM country_stats
ORDER BY year;
-- 2000-2016

-- How many distinct countries are represented in the countries and country_stats table?
SELECT COUNT(DISTINCT country)
FROM countries;
-- 203
SELECT COUNT(DISTINCT country_id)
FROM country_stats;
-- 203

-- How many distinct events are in the winter_games and summer_games table?
SELECT COUNT(DISTINCT event)
FROM winter_games;
-- 32
SELECT COUNT(DISTINCT event)
FROM summer_games;
-- 95

-- Count the number of athletes who participated in the summer games for each country. Your output should have country name and number of athletes in their own columns. Did any country have no athletes?
SELECT country, COUNT(athlete_id) AS number_athletes
FROM summer_games
	FULL JOIN countries
		ON country_id = id
GROUP BY country
ORDER BY COUNT(athlete_id);
-- No country had 0 athletes

SELECT country, SUM(all_games.bronze) AS total_bronze
FROM countries
	INNER JOIN (SELECT *
				FROM summer_games
				UNION
				SELECT *
				FROM winter_games) AS all_games
		ON id = country_id
GROUP BY country
ORDER BY total_bronze DESC NULLS LAST;

-- Write a query to list countries by total bronze medals, with the highest totals at the top and nulls at the bottom. 
SELECT country, SUM(summer_games.bronze) AS total_bronze
FROM countries
	INNER JOIN summer_games
		ON id = summer_games.country_id
GROUP BY country
ORDER BY total_bronze DESC NULLS LAST;
--Adjust the query to only return the country with the most bronze medals
SELECT country, SUM(summer_games.bronze) AS total_bronze
FROM countries
	INNER JOIN summer_games
		ON id = summer_games.country_id
GROUP BY country
ORDER BY total_bronze DESC NULLS LAST
LIMIT 1;

-- Calculate the average population in the country_stats table for countries in the winter_games. This will require 2 joins.
---First query gives you country names and the average population
---Second query returns only countries that participated in the winter_games
SELECT countries.country, ROUND(AVG(CAST(country_stats.pop_in_millions AS numeric) * 1000000)) AS avg_pop
FROM countries
	INNER JOIN country_stats
		ON id = country_stats.country_id
	INNER JOIN winter_games
		ON id = winter_games.country_id
GROUP BY countries.country;

-- Identify countries where the population decreased from 2000 to 2006.
SELECT countries.country, countries_2000.pop_in_millions AS pop_2000, countries_2006.pop_in_millions AS pop_2006
FROM country_stats AS countries_2000
	INNER JOIN country_stats AS countries_2006
		USING (country_id)
	INNER JOIN countries
		ON country_id = id
WHERE countries_2000.year = '2000-01-01'
	AND countries_2006.year = '2006-01-01'
	AND CAST(countries_2000.pop_in_millions AS numeric) > CAST(countries_2006.pop_in_millions AS numeric);