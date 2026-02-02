-- Find which county had the most months with unemployment rates above the state average:
--     Write a query to calculate the state average unemployment rate.
--     Use this query in the WHERE clause of an outer query to filter for months above the average.
--     Use Select to count the number of months each county was above the average. Which country had the most?
SELECT county, COUNT(*) AS months_above_average
FROM unemployment
WHERE value > (SELECT AVG(value)
				FROM unemployment)
GROUP BY county
ORDER BY months_above_average DESC;
-- Giles, Sevier, Benton, and Loudon are all tied at 65 months.

-- Find the average number of jobs created for each county based on projects involving the largest capital investment by each company:
--     Write a query to find each company’s largest capital investment, returning the company name along with the relevant capital investment amount for each.
--     Use this query in the FROM clause of an outer query, alias it, and join it with the original table.
--     Use Select * in the outer query to make sure your join worked properly
--     Adjust the SELECT clause to calculate the average number of jobs created by county.
SELECT county, ROUND(AVG(new_jobs)) AS avg_new_jobs
FROM (SELECT company, MAX(capital_investment) AS investment
	FROM ecd
	GROUP BY company) AS largest_investments
INNER JOIN ecd
ON ecd.capital_investment = largest_investments.investment
	AND ecd.company = largest_investments.company
GROUP BY county;
