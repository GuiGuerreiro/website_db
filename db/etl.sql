--ETL--

-------------------------------
--Populate REPORTER DIMENSION--
-------------------------------
INSERT INTO d_reporter
SELECT phone,name, address
FROM analyst natural join person;

-------------------------------
--Populate element DIMENSION--
-------------------------------

INSERT INTO d_element (element_id,element_type)
SELECT distinct(id),LEFT(id,1)
FROM incident;

-------------------------------
--Populate time dimension--
-------------------------------

CREATE OR REPLACE FUNCTION load_date_dim()
    RETURNS	VOID AS
$$
DECLARE date_value TIMESTAMP;
BEGIN
    date_value := '1950-01-01 00:00:00';
	WHILE date_value < '2050-01-01 00:00:00' LOOP
	    INSERT INTO d_time(
                id_time,
                day,
                week_day,
                week,
                month,
                trimester,
                year
			)
			VALUES (
                        EXTRACT(YEAR FROM date_value) *	10000
                            + EXTRACT(MONTH FROM date_value)*100
                            + EXTRACT(DAY FROM date_value),
			            EXTRACT(DAY FROM date_value),
                        EXTRACT(DOW FROM date_value), --Day of week:0-6 , Sunday to Saturday
                        EXTRACT(WEEK FROM date_value),
                        EXTRACT(MONTH FROM date_value),
                        EXTRACT(QUARTER FROM date_value),
                        EXTRACT(YEAR FROM date_value)
		            );
		date_value := date_value + INTERVAL	'1	DAY';
    END	LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT load_date_dim();

---------------------------
--Locality dimension POPULATE--
---------------------------
--For elements that do not have location
INSERT INTO d_location VALUES('0','0','0','Unknown');
--The rest of the elements
INSERT INTO d_location (latitude,longitude,locality)
SELECT DISTINCT gpslat,gpslong,locality
FROM substation;
--------------------------
--Fact Table populate--
-------------------------
INSERT INTO f_incident
SELECT id_reporter,id_time, id_location, id_element, severity --nao sei como a severity
FROM (incident i LEFT OUTER JOIN analyses a
                    ON i.instant = a.instant
                    AND i.id = a.id
                 LEFT OUTER JOIN (SELECT id,locality
                                  FROM transformer tr
                                  INNER JOIN substation sub
                                    ON tr.gpslat = sub.gpslat
                                    AND tr.gpslong = sub.gpslong) AS localofid
                    ON localofid.id = i.id) as op_t

    LEFT OUTER JOIN d_reporter r
        ON r.name = op_t.name
        AND r.address = op_t.address

    LEFT OUTER JOIN d_time t
        ON t.day = (EXTRACT DAY from op_t.instant)
        AND t.week_day = (EXTRACT DOW from op_t.instant)
        AND t.week = (EXTRACT WEEK from op_t.instant)
        AND t.month = (EXTRACT MONTH from op_t.instant)
        AND t.trimester = (EXTRACT QUARTER from op_t.instant)
        AND t.year = (EXTRACT YEAR from op_t.instant)
    LEFT OUTER JOIN  d_location l
        ON l.id_location = op_t.locality
    LEFT OUTER JOIN d_element e
        ON e.element_id = op_t.id

GROUP BY ROLLUP (id_reporter,id_time, id_location, id_element);

