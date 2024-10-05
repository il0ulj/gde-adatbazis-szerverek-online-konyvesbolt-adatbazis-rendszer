-------------------------------------------------------------------------------
--- Tábla particionálás tesztelése
-------------------------------------------------------------------------------

\c konyvesbolt

INSERT INTO vasarlo (nev, email, tel_szam)
VALUES ('Kiss János', 'j.kiss18@gmail.com', '06612345678');

INSERT INTO vasarlo_cim_part (vasarlo_id, cim, orszag, varos, ir_szam)
VALUES (3, 'Kossuth Lajos utca 10.', 'Magyarország', 'Péterváros', '1053');

SELECT * FROM vasarlo_cim_petervaros;
