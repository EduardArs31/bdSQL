CREATE TABLE customer
(
    "id"          BIGINT GENERATED ALWAYS AS IDENTITY,
    "name"        VARCHAR(200),
    "type"        VARCHAR(30),
    "city"        VARCHAR(50),
    "count_order" INT

);
INSERT INTO customer(name, type, city, count_order)
VALUES ('Алексей', 'Постоянный покупатель', 'Ленинград', 5),
       ('Иван', 'VIP покупатель', 'Уфа', 10),
       ('Юрий', 'Новый покупатель', 'Москва', 3),
       ('Владимир', 'Постоянный покупатель', 'Ленинград', 2);

SELECT id,
       name        AS "Ф.И.О",
       type        AS "Категория",
       city        AS "Город",
       count_order AS "Количество заказов"
FROM customer;

UPDATE customer
SET name = 'Андрей'
WHERE id = 2;

UPDATE customer
SET city = 'Санкт-Петербург'
WHERE city = 'Ленинград';

DELETE
FROM customer
WHERE id = 1;

SELECT *
FROM customer
ORDER by id;

SELECT *
FROM customer
WHERE city = 'Санкт-Петербург'
ORDER by name;