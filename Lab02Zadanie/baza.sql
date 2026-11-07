DROP TABLE IF EXISTS filmy CASCADE;
DROP TABLE IF EXISTS kategorie CASCADE;

CREATE TABLE kategorie (
    id SERIAL PRIMARY KEY,
    nazwa VARCHAR(50) NOT NULL,
    opis TEXT
);

CREATE TABLE filmy (
    id SERIAL PRIMARY KEY,
    tytul VARCHAR(150) NOT NULL,
    kategoria_id INT REFERENCES kategorie(id),
    rok_premiery INT,
    cena_wypozyczenia NUMERIC(5,2) NOT NULL,
    data_dodania DATE DEFAULT CURRENT_DATE,
    dostepny BOOLEAN DEFAULT TRUE
);
INSERT INTO kategorie (nazwa, opis) VALUES
    ('Sci-Fi', 'Filmy fantastycznonaukowe i przyszłość'),
    ('Akcja', 'Szybkie tempo, pościgi i walki'),
    ('Dramat', 'Poruszające historie ludzkie'),
    ('Komedia', 'Lekka tematyka i humor'),
    ('Horror', 'Filmy grozy i dreszczowce'),
    ('Animacja', 'Filmy animowane dla dzieci i dorosłych'),
    ('Przygoda', 'Wyprawy, odkrywanie nieznanego i wyzwania'),
    ('Kryminał', 'Zagadki kryminalne, detektywi i policja'),
    ('Fantasy', 'Magia, fikcyjne światy i stworzenia'),
    ('Dokumentalny', 'Filmy oparte na faktach i prawdziwych wydarzeniach');

INSERT INTO filmy (tytul, kategoria_id, rok_premiery, cena_wypozyczenia, data_dodania, dostepny) VALUES
    ('Incepcja', 1, 2010, 14.99, '2026-01-10', TRUE),
    ('Matrix', 1, 1999, 12.50, '2026-01-12', TRUE),
    ('Mroczny Rycerz', 2, 2008, 14.99, '2026-01-15', FALSE),
    ('Skazani na Shawshank', 3, 1994, 9.99, '2026-01-20', TRUE),
    ('Nietykalni', 4, 2011, 11.00, '2026-01-22', TRUE),
    ('Lśnienie', 5, 1980, 8.99, '2026-02-01', FALSE),
    ('Król Lew', 6, 1994, 10.00, '2026-02-05', TRUE),
    ('Interstellar', 1, 2014, 15.99, '2026-02-10', TRUE),
    ('Władca Pierścieni: Drużyna Pierścienia', 9, 2001, 13.99, '2026-02-15', TRUE),
    ('Pulp Fiction', 8, 1994, 10.50, '2026-02-20', TRUE);

-- 5. Sprawdzenie zawartości obu tabel
SELECT * FROM kategorie;
SELECT * FROM filmy;
