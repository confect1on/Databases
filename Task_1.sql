DROP TABLE IF EXISTS issuance;

DROP TABLE IF EXISTS books;
CREATE TABLE books
(
    Id BIGSERIAL PRIMARY KEY,
    Author VARCHAR(40),
--     Title VARCHAR(40),
    Title VARCHAR,
--     Publisher VARCHAR(30),
    Publisher VARCHAR(50),
    PagesCount INTEGER,
    PublishedAt DATE
);
INSERT INTO books (Author, Title, Publisher, PagesCount, PublishedAt) VALUES
('Джордж Оруэлл', '1984', 'АСТ', 320, make_date(2022, 1, 1)),
('Энтони Берджесс', 'Заводной апельсин', 'АСТ', 256, make_date(2021, 1, 1)),
('Август Цих', 'Введение в специальность "Математика"', 'Красноярский государственный университет', 160, make_date(2002, 1, 1)),
('Джеффри Рихтер', 'CLR via C#', 'Питер', 896, make_date(2013, 1, 1)),
('Роберт Мартин', 'Чистый код: создание, анализ и рефакторинг', 'Питер', 464, make_date(2018, 1, 1) ),
('Роберт Мартин', 'Чистая архитектура. Искусство разработки программного обеспечения', 'Питер', 352, make_date(2018, 1, 1)),
('Джером Сэлинджер', 'Над пропастью во ржи', 'Эксмо', 224, make_date(2021, 1, 1)),
('Артур Дойл', 'Записки о Шерлоке Холмсе', 'Азбука', 320, make_date(2022, 1, 1)),
('Маргарет Митчелл', 'Унесенные ветром. Том 1', 'АСТ', 704, make_date(2021, 1, 1)),
('Данте Алигьери', 'Божественная Комедия', 'АСТ', 800, make_date(2021, 1, 1));

DROP TABLE IF EXISTS readers;
CREATE TABLE readers
(
    Id SERIAL PRIMARY KEY CHECK ( Id <= 100000 ),
    Surname VARCHAR(20),
    Name VARCHAR(20),
    Patronymic VARCHAR(20),
    Address VARCHAR(100),
    Phone VARCHAR(15),
    Birthday DATE
);
INSERT INTO readers (Surname, Name, Patronymic, Address, Phone, Birthday) VALUES
('Солодников', 'Андрей', 'Вячеславович', 'г. Красноярск, пр. Свободный, д. 83, кв. 211', '89051756980', make_date(2002, 9, 19)),
('Стрекаловский', 'Илья', 'Алексеевич', 'г. Красноярск, пр. Свободный, д. 83, кв. 211', '89503838783', make_date(2003, 3, 29)),
('Мацука', 'Александра', 'Сергеевна', 'г. Красноярск, пр. Свободный, д. 83, кв. 803', '89248254117', make_date(2002, 3, 10)),
('Козлова', 'Анастасия', 'Романовна', 'г. Красноярск, пр. Свободный, д. 83, кв. 519', '89501384404', make_date(2003, 10, 29)),
('Иванов', 'Иван', 'Иванович', 'г. Красноярск, пр. Свободный, д. 83, кв. 666', '89998883322', make_date(2001, 9, 19)),
('Петров', 'Петр', 'Петрович', 'г. Красноярск, пр. Свободный, д. 81, кв. 228', '89051234567', make_date(2003, 2, 22)),
('Ханыкова', 'Нина', 'Святославовна', 'г. Красноярск, ул. Карла Марска, д. 12, кв. 55', '89172331212', make_date(1999, 3, 13)),
('Илюшин', 'Владимир', 'Петрович', 'г. Красноряск, ул. Лады Прушинской, д. 17, кв. 21', '89112331711', make_date(2001, 5, 17)),
('Баскаков', 'Евгений', 'Станиславович', 'г. Красноярск, ул. Карла Марска, д. 17, кв. 11', '89251173832', make_date(2000, 3, 14)),
('Мюллер', 'Юлия', 'Сергеевна', 'г. Красноярск, пр. Свободный, д. 83, кв. 513', '89111332232', make_date(2002, 5, 13));

CREATE TABLE issuance
(
    ReaderId INT CHECK (issuance.ReaderId >= 1 AND issuance.ReaderId <= 100000 ),
    BookId BIGINT,
    IssuedAt DATE,
    ReturnedDate DATE CHECK (ReturnedDate > IssuedAt),
    DeliveryHallId SMALLINT,
    CONSTRAINT Issuance_PK PRIMARY KEY (ReaderId, BookId, IssuedAt),
    CONSTRAINT ReaderId_FK FOREIGN KEY (ReaderId) REFERENCES readers (Id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
INSERT INTO issuance (ReaderId, BookId, IssuedAt, ReturnedDate, DeliveryHallId) VALUES
(1, 4, current_date - 11, current_date, 1),
(2, 3, make_date(2020, 9, 15), make_date(2021, 1, 19), 2),
(1, 3, make_date(2020, 11, 1), make_date(2021, 4, 2), 5),
(5, 9, current_date, current_date + 5, 6),
(7, 3, current_date - 1, current_date + 4, 2),
(6, 5, current_date - 7, current_date - 2, 4),
(7, 3, current_date - 2, current_date + 3, 1),
(8, 8, current_date, current_date + 7, 3),
(1, 9, current_date, current_date + 10, 5),
(4, 3, current_date - 31, current_date - 20, 6)
