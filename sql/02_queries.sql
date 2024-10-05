-------------------------------------------------------------------------------
--- Lekérdezések
-------------------------------------------------------------------------------

\c konyvesbolt

--- Könyvek elérhetősége

SELECT
    sz.nev AS szerzo_nev,
    k.konyv_cim, 
    k.ar, 
    k.keszlet
FROM 
    konyv k
JOIN 
    szerzo sz ON k.szerzo_id = sz.szerzo_id
WHERE 
    k.keszlet > 0
ORDER BY
    k.keszlet DESC;

--- Váráslók vásárlási előzményei

SELECT
    v.nev AS vasarlo_nev, 
    k.konyv_cim,
    rt.rend_mennyseg,
    rt.tetel_ar,
    r.rend_datum
FROM
    vasarlo v
JOIN
    rendelesek r ON v.vasarlo_id = r.vasarlo_id
JOIN
    rendelesi_tetel rt ON r.rendeles_id = rt.rendeles_id
JOIN
    konyv k ON rt.konyv_id = k.konyv_id
ORDER BY
    v.nev, r.rend_datum DESC;

--- Rendelések státusza

SELECT
    r.rendeles_id,
    v.nev AS vasarlo_nev,
    r.rend_statusz,
    r.telj_rend_osszeg,
    r.rend_datum
FROM
    rendelesek r
JOIN
    vasarlo v ON r.vasarlo_id = v.vasarlo_id
ORDER BY
    r.rend_datum DESC;
