SELECT surname, name, patronymic, birthday FROM readers
WHERE surname ~ '^(А|Б|В|Г|Д|Е|Ё|Ж|З|И|К).*';

CREATE OR REPLACE FUNCTION GetBooksWithSpecifiedAuthor(author VARCHAR) RETURNS books
BEGIN ATOMIC
SELECT * FROM books
WHERE GetBooksWithSpecifiedAuthor.author = books.author;
END;
SELECT * FROM GetBooksWithSpecifiedAuthor('Август Цих');

CREATE EXTENSION tablefunc;

SELECT author,
       COUNT(id) FILTER ( WHERE publisher = 'АСТ') as "АСТ",
       COUNT(id) FILTER ( WHERE publisher = 'Красноярский государственный университет' ) as "Красноярский государственный университет",
       COUNT(id) FILTER ( WHERE publisher = 'Питер' ) as "Питер",
       COUNT(id) FILTER ( WHERE publisher = 'Эксмо' ) as "Эксмо",
       COUNT(id) FILTER ( WHERE publisher = 'Азбука' ) as "Эксмо"
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
