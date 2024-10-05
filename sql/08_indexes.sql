-------------------------------------------------------------------------------
--- Indexelés beállítása
-------------------------------------------------------------------------------

\c konyvesbolt

--- rendelesek tábla

CREATE INDEX idx_rendelesek_vasarlo_id_rend_datum ON rendelesek (vasarlo_id, rend_datum);

--- rendelesi_tetel tábla

CREATE INDEX idx_rendelesi_tetel_konyv_id ON rendelesi_tetel (konyv_id);
