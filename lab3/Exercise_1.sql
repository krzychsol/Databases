--1 Podaj liczbę produktów o cenach mniejszych niż 10$ lub większych niż 20$
SELECT COUNT(*) AS 'Ilosc' FROM Products WHERE UnitPrice NOT BETWEEN 10 AND 20

--2 Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20$
SELECT MAX(UnitPrice) AS 'Max cena poznizej 20$' FROM Products WHERE UnitPrice < 20

--3 Podaj maksymalną i minimalną i średnią cenę produktu dla produktów o produktach sprzedawanych w butelkach (‘bottle’)
SELECT MAX(UnitPrice) AS 'Maks',MIN(UnitPrice) AS 'Min',AVG(UnitPrice) AS 'Srednia' FROM Products WHERE QuantityPerUnit LIKE '%bottle%'

--4 Wypisz informację o wszystkich produktach o cenie powyżej średniej
SELECT * FROM Products WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)

--5 Podaj sumę/wartość zamówienia o numerze 10250
SELECT CAST(SUM(UnitPrice*Quantity*(1-Discount)) AS DECIMAL(9,2)) AS 'Summary' FROM [Order Details] WHERE OrderID = 10250
