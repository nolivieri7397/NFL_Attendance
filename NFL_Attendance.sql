-- avg attendance per team per year -- 
SELECT
	team AS city,
    team_name,
    ROUND(AVG(weekly_attendance), 0) AS avg_weekly_att,
    year
FROM nfl.attendance
GROUP BY team, team_name, year
ORDER BY team_name, year ASC;

-- average att total for all teams per given year --
SELECT
	year,
    ROUND(AVG(total), 0) AS avg_total
FROM nfl.attendance
GROUP BY year
ORDER BY year ASC;

-- highest and lowest attendance per team -- 
SELECT DISTINCT
    a.team AS city,
    a.team_name,
    a.year,
    a.total
FROM nfl.attendance a
JOIN (
    SELECT team,
    MIN(total) AS min_total, 
    MAX(total) AS max_total
    FROM nfl.attendance
    GROUP BY team, team_name
) AS summary
ON a.team = summary.team
AND (a.total = summary.min_total OR a.total = summary.max_total)
ORDER BY a.team_name, a.total;

-- home vs. away attendance gap --
SELECT
	team AS city,
    team_name,
    ROUND(AVG(home), 0) AS avg_home,
    ROUND(AVG(away), 0) AS avg_away,
	ROUND((AVG(home) - AVG(away)), 0) AS avg_gap
FROM nfl.attendance
GROUP BY team, team_name
ORDER BY avg_gap DESC;

-- week and how much it effects season total-- 
SELECT
    team AS city,
    team_name,
    week,
    ROUND((weekly_attendance / total) * 100, 3) AS week_PCT,
    year
FROM nfl.attendance
ORDER BY team, year, week;

    