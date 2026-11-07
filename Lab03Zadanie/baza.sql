DROP TABLE IF EXISTS pozycje_zamowien CASCADE;
DROP TABLE IF EXISTS zamowienia CASCADE;
DROP TABLE IF EXISTS pracownicy CASCADE;
DROP TABLE IF EXISTS klienci CASCADE;
DROP TABLE IF EXISTS produkty CASCADE;
DROP TABLE IF EXISTS kategorie CASCADE;

CREATE TABLE kategorie (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(120) NOT NULL,
    opis TEXT
);

CREATE TABLE produkty (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(250) NOT NULL,
    kategoria_id INT REFERENCES kategorie(id),
    cena NUMERIC(10,2) NOT NULL,
    ilosc_magazyn INT NOT NULL,
    data_dodania DATE NOT NULL
);

CREATE TABLE klienci (
    id SERIAL PRIMARY KEY,
    imie VARCHAR(80) NOT NULL,
    nazwisko VARCHAR(80) NOT NULL,
    email VARCHAR(150) NOT NULL,
    data_rejestracji DATE NOT NULL,
    miasto VARCHAR(100) NOT NULL
);

CREATE TABLE pracownicy (
    id SERIAL PRIMARY KEY,
    imie VARCHAR(80) NOT NULL,
    nazwisko VARCHAR(80) NOT NULL,
    stanowisko VARCHAR(100) NOT NULL,
    data_zatrudnienia DATE NOT NULL
);

CREATE TABLE zamowienia (
    id SERIAL PRIMARY KEY,
    klient_id INT REFERENCES klienci(id),
    pracownik_id INT REFERENCES pracownicy(id),
    data_zamowienia DATE NOT NULL,
    status VARCHAR(50) NOT NULL
);

CREATE TABLE pozycje_zamowien (
    id SERIAL PRIMARY KEY,
    zamowienie_id INT REFERENCES zamowienia(id),
    produkt_id INT REFERENCES produkty(id),
    ilosc INT NOT NULL,
    cena_jednostkowa NUMERIC(10,2) NOT NULL
);

INSERT INTO kategorie (nazwa, opis) VALUES 
('Odżywki i Suplementy', 'Białka, kreatyny, przedtreningówki i witaminy'),
('Sprzęt i Akcesoria Treningowe', 'Ciężary, gryfy, pasy kulturystyczne i opaski');

INSERT INTO produkty (nazwa, kategoria_id, cena, ilosc_magazyn, data_dodania) VALUES
('Białko Izolat WPC 2kg GymBeam', 1, 249.00, 15, CURRENT_DATE - INTERVAL '10 days'),
('Gryf Olimpijski Chromowany 220cm', 2, 599.00, 2, CURRENT_DATE - INTERVAL '35 days'),
('Kreatyna Monohydrat 500g', 1, 89.99, 4, CURRENT_DATE - INTERVAL '2 days'),
('Pas Kulturystyczny Skórzany', 2, 199.00, 12, CURRENT_DATE - INTERVAL '18 days'),
('Przedtreningówka PumpSchock 400g', 1, 139.00, 8, CURRENT_DATE - INTERVAL '4 days'),
('Paski do podciągania (para)', 2, 45.00, 60, CURRENT_DATE - INTERVAL '6 days'),
('Hantle regulowane 2x20kg', 2, 340.00, 0, CURRENT_DATE - INTERVAL '50 days'),
('Shaker do odżywek 700ml Black', 1, 29.90, 120, CURRENT_DATE - INTERVAL '1 day'),
('Opaski na nadgarstki usztywniające', 2, 55.00, 20, CURRENT_DATE - INTERVAL '12 days'),
('Roller do masażu piankowy GRID', 2, 94.50, 0, CURRENT_DATE - INTERVAL '8 days'),
('Magnezja w płynie 250ml Grip', 2, 39.00, 35, CURRENT_DATE - INTERVAL '14 days');

INSERT INTO klienci (imie, nazwisko, email, data_rejestracji, miasto) VALUES
('Mariusz', 'Kowalski', 'pudzian@silka.pl', CURRENT_DATE - INTERVAL '580 days', 'Wroclaw'),
('Kamil', 'Kowalewski', 'kamil.dzik@wp.pl', CURRENT_DATE - INTERVAL '80 days', 'Poznan'),
('Sylwia', 'Szostak', 'sylwia.trener@gmail.com', CURRENT_DATE - INTERVAL '400 days', 'Białystok'),
('Anna', 'Podolska', 'ania.p@o2.pl', CURRENT_DATE - INTERVAL '150 days', 'Wroclaw'),
('Artur', 'Andrzejewski', 'artur.a@power.pl', CURRENT_DATE - INTERVAL '25 days', 'Rzeszów'),
('Mateusz', 'Borkowski', 'mati.b@poczta.pl', CURRENT_DATE - INTERVAL '5 days', 'Kielce');

INSERT INTO pracownicy (imie, nazwisko, stanowisko, data_zatrudnienia) VALUES
('Sebastian', 'Kurek', 'Trener/Sprzedawca', '2025-01-10');

INSERT INTO zamowienia (klient_id, pracownik_id, data_zamowienia, status) VALUES
(1, 1, CURRENT_DATE - INTERVAL '110 days', 'zrealizowane'),
(2, 1, CURRENT_DATE - INTERVAL '14 days', 'anulowane'),
(3, 1, CURRENT_DATE - INTERVAL '6 days', 'anulowane'),
(4, 1, CURRENT_DATE - INTERVAL '3 days', 'w realizacji');

INSERT INTO pozycje_zamowien (zamowienie_id, produkt_id, ilosc, cena_jednostkowa) VALUES
(1, 2, 1, 599.00),
(2, 1, 2, 249.00),
(3, 3, 1, 89.99);

-- 1
SELECT nazwa, cena 
FROM produkty 
WHERE cena > 200 
ORDER BY cena DESC;

-- 2
SELECT imie, nazwisko, miasto 
FROM klienci 
WHERE miasto IN ('Wroclaw', 'Poznan');

-- 3
SELECT nazwa, cena 
FROM produkty 
ORDER BY cena ASC 
LIMIT 10;

-- 4
SELECT * 
FROM zamowienia 
WHERE status = 'anulowane' 
ORDER BY data_zamowienia DESC;

-- 5    
SELECT * 
FROM produkty 
WHERE nazwa LIKE 'P%';

-- 6
SELECT * 
FROM produkty 
WHERE ilosc_magazyn < 5;

-- 7
SELECT * 
FROM klienci 
WHERE data_rejestracji > CURRENT_DATE - INTERVAL '500 days';

-- 8
(SELECT nazwa, cena, 'najdrozsze' AS typ 
 FROM produkty 
 ORDER BY cena DESC 
 LIMIT 5)
UNION ALL
(SELECT nazwa, cena, 'najtansze' AS typ 
 FROM produkty 
 ORDER BY cena ASC 
 LIMIT 5);

-- 9
SELECT * 
FROM produkty 
WHERE data_dodania >= CURRENT_DATE - INTERVAL '30 days';

-- 10
SELECT DISTINCT miasto 
FROM klienci;

-- 11
SELECT nazwisko AS oryginal, UPPER(nazwisko) AS wielkimi_literami 
FROM klienci;

-- 12
SELECT * 
FROM produkty 
WHERE ROUND(cena) BETWEEN 90 AND 110;

-- 13
SELECT * 
FROM klienci 
WHERE nazwisko LIKE '%ski' OR imie LIKE 'A%';

-- 14
SELECT * 
FROM zamowienia 
ORDER BY data_zamowienia ASC 
LIMIT 5;

-- 15
SELECT * 
FROM produkty 
WHERE cena NOT BETWEEN 100 AND 300;

-- 16
SELECT nazwa, (CURRENT_DATE - data_dodania) AS dni_od_dodania 
FROM produkty 
ORDER BY dni_od_dodania DESC;
