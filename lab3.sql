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

--6 Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia
SELECT OrderID,MAX(UnitPrice) AS 'Value' FROM [Order Details] GROUP BY OrderID

--7 Posortuj zamówienia wg maksymalnej ceny produktu
SELECT OrderID,MAX(UnitPrice) AS 'Value' FROM [Order Details] GROUP BY OrderID
ORDER BY 'Value' DESC

--8 Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia
SELECT OrderID,MAX(UnitPrice) AS 'MaxValue',MIN(UnitPrice) AS 'MinValue' FROM [Order Details] GROUP BY OrderID

--9 Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów (przewoźników)
SELECT ShipVia, (SELECT CompanyName FROM Shippers WHERE ShipperID = ShipVia) AS 'Shippers',COUNT(*)
FROM Orders
GROUP BY ShipVia

--10 Który z spedytorów był najaktywniejszy w 1997 roku
SELECT TOP 1 ShipVia,(SELECT CompanyName FROM Shippers WHERE ShipperID = ShipVia) AS 'Shippers',COUNT(*)
AS 'Activity' FROM Orders
WHERE YEAR(ShippedDate) = 1997
GROUP BY ShipVia
ORDER BY 'Activity' DESC

--Który z spedytorów zarobił najwięcej
SELECT TOP 1 ShipVia,SUM(Freight) FROM Orders
WHERE YEAR(ShippedDate) = 1997
GROUP BY ShipVia

--11 Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5
SELECT OrderID AS 'Value' FROM [Order Details] GROUP BY OrderID HAVING COUNT(*) > 5

--12 Wyświetl klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień
--(wyniki posortuj malejąco wg łącznej kwoty za dostarczenie zamówień dla
--każdego z klientów)

SELECT CustomerID,SUM(Freight) AS 'Value' FROM Orders
WHERE YEAR(ShippedDate) = 1998
GROUP BY CustomerID
HAVING COUNT(*) > 8
ORDER BY 'Value' DESC

/*13
Napisz polecenie, które oblicza wartość sprzedaży dla każdego zamówienia
w tablicy order details i zwraca wynik posortowany w malejącej kolejności
(wg wartości sprzedaży).
*/

SELECT OrderID,CONVERT(DECIMAL(9,2),SUM(UnitPrice*Quantity*(1-Discount))) AS 'Price'
FROM [Order Details]
GROUP BY OrderID
ORDER BY 'Price' DESC

--PRACA DOMOWA

--1 Ile lat przepracował w firmie każdy z pracowników?
SELECT FirstName,LastName,YEAR(GETDATE())-YEAR(HireDate) AS 'Lat w firmie' FROM Employees

--2 Policz sumę lat przepracowanych przez wszystkich pracowników i średni czas pracy w firmie
SELECT SUM(YEAR(GETDATE())-YEAR(HireDate)) AS 'Sum of years',AVG(YEAR(GETDATE())-YEAR(HireDate)) AS 'Average time' FROM Employees

--3 Dla każdego pracownika wyświetl imię, nazwisko oraz wiek
SELECT FirstName,LastName,YEAR(GETDATE())-YEAR(BirthDate) AS 'Wiek' FROM Employees

--4 Policz średni wiek wszystkich pracowników
SELECT AVG(YEAR(GETDATE())-YEAR(BirthDate)) AS 'Sredni wiek' FROM Employees

--5 Wyświetl wszystkich pracowników, którzy mają teraz więcej niż 25 lat.
SELECT * FROM Employees WHERE YEAR(GETDATE())-YEAR(BirthDate) > 25

--6 Policz średnią liczbę miesięcy przepracowanych przez każdego pracownika
SELECT AVG(YEAR(GETDATE())*12 - YEAR(HireDate)*12) AS 'Average num of months' FROM Employees

--7 Wyświetl dane wszystkich pracowników, którzy przepracowali w firmie co najmniej 320 miesięcy, ale nie więcej niż 333
SELECT * FROM Employees WHERE YEAR(GETDATE())*12 - YEAR(HireDate)*12 BETWEEN 320 AND 333

