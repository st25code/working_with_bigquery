-- Query 1: Countries spending the most on education (as % of GDP)

SELECT country_name, AVG(value) AS avg_spending
FROM `bigquery-public-data.world_bank_intl_education.international_education`
WHERE indicator_code = 'SE.XPD.TOTL.GD.ZS'
AND year >= 2010
GROUP BY country_name
HAVING avg_spending > 5
ORDER BY avg_spending DESC;


-- Query 2: Busiest taxi pickup locations in Chicago

SELECT pickup_community_area, COUNT(*) AS num_pickups
FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE pickup_community_area IS NOT NULL
GROUP BY pickup_community_area
ORDER BY num_pickups DESC
LIMIT 10;


-- Query 3: Average taxi speed per hour in Chicago

WITH RelevantRides AS (
    SELECT 
        EXTRACT(HOUR FROM trip_start_timestamp) AS hour,
        COUNT(*) AS num_trips,
        3600 * SUM(trip_miles) / SUM(trip_seconds) AS avg_mph
    FROM `bigquery-public-data.chicago_taxi_trips.taxi_trips`
    WHERE 
        EXTRACT(MONTH FROM trip_start_timestamp) BETWEEN 2 AND 3
        AND trip_seconds > 0 
        AND trip_miles > 0
    GROUP BY hour
)
SELECT hour, num_trips, avg_mph
FROM RelevantRides
ORDER BY hour;


-- Query 4: Most common programming languages on Stack Overflow

SELECT tag_name, COUNT(*) AS tag_count
FROM `bigquery-public-data.stackoverflow.tags`
GROUP BY tag_name
ORDER BY tag_count DESC
LIMIT 10;


-- Query 5: Find the fastest-growing programming languages on Stack Overflow

WITH yearly_tag_counts AS (
    -- Extract tag names from questions and count occurrences per year
    SELECT tag_name, 
           EXTRACT(YEAR FROM creation_date) AS year, 
           COUNT(*) AS tag_count
    FROM `bigquery-public-data.stackoverflow.posts_questions`, 
    UNNEST(SPLIT(tags, '|')) AS tag_name  -- Split multiple tags stored as a single string
    GROUP BY tag_name, year
),
growth_rate AS (
    -- Compute the growth of each tag over time
    SELECT 
        tag_name,
        MAX(tag_count) AS max_count,  -- Maximum count of the tag in any year
        MIN(tag_count) AS min_count,  -- Minimum count of the tag in any year
        MAX(tag_count) - MIN(tag_count) AS growth,  -- Absolute growth over time
        MIN(year) AS first_year,  -- The first year the tag appeared
        MAX(year) AS last_year  -- The last year the tag appeared
    FROM yearly_tag_counts
    GROUP BY tag_name
)
SELECT 
    tag_name, 
    growth,  -- Total increase in tag usage
    first_year,  -- Year the tag first appeared
    last_year,  -- Most recent year the tag appeared
    ROUND(SAFE_DIVIDE(growth, NULLIF(min_count, 0)), 2) AS growth_ratio  -- Growth ratio to normalize for small values
FROM growth_rate
WHERE growth > 5000  -- Only include tags with significant growth
ORDER BY growth_ratio DESC  -- Rank by relative growth rate
LIMIT 10;  -- Get the top 10 fastest-growing programming languages

