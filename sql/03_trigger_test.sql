-------------------------------------------------------------------------------
--- Trigger tesztelése
-------------------------------------------------------------------------------

\c konyvesbolt 

--- Előzetes lekérdezés

SELECT konyv_cim, keszlet, elerheto FROM konyv ORDER BY keszlet DESC;

--- Új rendelés betöltése

INSERT INTO rendelesek (vasarlo_id, telj_rend_osszeg, rend_statusz)
VALUES (1, 2650, 'Teljesítve');

--- Új rendelési tétel betöltése

INSERT INTO rendelesi_tetel (rendeles_id, konyv_id, rend_mennyseg, tetel_ar)
VALUES (3, 1, 1, 2650);

--- új számla betöltse

INSERT INTO szamla (rendeles_id, telj_osszeg)
VALUES (3, 2650);

--- Készlet ellenőrzés

SELECT konyv_cim, keszlet, elerheto FROM konyv ORDER BY keszlet DESC;
