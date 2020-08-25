/*
-- Esquema para el proyecto gps
CREATE SCHEMA gpsproject
    AUTHORIZATION aovudieocshokj;

COMMENT ON SCHEMA gpsproject
    IS 'Scheme for gps project';

GRANT ALL ON SCHEMA gpsproject TO PUBLIC;

GRANT ALL ON SCHEMA gpsproject TO aovudieocshokj;


-- position

CREATE TABLE gpsproject.position (
    id SERIAL PRIMARY KEY,
    idvehicles INTEGER,
    latitude NUMERIC,
    longitude NUMERIC,
    zoom NUMERIC(3)
);

INSERT INTO gpsproject.position(idvehicles, latitude, longitude, zoom) VALUES (1, 21.161006, 86.830486, 50);
INSERT INTO gpsproject.position(idvehicles, latitude, longitude, zoom) VALUES (1, 22.161006, 87.830486, 50);

-- Vehiculos

CREATE TABLE gpsproject.vehicles(
    id SERIAL PRIMARY KEY,
    plates VARCHAR(10),
    make VARCHAR(255),
    color VARCHAR(16),
    model VARCHAR(4), 
    userid INTEGER REFERENCES authuser.users(id),
    positiongps INTEGER REFERENCES gpsproject.position(id)
);


INSERT INTO gpsproject.vehicles(plates, make, color, model, userid, positiongps) 
VALUES ('GMS-7502', 'VW', 'BACK', '1992', 1, NULL);

UPDATE gpsproject.vehicles
SET positiongps = 1
WHERE id = 1;

-- Disparadores, actuliza la actual posiscion del vehiculo

CREATE FUNCTION gpsproject.newposition_funcion() RETURNS TRIGGER AS $$
BEGIN

UPDATE gpsproject.vehicles
SET positiongps = NEW.id
WHERE id = NEW.idvehicles;

RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER newposition_trigger
    AFTER INSERT
    ON gpsproject."position"
    FOR EACH ROW
    EXECUTE PROCEDURE gpsproject.newposition_funcion();

*/