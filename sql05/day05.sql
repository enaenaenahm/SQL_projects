--Пожалуйста, создайте простой индекс BTree для каждого внешнего ключа в нашей базе данных.
--Шаблон имени должен соответствовать следующему правилу "idx_{table_name}_{column_name}". 
--Например, имя индекса BTree для столбца pizzeria_id в таблице меню — idx_menu_pizzeria_id.
CREATE INDEX idx_person_visits_pizzeria_id ON person_visits (pizzeria_id);
CREATE INDEX idx_person_visits_person_id ON person_visits (person_id);
CREATE INDEX idx_menu_pizzeria_id ON menu (pizzeria_id);
CREATE INDEX idx_person_order_menu_id ON person_order (menu_id);
CREATE INDEX idx_person_order_person_id ON person_order (person_id);
SELECT * FROM pg_indexes;

--Прежде чем продолжить, пожалуйста, напишите SQL-выражение, 
--которое возвращает пиццы и соответствующие названия пиццерий. 
--Смотрите пример результата ниже (сортировка не требуется).
--pizza_name pizzeria_name
--cheese pizza Pizza Hut
--Результат в 01.png
SET enable_seqscan = OFF;
EXPLAIN ANALYSE
SELECT pizza_name, piz.name AS pizzeria_name
FROM menu
INNER JOIN pizzeria piz ON menu.pizzeria_id = piz.id;

--Создайте функциональный индекс B-Tree с именем idx_person_name 
--для столбца name таблицы person. 
--Индекс должен содержать имена людей в верхнем регистре.
--Напишите и предоставьте любой SQL с доказательством (EXPLAIN ANALYZE),
--что индекс idx_person_name работает.
--Результат в 02.png
CREATE INDEX idx_person_name ON person (upper(name));
SET enable_seqscan = OFF;
EXPLAIN ANALYSE
SELECT name
FROM person
WHERE upper(name) = 'ANDREY';

--Создайте лучший многостолбцовый индекс B-Tree с именем 
--idx_person_order_multi для приведенного ниже оператора SQL.
--Команда EXPLAIN ANALYZE должна вернуть следующий шаблон. 
--Обратите внимание на сканирование "Index Only Scan"!
--Предоставьте любой SQL-код с доказательством (EXPLAIN ANALYZE) того, 
--что индекс idx_person_order_multi работает.
--Результат в 03.png
CREATE INDEX idx_person_order_multi ON person_order (person_id, menu_id,order_date);
SET enable_seqscan = OFF;
EXPLAIN ANALYSE
SELECT person_id, menu_id,order_date
FROM person_order
WHERE person_id = 8 AND menu_id = 19;

--Создайте уникальный индекс BTree с именем idx_menu_unique
--в таблице меню для столбцов pizzeria_id и pizza_name. 
--Напишите и предоставьте любой SQL с доказательством (EXPLAIN ANALYZE),
--что индекс idx_menu_unique работает.
--Результат в 04.png
CREATE UNIQUE INDEX idx_menu_unique ON menu (pizzeria_id, pizza_name);
SET enable_seqscan = OFF;
EXPLAIN ANALYSE
SELECT pizzeria_id, pizza_name
FROM menu
WHERE pizzeria_id = 1 AND pizza_name = 'pepperoni pizza';

--Создайте частично уникальный индекс BTree с именем idx_person_order_order_date
--в таблице person_order для атрибутов person_id и menu_id
--с частичной уникальностью для столбца order_date для даты «2022-01-01».
--The EXPLAIN ANALYZE command should return the next pattern.
--Результат в 05.png
CREATE UNIQUE INDEX idx_person_order_order_date ON person_order (person_id, menu_id)
WHERE order_date = '2022-01-01';
SET enable_seqscan = OFF;
EXPLAIN ANALYSE
SELECT person_id, menu_id
FROM person_order
WHERE order_date = '2022-01-01';

--Взгляните на приведенный ниже SQL-код с технической точки зрения
--(не обращайте внимания на логическую сторону этого SQL-выражения).
--Создайте новый индекс BTree с именем idx_1, который должен улучшить метрику «Время выполнения» этого SQL.
--Предоставьте доказательства (EXPLAIN ANALYZE) того, что SQL был улучшен.
--Подсказка: это упражнение выглядит как задача «грубой силы» для поиска хорошего индекса покрытия,
--поэтому перед новым тестом удалите индекс idx_1.
CREATE INDEX idx_1 ON pizzeria(rating);
SET enable_seqscan = OFF;
EXPLAIN ANALYZE SELECT
    m.pizza_name AS pizza_name,
    max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS k
FROM  menu m
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
ORDER BY 1,2;