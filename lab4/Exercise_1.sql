/*
1.Dla każdego zamówienia podaj łączną liczbę zamówionych jednostek towaru oraz nazwę klienta.
 */

SELECT [Order Details].OrderID,SUM(Quantity) AS TotalQuantity ,CompanyName
FROM [Order Details]
JOIN Orders O on O.OrderID = [Order Details].OrderID
JOIN Customers C on O.CustomerID = C.CustomerID
GROUP BY [Order Details].OrderID,C.CompanyName

/*
2. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia, dla których
łączna liczbę zamówionych jednostek jest większa niż 250
 */

SELECT [Order Details].OrderID,SUM(Quantity) AS totalQuantity,CompanyName FROM [Order Details]
JOIN Orders O on O.OrderID = [Order Details].OrderID
JOIN Customers C on O.CustomerID = C.CustomerID
GROUP BY [Order Details].OrderID,C.CompanyName
HAVING SUM(Quantity) > 250

/*
3.Dla każdego zamówienia podaj łączną wartość tego zamówienia oraz nazwę klienta.
 */

SELECT [Order Details].OrderID,CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) AS Value,CompanyName
FROM [Order Details]
JOIN Orders O on O.OrderID = [Order Details].OrderID
JOIN Customers C on O.CustomerID = C.CustomerID
GROUP BY [Order Details].OrderID,C.CompanyName

/*
4. Zmodyfikuj poprzedni przykład, aby pokazać tylko takie zamówienia,
dla których łączna liczba jednostek jest większa niż 250.
 */

SELECT [Order Details].OrderID,CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) AS 'Value',CompanyName
FROM [Order Details]
JOIN Orders O on O.OrderID = [Order Details].OrderID
JOIN Customers C on O.CustomerID = C.CustomerID
GROUP BY [Order Details].OrderID,C.CompanyName
HAVING CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) > 250

/*
5. Zmodyfikuj poprzedni przykład tak żeby dodać jeszcze imię i nazwisko
pracownika obsługującego zamówienie
 */

SELECT [Order Details].OrderID,CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) AS 'Value',CompanyName,E.FirstName,E.LastName
FROM [Order Details]
JOIN Orders O on O.OrderID = [Order Details].OrderID
JOIN Customers C on O.CustomerID = C.CustomerID
JOIN  Employees E on O.EmployeeID = E.EmployeeID
GROUP BY [Order Details].OrderID,C.CompanyName, E.FirstName,E.LastName
HAVING CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) > 250

