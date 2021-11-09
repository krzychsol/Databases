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