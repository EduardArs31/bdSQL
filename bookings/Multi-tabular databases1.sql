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
