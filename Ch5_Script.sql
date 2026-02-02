-- Find Athletes from Summer or Winter Games
-- Write a query to list all athlete names who participated in the Summer or Winter Olympics. Ensure no duplicates appear in the final table using a set theory clause.
(SELECT DISTINCT name
FROM athletes
INNER JOIN summer_games
ON id = athlete_id)
UNION
(SELECT DISTINCT name
FROM athletes
INNER JOIN winter_games
ON id = athlete_id);

-- Find Countries Participating in Both Games
--     Write a query to retrieve country_id and country_name for countries in the Summer Olympics.
--     Add a JOIN to include the country’s 2016 population and exclude the country_id from the SELECT statement.
--     Repeat the process for the Winter Olympics.
--     Use a set theory clause to combine the results.
(SELECT DISTINCT country, pop_in_millions
FROM summer_games
INNER JOIN countries
ON summer_games.country_id = countries.id
INNER JOIN country_stats
ON countries.id = country_stats.country_id
WHERE country_stats.year LIKE '2016-01-01')
INTERSECT
(SELECT DISTINCT country, pop_in_millions
FROM winter_games
INNER JOIN countries
ON winter_games.country_id = countries.id
INNER JOIN country_stats
ON countries.id = country_stats.country_id
WHERE country_stats.year LIKE '2016-01-01');

-- Identify Countries Exclusive to the Summer Olympics
-- Return the country_name and region for countries present in the countries table but not in the winter_games table.
-- (Hint: Use a set theory clause where the top query doesn’t involve a JOIN, but the bottom query does.)
(SELECT country, region
FROM countries)
EXCEPT
(SELECT country, region
FROM countries
INNER JOIN winter_games
ON id = country_id);