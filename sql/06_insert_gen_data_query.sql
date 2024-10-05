-------------------------------------------------------------------------------
--- Összetett lekérdezés
-------------------------------------------------------------------------------

\c konyvesbolt

--- Vásárlók legutóbbi rendelései és a rendelésükhöz tartozó könyvek

SELECT
    v.nev AS vasarlo_nev,
    v.email AS vasarlo_email,
    r.rend_datum AS rendeles_datum,
    r.rend_statusz AS Rendezes_Statusz,
    k.konyv_cim AS Konyv_Cime,
    rt.tetel_ar AS Konyv_Ar,
    rt.rend_mennyseg AS Rendelesi_Mennyiseg
FROM
    vasarlo v
JOIN
    rendelesek r ON v.vasarlo_id = r.vasarlo_id
JOIN
    rendelesi_tetel rt ON r.rendeles_id = rt.rendeles_id
JOIN
    konyv k ON rt.konyv_id = k.konyv_id
WHERE
    r.rend_datum = (
        SELECT MAX(r2.rend_datum)
        FROM rendelesek r2
        WHERE r2.vasarlo_id = v.vasarlo_id
    )
ORDER BY
    v.nev, r.rend_datum DESC;
