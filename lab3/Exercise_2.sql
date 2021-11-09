--1 Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia
SELECT OrderID,MAX(UnitPrice) AS 'Value' FROM [Order Details] GROUP BY OrderID

--2 Posortuj zamówienia wg maksymalnej ceny produktu
SELECT OrderID,MAX(UnitPrice) AS 'Value' FROM [Order Details] GROUP BY OrderID
ORDER BY 'Value' DESC

--3 Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia
SELECT OrderID,MAX(UnitPrice) AS 'MaxValue',MIN(UnitPrice) AS 'MinValue' FROM [Order Details] GROUP BY OrderID

--4 Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów (przewoźników)
SELECT ShipVia, (SELECT CompanyName FROM Shippers WHERE ShipperID = ShipVia) AS 'Shippers',COUNT(*)
FROM Orders
GROUP BY ShipVia

--5 Który z spedytorów był najaktywniejszy w 1997 roku
SELECT TOP 1 ShipVia,(SELECT CompanyName FROM Shippers WHERE ShipperID = ShipVia) AS 'Shippers',COUNT(*)
AS 'Activity' FROM Orders
WHERE YEAR(ShippedDate) = 1997
GROUP BY ShipVia
ORDER BY 'Activity' DESC