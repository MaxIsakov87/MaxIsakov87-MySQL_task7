
-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.


-- orders и orders_products были не заполнены. Я так понял что их надо было делать самим

SELECT * FROM users; 
-- посмотрел имена для создания таблиц

INSERT INTO orders (user_id)
SELECT id FROM users WHERE name = 'Процессоры';

INSERT INTO orders_products (order_id, product_id, total, created_at)
SELECT last_insert_id(), id, 2, now()
FROM products WHERE name like 'int%';

INSERT INTO orders (user_id)
SELECT id FROM users WHERE name = 'Геннадий';

INSERT INTO orders_products (order_id, product_id, total, created_at)
SELECT last_insert_id(), id, 1, now()
FROM products WHERE id IN (1, 6);

INSERT INTO orders (user_id)
SELECT id FROM users WHERE name = 'Наталья';

INSERT INTO orders_products (order_id, product_id, total, created_at)
SELECT last_insert_id(), id, 1, now()
FROM products WHERE id IN (1, 3, 4, 6, 7);

SELECT * FROM users
WHERE id IN (SELECT user_id FROM orders);



-- Выведите список товаров products и разделов catalogs, который соответствует товару. (Я понял, что надо вывести из созданных в скрипте наполенных таблиц)
SELECT
	catalogs.name AS c,
	products.name AS product_name,
	products.price
FROM products
LEFT JOIN catalogs ON catalogs.id = products.catalog_id;

-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY, 
    `from` VARCHAR(50),
    `to` VARCHAR(50)
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	id SERIAL PRIMARY KEY, 
    label VARCHAR(50),
    name VARCHAR(50)
);

INSERT INTO flights (`from`, `to`) VALUES
			('moscow', 'omsk'),
			('novgorod', 'kazan'),
			('irkutsk', 'moscow'),
			('omsk', 'irkutsk'),
			('moscow', 'kazan');
			
INSERT INTO cities (label, name) VALUES
			('moscow', 'Москва'),
			('irkutsk', 'Иркутск'),
			('novgorod', 'Новгород'),
			('kazan', 'Казань'),
			('omsk', 'Омск');
			
SELECT
	id,
	(SELECT name FROM cities WHERE label = flights.`from`) AS 	`from`,
	(SELECT name FROM cities c WHERE label = flights.`to`) AS `to`
FROM flights;
