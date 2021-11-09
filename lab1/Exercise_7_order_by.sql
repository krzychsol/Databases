--1 Wybierz nazwy i kraje wszystkich klientów, wyniki posortuj według kraju, w ramach danego kraju nazwy firm posortuj alfabetycznie
SELECT Country,CompanyName FROM Customers ORDER BY Country,CompanyName

--2 Wybierz informację o produktach (grupa, nazwa, cena), produkty posortuj wg grup a w grupach malejąco wg ceny
SELECT CategoryName,ProductName,UnitPrice FROM Products,Categories WHERE Categories.CategoryID = Products.CategoryID ORDER BY CategoryName,UnitPrice DESC

--3 Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) lub we Włoszech (Italy), wyniki posortuj tak jak w pkt 1
SELECT CompanyName,Country FROM Customers WHERE ( Country = 'Japan' ) OR ( Country = 'Italy' ) ORDER BY Country,CompanyName