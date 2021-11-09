-- 1. Wybierz nazwy i adresy wszystkich klientów
SELECT CompanyName, Address, City, Region, PostalCode, Country
FROM Customers

-- 2. Wybierz nazwiska i numery telefonów pracowników
SELECT LastName, HomePhone
FROM Employees

-- 3. Wybierz nazwy i ceny produktów
SELECT ProductName, UnitPrice
FROM Products

-- 4. Pokaż wszystkie kategorie produktów (nazwy i opisy)
SELECT CategoryName, Description
FROM Categories

-- 5. Pokaż nazwy i adresy stron www dostawców
SELECT CompanyName, HomePage
FROM Suppliers