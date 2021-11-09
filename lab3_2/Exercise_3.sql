--1 Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień
SELECT EmployeeID,COUNT(EmployeeID) AS 'Number of tasks' FROM Orders GROUP BY EmployeeID

--2 Dla każdego spedytora/przewoźnika podaj wartość "opłata za przesyłkę"
--przewożonych przez niego zamówień
SELECT ShipVia,OrderID,SUM(Freight) AS 'Opłata za przesyłkę'
FROM Orders
GROUP BY ShipVia, OrderID
WITH ROLLUP

--3 Dla każdego spedytora/przewoźnika podaj wartość "opłata za przesyłkę"
--przewożonych przez niego zamówień w latach o 1996 do 1997

SELECT ShipVia,OrderID,SUM(Freight) AS 'Opłata za przesyłkę'
FROM Orders
WHERE YEAR(ShippedDate) BETWEEN 1996 AND 1997
GROUP BY ShipVia, OrderID
WITH ROLLUP