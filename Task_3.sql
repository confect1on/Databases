SELECT * FROM books
WHERE pagescount > 100;

SELECT readerid, surname, name, patronymic, author, title, issuedat FROM readers
INNER JOIN issuance on readers.id = issuance.readerid
INNER JOIN books on books.id = issuance.bookid
WHERE issuance.returneddate > current_date - interval '2 year'
ORDER BY surname, name, patronymic;

SELECT bookid, author, title FROM books
INNER JOIN issuance ON bookid = books.id
GROUP BY bookid, author, title
HAVING count(*) > 3;

SELECT id, surname, name, patronymic FROM readers
INNER JOIN issuance i on readers.id = i.readerid
WHERE returneddate < current_date
GROUP BY id, surname, name, patronymic;

SELECT bookid, author, title, pagescount FROM books
INNER JOIN issuance ON books.id = issuance.bookid
INNER JOIN readers r on r.id = issuance.readerid
WHERE date_part('year', current_date) - date_part('year', r.birthday) < 31
GROUP BY bookid, author, title, pagescount;

SELECT surname, name, patronymic FROM readers
RIGHT JOIN issuance i on readers.id = i.readerid
LEFT JOIN books b ON b.id = bookid
WHERE pagescount > 200 AND returneddate < current_date OR (date_part('year', current_date) - date_part('year', issuedat)) * 12 + date_part('month', current_date) - date_part('month', issuedat) < 2
GROUP BY surname, name, patronymic;

UPDATE issuance
SET returneddate = returneddate + 5
WHERE deliveryhallid <= 4;

DELETE FROM issuance
WHERE (date_part('year', current_date) - date_part('year', returneddate)) * 12 + date_part('month', current_date) - date_part('month', returneddate) > 6
