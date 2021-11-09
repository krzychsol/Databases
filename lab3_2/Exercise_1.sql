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