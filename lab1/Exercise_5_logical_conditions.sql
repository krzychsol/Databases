--8 Wybierz nazwy i kraje wszystkich klientów mających siedziby w Japonii (Japan) lub we Włoszech (Italy)
SELECT CompanyName,Country FROM Customers WHERE (Country = 'Japan') OR (Country = 'Italy')
