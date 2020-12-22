--OLAP QUERIE--

SELECT severity, locality, week_day, COUNT(*)
FROM f_incident natural join d_locality natural join d_time
GROUP BY CUBE(severity, locality, week_day)
ORDER BY severity, locality, week_day, COUNT(*) desc;