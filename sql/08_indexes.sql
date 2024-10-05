-------------------------------------------------------------------------------
--- Indexelés beállítása
-------------------------------------------------------------------------------

\c konyvesbolt

--- vasarlo tábla

CREATE INDEX idx_rendelesek_vasarlo_datum ON rendelesek (vasarlo_id, rend_datum DESC);
CREATE INDEX idx_vasarlo_id ON vasarlo (vasarlo_id);
