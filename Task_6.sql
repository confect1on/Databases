SELECT surname, name, patronymic, birthday FROM readers
WHERE surname REGEXP '^(А|Б|В|Г|Д|Е|Ё|Ж|З|И|К).*';

CREATE OR REPLACE PROCEDURE  GetBooksWithSpecifiedAuthor(author VARCHAR(100))
BEGIN
SELECT * FROM books
WHERE author = books.author;
END;

CALL GetBooksWithSpecifiedAuthor('Август Цих');

SELECT author,
       SUM(IF(publisher = 'АСТ', 1, 0))                                      as "АСТ",
       SUM(IF(publisher = 'Красноярский государственный университет', 1, 0)) as "Красноярский государственный университет",
       SUM(IF(publisher = 'Питер', 1, 0))                                    as "Питер",
       SUM(IF(publisher = 'Эксмо', 1, 0))                                    as "Эксмо",
       SUM(IF(publisher = 'Азбука', 1, 0)) as "Эксмо"
FROM books
GROUP BY author;

SELECT id, title, author, count(*) as BooksCount FROM books
INNER JOIN issuance i on i.bookid = books.id
GROUP BY id, title, author;

SELECT readers.id, surname, name, patronymic, SUM(pagescount) as TotalPages, count(bookid) as TotalBooks FROM readers
LEFT JOIN issuance i on readers.id = i.readerid
LEFT JOIN books b on b.id = i.bookid
GROUP BY readers.id, surname, name, patronymic;

SELECT * FROM readers
LEFT JOIN issuance i on readers.id = i.readerid
LEFT JOIN books b on b.id = i.bookid

SELECT * FROM books
WHERE pagescount > 100;

SELECT readerid, surname, name, patronymic, author, title, issuedat FROM readers
INNER JOIN issuance on readers.id = issuance.readerid
INNER JOIN books on books.id = issuance.bookid
WHERE issuance.returneddate > current_date - interval 2 YEAR
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
WHERE YEAR(current_date) - YEAR(r.birthday) < 31
GROUP BY bookid, author, title, pagescount;

SELECT surname, name, patronymic FROM readers
RIGHT JOIN issuance i on readers.id = i.readerid
LEFT JOIN books b ON b.id = bookid
WHERE pagescount > 200 AND returneddate < current_date OR (YEAR(current_date) - YEAR(issuedat)) * 12 + YEAR(current_date) - YEAR(issuedat) < 2
GROUP BY surname, name, patronymic;

UPDATE issuance
SET returneddate = returneddate + 1
WHERE deliveryhallid <= 4;

DELETE FROM issuance
WHERE (YEAR(current_date) - YEAR(returneddate)) * 12 + YEAR(current_date) - YEAR(returneddate) > 6
