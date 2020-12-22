-- SQL QUERIES--
-- 1 --
SELECT name, address
FROM analyst a
WHERE NOT EXISTS(
    SELECT name, address
    FROM analyses a1
    WHERE a1.id = 'B-789' AND (a1.instant) NOT IN (
        SELECT instant
        FROM analyses a2
        WHERE a2.id = 'B-789'AND a2.name = a.name AND a2.address = a.address AND NOT EXISTS(
            SELECT instant
            FROM incident i
            WHERE i.id = 'B-789' AND i.instant NOT IN (
                SELECT instant
                FROM analyses a3
                WHERE a3.id = 'B-789')
            )
        )
    );

-- 2 --
SELECT sname, saddress, gpslat, gpslong
FROM substation
WHERE gpslat >= 39.336775
ORDER BY gpslat;

-- 3 --
SELECT e.id,
       COALESCE(i.count, 0) as total_count
FROM element e LEFT OUTER JOIN (
    SELECT id, COUNT(*)
    FROM incident
    GROUP BY id) i ON e.id = i.id
GROUP BY (e.id, i.count)
HAVING COALESCE(i.count, 0) <= ALL(
    SELECT coalesce(i.count, 0)
    FROM element e LEFT OUTER JOIN (
        SELECT id, COUNT(*)
        FROM incident
        GROUP BY id) i ON e.id = i.id
    );

-- 4 --
SELECT sup.name, sup.address,
       coalesce(sub.count, 0) as total_count
FROM supervisor sup LEFT OUTER JOIN substation sub on sup.name = sub.sname and sup.address = sub.saddress
GROUP BY (sup.name, sup.address);