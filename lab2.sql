/* 
1. Napisz polecenie select, za pomoc¹ którego uzyskasz tytu³ i numer ksi¹¿ki
2. Napisz polecenie, które wybiera tytu³ o numerze 10
3. Napisz polecenie select, za pomoc¹ którego uzyskasz numer ksi¹¿ki (nr tyu³u) i
autora z tablicy title dla wszystkich ksi¹¿ek, których autorem jest Charles
Dickens lub Jane Austen
*/

--1
--SELECT title,title_no FROM title 
--2
--SELECT title FROM title WHERE title_no = 10
--3
--SELECT title_no, author FROM title WHERE (author = 'Charles Dickens') OR (author = 'Jane Austen')

/*
1. Napisz polecenie, które wybiera numer tytu³u i tytu³ dla wszystkich ksi¹¿ek,
których tytu³y zawieraj¹cych s³owo „adventure”
2. Napisz polecenie, które wybiera numer czytelnika, oraz zap³acon¹ karê
3. Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy
adult.
4. Napisz polecenie, które wybiera wszystkie tytu³y z tablicy title i wyœwietla je w
porz¹dku alfabetycznym.
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
1. Napisz polecenie, które:
– wybiera numer cz³onka biblioteki (member_no), isbn ksi¹¿ki (isbn) i watroœæ
naliczonej kary (fine_assessed) z tablicy loanhist dla wszystkich wypo¿yczeñ
dla których naliczono karê (wartoœæ nie NULL w kolumnie fine_assessed)
– stwórz kolumnê wyliczeniow¹ zawieraj¹c¹ podwojon¹ wartoœæ kolumny
fine_assessed
– stwórz alias ‘double fine’ dla tej kolumny
*/

--SELECT member_no,isbn,fine_assessed,2*fine_assessed AS 'double fine' FROM loanhist WHERE fine_assessed IS NOT NULL 

/*
1. Napisz polecenie, które
– generuje pojedyncz¹ kolumnê, która zawiera kolumny: firstname (imiê
cz³onka biblioteki), middleinitial (inicja³ drugiego imienia) i lastname
(nazwisko) z tablicy member dla wszystkich cz³onków biblioteki, którzy
nazywaj¹ siê Anderson
– nazwij tak powsta³¹ kolumnê email_name (u¿yj aliasu email_name dla
kolumny)
– zmodyfikuj polecenie, tak by zwróci³o „listê proponowanych loginów e-mail”
utworzonych przez po³¹czenie imienia cz³onka biblioteki, z inicja³em
drugiego imienia i pierwszymi dwoma literami nazwiska (wszystko ma³ymi
ma³ymi literami).
– Wykorzystaj funkcjê SUBSTRING do uzyskania czêœci kolumny
znakowej oraz LOWER do zwrócenia wyniku ma³ymi literami.
Wykorzystaj operator (+) do po³¹czenia stringów.
*/

--SELECT LOWER(firstname+middleinitial+SUBSTRING(lastname,1,2)) AS 'email_name' 
--FROM member WHERE lastname = 'Anderson'

/*
1. Napisz polecenie, które wybiera title i title_no z tablicy title.
§ Wynikiem powinna byæ pojedyncza kolumna o formacie jak w przyk³adzie
poni¿ej:
The title is: Poems, title number 7
§ Czyli zapytanie powinno zwracaæ pojedyncz¹ kolumnê w oparciu o
wyra¿enie, które ³¹czy 4 elementy:
sta³a znakowa ‘The title is:’
wartoœæ kolumny title
sta³a znakowa ‘title number’
wartoœæ kolumny title_no
*/

--SELECT 'The title is: '+title+' , title number '+CAST(title_no AS varchar) FROM title