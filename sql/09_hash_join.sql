-------------------------------------------------------------------------------
--- Lekérdezés optimalizálása 
-------------------------------------------------------------------------------

\c konyvesbolt

--- Nested loop helyett hash join

WITH LatestOrders AS (
    SELECT
        r.vasarlo_id,
        r.rendeles_id, 
        r.rend_datum,
        r.rend_statusz,
        ROW_NUMBER() OVER (PARTITION BY r.vasarlo_id ORDER BY r.rend_datum DESC) AS rn
    FROM
        rendelesek r
)
SELECT
    v.nev AS vasarlo_nev,
    v.email AS vasarlo_email,
    lo.rend_datum AS rendeles_datum,
    lo.rend_statusz AS rendezes_statusz,
    k.konyv_cim AS konyv_cim,
    rt.tetel_ar AS konyv_ar,
    rt.rend_mennyseg AS rendelesi_mennyiseg
FROM
    vasarlo v
JOIN LatestOrders lo ON v.vasarlo_id = lo.vasarlo_id AND lo.rn = 1
JOIN
    rendelesi_tetel rt ON lo.rendeles_id = rt.rendeles_id
JOIN
    konyv k ON rt.konyv_id = k.konyv_id
ORDER BY
    v.nev, lo.rend_datum DESC;

