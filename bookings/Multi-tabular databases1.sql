CREATE TABLE publishers (
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(300)
);


CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);


CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(300),
    publisher_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);


CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);


INSERT INTO authors (first_name, last_name)
VALUES
    ('Лев', 'Толстой'),
    ('Максим', 'Горький'),
    ('Александр', 'Пушкин');


INSERT INTO publishers (name)
VALUES
    ('Издательство Самовар'),
    ('Издательство «Азбука-Аттикус»'),
    ('Издательство Советский писатель');


INSERT INTO books (title, publisher_id)
VALUES
    ('Война и мир', 1),
    ('Макар Чудра', 2),
    ('Руслан и Людмила', 3);


INSERT INTO book_authors (book_id, author_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);


SELECT
 books.title AS book_title,
       publishers.name AS publisher_name
FROM
 books
JOIN
 publishers ON books.publisher_id = publishers.publisher_id;


--Агрегатные функции

ALTER TABLE books ADD COLUMN price DECIMAL(10, 2);


UPDATE books
SET price = 1500.00
WHERE book_id = 1;

UPDATE books
SET price = 800.00
WHERE book_id = 2;

UPDATE books
SET price = 1200.00
WHERE book_id = 3;

SELECT
    AVG(price) AS average_price,
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM books;


SELECT
    authors.first_name,
    authors.last_name,
    COUNT(*) AS book_count
FROM
    authors
JOIN
    book_authors ON authors.author_id = book_authors.author_id
GROUP BY
    authors.author_id, authors.first_name, authors.last_name;


SELECT
    authors.first_name,
    authors.last_name,
    COUNT(books.book_id) AS book_count,
    AVG(books.price) AS average_price
FROM
    authors
JOIN
    book_authors ON authors.author_id = book_authors.author_id
JOIN
    books ON book_authors.book_id = books.book_id
GROUP BY
    authors.author_id, authors.first_name, authors.last_name;


INSERT INTO authors (first_name, last_name)
VALUES
    ('Фёдор', 'Достоевский'),
    ('Антон', 'Чехов');


SELECT
    authors.first_name,
    authors.last_name
FROM
    authors
LEFT JOIN
    book_authors ON authors.author_id = book_authors.author_id
WHERE
    book_authors.book_id IS NULL;


SELECT
    authors.first_name,
    authors.last_name
FROM
    authors
LEFT JOIN
    book_authors ON authors.author_id = book_authors.author_id
GROUP BY
    authors.author_id, authors.first_name, authors.last_name
HAVING
    COUNT(book_authors.book_id) = 0;