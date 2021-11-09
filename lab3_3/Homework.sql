--PRACA DOMOWA

--1 Ile lat przepracował w firmie każdy z pracowników?
SELECT FirstName,LastName,YEAR(GETDATE())-YEAR(HireDate) AS 'Lat w firmie' FROM Employees

--2 Policz sumę lat przepracowanych przez wszystkich pracowników i średni czas pracy w firmie
SELECT SUM(YEAR(GETDATE())-YEAR(HireDate)) AS 'Sum of years',AVG(YEAR(GETDATE())-YEAR(HireDate)) AS 'Average time' FROM Employees

--3 Dla każdego pracownika wyświetl imię, nazwisko oraz wiek
SELECT FirstName,LastName,YEAR(GETDATE())-YEAR(BirthDate) AS 'Wiek' FROM Employees

--4 Policz średni wiek wszystkich pracowników
SELECT AVG(YEAR(GETDATE())-YEAR(BirthDate)) AS 'Sredni wiek' FROM Employees

--5 Wyświetl wszystkich pracowników, którzy mają teraz więcej niż 25 lat.
SELECT * FROM Employees WHERE YEAR(GETDATE())-YEAR(BirthDate) > 25

--6 Policz średnią liczbę miesięcy przepracowanych przez każdego pracownika
SELECT AVG(YEAR(GETDATE())*12 - YEAR(HireDate)*12) AS 'Average num of months' FROM Employees

--7 Wyświetl dane wszystkich pracowników, którzy przepracowali w firmie co najmniej 320 miesięcy, ale nie więcej niż 333
SELECT * FROM Employees WHERE YEAR(GETDATE())*12 - YEAR(HireDate)*12 BETWEEN 320 AND 333