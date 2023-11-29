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
