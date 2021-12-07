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

WITH sum_of_view_stats AS (
        SELECT challenge_id,
                total_views = SUM(total_views),
                total_unique_views = sum(total_unique_views)
        FROM View_Stats 
        GROUP BY challenge_id)

,sum_of_submission_stats AS (
        SELECT challenge_id,
                total_submissions = sum(total_submissions),
                total_accepted_submissions = sum(total_accepted_submissions)
        FROM Submission_Stats 
        GROUP BY challenge_id)

SELECT con.contest_id,
        con.hacker_id,
        con.name,
        SUM(total_submissions),
        SUM(total_accepted_submissions),
        SUM(total_views),
        SUM(total_unique_views)
FROM Contests con
INNER JOIN Colleges col ON con.contest_id = col.contest_id
INNER JOIN Challenges cha ON cha.college_id = col.college_id
LEFT JOIN sum_view_stats vs ON vs.challenge_id = cha.challenge_id
LEFT JOIN sum_submission_stats ss ON ss.challenge_id = cha.challenge_id
GROUP BY con.contest_id,con.hacker_id,con.name
HAVING (SUM(total_submissions)
        +SUM(total_accepted_submissions)
        +SUM(total_views)
        +SUM(total_unique_views)) <> 0
ORDER BY con.contest_ID
