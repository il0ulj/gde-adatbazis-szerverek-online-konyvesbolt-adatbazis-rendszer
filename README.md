# GDE
## Adatbázis-szerverek
### Online Könyvesbolt Adatbázis Rendszer Kialakítása feladat leírása

# Cél
Egy online könyvesbolt adatbázis rendszerének kialakítása, megvalósítása és elemzése. Az adatbázisnak képesnek kell lennie kezelni a könyvek, vásárlók, rendelések és számlák adatait, valamint automatizálnia kell bizonyos műveleteket tárolt eljárások segítségével, mint például a rendelés teljesítése és számlázás.

# Feladatok
## Adatbázis tervezés
- Tervezd meg az online könyvesbolt adatbázist, vedd figyelembe a szükséges táblákat.
- Tervezd meg az indexeket a hatékony lekérdezés érdekében.

## Adatok beszúrása
- Készíts SQL INSERT utasításokat az adatok táblákba történő beszúrásához.

## Lekérdezések megírása
- Készíts lekérdezéseket, amelyek információt nyújtanak az egyes könyvek elérhetőségéről, a vásárlók vásárlási előzményeiről és a rendelések státuszáról.

## Triggerek megírása
- Hozz létre egy triggert, ami automatikusan frissíti a könyv készletét (elérhető/nem elérhető), amikor egy rendelés teljesül.

## Tárolt eljárások megírása
- Írj egy tárolt eljárást a számla generálására a vásárlás alapján.
- Készíts tárolt eljárásokat, amelyek különféle statisztikákat és riportokat generálnak, például a legjobban fogyó könyvek és a legaktívabb vásárlók alapján.

## Vásárlók tábla particionálása
- Particionáld a vásárlók adatait tartalmazó táblát régió (pl. város) alapján.

## Adatbázis teljesítmény analízis
- Töltsd fel a táblákat legalább 10 000 rekorddal (használhatsz generált adatokat, hogy szimuláld a valós adatbázis terhelést)
- Írj egy összetett SQL lekérdezést, amely több táblából olvas adatokat (pl. Vásárlók legutóbbi rendelései és a rendelésükhöz tartozó könyvek).
- Elemezd, hogyan teljesít az adatbázis a lekérdezések és műveletek során, és tegyél javaslatokat a teljesítmény optimalizálására (indexek stb.).

# Beadandók
- Az adatbázis tervezését bemutató dokumentáció.
- SQL scriptek (táblák létrehozása, adatok beszúrása, lekérdezések, triggerek, tárolt eljárások).
- Teljesítményanalízis jelentés.

# Értékelési szempontok
- A tervezés logikai felépítése és megvalósíthatósága.
- Az SQL scriptek helyessége és hatékonysága.
- A teljesítményanalízis alapossága és a benne foglalt javaslatok relevanciája.
