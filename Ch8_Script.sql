-- Display Country name, 4-digit year, count of Nobel prize winners (where the count is ≥ 1), and country size:
--     Large: Population > 100 million
--     Medium: Population between 50 and 100 million (inclusive)
--     Small: Population < 50 million
-- Sort results so that the country and year with the largest number of Nobel prize winners appear at the top.
-- Export the results as a CSV file.
-- Use Excel to create a chart effectively communicating the findings.
SELECT country, SUBSTRING(year, 1, 4) AS calendar_year, nobel_prize_winners, 
	CASE
		WHEN pop_in_millions::numeric > 100 THEN 'large'
		WHEN pop_in_millions::numeric BETWEEN 50 AND 100 THEN 'medium'
		WHEN pop_in_millions::numeric < 50 THEN 'small'
	END AS country_size
FROM countries
	INNER JOIN country_stats
		ON id = country_id
WHERE nobel_prize_winners > 0
ORDER BY nobel_prize_winners DESC;

-- Create the output below that shows a row for each country and each year. Use COALESCE() to display unknown when the gdp is NULL.
SELECT country,  SUBSTRING(year, 1, 4) AS calendar_year, 
	COALESCE(gdp::numeric::money::text, 'unknown') AS gdp_amount
FROM countries
	INNER JOIN country_stats
		ON id = country_id
ORDER BY country, year;