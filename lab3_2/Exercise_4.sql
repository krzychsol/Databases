--1
--Dla każdego pracownika podaj liczbę obsługiwanych przez niego zamówień z
--podziałem na lata i miesiące

SELECT EmployeeID,COUNT(EmployeeID) AS 'Num of tasks',YEAR(OrderDate) AS 'Year',MONTH(OrderDate) AS 'Month'
FROM Orders
GROUP BY EmployeeID, YEAR(OrderDate), MONTH(OrderDate)

--2
--Dla każdej kategorii podaj maksymalną i minimalną cenę produktu w tej
--kategorii

SELECT CategoryID,MIN(UnitPrice) AS 'Min',MAX(UnitPrice) AS 'Max'
FROM Products
GROUP BY CategoryID