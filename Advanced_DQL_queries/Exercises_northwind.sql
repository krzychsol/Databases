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


