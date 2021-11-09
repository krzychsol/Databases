/*
1. Dla każdej kategorii produktu (nazwa), podaj łączną liczbę zamówionych przez
klientów jednostek towarów z tej kategorii.
*/

SELECT CategoryName,SUM(Quantity) AS 'Quantity'
FROM Categories
JOIN Products P on Categories.CategoryID = P.CategoryID
JOIN [Order Details] [O D] on P.ProductID = [O D].ProductID
GROUP BY CategoryName

/*
2. Dla każdej kategorii produktu (nazwa), podaj łączną wartość zamówionych przez
klientów jednostek towarów z tej kategorii.
*/

SELECT CategoryName,CAST(ROUND(SUM(Quantity*P.UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) AS 'TotalValue'
FROM Categories
JOIN Products P on Categories.CategoryID = P.CategoryID
JOIN [Order Details] [O D] on P.ProductID = [O D].ProductID
GROUP BY CategoryName

/*
3. Posortuj wyniki w zapytaniu z poprzedniego punktu wg:
a) łącznej wartości zamówień
b) łącznej liczby zamówionych przez klientów jednostek towarów.
*/

--a
SELECT CategoryName,CAST(ROUND(SUM(Quantity*P.UnitPrice*(1-Discount)),2) AS DECIMAL(9,2)) AS 'TotalValue'
FROM Categories
JOIN Products P on Categories.CategoryID = P.CategoryID
JOIN [Order Details] [O D] on P.ProductID = [O D].ProductID
GROUP BY CategoryName
ORDER BY 2

--b
SELECT CategoryName,SUM(Quantity) AS 'Quantity'
FROM Categories
JOIN Products P ON Categories.CategoryID = P.CategoryID
JOIN [Order Details] [O D] ON P.ProductID = [O D].ProductID
GROUP BY CategoryName
ORDER BY 2

/*
4. Dla każdego zamówienia podaj jego wartość uwzględniając opłatę za przesyłkę
 */

SELECT [Order Details].OrderID,CAST(ROUND(SUM(Quantity*UnitPrice*(1-Discount))+Freight,2) AS DECIMAL(9,2)) AS 'TotalValue'
FROM [Order Details]
JOIN Orders O on O.OrderID = [Order Details].OrderID
GROUP BY [Order Details].OrderID,Freight
