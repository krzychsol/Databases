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
