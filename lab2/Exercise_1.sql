--1 Napisz polecenie select, za pomocą którego uzyskasz tytuł i numer książki
SELECT title,title_no FROM title

--2 Napisz polecenie, które wybiera tytuł o numerze 10
SELECT title FROM title WHERE title_no = 10

--3  Napisz polecenie select, za pomocą którego uzyskasz numer książki (nr tyułu) i
--autora z tablicy title dla wszystkich książek, których autorem jest Charles
--Dickens lub Jane Austen
SELECT title_no, author FROM title WHERE (author = 'Charles Dickens') OR (author = 'Jane Austen')