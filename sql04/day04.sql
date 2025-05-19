--Пожалуйста, создайте 2 представления базы данных (с атрибутами, аналогичными исходной таблице) 
--на основе простой фильтрации по полу лиц. Задайте соответствующие имена для 
--представлений базы данных: v_persons_female и v_persons_male.
CREATE VIEW v_persons_female AS
SELECT id, name, age, gender, address
FROM person
WHERE gender = 'female';

CREATE VIEW v_persons_male AS
SELECT id, name, age, gender, address
FROM person
WHERE gender = 'male';

--Пожалуйста, используйте 2 представления базы данных из упражнения № 00 и 
--напишите SQL, чтобы получить женские и мужские имена в одном списке. 
--Пожалуйста, укажите порядок по имени человека.
SELECT name FROM v_persons_female
UNION
SELECT name
FROM v_persons_male
ORDER BY 1;

--Пожалуйста, создайте представление базы данных (с именем `v_generated_dates`), 
--которое должно "хранить" сгенерированные даты с 1 по 31 января 2022 года в типе DATE. 
--Не забудьте порядок столбца generated_date.
CREATE VIEW v_generated_dates AS
SELECT generated_date::date
FROM generate_series('2022-01-01'::timestamp, '2022-01-31'::timestamp, '1 day') generated_date
ORDER BY 1;

--Напишите SQL-выражение, которое возвращает пропущенные дни для 
--посещений людей в январе 2022 года. Используйте представление `v_generated_dates` 
--для этой задачи и отсортируйте результат по столбцу missing_date.
SELECT generated_date missing_date
FROM v_generated_dates
EXCEPT
SELECT visit_date
FROM person_visits
ORDER BY 1;

--Напишите SQL-выражение, удовлетворяющее формуле `(R - S)∪(S - R)`.
--Где R - таблица `person_visits` с фильтром на 2 января 2022 года, S - также таблица `person_visits`, 
--но с другим фильтром на 6 января 2022 года. Пожалуйста, выполните вычисления с наборами 
--в столбце `person_id`, и этот столбец будет единственным в результате. 
--Пожалуйста, отсортируйте результат по столбцу `person_id` и представьте 
--свой окончательный SQL в представлении базы данных `v_symmetric_union` (*).
--(*) Честно говоря, определения «симметричного объединения» в теории множеств не существует. Это интерпретация автора, основная идея основана на существующем правиле симметричной разности.
CREATE VIEW v_symmetric_union AS
(	SELECT person_id
	FROM person_visits
	WHERE visit_date = '2022-01-02'
	EXCEPT
	SELECT person_id
	FROM person_visits
	WHERE visit_date = '2022-01-06')
UNION
(	SELECT person_id
	FROM person_visits
	WHERE visit_date = '2022-01-06'
	EXCEPT
	SELECT person_id
	FROM person_visits
	WHERE visit_date = '2022-01-02')
	
ORDER BY 1;

--Пожалуйста, создайте представление базы данных `v_price_with_discount`, 
--которое возвращает заказы человека с именем человека, названием пиццы, 
--реальной ценой и вычисляемым столбцом `discount_price` (с примененной скидкой 10% и 
--удовлетворяющей формулой `price - price*0.1`). 
--Пожалуйста, отсортируйте результат по именам людей и названиям пиццы и 
--преобразуйте столбец `discount_price` в целочисленный тип. 
CREATE VIEW v_price_with_discount AS
SELECT p.name,
		m.pizza_name, 
		m.price, 
		(SELECT (m2.price *0.9)::INT discount_price FROM menu m2 WHERE m2.id = m.id)
FROM person_order po
LEFT JOIN person p ON p.id = po.person_id
LEFT JOIN menu m ON m.id = po.menu_id
ORDER BY 1, 2;

--Создайте материализованное представление `mv_dmitriy_visits_and_eats` (с включенными данными) на основе оператора SQL, 
--который находит название пиццерии, которую Дмитрий посетил 8 января 2022 года и мог съесть пиццу менее чем за 800 рублей 
--(этот SQL можно найти в упражнении № 02 дня № 07).
--Чтобы проверить себя, вы можете написать SQL в материализованное представление `mv_dmitriy_visits_and_eats` 
--и сравнить результаты с вашим предыдущим запросом.
CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
SELECT pz.name
FROM person_visits pv
FULL JOIN menu ON menu.pizzeria_id = pv.pizzeria_id
FULL JOIN pizzeria pz ON pz.id = menu.pizzeria_id
FULL JOIN person p ON p.id = pv.person_id
WHERE p.name = 'Dmitriy' AND pv.visit_date = '2022-01-08' AND menu.price < 800;

--Давайте обновим данные в нашем материализованном представлении `mv_dmitriy_visits_and_eats` из 
--упражнения № 06. Перед этим действием, пожалуйста, создайте еще 
--одно посещение Дмитрия, которое удовлетворяет предложению SQL материализованного представления, 
--за исключением пиццерии, которую мы можем увидеть в результате из упражнения № 06.
После добавления нового посещения, пожалуйста, обновите состояние данных для `mv_dmitriy_visits_and_eats`.
CREATE VIEW find_pizza AS
	SELECT pizzeria.id pizzeria_id, menu.id menu_id
	FROM pizzeria
	JOIN menu ON menu.pizzeria_id = pizzeria.id
	WHERE menu.price < 800 AND pizzeria.name != 'Papa Johns'
	ORDER BY 1
	LIMIT 1;
INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
SELECT
		(SELECT MAX(id) + 1 FROM person_visits),
		(SELECT id FROM person WHERE name = 'Dmitriy'),
		(SELECT pizzeria_id FROM find_pizza),
		'2022-01-08';
INSERT INTO person_order (id, person_id, menu_id, order_date)
SELECT
		(SELECT MAX(id) + 1 FROM person_order),
		(SELECT id FROM person WHERE name = 'Dmitriy'),
		(SELECT menu_id FROM find_pizza),
		'2022-01-08';
DROP VIEW find_pizza;
REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;

--После всех наших упражнений у нас есть пара виртуальных таблиц и материализованное представление. Давайте отбросим их!
DROP VIEW v_generated_dates, v_persons_female, v_persons_male, 
			v_price_with_discount, v_symmetric_union;
DROP MATERIALIZED VIEW mv_dmitriy_visits_and_eats;