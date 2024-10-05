# Feladat megoldása
## 01 - Adatbázis létrehozása és feltöltése kis mennyiségű adattal
```
psql -U postgres -h localhost < 01_create-db.sql
```
## 02 - Lekérdezések futtatása, amelyek információt nyújtanak az egyes könyvek elérhetőségéről, a vásárlók vásárlási előzményeiről és a rendelések státuszáról
```
psql -U postgres -h localhost < 02_queries.sql
```
## 03 - Trigger létrehozása ami automatikusan frissíti a könyv készletét (elérhető/nem elérhető), amikor egy rendelés teljesül
```
psql -U postgres -h localhost < 03_trigger.sql
```
### 03 Trigger teszelése
```
psql -U postgres -h localhost < 03_trigger_test.sql
```
## 04 - Tárolt eljárások létrehozása
```
psql -U postgres -h localhost < 04_stored_proc.sql
```
### 04 - Tárolt eljárások tesztelése
```
psql -U postgres -h localhost < 04_stored_proc_test.sql
```
## 05 - Vásárlók tábla particiónálása
```
psql -U postgres -h localhost < 05_part.sql
```
### 05 - Táblaparticiónálás tesztelése
```
psql -U postgres -h localhost < 05_part_test.sql
```
## 06 - Táblák feltöltése generált adatokkal
```
psql -U postgres -h localhost < 06_insert_gen_data.sql
```
### 06 - Lekérdezések futtatása a generált adatokkal
```
psql -U postgres -h localhost < 06_insert_gen_data_query.sql
```
## 07 - Analizís futtatása az indexek létrehozása előtt
```
psql -U postgres -h localhost < 07_analyze.sql
```
## 08 - Indexek létrehozása
```
psql -U postgres -h localhost < 08_indexes.sql
```
## 07 - Analizís futtatása az indexek létrehozását követően
```
psql -U postgres -h localhost < 07_analyze.sql
```
