DROP TABLE IF EXISTS f_incident;
DROP TABLE IF EXISTS d_reporter;
DROP TABLE IF EXISTS d_time;
DROP TABLE IF EXISTS d_location;
DROP TABLE IF EXISTS d_element;


CREATE TABLE d_reporter(
    id_reporter NUMERIC(9) NOT NULL,
    name VARCHAR(80),
    address VARCHAR(80),
    PRIMARY KEY(id_reporter)
);

CREATE TABLE d_time(
    id_time INTEGER NOT NULL,
    day INTEGER NOT NULL,
    week_day INTEGER NOT NULL,
    week INTEGER NOT NULL,
    month INTEGER NOT NULL,
    trimester INTEGER NOT NULL,
    year INTEGER NOT NULL,
    PRIMARY KEY(id_time)

);

CREATE TABLE d_location(
    id_location SERIAL NOT NULL,
    latitude NUMERIC(9,6),
    longitude NUMERIC(8,6),
    locality VARCHAR(80),
    PRIMARY KEY(id_location)
);


CREATE TABLE d_element(
    id_element SERIAL,
    element_id VARCHAR(10),
    element_type VARCHAR(11),
    PRIMARY KEY(id_element)
);

CREATE TABLE f_incident(
    id_reporter NUMERIC(9) NOT NULL,
    id_time INTEGER NOT NULL,
    id_location INTEGER NOT NULL,
    id_element INTEGER NOT NULL,
    severity VARCHAR(30),
    PRIMARY KEY(id_reporter,id_time,id_location,id_element),
    FOREIGN KEY(id_reporter) REFERENCES d_reporter(id_reporter),
    FOREIGN KEY(id_time) REFERENCES d_time(id_time),
    FOREIGN KEY(id_location) REFERENCES d_location(id_location),
    FOREIGN KEY(id_element) REFERENCES d_element(id_element)
);