-------------------------------------------------------------------------------
--- Tábla particiónálás
-------------------------------------------------------------------------------

\c konyvesbolt

--- Táblapartició létrehozása város alapján

CREATE TABLE vasarlo_cim_part (
    vasarlo_cim_id SERIAL NOT NULL,
    vasarlo_id INT REFERENCES vasarlo(vasarlo_id) ON DELETE CASCADE,
    cim VARCHAR(255) NOT NULL,
    orszag VARCHAR(100) NOT NULL,
    varos VARCHAR(100) NOT NULL,
    ir_szam VARCHAR(10) NOT NULL,
    CONSTRAINT vasarlo_cim_part_pkey PRIMARY KEY (vasarlo_cim_id, varos)
) PARTITION BY LIST (varos);

CREATE TABLE vasarlo_cim_petervaros PARTITION OF vasarlo_cim_part FOR VALUES IN ('Péterváros');
CREATE TABLE vasarlo_cim_lennevaros PARTITION OF vasarlo_cim_part FOR VALUES IN ('Lenneváros');
