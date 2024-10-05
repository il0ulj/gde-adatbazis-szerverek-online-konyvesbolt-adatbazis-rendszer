-------------------------------------------------------------------------------
--- Tárolt eljárások tesztelése
-------------------------------------------------------------------------------

\c konyvesbolt

--- Számla generálása

CALL szamla_gen(1);
SELECT * FROM legjobban_fogyo_konyvek(2);
SELECT * FROM legaktivabb_vasarlok(2);
