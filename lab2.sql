/* 
1. Napisz polecenie select, za pomoc� kt�rego uzyskasz tytu� i numer ksi��ki
2. Napisz polecenie, kt�re wybiera tytu� o numerze 10
3. Napisz polecenie select, za pomoc� kt�rego uzyskasz numer ksi��ki (nr tyu�u) i
autora z tablicy title dla wszystkich ksi��ek, kt�rych autorem jest Charles
Dickens lub Jane Austen
*/

--1
--SELECT title,title_no FROM title 
--2
--SELECT title FROM title WHERE title_no = 10
--3
--SELECT title_no, author FROM title WHERE (author = 'Charles Dickens') OR (author = 'Jane Austen')

/*
1. Napisz polecenie, kt�re wybiera numer tytu�u i tytu� dla wszystkich ksi��ek,
kt�rych tytu�y zawieraj�cych s�owo �adventure�
2. Napisz polecenie, kt�re wybiera numer czytelnika, oraz zap�acon� kar�
3. Napisz polecenie, kt�re wybiera wszystkie unikalne pary miast i stan�w z tablicy
adult.
4. Napisz polecenie, kt�re wybiera wszystkie tytu�y z tablicy title i wy�wietla je w
porz�dku alfabetycznym.
*/

--1
--SELECT title_no,title FROM title WHERE title LIKE '%adventure%'
--2
--SELECT member_no, isnull(fine_paid,0) AS finePaid 
--FROM loanhist WHERE isnull(fine_paid,0)=0 and isnull(fine_assessed,0)>0
--3
--SELECT DISTINCT city,state FROM adult
--4
--SELECT title FROM title ORDER BY title 

/*
1. Napisz polecenie, kt�re:
� wybiera numer cz�onka biblioteki (member_no), isbn ksi��ki (isbn) i watro��
naliczonej kary (fine_assessed) z tablicy loanhist dla wszystkich wypo�ycze�
dla kt�rych naliczono kar� (warto�� nie NULL w kolumnie fine_assessed)
� stw�rz kolumn� wyliczeniow� zawieraj�c� podwojon� warto�� kolumny
fine_assessed
� stw�rz alias �double fine� dla tej kolumny
*/

--SELECT member_no,isbn,fine_assessed,2*fine_assessed AS 'double fine' FROM loanhist WHERE fine_assessed IS NOT NULL 

/*
1. Napisz polecenie, kt�re
� generuje pojedyncz� kolumn�, kt�ra zawiera kolumny: firstname (imi�
cz�onka biblioteki), middleinitial (inicja� drugiego imienia) i lastname
(nazwisko) z tablicy member dla wszystkich cz�onk�w biblioteki, kt�rzy
nazywaj� si� Anderson
� nazwij tak powsta�� kolumn� email_name (u�yj aliasu email_name dla
kolumny)
� zmodyfikuj polecenie, tak by zwr�ci�o �list� proponowanych login�w e-mail�
utworzonych przez po��czenie imienia cz�onka biblioteki, z inicja�em
drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko ma�ymi
ma�ymi literami).
� Wykorzystaj funkcj� SUBSTRING do uzyskania cz�ci kolumny
znakowej oraz LOWER do zwr�cenia wyniku ma�ymi literami.
Wykorzystaj operator (+) do po��czenia string�w.
*/

--SELECT LOWER(firstname+middleinitial+SUBSTRING(lastname,1,2)) AS 'email_name' 
--FROM member WHERE lastname = 'Anderson'

/*
1. Napisz polecenie, kt�re wybiera title i title_no z tablicy title.
� Wynikiem powinna by� pojedyncza kolumna o formacie jak w przyk�adzie
poni�ej:
The title is: Poems, title number 7
� Czyli zapytanie powinno zwraca� pojedyncz� kolumn� w oparciu o
wyra�enie, kt�re ��czy 4 elementy:
sta�a znakowa �The title is:�
warto�� kolumny title
sta�a znakowa �title number�
warto�� kolumny title_no
*/

--SELECT 'The title is: '+title+' , title number '+CAST(title_no AS varchar) FROM title