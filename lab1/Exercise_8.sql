--1 Napisz polecenie, które oblicza wartość każdej pozycji zamówienia o numerze 10250
SELECT ProductID,UnitPrice*Quantity AS 'Value' FROM [Order Details] WHERE OrderID = 10250

--2 Napisz polecenie które dla każdego dostawcy (supplier) pokaże pojedynczą kolumnę zawierającą nr telefonu i nr faksu w formacie (numer telefonu i faksu mają być oddzielone przecinkiem)
SELECT CompanyName,Phone+','+Fax AS 'Phone and Fax' FROM Suppliers