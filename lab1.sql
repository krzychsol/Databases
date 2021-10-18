/* Porównywanie napisów:
1. Szukamy informacji o produktach sprzedawanych w butelkach (‘bottle’)
2. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynaj¹ siê
na literê z zakresu od B do L
3. Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynaj¹ siê
na literê B lub L
4. ZnajdŸ nazwy kategorii, które w opisie zawieraj¹ przecinek
5. ZnajdŸ klientów, którzy w swojej nazwie maj¹ w którymœ miejscu s³owo ‘Store’
*/

/*1*/
--SELECT * FROM Products WHERE QuantityPerUnit LIKE '%bottle%'
/*2*/
--SELECT * FROM Employees WHERE LastName LIKE '[B-L]%'
/*3*/
--SELECT * FROM Employees WHERE LastName LIKE '[BL]%'
/*4*/
--SELECT CategoryName FROM Categories WHERE Description LIKE '%,%' 
/*5*/
--SELECT * FROM Customers WHERE CompanyName LIKE '%Store%'

/*Zakres wartoœci:
1. Szukamy informacji o produktach o cenach mniejszych ni¿ 10 lub wiêkszych ni¿ 20
2. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiêdzy 20.00 a 30.00
*/

/*1*/
--SELECT * FROM Products WHERE UnitPrice NOT BETWEEN 10 AND 20
/*2*/
--SELECT ProductName,UnitPrice FROM Products WHERE UnitPrice BETWEEN 20 AND 30

/*Warunki logiczne -
1. Wybierz nazwy i kraje wszystkich klientów maj¹cych siedziby w Japonii (Japan)
lub we W³oszech (Italy)
*/

/*1*/
--SELECT CompanyName,Country FROM Customers WHERE (Country = 'Japan') OR (Country = 'Italy')

/*Æwiczenie
Napisz instrukcjê select tak aby wybraæ numer zlecenia, datê zamówienia, numer
klienta dla wszystkich niezrealizowanych jeszcze zleceñ, dla których krajem
odbiorcy jest Argentyna
*/

--SELECT OrderID,OrderDate,CustomerID FROM Orders WHERE (ShippedDate IS NULL ) AND ( ShipCountry = 'Argentina')

/*ORDER BY
1. Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj wed³ug kraju, w
ramach danego kraju nazwy firm posortuj alfabetycznie
2. Wybierz informacjê o produktach (grupa, nazwa, cena), produkty posortuj wg
grup a w grupach malej¹co wg ceny
3. Wybierz nazwy i kraje wszystkich klientów maj¹cych siedziby w Japonii (Japan)
lub we W³oszech (Italy), wyniki posortuj tak jak w pkt 1
*/

--1
--SELECT Country,CompanyName FROM Customers ORDER BY Country,CompanyName
--2
--SELECT CategoryName,ProductName,UnitPrice FROM Products,Categories WHERE Categories.CategoryID = Products.CategoryID ORDER BY CategoryName,UnitPrice DESC
--3
--SELECT CompanyName,Country FROM Customers WHERE ( Country = 'Japan' ) OR ( Country = 'Italy' ) ORDER BY Country,CompanyName

/* Æwiczenie:
1. Napisz polecenie, które oblicza wartoœæ ka¿dej pozycji zamówienia o numerze 10250
2. Napisz polecenie które dla ka¿dego dostawcy (supplier) poka¿e pojedyncz¹ kolumnê zawieraj¹c¹ nr telefonu i nr faksu w formacie
(numer telefonu i faksu maj¹ byæ oddzielone przecinkiem)
*/

--1
--SELECT ProductID,UnitPrice*Quantity AS 'Value' FROM [Order Details] WHERE OrderID = 10250
--2
--SELECT CompanyName,Phone+','+Fax AS 'Phone and Fax' FROM Suppliers