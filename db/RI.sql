-- VIEW --
DROP VIEW IF EXISTS sup_with_sub;

CREATE VIEW sup_with_sub
AS SELECT sname, saddress, count(*)
FROM substation
GROUP BY (sname, saddress);

--Invocation of the VIEW
SELECT *
FROM sup_with_sub;

-----------------------------------------------------------------
--Function that returns the voltage of the input busbar
-----------------------------------------------------------------
DROP FUNCTION IF EXISTS voltage_of_busbar(varchar);

CREATE FUNCTION voltage_of_busbar(bus_barID VARCHAR(80))
RETURNS NUMERIC AS
$$
DECLARE bus_bar_volt NUMERIC;
BEGIN
    SELECT voltage into bus_bar_volt
    FROM busbar
    WHERE id = bus_barID;

    RETURN bus_bar_volt;
END;

$$ LANGUAGE plpgsql;

-----------------------------------------------------------------
--PREVENTS IC1 and IC2 when there is an INSERT in transformer
--It deletes from transformer and element if the isert is invalid
-----------------------------------------------------------------

DROP TRIGGER IF EXISTS verify_matching_voltages_trig ON transformer;
CREATE OR REPLACE FUNCTION verify_matching_voltages()
RETURNS TRIGGER AS
$$
BEGIN

    IF new.pv != (SELECT voltage_of_busbar(new.pbbid)) then
        RAISE EXCEPTION 'The voltage of the Primary busbar does not match the primary voltage';

    ELSEIF new.sv != (SELECT voltage_of_busbar(new.sbbid)) then
        RAISE EXCEPTION 'The voltage of the Second busbar does not match the secondary voltage';
    END IF;

    RETURN new;

    EXCEPTION WHEN OTHERS THEN
        DELETE FROM transformer where id = new.id;
        DELETE FROM element where id = new.id;
        RAISE WARNING 'NOT INSERTED: One or Both Bus bars do not match each other';
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER verify_matching_voltages_trig
AFTER INSERT ON transformer
FOR EACH ROW EXECUTE PROCEDURE verify_matching_voltages();

-----------------------------------------------------------------
--PREVENTS IC1 and IC2 when the table transformer is updated
-----------------------------------------------------------------

DROP TRIGGER IF EXISTS verify_matching_voltages_update_trig ON transformer;
CREATE OR REPLACE FUNCTION verify_matching_voltages_update()
RETURNS TRIGGER AS
$$
BEGIN
    IF new.pv != (SELECT voltage_of_busbar(new.pbbid)) then
        RAISE EXCEPTION 'The voltage of the Primary busbar does not match the primary voltage';

    ELSEIF new.sv != (SELECT voltage_of_busbar(new.sbbid)) then
        RAISE EXCEPTION 'The voltage of the Second busbar does not match the secondary voltage';
    END IF;

    RETURN new;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER verify_matching_voltages_update_trig
BEFORE UPDATE ON transformer
FOR EACH ROW EXECUTE PROCEDURE verify_matching_voltages_update();

-----------------------------------------------------------------
--PREVENTS IC5
-----------------------------------------------------------------

DROP TRIGGER IF EXISTS supervisor_limitations_trig ON analyses;
CREATE OR REPLACE FUNCTION supervisor_limitations()
RETURNS TRIGGER AS
$$
BEGIN
    IF new.name = (SELECT sname from transformer NATURAL JOIN substation where id = new.id)
        AND
       new.address = (SELECT saddress FROM transformer NATURAL JOIN substation where id = new.id)
        THEN
        RAISE EXCEPTION 'This Analyst supervises the substation this element belongs. He/She can not annalyze it!';

    END IF;

    RETURN new;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER supervisor_limitations_trig
BEFORE INSERT OR UPDATE ON analyses
FOR EACH ROW EXECUTE PROCEDURE supervisor_limitations();




