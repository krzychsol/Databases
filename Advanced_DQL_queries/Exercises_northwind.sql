/*
Dla każdego klienta znajdź wartość wszystkich złożonych zamówień (weź pod uwagę koszt przesyłki)
 */

SELECT c.CustomerID,c.CompanyName,CAST(ROUND(ISNULL(SUM(Quantity*UnitPrice*(1-Discount))+SUM(Freight),0),2) AS DECIMAL(9,2)) AS total
FROM Customers c
LEFT JOIN Orders O on c.CustomerID = O.CustomerID
LEFT JOIN [Order Details] OD on O.OrderID = OD.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY total

/*
Czy są jacyś klienci, którzy nie złożyli żadnego zamówienia w 1997 roku? Jeśli tak, wyświetl ich dane adresowe. Wykonaj za pomocą operatorów:
a)join b)in c)exist
 */

--a JOIN
SELECT CompanyName,City,Address,PostalCode,Country
FROM Customers C
LEFT JOIN Orders O on C.CustomerID = O.CustomerID AND YEAR(OrderDate)=1997
WHERE OrderDate IS NULL

--b IN
SELECT CompanyName, City, Address, PostalCode, Country
FROM Customers c
WHERE CustomerID NOT IN
      (SELECT CustomerID
       FROM Orders o
       WHERE YEAR(OrderDate) = 1997
         AND o.CustomerID = C.CustomerID)

--c EXIST
SELECT CompanyName, City, Address, PostalCode, Country
FROM Customers c
WHERE NOT EXISTS
      (SELECT CustomerID
       FROM Orders o
       WHERE YEAR(OrderDate) = 1997
         AND o.CustomerID = C.CustomerID)

/*
Dla każdej kategorii produktów wypisz po miesiącach wartość sprzedanych z niej produktów.
Interesują nas tylko lata 1996-1997
 */

SELECT CategoryName,MONTH(OrderDate) AS month,YEAR(OrderDate) AS year,CAST(ROUND(ISNULL(SUM(Quantity*[O D].UnitPrice*(1-Discount)),0),2) AS DECIMAL(9,2)) AS value
FROM Categories
JOIN Products P on Categories.CategoryID = P.CategoryID
JOIN [Order Details] [O D] on P.ProductID = [O D].ProductID
JOIN Orders O on [O D].OrderID = O.OrderID
WHERE YEAR(OrderDate) = 1996 OR YEAR(OrderDate) = 1997
GROUP BY CategoryName, MONTH(OrderDate), YEAR(OrderDate)
ORDER BY CategoryName

/*
Dla każdego produktu podaj nazwę jego kategorii, nazwę produktu, cenę, średnią cenę wszystkich
produktów danej kategorii, różnicę między ceną produktu a średnią ceną wszystkich produktów
danej kategorii, dodatkowo dla każdego produktu podaj wartośc jego sprzedaży w marcu 1997
 */

SELECT CategoryName,P.ProductName,P.UnitPrice,
       (SELECT AVG(p.UnitPrice) FROM Products p WHERE p.ProductID=c.CategoryID) AS [avg price],
       P.UnitPrice - (SELECT AVG(p.UnitPrice) FROM Products p WHERE p.ProductID=c.CategoryID) AS difference,
       ISNULL((SELECT CAST(ROUND(ISNULL(SUM(Quantity*UnitPrice*(1-Discount)),0),2) AS DECIMAL(9,2))
       FROM [Order Details] od
       JOIN Orders O on od.OrderID = O.OrderID
        AND year(OrderDate) = 1997
        AND month(OrderDate) = 3
        WHERE P.ProductID = od.ProductID),0) AS inMarch
FROM Categories C
JOIN Products P on C.CategoryID = P.CategoryID

-- Produkty kupowane przez więcej niż jednego klienta w marcu 1997
SELECT DISTINCT od.ProductID
FROM [Order Details] od
JOIN Orders o on od.OrderID = o.OrderID
WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 3
GROUP BY od.ProductID
HAVING COUNT(*) > 1
ORDER BY od.ProductID

-- Podaj produkty kupowane przez więcej niż jednego klienta w marcu 1997 - wersja z labów
with o1 as
    (select CustomerID, ProductID
    from Orders
    inner join [Order Details] [OD] on Orders.OrderID = [OD].OrderID
    where year(OrderDate) = 1997 and month(OrderDate) = 3)

select distinct [OD].ProductID
from Orders as o2
inner join [Order Details] [OD] on o2.OrderID = [OD].OrderID
inner join o1 on [OD].ProductID = o1.ProductID
where o2.CustomerID > o1.CustomerID and year(OrderDate) = 1997 and month(OrderDate) = 3

--Dla każdego pracownika (imię i nazwisko) podaj łączną wartość zamówień obsłużonych przez tego pracownika
-- (przy obliczaniu wartości zamówień uwzględnij cenę za przesyłkę)
--subqueries

SELECT firstname+' '+lastname AS name,
       (SELECT CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) FROM [Order Details] od
       JOIN Orders o on o.OrderID = od.OrderID
           WHERE e.EmployeeID = o.EmployeeID)
        +
        (SELECT SUM(Freight) FROM Orders o2
        WHERE e.EmployeeID = o2.EmployeeID) AS totalValue
FROM Employees e
ORDER BY FirstName,LastName
--OFFSET 4 ROWS : ZACZYNA OD 5 WIERSZA

--join
SELECT e.EmployeeID,firstname+' '+lastname AS name,
       SUM(Quantity*UnitPrice*(1-Discount)) + (SELECT SUM(Freight) FROM Orders o2
                                                WHERE o2.EmployeeID = e.EmployeeID) AS totalValue
FROM Employees e
JOIN Orders o on e.EmployeeID = o.EmployeeID
JOIN [Order Details] od on o.OrderID = od.OrderID
GROUP BY e.EmployeeID,FirstName,LastName
ORDER BY FirstName,LastName

/*
Który z pracowników obsłużył najaktywniejszy (obsłużył zamówienia o
największej wartości) w 1997r, podaj imię i nazwisko takiego pracownika
 */

--join
SELECT TOP 1 e.EmployeeID,firstname,lastname,
       SUM(Quantity*UnitPrice*(1-Discount))+(SELECT SUM(Freight) FROM Orders o2
                                                WHERE o2.EmployeeID = e.EmployeeID) AS totalValue
FROM Employees e
JOIN Orders O on e.EmployeeID = O.EmployeeID
JOIN [Order Details] od ON O.OrderID = od.OrderID
GROUP BY e.EmployeeID, firstname, lastname
ORDER BY totalValue DESC

/*
Ogranicz wynik z pkt 1 tylko do pracowników
a) którzy mają podwładnych
b) którzy nie mają podwładnych
 */

--a
SELECT e.EmployeeID,e.firstname,e.lastname,
       SUM(Quantity*UnitPrice*(1-Discount))+(SELECT SUM(Freight) FROM Orders o2
                                            WHERE o2.EmployeeID = e.EmployeeID)
FROM Employees e
JOIN Orders O on e.EmployeeID = O.EmployeeID
JOIN [Order Details] od on O.OrderID = od.OrderID
JOIN Employees e2 ON e.EmployeeID = e2.ReportsTo
GROUP BY e.EmployeeID, e.firstname, e.lastname

--b
SELECT e.EmployeeID,e.firstname,e.lastname,
       SUM(Quantity*UnitPrice*(1-Discount))+(SELECT SUM(Freight) FROM Orders o2
                                            WHERE o2.EmployeeID = e.EmployeeID)
FROM Employees e
JOIN Orders O on e.EmployeeID = O.EmployeeID
JOIN [Order Details] od on O.OrderID = od.OrderID
LEFT JOIN Employees e2 ON e.EmployeeID = e2.ReportsTo
WHERE e2.FirstName IS NULL
GROUP BY e.EmployeeID, e.firstname, e.lastname

--Zmodyfikuj rozwiązania z pkt 3 tak aby dla pracowników pokazać jeszcze datę
--ostatnio obsłużonego zamówienia

--a
SELECT TOP 1 e.EmployeeID,e.firstname,e.lastname,
       SUM(Quantity*UnitPrice*(1-Discount))+(SELECT SUM(Freight) FROM Orders o2
                                            WHERE o2.EmployeeID = e.EmployeeID),
       OrderDate
FROM Employees e
JOIN Orders O on e.EmployeeID = O.EmployeeID
JOIN [Order Details] od on O.OrderID = od.OrderID
JOIN Employees e2 ON e.EmployeeID = e2.ReportsTo
GROUP BY e.EmployeeID, e.firstname, e.lastname, OrderDate
ORDER BY OrderDate DESC

--b
SELECT TOP 1 e.EmployeeID,e.firstname,e.lastname,
       SUM(Quantity*UnitPrice*(1-Discount))+(SELECT SUM(Freight) FROM Orders o2
                                            WHERE o2.EmployeeID = e.EmployeeID),
       OrderDate
FROM Employees e
JOIN Orders O on e.EmployeeID = O.EmployeeID
JOIN [Order Details] od on O.OrderID = od.OrderID
LEFT JOIN Employees e2 ON e.EmployeeID = e2.ReportsTo
WHERE e2.FirstName IS NULL
GROUP BY e.EmployeeID, e.firstname, e.lastname,OrderDate
ORDER BY OrderDate DESC

/*
 Zamówienia z Freight większym niż AVG danego roku.
 */

WITH t1 AS
(SELECT YEAR(OrderDate) yr,AVG(Freight) fr
FROM Orders o
GROUP BY YEAR(OrderDate))

SELECT OrderID
FROM Orders
WHERE Freight > (SELECT fr FROM t1
    WHERE YEAR(Orders.OrderDate) = YEAR(yr))

-- 1. Wybierz nazwy i numery telefonów klientów, którym w 1997 roku przesyłki dostarczała firma United Package.

-- subqueries
SELECT CompanyName,Phone
FROM Customers
WHERE CustomerID IN
      (SELECT CustomerID
          FROM Orders
          WHERE YEAR(OrderDate)=1997
          AND ShipVia IN
              (SELECT ShipperID
                  FROM Shippers S
                  WHERE S.CompanyName = 'United Package'))

--join
SELECT DISTINCT C.CompanyName,C.Phone
FROM Customers C
JOIN Orders O on C.CustomerID = O.CustomerID AND YEAR(OrderDate)=1997
JOIN Shippers S on O.ShipVia = S.ShipperID AND S.CompanyName = 'United Package'

-- 2. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii Confections.

-- subqueries
SELECT CompanyName,Phone
FROM Customers
WHERE CustomerID IN
      (SELECT CustomerID
          FROM Orders
          WHERE OrderID IN
                (SELECT OrderID
                    FROM [Order Details] od
                    WHERE ProductID IN
                          (SELECT ProductID
                              FROM Products p
                              WHERE CategoryID IN
                                    (SELECT CategoryID
                                        FROM Categories c
                                        WHERE c.CategoryName = 'Confections'))))

--join
SELECT DISTINCT CompanyName,Phone
FROM Customers c
JOIN Orders O on c.CustomerID = O.CustomerID
JOIN [Order Details] [O D] on O.OrderID = [O D].OrderID
JOIN Products P on [O D].ProductID = P.ProductID
JOIN Categories C2 on C2.CategoryID = P.CategoryID AND C2.CategoryName = 'Confections'

-- 3. Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z kategorii Confections.

--subqueries
SELECT CompanyName,Phone
FROM Customers
WHERE CustomerID NOT IN
      (SELECT CustomerID
          FROM Orders
          WHERE OrderID IN
                (SELECT OrderID
                    FROM [Order Details] od
                    WHERE ProductID IN
                          (SELECT ProductID
                              FROM Products p
                              WHERE CategoryID IN
                                    (SELECT CategoryID
                                        FROM Categories c
                                        WHERE c.CategoryName = 'Confections'))))

--join
SELECT C.CompanyName, C.Phone
FROM Customers AS C
WHERE C.CustomerID NOT IN (SELECT CustomerID
                           FROM Categories AS C
                                    INNER JOIN Products P ON C.CategoryID = P.CategoryID
                                    INNER JOIN [Order Details] OD ON OD.ProductID = P.ProductID
                                    INNER JOIN Orders O ON OD.OrderID = O.OrderID
                           WHERE C.CategoryName = 'Confections')
                           
 --Klienci, którzy nie zamówili nigdy nic z kategorii 'Seafood' w trzech wersjach.

--subqueries
SELECT CustomerID
FROM Customers c
WHERE CustomerID NOT IN
    (SELECT CustomerID
          FROM Orders
          WHERE OrderID IN
                (SELECT OrderID
                    FROM [Order Details] od
                    WHERE ProductID IN
                          (SELECT ProductID
                              FROM Products p
                              WHERE CategoryID IN
                                    (SELECT CategoryID
                                        FROM Categories c
                                        WHERE c.CategoryName = 'Seafood'))))

--join
SELECT CustomerID
FROM Customers c
WHERE CustomerID NOT IN
      (SELECT CustomerID FROM Orders
        JOIN [Order Details] [O D] on Orders.OrderID = [O D].OrderID
        JOIN Products P on [O D].ProductID = P.ProductID
        JOIN Categories C2 on C2.CategoryID = P.CategoryID
        WHERE C2.CategoryName = 'Seafood')

--exist
SELECT CustomerID
FROM Customers c
WHERE NOT EXISTS ( SELECT CustomerID FROM Orders o
                    WHERE o.CustomerID = c.CustomerID
                    AND EXISTS( SELECT OrderID FROM [Order Details] od
                                WHERE od.OrderID = o.OrderID
                                AND EXISTS( SELECT ProductID FROM Products p
                                            WHERE p.ProductID = od.ProductID
                                            AND EXISTS( SELECT CategoryID FROM Categories cat
                                                        WHERE cat.CategoryID = p.CategoryID
                                                        AND cat.CategoryName = 'Seafood'))))
