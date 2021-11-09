-- 1. Wybierz nazwy i adresy wszystkich klientów mających siedziby w Londynie
SELECT CompanyName, Address, City, Region, PostalCode, Country
FROM Customers
WHERE City = 'London'

-- 2. Wybierz nazwy i adresy wszystkich klientów mających siedziby we Francji lub w Hiszpanii
SELECT CompanyName, Address, City, Region, PostalCode, Country
FROM Customers
WHERE Country = 'France'
   OR Country = 'Spain'

-- 3. Wybierz nazwy i ceny produktów o cenie jednostkowej pomiędzy 20.00 a 30.00
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice >= 20
  AND UnitPrice <= 30

-- 4. Wybierz nazwy i ceny produktów z kategorii ‘meat’
-- first solution
SELECT ProductName, UnitPrice
FROM Products
WHERE CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName = 'Meat/Poultry')

-- second solution
SELECT ProductName, UnitPrice
FROM Products
WHERE CategoryID = 6

-- 5. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez
-- firmę ‘Tokyo Traders’
SELECT ProductName, UnitsInStock
FROM Products
WHERE SupplierID IN (SELECT SupplierID FROM Suppliers WHERE CompanyName = 'Tokyo Traders')

-- 6. Wybierz nazwy produktów których nie ma w magazynie
SELECT ProductName
FROM Products
WHERE UnitsInStock = 0