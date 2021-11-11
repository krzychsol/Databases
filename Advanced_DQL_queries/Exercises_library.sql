/*1. Wypisz wszystkich członków biblioteki (imie i nazwisko, adres), liczba
aktualnie zarezerwowanych ksiazek oraz sumaryczna liczba dni zalegania z
wypozyczonymi ksiazkami. Dla kazdego czytelnika podaj informacje czy jest
dzieckiem czy doroslym, jezeli jest dzieckiem i zalegal z oddaniem ksiazek
wyswietl imie i nazwisko opiekuna prawnego.
*/
SELECT DISTINCT firstname+' '+lastname+' '+middleinitial AS name,street+' '+city+' '+state AS address,
(SELECT COUNT(*) FROM reservation r WHERE r.member_no = m.member_no) AS zarezerwowanych,
(SELECT SUM(DATEDIFF(day,out_date,in_date)) FROM loanhist l WHERE l.member_no = m.member_no) AS przetrzymywanie,
IIF(J.member_no IS NULL,'adult','juvenile') AS status
FROM member m
LEFT JOIN juvenile j on m.member_no = j.member_no
LEFT JOIN adult a ON ( m.member_no = a.member_no and j.member_no IS NULL ) OR ( j.adult_member_no = a.member_no)

/*
4. Wybierz członków biblioteki, ktůrzy nie wypożyczyli w 1996 r. książki, której
autorem jest Samuel Smiles, w języku arabskim. Napisz w 2 wersjach: bez
podzapytań i z podzapytaniami.
 */

--wersja bez podzapytań
SELECT DISTINCT m1.member_no,m1.firstname,m1.lastname
FROM member m1
JOIN loanhist l on (m1.member_no = l.member_no AND YEAR(out_date) = 1996)
JOIN item i on (l.isbn = i.isbn AND translation='ARABIC')
JOIN title t on (l.title_no = t.title_no AND t.author = 'Samuel Smiles')
RIGHT OUTER JOIN member m2 ON m1.member_no = m2.member_no
WHERE m1.member_no IS NULL

--wersja z podzapytaniami
SELECT DISTINCT m1.member_no,m1.firstname,m1.lastname
FROM member m1
WHERE m1.member_no NOT IN
      (SELECT loanhist.member_no FROM loanhist WHERE YEAR(out_date)=1996 AND loanhist.isbn IN
          (SELECT item.isbn FROM item WHERE item.translation='ARABIC' AND item.title_no IN
              (SELECT title.title_no FROM title WHERE title.author = 'Samuel Smiles')))

/*
5. Wypisz imie i nazwisko oraz adres członków biblioteki którzy są ze stanu
arizona oraz nigdy nie wypożyczyli żadnej ksiązki, oraz takich członków którzy
wypożyczyli więcej niż 5 książek i nie mają podwładnych (dzieci). *ci drudzy
nie muszą być z arizony
 */

SELECT DISTINCT firstname+' '+lastname+' '+middleinitial AS name,street+' '+city+' '+state AS address
FROM member AS m
LEFT JOIN juvenile j on m.member_no = j.member_no
LEFT JOIN adult a on (m.member_no = a.member_no AND j.member_no IS NULL ) OR (j.adult_member_no = a.member_no)
WHERE a.state = 'CA' AND m.member_no NOT IN
    (SELECT member_no FROM loanhist AS lh
    UNION
    SELECT member_no FROM loan AS l)
UNION
SELECT DISTINCT firstname+' '+lastname+' '+middleinitial AS name,street+' '+city+' '+state AS address
FROM member AS m
JOIN adult a on m.member_no = a.member_no
WHERE a.member_no NOT IN
    (SELECT a2.member_no FROM adult AS a
        JOIN juvenile j on a.member_no = j.adult_member_no
        RIGHT OUTER JOIN adult as a2 on a2.member_no = a.member_no
        WHERE a.member_no IS NULL AND a.member_no IN
            (SELECT a3.member_no FROM adult as a3
            WHERE (SELECT COUNT(*) FROM loanhist AS lh WHERE lh.member_no = a3.member_no)
                +(SELECT COUNT(*) FROM loan AS l WHERE l.member_no = a3.member_no) > 5))

/*
Zadanie 2 (Library)
Wypisz imiona, nazwiska i adresy członków biblioteki wraz z informację, czy są dorosłym czy
dzieckiem (przy dzieciach dopisz ich opiekuna prawnego) oraz długiem za przetrzymywanie
książek.
 */

SELECT DISTINCT member.member_no,firstname+' '+lastname+' '+middleinitial AS name,street+' '+city+' '+state AS address,
IIF(j.member_no IS NULL,'adult','juvenile: '+(SELECT member.firstname+' '+member.lastname FROM member WHERE member.member_no = j.adult_member_no)) AS status,
(SELECT SUM(l.fine_assessed) FROM loanhist AS l WHERE l.member_no = member.member_no GROUP BY l.member_no) AS grzywna
FROM member
LEFT JOIN juvenile j on member.member_no = j.member_no
LEFT JOIN adult a ON (member.member_no = a.member_no AND j.member_no IS NULL) OR (j.adult_member_no = a.member_no)

/*
3)Dla każdego dziecka zapisanego w bibliotece wyświetl jego imię i nazwisko, adres zamieszkania,
imię i nazwisko rodzica (opiekuna) oraz liczbę wypożyczonych książek w grudniu 2001 roku przez dziecko i opiekuna.
*) Uwzględnij tylko te dzieci, dla których liczba wypożyczonych książek jest większa od 1
 */

SELECT ch.firstname,
       ch.lastname,
       street,
       city,
       state,
       par.firstname,
       par.lastname,
       ISNULL((SELECT COUNT(*)
               FROM loanhist AS lh
               WHERE lh.member_no = ch.member_no
                 AND YEAR(lh.in_date) = 2001
                 AND MONTH(lh.in_date) = 12
               GROUP BY member_no), 0) AS [child loans],
       ISNULL((SELECT COUNT(*)
               FROM loanhist AS lh
               WHERE lh.member_no = par.member_no
                 AND YEAR(lh.in_date) = 2001
                 AND MONTH(lh.in_date) = 12
               GROUP BY member_no), 0) AS [parent loans],
       ISNULL((SELECT COUNT(*)
               FROM loanhist AS lh
               WHERE lh.member_no = ch.member_no
                 AND YEAR(lh.in_date) = 2001
                 AND MONTH(lh.in_date) = 12
               GROUP BY member_no), 0) + ISNULL((SELECT COUNT(*)
                                                 FROM loanhist AS lh
                                                 WHERE lh.member_no = par.member_no
                                                   AND YEAR(lh.in_date) = 2001
                                                   AND MONTH(lh.in_date) = 12
                                                 GROUP BY member_no), 0) AS [total loans]
FROM juvenile AS j
         JOIN member ch on j.member_no = ch.member_no
         JOIN adult a on j.adult_member_no = a.member_no
         JOIN member par on a.member_no = par.member_no

WHERE ISNULL((SELECT COUNT(*)
              FROM loanhist AS lh
              WHERE lh.member_no = ch.member_no
                AND YEAR(lh.in_date) = 2001
                AND MONTH(lh.in_date) = 12), 0) > 1












