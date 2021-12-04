/*
INTERVIEWS

Samanta przeprowadza rozmowy kwalifikacyjne ze studentami z różnych uczelni 
przeprowadzając konkursy z programowania. Napisać zapytanie wyświetlające kolumny:
contest_id,hacker_id , name oraz sumy total_submissions , total_accepted_submissions , total_views i total_unique_views 
dla każdego konkursu posortowanego według contest_id .
Wyklucz konkurs z wyniku, jeśli wszystkie cztery sumy są równe 0.

Uwaga: określony konkurs może służyć do sprawdzania kandydatów w więcej niż jednej uczelni,
        ale każda uczelnia posiada tylko jeden konkurs przesiewowy.

*/

SELECT con.contest_id,
        con.hacker_id, 
        con.name, 
        SUM(total_submissions), 
        SUM(total_accepted_submissions), 
        SUM(total_views),
        SUM(total_unique_views)
FROM contests con
JOIN colleges col on con.contest_id = col.contest_id 
JOIN challenges cha on  col.college_id = cha.college_id 
LEFT JOIN (SELECT challenge_id,
            SUM(total_views) AS sum_of_views,
            SUM(total_unique_views) AS sum_of_unique_views
            FROM view_stats 
            GROUP BY challenge_id) vs ON cha.challenge_id = vs.challenge_id 
LEFT JOIN (SELECT challenge_id, 
            SUM(total_submissions) AS total_submissions,
            SUM(total_accepted_submissions) AS total_accepted_submissions 
            FROM submission_stats GROUP BY challenge_id) ss ON cha.challenge_id = ss.challenge_id
GROUP BY con.contest_id, con.hacker_id, con.name
HAVING  SUM(total_submissions)!=0 OR 
        SUM(total_accepted_submissions)!=0 OR
        SUM(total_views)!=0 OR
        SUM(total_unique_views)!=0
ORDER BY contest_id;
