--1  Szukamy informacji o produktach sprzedawanych w butelkach (‘bottle’)
SELECT * FROM Products WHERE QuantityPerUnit LIKE '%bottle%'

--2 Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę z zakresu od B do L
SELECT * FROM Employees WHERE LastName LIKE '[B-L]%'

--3 Wyszukaj informacje o stanowisku pracowników, których nazwiska zaczynają się na literę B lub L
SELECT * FROM Employees WHERE LastName LIKE '[BL]%'

--4 Znajdź nazwy kategorii, które w opisie zawierają przecinek
SELECT CategoryName FROM Categories WHERE Description LIKE '%,%' 

--5 Znajdź klientów, którzy w swojej nazwie mają w którymś miejscu słowo ‘Store’
SELECT * FROM Customers WHERE CompanyName LIKE '%Store%'

--6 Szukamy informacji o produktach o cenach mniejszych niż 10 lub większych niż 20
SELECT * FROM Products WHERE UnitPrice NOT BETWEEN 10 AND 20

--7 Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
SELECT ProductName,UnitPrice FROM Products WHERE UnitPrice BETWEEN 20 AND 30

--8 Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) lub we Włoszech (Italy)
SELECT CompanyName,Country FROM Customers WHERE (Country = 'Japan') OR (Country = 'Italy')

/*9
Napisz instrukcję select tak aby wybrać numer zlecenia, datę zamówienia, numer
klienta dla wszystkich niezrealizowanych jeszcze zleceń, dla których krajem
odbiorcy jest Argentyna
*/
SELECT OrderID,OrderDate,CustomerID FROM Orders WHERE (ShippedDate IS NULL ) AND ( ShipCountry = 'Argentina')

--10 Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj według kraju, w ramach danego kraju nazwy firm posortuj alfabetycznie
SELECT Country,CompanyName FROM Customers ORDER BY Country,CompanyName

--11 Wybierz informację o produktach (grupa, nazwa, cena), produkty posortuj wg grup a w grupach malejąco wg ceny
SELECT CategoryName,ProductName,UnitPrice FROM Products,Categories WHERE Categories.CategoryID = Products.CategoryID ORDER BY CategoryName,UnitPrice DESC

--12 Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) lub we Włoszech (Italy), wyniki posortuj tak jak w pkt 1
SELECT CompanyName,Country FROM Customers WHERE ( Country = 'Japan' ) OR ( Country = 'Italy' ) ORDER BY Country,CompanyName

--13 Napisz polecenie, które oblicza wartość każdej pozycji zamówienia o numerze 10250
SELECT ProductID,UnitPrice*Quantity AS 'Value' FROM [Order Details] WHERE OrderID = 10250

--14 Napisz polecenie które dla każdego dostawcy (supplier) pokaże pojedynczą kolumnę zawierającą nr telefonu i nr faksu w formacie (numer telefonu i faksu mają być oddzielone przecinkiem)
SELECT CompanyName,Phone+','+Fax AS 'Phone and Fax' FROM Suppliers
