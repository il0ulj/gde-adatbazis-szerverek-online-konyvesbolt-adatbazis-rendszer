-------------------------------------------------------------------------------
--- Trigger létrehozása
-------------------------------------------------------------------------------

\c konyvesbolt

--- Trigger függvény létrehozása

CREATE OR REPLACE FUNCTION frissit_keszlet() 
RETURNS TRIGGER AS $$
DECLARE
    aktualis_keszlet INT;
BEGIN
    SELECT keszlet INTO aktualis_keszlet FROM konyv WHERE konyv_id = NEW.konyv_id;
    
    IF aktualis_keszlet < NEW.rend_mennyseg THEN
        RAISE EXCEPTION 'Nincs elegendő készlet. Jelenlegi készlet: %, Rendelési mennyiség: %', aktualis_keszlet, NEW.rend_mennyseg;
    END IF;
    
    UPDATE konyv
    SET keszlet = keszlet - NEW.rend_mennyseg
    WHERE konyv_id = NEW.konyv_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER frissit_keszlet_trigger
AFTER INSERT ON rendelesi_tetel
FOR EACH ROW EXECUTE FUNCTION frissit_keszlet();

--- Trigger létrehozása

CREATE TRIGGER frissit_konyv_keszlet
AFTER INSERT ON rendelesi_tetel
FOR EACH ROW
EXECUTE FUNCTION frissit_keszlet();
