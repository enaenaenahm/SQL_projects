--Установите атрибут id как первичный ключ (пожалуйста, посмотрите на столбец id 
--в существующих таблицах и выберите тот же тип данных).
--Установите атрибуты person_id и pizzeria_id как внешние ключи для соответствующих таблиц 
--(типы данных должны быть такими же, как для столбцов id в соответствующих родительских таблицах).
--Пожалуйста, задайте явные имена для ограничений внешнего ключа, используя 
--шаблон fk_{table_name}_{column_name}, например fk_person_discounts_person_id.
--Добавьте атрибут discount для хранения значения скидки в процентах. 
--Помните, что значение скидки может быть числом с плавающей точкой (просто используйте числовой тип данных).
--Поэтому выберите подходящий тип данных, чтобы охватить эту возможность.
CREATE TABLE person_discounts (
    id BIGINT PRIMARY KEY,
    person_id BIGINT NOT NULL,
    pizzeria_id BIGINT NOT NULL,
    discount NUMERIC(5,2) NOT NULL,
    CONSTRAINT fk_person_discounts_person_id 
        FOREIGN KEY (person_id) REFERENCES person(id),
    CONSTRAINT fk_person_discounts_pizzeria_id 
        FOREIGN KEY (pizzeria_id) REFERENCES pizzeria(id),
    CONSTRAINT uk_person_discounts_unique 
        UNIQUE (person_id, pizzeria_id)
);
COMMENT ON TABLE person_discounts IS 'Таблица для хранения персональных скидок клиентов в пиццериях';
COMMENT ON COLUMN person_discounts.id IS 'Первичный ключ таблицы';
COMMENT ON COLUMN person_discounts.person_id IS 'Идентификатор клиента';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Идентификатор пиццерии';
COMMENT ON COLUMN person_discounts.discount IS 'Размер скидки в процентах (от 0 до 100)';

--Напишите оператор DML (INSERT INTO ... SELECT ...), который вставляет новые записи в 
--таблицу person_discounts на основе следующих правил.
--Возьмите агрегированное состояние из столбцов person_id и pizzeria_id.
--Рассчитайте значение персональной скидки с помощью следующего псевдокода:
--if «amount of orders» = 1 then «discount» = 10.5 
--else if «amount of orders» = 2 then «discount» = 22 else «discount» = 30
--Чтобы создать первичный ключ для таблицы person_discounts, используйте следующую 
--конструкцию SQL (эта конструкция из раздела SQL WINDOW FUNCTION).
--... ROW_NUMBER( ) OVER ( ) AS id ...
INSERT INTO person_discounts (id, person_id, pizzeria_id, discount)
WITH order_counts AS (
    SELECT 
        person_id,
        pizzeria_id,
        COUNT(*) AS amount_of_orders
    FROM (
        SELECT 
            po.person_id,
            m.pizzeria_id
        FROM person_order po
        JOIN menu m ON po.menu_id = m.id
    ) AS person_pizzeria_orders
    GROUP BY person_id, pizzeria_id
)
SELECT 
    ROW_NUMBER() OVER () AS id,
    person_id,
    pizzeria_id,
    CASE 
        WHEN amount_of_orders = 1 THEN 10.5
        WHEN amount_of_orders = 2 THEN 22
        ELSE 30
    END AS discount
FROM order_counts;

--Напишите SQL-выражение, которое возвращает заказы с фактической ценой и 
--ценой со скидкой, примененной для каждого человека в соответствующей пиццерии, 
--отсортированные по имени человека и названию пиццы. Пожалуйста, ознакомьтесь с примерами данных ниже.
SELECT 
    p.name AS name,
    m.pizza_name AS pizza_name,
    m.price AS price,
    ROUND(m.price * (100 - COALESCE(pd.discount, 0)) / 100) AS discount_price,
    pz.name AS pizzeria_name
FROM 
    person_order po
JOIN 
    person p ON po.person_id = p.id
JOIN 
    menu m ON po.menu_id = m.id
JOIN 
    pizzeria pz ON m.pizzeria_id = pz.id
LEFT JOIN 
    person_discounts pd ON p.id = pd.person_id AND pz.id = pd.pizzeria_id
ORDER BY 
    p.name, m.pizza_name;

--Создайте уникальный индекс с несколькими столбцами (с именем idx_person_discounts_unique), 
--который предотвращает дубликаты пар идентификаторов персоны и пиццерии.
--После создания нового индекса, пожалуйста, предоставьте любой простой оператор SQL, 
--который показывает доказательство использования индекса (используя EXPLAIN ANALYZE).
CREATE UNIQUE INDEX idx_person_discounts_unique 
ON person_discounts(person_id, pizzeria_id);
SET enable_seqscan = OFF;
EXPLAIN ANALYZE
SELECT * FROM person_discounts 
WHERE person_id = 1 AND pizzeria_id = 1;

--Добавьте следующие правила ограничений для существующих столбцов таблицы person_discounts.
--столбец person_id не должен быть NULL (используйте имя ограничения ch_nn_person_id);
--столбец pizzeria_id не должен быть NULL (используйте имя ограничения ch_nn_pizzeria_id);
--столбец discount не должен быть NULL (используйте имя ограничения ch_nn_discount);
--столбец discount должен быть 0 процентов по умолчанию;
--столбец discount должен быть в диапазоне значений от 0 до 100 (используйте имя ограничения ch_range_discount).
ALTER TABLE person_discounts
ALTER COLUMN person_id SET NOT NULL,
ADD CONSTRAINT ch_nn_person_id CHECK (person_id IS NOT NULL),
ALTER COLUMN pizzeria_id SET NOT NULL,
ADD CONSTRAINT ch_nn_pizzeria_id CHECK (pizzeria_id IS NOT NULL),
ALTER COLUMN discount SET NOT NULL,
ADD CONSTRAINT ch_nn_discount CHECK (discount IS NOT NULL),
ALTER COLUMN discount SET DEFAULT 0,
ADD CONSTRAINT ch_range_discount CHECK (discount >= 0 AND discount <= 100);

--Добавьте комментарии на английском или русском языке (на ваше усмотрение), объясняющие, 
--какова бизнес-цель таблицы и всех ее атрибутов.
COMMENT ON TABLE person_discounts IS 
'Таблица для хранения персональных скидок клиентов в пиццериях. 
Бизнес-цель: повышение лояльности клиентов за счет индивидуальных предложений 
и увеличение продаж за счет стимулирования повторных заказов.';
COMMENT ON COLUMN person_discounts.id IS 
'Уникальный идентификатор записи о скидке. Первичный ключ таблицы.';
COMMENT ON COLUMN person_discounts.person_id IS 
'Идентификатор клиента. Внешний ключ к таблице person. 
Определяет, для какого клиента действует скидка.';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 
'Идентификатор пиццерии. Внешний ключ к таблице pizzeria. 
Определяет, в какой пиццерии действует скидка.';
COMMENT ON COLUMN person_discounts.discount IS 
'Размер персональной скидки в процентах (от 0 до 100). 
Значение по умолчанию: 0. 
Бизнес-правила: скидка зависит от количества заказов клиента в пиццерии.';

--Давайте создадим последовательность базы данных с именем seq_person_discounts 
--(начиная со значения 1) и установим значение по умолчанию для атрибута id таблицы person_discounts, 
--чтобы автоматически брать значение из seq_person_discounts каждый раз.
--Обратите внимание, что ваш следующий номер последовательности равен 1, в этом случае, пожалуйста, 
--установите фактическое значение для последовательности базы данных на основе формулы «количество строк 
--в таблице person_discounts» + 1. 
--В противном случае вы получите ошибки о нарушении ограничения первичного ключа.
CREATE TABLE IF NOT EXISTS person_discounts (
    id SERIAL PRIMARY KEY,
    person_id INT REFERENCES person(id),
    discount DECIMAL(5,2));
CREATE SEQUENCE IF NOT EXISTS seq_person_discounts START WITH 1;
SELECT setval(
    'seq_person_discounts', 
    COALESCE((SELECT MAX(id) FROM person_discounts), 0) + 1);
ALTER TABLE person_discounts 
ALTER COLUMN id SET DEFAULT nextval('seq_person_discounts');

