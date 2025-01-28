CREATE TABLE product
(
    "id"       BIGINT GENERATED ALWAYS AS IDENTITY,
    "title"    VARCHAR(30),
    "price"    DOUBLE PRECISION,
    "category" VARCHAR(30)
);
INSERT INTO product(title, price, category)
VALUES (мандарины, 300, продукты),
       (смартфон, 22000, электроника),
       (джинсы, 3000, одежда),
       (ноутбук, 150000, электроника);
SELECT
    id,
    title AS "Название товара",
    price AS "Цена",
    category AS "Категория товара"
FROM product;

UPDATE product
SET title = "джинсовая куртка"
WHERE id = 3;