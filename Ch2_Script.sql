-- i. How many counties are represented? How many companies?
SELECT COUNT(DISTINCT county)
FROM ecd;
-- 88
SELECT COUNT(DISTINCT company)
FROM ecd;
-- 764

-- ii. How many companies did not get ANY Economic Development grants (ed) for any of their projects? (Hint, you will probably need a couple of steps to figure this one out)
SELECT COUNT(*)
FROM(
	(SELECT DISTINCT company
	FROM ecd)
	EXCEPT
	(SELECT DISTINCT company
	FROM ecd
	WHERE ed IS NOT NULL));
--576

-- iii. What is the total capital_investment, in millions, when there was a grant received from the fjtap? Call the column fjtap_cap_invest_mil.
SELECT SUM(capital_investment) / 1000000 AS fjtap_cap_invest_mil
FROM ecd
WHERE fjtap IS NOT NULL;
-- $12,634,623,829.00 or 12,634.62 million

-- iv. What is the average number of new jobs for each county_tier?
SELECT county_tier, AVG(new_jobs)
FROM ecd
GROUP BY county_tier
ORDER BY county_tier ASC;
-- 1, 200.69
-- 2, 128.45
-- 3, 112.44
-- 4, 88.99

-- v. How many companies are LLCs? Call this value llc_companies. (Hint, combine COUNT() and DISTINCT(). Also, consider that LLC may not always be capitalized the same in company names. Find a SQL keyword that can help you with this.)
SELECT COUNT(DISTINCT company) AS llc_companies
FROM ecd
WHERE company ILIKE '%LLC%';
-- 114