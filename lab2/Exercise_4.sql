/*
9. Napisz polecenie, które
– generuje pojedynczą kolumnę, która zawiera kolumny: firstname (imię
członka biblioteki), middleinitial (inicjał drugiego imienia) i lastname
(nazwisko) z tablicy member dla wszystkich członków biblioteki, którzy
nazywają się Anderson
– nazwij tak powstałą kolumnę email_name (użyj aliasu email_name dla
kolumny)
– zmodyfikuj polecenie, tak by zwróciło „listę proponowanych loginów e-mail”
utworzonych przez połączenie imienia członka biblioteki, z inicjałem
drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko małymi
małymi literami).
– Wykorzystaj funkcję SUBSTRING do uzyskania części kolumny
znakowej oraz LOWER do zwrócenia wyniku małymi literami.
Wykorzystaj operator (+) do połączenia stringów.
*/

SELECT REPLACE(LOWER(firstname+middleinitial+SUBSTRING(lastname,1,2)),' ','') AS 'email_name'
FROM member WHERE lastname = 'Anderson'

