/*
1. Dla każdego przewoźnika (nazwa) podaj liczbę zamówień które przewieźli w 1997r
 */

SELECT Shippers.CompanyName,COUNT(*) AS 'OrdersNumber'
FROM Shippers
JOIN Orders ON Shippers.ShipperID = Orders.ShipVia
WHERE YEAR(OrderDate) = 1997
GROUP BY Shippers.CompanyName

/*
2. Który z przewoźników był najaktywniejszy (przewiózł największą liczbę
zamówień) w 1997r, podaj nazwę tego przewoźnika
*/

SELECT TOP 1 Shippers.CompanyName,COUNT(*) AS 'OrdersNumber'
FROM Shippers
JOIN Orders ON Shippers.ShipperID = Orders.ShipVia
WHERE YEAR(OrderDate) = 1997
GROUP BY Shippers.CompanyName
ORDER BY OrdersNumber DESC

/*
3. Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień
obsłużonych przez tego pracownika
*/

SELECT FirstName,LastName,CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) AS OrdersPerEmployee
FROM Employees
JOIN Orders O on Employees.EmployeeID = O.EmployeeID
JOIN [Order Details] [O D] on O.OrderID = [O D].OrderID
GROUP BY FirstName, LastName

/*
4. Który z pracowników obsłużył największą liczbę zamówień w 1997r, podaj imię i
nazwisko takiego pracownika
*/

SELECT TOP 1  FirstName,LastName,COUNT(*)
FROM Employees
JOIN Orders O on Employees.EmployeeID = O.EmployeeID
JOIN [Order Details] [O D] on O.OrderID = [O D].OrderID
WHERE YEAR(OrderDate) = 1997
GROUP BY FirstName, LastName
ORDER BY 3 DESC

/*
5. Który z pracowników obsłużył najaktywniejszy (obsłużył zamówienia o
największej wartości) w 1997r, podaj imię i nazwisko takiego pracownika
*/

SELECT TOP 1 FirstName,LastName,CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) AS OrdersPerEmployee
FROM Employees
JOIN Orders O on Employees.EmployeeID = O.EmployeeID
JOIN [Order Details] [O D] on O.OrderID = [O D].OrderID
WHERE YEAR(OrderDate) = 1997
GROUP BY FirstName, LastName
ORDER BY 3 DESC