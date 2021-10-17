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
