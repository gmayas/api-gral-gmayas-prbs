/*
-- Esquema para la autenticación de usuarios

CREATE SCHEMA authuser
    AUTHORIZATION aovudieocshokj;

GRANT ALL ON SCHEMA authuser TO PUBLIC;

GRANT ALL ON SCHEMA authuser TO aovudieocshokj;

COMMENT ON SCHEMA authuser
    IS 'Scheme for user authentication';

-- Tipo de usuarios
CREATE TABLE authuser.typeofuser (
    id SERIAL PRIMARY KEY,
    usertype VARCHAR(40),
    valuedata INTEGER DEFAULT null
);
INSERT INTO authuser.typeofuser(usertype, valuedata) VALUES ('AdminUser', null), ( 'SimpleUser', 1);

-- Usuarios
CREATE TABLE authuser.users (
    id SERIAL PRIMARY KEY,
    emailuser text,
    nameuser VARCHAR(40),
    passworduser VARCHAR(255),
    typeiduser INTEGER REFERENCES authuser.typeofuser(id)
);

INSERT INTO authuser.users(emailuser, nameuser, passworduser, typeiduser) VALUES ('gmayas@gmail.com', 'gmayas', 'p1000',1), ('karen@gmail.com', 'karen', 'p2000', 2), ('andres@gmail.com', 'andres', 'p3000',2);
*/
