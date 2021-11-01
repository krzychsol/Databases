/*
1. Napisz polecenie, które oblicza wartość sprzedaży dla każdego zamówienia
w tablicy order details i zwraca wynik posortowany w malejącej kolejności
(wg wartości sprzedaży).
 */

 SELECT OrderID,SUM(UnitPrice*Quantity*(1-Discount)) AS 'Value'
 FROM [Order Details]
 GROUP BY OrderID
 ORDER BY 'Value' DESC

--2 Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwracało pierwszych 10 wierszy
 SELECT TOP 10 OrderID,SUM(UnitPrice*Quantity*(1-Discount)) AS 'Value'
 FROM [Order Details]
 GROUP BY OrderID
 ORDER BY 'Value' DESC

--3 Podaj liczbę zamówionych jednostek produktów dla produktów, dla których productid < 3
SELECT ProductID,SUM(Quantity) AS 'Summary quantity'
FROM [Order Details]
WHERE ProductID < 3
GROUP BY ProductID

--4 Zmodyfikuj zapytanie z poprzedniego punktu, tak aby podawało liczbę zamówionych jednostek produktu dla wszystkich produktów
SELECT ProductID,SUM(Quantity) AS 'Summary quantity'
FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID

--5 Podaj nr zamówienia oraz wartość zamówienia, dla zamówień, dla których
-- łączna liczba zamawianych jednostek produktów jest > 250

SELECT OrderID,SUM(UnitPrice*Quantity*(1-Discount)) AS 'Value'
FROM [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity) > 250

--6 Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień
SELECT EmployeeID,COUNT(EmployeeID) AS 'Number of tasks' FROM Orders GROUP BY EmployeeID

--7 Dla każdego spedytora/przewoźnika podaj wartość "opłata za przesyłkę"
--przewożonych przez niego zamówień
SELECT ShipVia,OrderID,SUM(Freight) AS 'Opłata za przesyłkę'
FROM Orders
GROUP BY ShipVia, OrderID
WITH ROLLUP

--8 Dla każdego spedytora/przewoźnika podaj wartość "opłata za przesyłkę"
--przewożonych przez niego zamówień w latach o 1996 do 1997

SELECT ShipVia,OrderID,SUM(Freight) AS 'Opłata za przesyłkę'
FROM Orders
WHERE YEAR(ShippedDate) BETWEEN 1996 AND 1997
GROUP BY ShipVia, OrderID
WITH ROLLUP

--9
--Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z
--podziałem na lata i miesiące

SELECT EmployeeID,COUNT(EmployeeID) AS 'Num of tasks',YEAR(OrderDate) AS 'Year',MONTH(OrderDate) AS 'Month'
FROM Orders
GROUP BY EmployeeID, YEAR(OrderDate), MONTH(OrderDate)

--10
--Dla każdej kategorii podaj maksymalną i minimalną cenę produktu w tej
--kategorii

SELECT CategoryID,MIN(UnitPrice) AS 'Min',MAX(UnitPrice) AS 'Max'
FROM Products
GROUP BY CategoryID
