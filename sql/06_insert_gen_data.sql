-------------------------------------------------------------------------------
--- Táblák feltöltése generált adatokkal
-------------------------------------------------------------------------------

\c konyvesbolt

--- szerzo tábla feltöltése

INSERT INTO szerzo (nev)
SELECT 'Szerző ' || i
FROM generate_series(1, 10000) AS s(i);

--- konyv tábla feltöltése

INSERT INTO konyv (konyv_cim, szerzo_id, ar, keszlet, elerheto)
SELECT 
    'Könyv ' || i,
    (FLOOR(RANDOM() * 10000) + 1)::INT,
    ROUND((RANDOM() * 10000)::NUMERIC, 2),
    (FLOOR(RANDOM() * 100000) + 100000)::INT,
    TRUE
FROM generate_series(1, 10000) AS s(i);


--- vasarlo tábla feltöltése

INSERT INTO vasarlo (nev, email, tel_szam)
SELECT 
    'Vásárló ' || i,
    'vasarlo' || i || '@gmail.com',
    '061234567' || LPAD(i::TEXT, 2, '0')
FROM generate_series(1, 10000) AS s(i);

--- vasarlo_cim tábla feltöltése

INSERT INTO vasarlo_cim (vasarlo_id, cim, orszag, varos, ir_szam)
SELECT 
    v.vasarlo_id,
    'Cím ' || v.vasarlo_id,
    'Magyarország',
    'Város ' || (FLOOR(RANDOM() * 100) + 1)::INT,
    LPAD((FLOOR(RANDOM() * 10000))::TEXT, 4, '0')
FROM vasarlo v;

--- rendelesek tábla feltöltése

INSERT INTO rendelesek (vasarlo_id, rend_datum, telj_rend_osszeg, rend_statusz)
SELECT 
    (FLOOR(RANDOM() * 10000) + 1)::INT,
    CURRENT_DATE - INTERVAL '1 day' * FLOOR(RANDOM() * 10)::INT AS rend_datum,
    ROUND((RANDOM() * 10000)::NUMERIC, 2),
    CASE 
        WHEN CURRENT_DATE - INTERVAL '1 day' * FLOOR(RANDOM() * 10)::INT > CURRENT_DATE - INTERVAL '5 days' 
        THEN 'Függőben' 
        ELSE 'Teljesítve' 
    END AS rend_statusz
FROM generate_series(1, 10000) AS gs;

--- rendeles_tetel tábla feltöltése

INSERT INTO rendelesi_tetel (rendeles_id, konyv_id, rend_mennyseg, tetel_ar)
SELECT
    r.rendeles_id,
    k.konyv_id,
    FLOOR(RANDOM() * 5) + 1 AS rend_mennyseg,
    FLOOR(RANDOM() * 9001 + 1000)::INT AS tetel_ar
FROM
    rendelesek r
JOIN (
    SELECT konyv_id, keszlet
    FROM konyv
    WHERE keszlet > 0
    ORDER BY RANDOM()
    LIMIT 10000
) k ON TRUE
ORDER BY
    RANDOM()
LIMIT 10000;

--- szamla tábla feltöltése

INSERT INTO szamla (rendeles_id, telj_osszeg)
SELECT
    r.rendeles_id,
    ROUND((RANDOM() * 10000)::NUMERIC, 2)
FROM rendelesek r;
