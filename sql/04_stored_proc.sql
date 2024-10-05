-------------------------------------------------------------------------------
--- Tárolt eljárás létrehozása
-------------------------------------------------------------------------------

\c konyvesbolt 

--- Számla generálása

CREATE OR REPLACE PROCEDURE szamla_gen(rendeles_id_input INT)
LANGUAGE plpgsql
AS $$
DECLARE
    telj_osszeg NUMERIC(10, 2);
    rend_statusz_var VARCHAR(50);
    vasarlas_datum TIMESTAMP;
    tetelekszoveg TEXT := '';
BEGIN
    SELECT telj_rend_osszeg, rendelesek.rend_statusz, rend_datum INTO telj_osszeg, rend_statusz_var, vasarlas_datum
    FROM rendelesek
    WHERE rendeles_id = rendeles_id_input;
    
    SELECT STRING_AGG(k.konyv_cim, ', ') INTO tetelekszoveg
    FROM rendelesi_tetel rt
    JOIN konyv k ON rt.konyv_id = k.konyv_id
    WHERE rt.rendeles_id = rendeles_id_input;
    
    RAISE NOTICE 'Számla';
    RAISE NOTICE '------';
    RAISE NOTICE 'Rendelés ID-ja: %', rendeles_id_input;
    RAISE NOTICE 'Tételek: %', tetelekszoveg;
    RAISE NOTICE 'Teljes összeg: %', telj_osszeg;
    RAISE NOTICE 'Vásárlás dátuma: %', vasarlas_datum;

    INSERT INTO szamla (rendeles_id, telj_osszeg, szaml_kiall_datum)
    VALUES (rendeles_id_input, telj_osszeg, CURRENT_TIMESTAMP);
    
    UPDATE rendelesek
    SET rend_statusz = 'Teljesítve'
    WHERE rendeles_id = rendeles_id_input;

END $$;

--- Legjobban fogyó könyvek

CREATE OR REPLACE FUNCTION legjobban_fogyo_konyvek(n INT)
RETURNS TABLE(konyv_cim VARCHAR, eladott_mennyiseg INT) AS $$
BEGIN
    RETURN QUERY
    SELECT k.konyv_cim, SUM(rt.rend_mennyseg)::INT AS eladott_mennyiseg
    FROM konyv k
    JOIN rendelesi_tetel rt ON k.konyv_id = rt.konyv_id
    GROUP BY k.konyv_cim
    ORDER BY eladott_mennyiseg DESC
    LIMIT n;
END;
$$ LANGUAGE plpgsql;

--- LEgaktívabb vásárlók

CREATE OR REPLACE FUNCTION legaktivabb_vasarlok(n INT)
RETURNS TABLE(vasarlo_nev VARCHAR, vasarlasok_szama INT) AS $$
BEGIN
    RETURN QUERY
    SELECT v.nev, COUNT(r.rendeles_id)::INT AS vasarlasok_szama
    FROM vasarlo v
    JOIN rendelesek r ON v.vasarlo_id = r.vasarlo_id
    GROUP BY v.vasarlo_id, v.nev
    ORDER BY vasarlasok_szama DESC
    LIMIT n;
END;
$$ LANGUAGE plpgsql;
