-------------------------------------------------------------------------------
--- Adabázis létrehozása
-------------------------------------------------------------------------------

CREATE DATABASE konyvesbolt;

\c konyvesbolt

-------------------------------------------------------------------------------
--- Táblák létrehozása
-------------------------------------------------------------------------------

--- szerzo tábla létrehozása

CREATE TABLE szerzo (
    szerzo_id SERIAL NOT NULL,
    nev VARCHAR(255) NOT NULL,
    CONSTRAINT szerzo_pkey PRIMARY KEY (szerzo_id)
);

--- konyv tábla létrehozása

CREATE TABLE konyv (
    konyv_id SERIAL NOT NULL,
    konyv_cim VARCHAR(255) NOT NULL,
    szerzo_id INT REFERENCES szerzo(szerzo_id) ON DELETE SET NULL,
    ar NUMERIC(10, 2) NOT NULL,
    keszlet INT CHECK (keszlet >= 0),
    elerheto BOOLEAN DEFAULT TRUE,
    CONSTRAINT konyv_pkey PRIMARY KEY (konyv_id)
);

--- vasarlo tábla létrehozása

CREATE TABLE vasarlo (
    vasarlo_id SERIAL NOT NULL,
    nev VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    tel_szam VARCHAR(20),
    CONSTRAINT vasarlo_pkey PRIMARY KEY (vasarlo_id)
);

--- vasarlo_cim tábla létrehozása

CREATE TABLE vasarlo_cim (
    vasarlo_cim_id SERIAL NOT NULL,
    vasarlo_id INT REFERENCES vasarlo(vasarlo_id) ON DELETE CASCADE,
    cim VARCHAR(255) NOT NULL,
    orszag VARCHAR(100) NOT NULL,
    varos VARCHAR(100) NOT NULL,
    ir_szam VARCHAR(10) NOT NULL,
    CONSTRAINT vasarlo_cim_pkey PRIMARY KEY (vasarlo_cim_id)
);

--- rendelesek tábla létrehozása

CREATE TABLE rendelesek (
    rendeles_id SERIAL NOT NULL,
    vasarlo_id INT REFERENCES vasarlo(vasarlo_id) ON DELETE CASCADE,
    rend_datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    telj_rend_osszeg NUMERIC(10, 2),
    rend_statusz VARCHAR(50) DEFAULT 'Függőben',
    CONSTRAINT rendelesek_pkey PRIMARY KEY (rendeles_id)
);

--- rendelesi_tetel tábla létrehozása

CREATE TABLE rendelesi_tetel (
    rendelesi_tetel_id SERIAL NOT NULL,
    rendeles_id INT REFERENCES rendelesek(rendeles_id) ON DELETE CASCADE,
    konyv_id INT REFERENCES konyv(konyv_id),
    rend_mennyseg INT CHECK (rend_mennyseg > 0),
    tetel_ar NUMERIC(10, 2),
    CONSTRAINT rendelesi_tetel_pkey PRIMARY KEY (rendeles_id, konyv_id)
);

--- szamla tábla létrehozása

CREATE TABLE szamla (
    szamla_id SERIAL NOT NULL,
    rendeles_id INT REFERENCES rendelesek(rendeles_id) ON DELETE CASCADE,
    telj_osszeg NUMERIC(10, 2),
    szaml_kiall_datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT szamla_pkey PRIMARY KEY (szamla_id)
);

-------------------------------------------------------------------------------
--- Adatok betöltése
-------------------------------------------------------------------------------

--- szerzo tábla feltöltése

INSERT INTO szerzo (nev)
VALUES
('Marék Veronika'),
('Kordos Szabolcs'),
('Blake Crouch');

--- konyv tábla feltöltése

INSERT INTO konyv (konyv_cim, szerzo_id, ar, keszlet, elerheto)
VALUES
('Boribon autózik', 1, 2650, 1500, TRUE),
('Egy város titkai', 2, 7590, 5000, TRUE),
('Sötét anyag', 3, 3585, 1800, TRUE);

--- vasarlo tábla feltöltése

INSERT INTO vasarlo (nev, email, tel_szam)
VALUES
('Vevő Veronika', 'vevovera84@gmail.com', '06413456789'),
('Vásárl Ódett', 'v.odett1978@freemail.hu', '06513456789');

--- vasarlo_cim tábla feltöltése

INSERT INTO vasarlo_cim (vasarlo_id, cim, orszag, varos, ir_szam)
VALUES
(1, 'Babits Mihály utca 7.', 'Magyarország', 'Péterváros', '10111'),
(2, 'József Attila utca 14.', 'Magyarország', 'Lenneváros', '24024');

--- rendelesek tábla feltöltése

INSERT INTO rendelesek (vasarlo_id, rend_datum, telj_rend_osszeg, rend_statusz)
VALUES
(1, CURRENT_TIMESTAMP, 5300, 'Függőben'),
(2, CURRENT_TIMESTAMP, 3585, 'Függőben');

--- rendelesi_tetel tábla feltöltése

INSERT INTO rendelesi_tetel (rendeles_id, konyv_id, rend_mennyseg, tetel_ar)
VALUES
(1, 1, 2, 2650),
(2, 3, 1, 3585);

--- szamla tábla feltöltése

INSERT INTO szamla (rendeles_id, telj_osszeg)
VALUES
(1, 5300),
(2, 3585);
