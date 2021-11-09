/*
1.Dla każdego zamówienia podaj łączną liczbę zamówionych jednostek towaru oraz nazwę klienta.
 */

SELECT DISTINCT [Order Details].OrderID,SUM(Quantity),CompanyName FROM [Order Details]
LEFT JOIN Orders O on O.OrderID = [Order Details].OrderID
INNER JOIN Customers C on O.CustomerID = C.CustomerID
GROUP BY [Order Details].OrderID,C.CompanyName

/*
2. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których
łączna liczbę zamówionych jednostek jest większa niż 250
 */

SELECT DISTINCT [Order Details].OrderID,SUM(Quantity) AS t,CompanyName FROM [Order Details]
LEFT JOIN Orders O on O.OrderID = [Order Details].OrderID
INNER JOIN Customers C on O.CustomerID = C.CustomerID
GROUP BY [Order Details].OrderID,C.CompanyName
HAVING SUM(Quantity) > 250

/*
3.Dla każdego zamówienia podaj łączną wartość tego zamówienia oraz nazwę klienta.
 */

SELECT DISTINCT [Order Details].OrderID,CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) ,CompanyName
FROM [Order Details]
LEFT JOIN Orders O on O.OrderID = [Order Details].OrderID
INNER JOIN Customers C on O.CustomerID = C.CustomerID
GROUP BY [Order Details].OrderID,C.CompanyName

/*
4. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia,
dla których łączna liczba jednostek jest większa niż 250.
 */

SELECT DISTINCT [Order Details].OrderID,CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)),CompanyName
FROM [Order Details]
LEFT JOIN Orders O on O.OrderID = [Order Details].OrderID
INNER JOIN Customers C on O.CustomerID = C.CustomerID
GROUP BY [Order Details].OrderID,C.CompanyName
HAVING CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) > 250

/*
5. Zmodyfikuj poprzedni przykład tak żeby dodać jeszcze imię i nazwisko
pracownika obsługującego zamówienie
 */

SELECT DISTINCT [Order Details].OrderID,CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)),CompanyName,E.FirstName,E.LastName
FROM [Order Details]
LEFT JOIN Orders O on O.OrderID = [Order Details].OrderID
INNER JOIN Customers C on O.CustomerID = C.CustomerID
INNER JOIN  Employees E on O.EmployeeID = E.EmployeeID
GROUP BY [Order Details].OrderID,C.CompanyName, E.FirstName,E.LastName
HAVING CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) > 250

/*
1. Dla każdej kategorii produktu (nazwa), podaj łączną liczbę zamówionych przez
klientów jednostek towarów z tek kategorii.
*/

SELECT CategoryName,SUM(Quantity) AS 'Quantity'
FROM Categories
LEFT JOIN Products P on Categories.CategoryID = P.CategoryID
INNER JOIN [Order Details] [O D] on P.ProductID = [O D].ProductID
GROUP BY CategoryName

/*
2. Dla każdej kategorii produktu (nazwa), podaj łączną wartość zamówionych przez
klientów jednostek towarów z tek kategorii.
*/

SELECT CategoryName,CAST(ROUND(SUM(Quantity*P.UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) AS 'TotalValue'
FROM Categories
LEFT JOIN Products P on Categories.CategoryID = P.CategoryID
INNER JOIN [Order Details] [O D] on P.ProductID = [O D].ProductID
GROUP BY CategoryName

/*
3. Posortuj wyniki w zapytaniu z poprzedniego punktu wg:
a) łącznej wartości zamówień
b) łącznej liczby zamówionych przez klientów jednostek towarów.
*/

--a
SELECT CategoryName,CAST(ROUND(SUM(Quantity*P.UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) AS 'TotalValue'
FROM Categories
LEFT JOIN Products P on Categories.CategoryID = P.CategoryID
INNER JOIN [Order Details] [O D] on P.ProductID = [O D].ProductID
GROUP BY CategoryName
ORDER BY CAST(ROUND(SUM(Quantity*P.UnitPrice*(1-Discount)),2) AS DECIMAL(9,2))

--b
SELECT CategoryName,SUM(Quantity) AS 'Quantity'
FROM Categories
LEFT JOIN Products P on Categories.CategoryID = P.CategoryID
INNER JOIN [Order Details] [O D] on P.ProductID = [O D].ProductID
GROUP BY CategoryName
ORDER BY SUM(Quantity)

/*
4. Dla każdego zamówienia podaj jego wartość uwzględniając opłatę za przesyłkę
 */

SELECT [Order Details].OrderID,CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)+Freight),2) AS DECIMAL(9,2)) AS 'TotalValue'
FROM [Order Details]
LEFT JOIN Orders O on O.OrderID = [Order Details].OrderID
GROUP BY [Order Details].OrderID

/*
1. Dla każdego przewoźnika (nazwa) podaj liczbę zamówień które przewieźli w 1997r
 */

SELECT Suppliers.CompanyName,COUNT(*) AS 'OrdersNumber'
FROM Suppliers
LEFT JOIN Products P on Suppliers.SupplierID = P.SupplierID
INNER JOIN [Order Details] [O D] on P.ProductID = [O D].ProductID
INNER JOIN Orders O on [O D].OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY Suppliers.CompanyName

/*
2. Który z przewoźników był najaktywniejszy (przewiózł największą liczbę
zamówień) w 1997r, podaj nazwę tego przewoźnika
*/

SELECT TOP 1 Suppliers.CompanyName
FROM Suppliers
LEFT JOIN Products P on Suppliers.SupplierID = P.SupplierID
INNER JOIN [Order Details] [O D] on P.ProductID = [O D].ProductID
INNER JOIN Orders O on [O D].OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY Suppliers.CompanyName
ORDER BY COUNT(*) DESC

/*
3. Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień
obsłużonych przez tego pracownika
*/

SELECT FirstName,LastName,COUNT(*) AS OrdersPerEmployee
FROM Employees
LEFT JOIN Orders O on Employees.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] [O D] on O.OrderID = [O D].OrderID
GROUP BY FirstName, LastName

/*
4. Który z pracowników obsłużył największą liczbę zamówień w 1997r, podaj imię i
nazwisko takiego pracownika
*/

SELECT TOP 1 FirstName,LastName
FROM Employees
LEFT JOIN Orders O on Employees.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] [O D] on O.OrderID = [O D].OrderID
GROUP BY FirstName, LastName
ORDER BY COUNT(*) DESC

/*
5. Który z pracowników obsłużył najaktywniejszy (obsłużył zamówienia o
największej wartości) w 1997r, podaj imię i nazwisko takiego pracownika
*/