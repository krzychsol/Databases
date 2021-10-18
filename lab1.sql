/* Por�wnywanie napis�w:
1. Szukamy informacji o produktach sprzedawanych w butelkach (�bottle�)
2. Wyszukaj informacje o stanowisku pracownik�w, kt�rych nazwiska zaczynaj� si�
na liter� z zakresu od B do L
3. Wyszukaj informacje o stanowisku pracownik�w, kt�rych nazwiska zaczynaj� si�
na liter� B lub L
4. Znajd� nazwy kategorii, kt�re w opisie zawieraj� przecinek
5. Znajd� klient�w, kt�rzy w swojej nazwie maj� w kt�rym� miejscu s�owo �Store�
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

/*Zakres warto�ci:
1. Szukamy informacji o produktach o cenach mniejszych ni� 10 lub wi�kszych ni� 20
2. Wybierz nazwy i ceny produkt�w o cenie jednostkowej pomi�dzy 20.00 a 30.00
*/

/*1*/
--SELECT * FROM Products WHERE UnitPrice NOT BETWEEN 10 AND 20
/*2*/
--SELECT ProductName,UnitPrice FROM Products WHERE UnitPrice BETWEEN 20 AND 30

/*Warunki logiczne -
1. Wybierz nazwy i kraje wszystkich klient�w maj�cych siedziby w Japonii (Japan)
lub we W�oszech (Italy)
*/

/*1*/
--SELECT CompanyName,Country FROM Customers WHERE (Country = 'Japan') OR (Country = 'Italy')

/*�wiczenie
Napisz instrukcj� select tak aby wybra� numer zlecenia, dat� zam�wienia, numer
klienta dla wszystkich niezrealizowanych jeszcze zlece�, dla kt�rych krajem
odbiorcy jest Argentyna
*/

--SELECT OrderID,OrderDate,CustomerID FROM Orders WHERE (ShippedDate IS NULL ) AND ( ShipCountry = 'Argentina')

/*ORDER BY
1. Wybierz nazwy i kraje wszystkich klient�w, wyniki posortuj wed�ug kraju, w
ramach danego kraju nazwy firm posortuj alfabetycznie
2. Wybierz informacj� o produktach (grupa, nazwa, cena), produkty posortuj wg
grup a w grupach malej�co wg ceny
3. Wybierz nazwy i kraje wszystkich klient�w maj�cych siedziby w Japonii (Japan)
lub we W�oszech (Italy), wyniki posortuj tak jak w pkt 1
*/

--1
--SELECT Country,CompanyName FROM Customers ORDER BY Country,CompanyName
--2
--SELECT CategoryName,ProductName,UnitPrice FROM Products,Categories WHERE Categories.CategoryID = Products.CategoryID ORDER BY CategoryName,UnitPrice DESC
--3
--SELECT CompanyName,Country FROM Customers WHERE ( Country = 'Japan' ) OR ( Country = 'Italy' ) ORDER BY Country,CompanyName

/* �wiczenie:
1. Napisz polecenie, kt�re oblicza warto�� ka�dej pozycji zam�wienia o numerze 10250
2. Napisz polecenie kt�re dla ka�dego dostawcy (supplier) poka�e pojedyncz� kolumn� zawieraj�c� nr telefonu i nr faksu w formacie
(numer telefonu i faksu maj� by� oddzielone przecinkiem)
*/

--1
--SELECT ProductID,UnitPrice*Quantity AS 'Value' FROM [Order Details] WHERE OrderID = 10250
--2
--SELECT CompanyName,Phone+','+Fax AS 'Phone and Fax' FROM Suppliers