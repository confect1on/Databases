DROP TABLE IF EXISTS issuance;

DROP TABLE IF EXISTS books;
CREATE TABLE books
(
    Id BIGINT PRIMARY KEY AUTO_INCREMENT,
    Author VARCHAR(40),
    Title VARCHAR(200),
    Publisher VARCHAR(50),
    PagesCount INTEGER,
    PublishedAt DATE
);
INSERT INTO books (Author, Title, Publisher, PagesCount, PublishedAt) VALUES
('Джордж Оруэлл', '1984', 'АСТ', 320, MAKEDATE(2022, 1)),
('Энтони Берджесс', 'Заводной апельсин', 'АСТ', 256, MAKEDATE(2021, 1)),
('Август Цих', 'Введение в специальность "Математика"', 'Красноярский государственный университет', 160, MAKEDATE(2002, 1)),
('Джеффри Рихтер', 'CLR via C#', 'Питер', 896, MAKEDATE(2013, 1)),
('Роберт Мартин', 'Чистый код: создание, анализ и рефакторинг', 'Питер', 464, MAKEDATE(2018, 1) ),
('Роберт Мартин', 'Чистая архитектура. Искусство разработки программного обеспечения', 'Питер', 352, MAKEDATE(2018, 1)),
('Джером Сэлинджер', 'Над пропастью во ржи', 'Эксмо', 224, MAKEDATE(2021, 1)),
('Артур Дойл', 'Записки о Шерлоке Холмсе', 'Азбука', 320, MAKEDATE(2022, 1)),
('Маргарет Митчелл', 'Унесенные ветром. Том 1', 'АСТ', 704, MAKEDATE(2021, 1)),
('Данте Алигьери', 'Божественная Комедия', 'АСТ', 800, MAKEDATE(2021, 1));

DROP TABLE IF EXISTS readers;
CREATE TABLE readers
(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Surname VARCHAR(20),
    Name VARCHAR(20),
    Patronymic VARCHAR(20),
    Address VARCHAR(100),
    Phone VARCHAR(15),
    Birthday DATE
);
CREATE TRIGGER OnUpdateCheck
    BEFORE INSERT ON readers
    FOR EACH ROW
    BEGIN
        IF NEW.Id >= 10000 THEN
            SIGNAL SQLSTATE '22000'
                SET MESSAGE_TEXT = 'Enough';
        end if;
    end;
INSERT INTO readers (Surname, Name, Patronymic, Address, Phone, Birthday) VALUES
('Солодников', 'Андрей', 'Вячеславович', 'г. Красноярск, пр. Свободный, д. 83, кв. 211', '89051756980', MAKEDATE(2002, 9 * 30 + 19)),
('Стрекаловский', 'Илья', 'Алексеевич', 'г. Красноярск, пр. Свободный, д. 83, кв. 211', '89503838783', MAKEDATE(2003, 3 * 30 + 29)),
('Мацука', 'Александра', 'Сергеевна', 'г. Красноярск, пр. Свободный, д. 83, кв. 803', '89248254117', MAKEDATE(2002, 3 * 30 + 10)),
('Козлова', 'Анастасия', 'Романовна', 'г. Красноярск, пр. Свободный, д. 83, кв. 519', '89501384404', MAKEDATE(2003, 10 * 30 + 29)),
('Иванов', 'Иван', 'Иванович', 'г. Красноярск, пр. Свободный, д. 83, кв. 666', '89998883322', MAKEDATE(2001, 10 * 30 + 29)),
('Петров', 'Петр', 'Петрович', 'г. Красноярск, пр. Свободный, д. 81, кв. 228', '89051234567', MAKEDATE(2003, 10 * 30 + 29)),
('Ханыкова', 'Нина', 'Святославовна', 'г. Красноярск, ул. Карла Марска, д. 12, кв. 55', '89172331212', MAKEDATE(1999, 10 * 30 + 29)),
('Илюшин', 'Владимир', 'Петрович', 'г. Красноряск, ул. Лады Прушинской, д. 17, кв. 21', '89112331711', MAKEDATE(2001, 10 * 30 + 29)),
('Баскаков', 'Евгений', 'Станиславович', 'г. Красноярск, ул. Карла Марска, д. 17, кв. 11', '89251173832', MAKEDATE(2000, 10 * 30 + 29)),
('Мюллер', 'Юлия', 'Сергеевна', 'г. Красноярск, пр. Свободный, д. 83, кв. 513', '89111332232', MAKEDATE(2002, 10 * 30 + 29));

CREATE TABLE issuance
(
    ReaderId INT,
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
(2, 3, MAKEDATE(2020, 9 * 12 + 15), MAKEDATE(2021, 1 * 15 + 19), 2),
(1, 3, MAKEDATE(2020, 11 * 14 + 1), MAKEDATE(2021, 4 * 13 + 2), 5),
(6, 5, current_date - 7, current_date - 2, 4),
(7, 3, current_date - 2, current_date, 1)
