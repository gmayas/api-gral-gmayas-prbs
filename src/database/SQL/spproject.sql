/*
-- Esquema para el proyecto punto de venta
CREATE SCHEMA spproject
    AUTHORIZATION aovudieocshokj;

COMMENT ON SCHEMA spproject
    IS 'Point of sale project';

GRANT ALL ON SCHEMA spproject TO PUBLIC;

GRANT ALL ON SCHEMA spproject TO aovudieocshokj;


-- catalogo

CREATE TABLE spproject.catalogo (
    id SERIAL PRIMARY KEY,
    grupo VARCHAR(255),
    claveart VARCHAR(6),
    articulo VARCHAR(255),
    urlimagen VARCHAR(255), 
    impuesto NUMERIC(2),
    precio NUMERIC(12,2)
);

INSERT INTO spproject.catalogo (grupo, claveart, articulo, urlimagen, impuesto, precio) 
                        VALUES ('TRUPER', 'T14284', 'Lentes Seguridad Transparentes Ajustables', 
                                'https://http2.mlstatic.com/lentes-seguridad-transparentes-ajustables-truper-14284-D_NQ_NP_689723-MLM32349496376_092019-F.webp',
                                 16, 55);

INSERT INTO spproject.catalogo (grupo, claveart, articulo, urlimagen, impuesto, precio) 
                        VALUES ('TRUPER', 'T14160', 'Juego Desarmadores Precisión Intercambi 29pz, Truper', 
                                'https://http2.mlstatic.com/juego-desarmadores-precision-intercambi-29pz-truper-14160-D_NQ_NP_681478-MLM41773818383_052020-F.webp',
                                 16, 109);

INSERT INTO spproject.catalogo (grupo, claveart, articulo, urlimagen, impuesto, precio) 
                        VALUES ('TRUPER', '491059', 'JUEGO DE HERRAMIENTAS PARA JARDÍN NEGRO TRUPER 4 PIEZAS', 
                                'https://cdn.homedepot.com.mx/productos/491059/491059-z.jpg',
                                 16, 279);


Select id, grupo, claveart, articulo, urlimagen, impuesto, precio from spproject.catalogo Order by articulo; 


-- sales book

CREATE TABLE spproject.salesbook(
    id SERIAL PRIMARY KEY,
    userid INTEGER REFERENCES authuser.users(id),
    artid INTEGER REFERENCES spproject.catalogo(id),
    folio NUMERIC,
    fecha DATE, 
    impuesto NUMERIC(2),
    catidad NUMERIC(12,2),
    precio NUMERIC(12,2)
);