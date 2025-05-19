--Пожалуйста, напишите SQL-выражение, которое возвращает список названий 
--пиццы, цен на пиццу, названий пиццерий и дат посещения для Кейт и для 
--цен в диапазоне от 800 до 1000 рублей. 
--Пожалуйста, отсортируйте по пицце, цене и названию пиццерии. 
SELECT pizza_name, price, p.name AS pizzeria_name, pv.visit_date
FROM menu
INNER JOIN pizzeria p ON p.id = menu.pizzeria_id
INNER JOIN person_visits pv ON p.id = pv.pizzeria_id
INNER JOIN person p2 ON p2.id = pv.person_id
WHERE price BETWEEN 800 AND 1000 AND p2.name = 'Kate'
ORDER BY 1,2,3;

--Найти все идентификаторы меню, которые не упорядочены никем. 
--Результат должен быть отсортирован по идентификатору. 
SELECT id AS menu_id
FROM menu
EXCEPT  
SELECT menu_id
FROM person_order 
order by 1;

--Пожалуйста, используйте SQL-выражение из упражнения № 01 и 
--выведите на экран названия пицц из пиццерии, которые никто не заказывал, 
--включая соответствующие цены. Результат должен быть отсортирован по названию пиццы и цене. 
SELECT pizza_name, price, p.name
FROM
 (SELECT id AS menu_id
 FROM menu
 EXCEPT SELECT menu_id
 FROM person_order) AS t1
INNER JOIN menu ON t1.menu_id = menu.id
INNER JOIN pizzeria p ON p.id = menu.pizzeria_id
ORDER BY 1,2;

--Найдите пиццерии, которые чаще посещали женщины или мужчины. 
--Сохраните дубликаты для любых операторов SQL с множествами 
--(конструкции UNION ALL, EXCEPT ALL, INTERSECT ALL). 
--Отсортируйте результат по названию пиццерии. 
(SELECT p2.name AS pizzeria_name
 FROM person p
 INNER JOIN person_visits pv ON p.id = pv.person_id
 INNER JOIN pizzeria p2 ON p2.id = pv.pizzeria_id
 WHERE p.gender = 'female'
 EXCEPT ALL SELECT p2.name
 FROM person p
 INNER JOIN person_visits pv ON p.id = pv.person_id
 INNER JOIN pizzeria p2 ON p2.id = pv.pizzeria_id
 WHERE p.gender = 'male')
UNION
(SELECT p2.name
 FROM person p
 INNER JOIN person_visits pv ON p.id = pv.person_id
 INNER JOIN pizzeria p2 ON p2.id = pv.pizzeria_id
 WHERE p.gender = 'male'
 EXCEPT ALL SELECT p2.name
 FROM person p
 INNER JOIN person_visits pv ON p.id = pv.person_id
 INNER JOIN pizzeria p2 ON p2.id = pv.pizzeria_id
 WHERE p.gender = 'female')
ORDER BY 1;

--Найдите объединение пиццерий, в которых есть заказы либо от женщин, 
--либо от мужчин. Другими словами, вам следует найти набор названий пиццерий, 
--которые были заказаны только женщинами, и выполнить операцию "UNION" с 
--набором названий пиццерий, которые были заказаны только мужчинами. 
--Будьте осторожны со словом "only" для обоих полов. 
--Для всех операторов SQL с наборами не сохраняйте дубликаты (UNION, EXCEPT, INTERSECT). 
--Пожалуйста, отсортируйте результат по названию пиццерии.
(SELECT p2.name AS pizzeria_name
 FROM person p
 INNER JOIN person_order po ON p.id = po.person_id
 INNER JOIN menu m ON m.id = po.menu_id
 INNER JOIN pizzeria p2 ON p2.id = m.pizzeria_id
 WHERE p.gender = 'female'
 EXCEPT
 SELECT p2.name
 FROM person p
 INNER JOIN person_order po ON p.id = po.person_id
 INNER JOIN menu m ON m.id = po.menu_id
 INNER JOIN pizzeria p2 ON p2.id = m.pizzeria_id
 WHERE p.gender = 'male')
UNION
(SELECT p2.name
 FROM person p
 INNER JOIN person_order po ON p.id = po.person_id
 INNER JOIN menu m ON m.id = po.menu_id
 INNER JOIN pizzeria p2 ON p2.id = m.pizzeria_id
 WHERE p.gender = 'male'
 EXCEPT
 SELECT p2.name
 FROM person p
 INNER JOIN person_order po ON p.id = po.person_id
 INNER JOIN menu m ON m.id = po.menu_id
 INNER JOIN pizzeria p2 ON p2.id = m.pizzeria_id
 WHERE p.gender = 'female');

--Напишите SQL-выражение, которое возвращает список пиццерий, которые посетил Андрей, но не сделал там заказ. 
--Пожалуйста, сделайте заказ по названию пиццерии.
 FROM person_visits
 INNER JOIN person p ON p.id = person_visits.person_id
 INNER JOIN pizzeria p2 ON p2.id = person_visits.pizzeria_id
 WHERE p.name = 'Andrey'
 EXCEPT 
 SELECT p2.name
 FROM person_order
 INNER JOIN person p ON p.id = person_order.person_id
 INNER JOIN menu m ON m.id = person_order.menu_id
 INNER JOIN pizzeria p2 ON p2.id = m.pizzeria_id
 WHERE p.name = 'Andrey'
ORDER BY 1;

--Найдите одинаковые названия пиццы с одинаковой ценой, но из разных пиццерий. 
--Убедитесь, что результат упорядочен по названию пиццы. 
SELECT m1.pizza_name,
    p1.name AS pizzeria_name_1,
    p2.name AS pizzeria_name_2,
    m1.price
FROM menu m1
INNER JOIN menu m2 ON m1.id <> m2.id
AND m1.price = m2.price
AND m1.pizzeria_id > m2.pizzeria_id
AND m1.pizza_name = m2.pizza_name
INNER JOIN pizzeria p1 ON m1.pizzeria_id = p1.id
INNER JOIN pizzeria p2 ON m2.pizzeria_id = p2.id
ORDER BY 1;

--Пожалуйста, зарегистрируйте новую пиццу с названием "greek pizza" (используйте id = 19) с ценой 800 рублей в ресторане "Dominos" (pizzeria_id = 2).
--Внимание: это упражнение, скорее всего, приведет к неправильной модификации данных. 
INSERT INTO menu VALUES (19,2,'greek pizza',800);

--Пожалуйста, зарегистрируйте новую пиццу с названием «sicilian pizza» 
--(id которой должен быть вычислен по формуле «максимальное значение id + 1») 
--с ценой 900 рублей в ресторане «Dominos» (пожалуйста, используйте 
--внутренний запрос для получения идентификатора пиццерии).
--Внимание: это упражнение, скорее всего, приведет к неправильной модификации данных. 
--На самом деле, вы можете восстановить исходную модель базы данных с данными по ссылке в разделе «Правила дня» и воспроизвести сценарий из упражнений 07.
INSERT INTO menu values 
((SELECT max(id)+1 FROM menu ),
(SELECT id FROM pizzeria WHERE name = 'Dominos'),
'sicilian pizza',
900);

--Пожалуйста, запишите новые визиты в ресторан Domino's Дениса и Ирины 24 февраля 2022 г.
--Предупреждение: это упражнение, скорее всего, приведет к неправильной модификации данных. 
--На самом деле, вы можете восстановить исходную модель базы данных с данными по ссылке в разделе «Правила дня» и воспроизвести сценарий из упражнений 07, 08.
INSERT INTO person_visits VALUES(
(SELECT max(id)+1 FROM person_visits),
(SELECT id FROM person WHERE name ='Denis'),
(SELECT id FROM pizzeria WHERE name = 'Dominos'),
'2022-02-24');

INSERT INTO person_visits VALUES(
(SELECT max(id)+1 FROM person_visits),
(SELECT id FROM person WHERE name = 'Irina'),
(SELECT id FROM pizzeria WHERE name = 'Dominos'),
'2022-02-24');

--Пожалуйста, зарегистрируйте новые заказы от Дениса и Ирины 24 февраля 2022 года на новое меню с «сицилийской пиццей».
--Предупреждение: это упражнение, вероятно, заставит вас изменить данные неправильным образом. 
--На самом деле, вы можете восстановить исходную модель базы данных с данными по ссылке в разделе «Правила дня» и воспроизвести сценарий из упражнений 07, 08 и 09.
INSERT INTO person_order 
VALUES(
(SELECT max(id)+1 FROM person_order),
(SELECT id FROM person WHERE name = 'Denis'),
(SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),
'2022-02-24');

INSERT INTO person_order 
VALUES(
(SELECT max(id)+1 FROM person_order),
(SELECT id FROM person WHERE name = 'Irina'),
(SELECT id FROM menu WHERE pizza_name = 'sicilian pizza'),
'2022-02-24');

--Пожалуйста, измените цену "греческой пиццы" на -10% от текущего значения.
--Предупреждение: это упражнение, скорее всего, заставит вас изменить данные неправильным образом. 
--На самом деле, вы можете перестроить исходную модель базы данных с данными по ссылке в разделе "Правила дня" и воспроизвести сценарий из упражнений 07, 08, 09 и 10.
UPDATE menu
SET price = ROUND(price*0.9)
WHERE pizza_name = 'greek pizza';

--Пожалуйста, зарегистрируйте новые заказы всех лиц на «греческую пиццу» 25 февраля 2022 г.
--Предупреждение: это упражнение, вероятно, заставит вас изменить данные неправильным образом. 
--На самом деле, вы можете восстановить исходную модель базы данных с данными по ссылке в разделе «Правила дня» и воспроизвести сценарий из упражнений 07, 08, 09, 10 и 11.
INSERT INTO person_order
SELECT g+
    (SELECT max(id)
    FROM person_order) AS id, id AS person_id,

    (SELECT id
    FROM menu
    WHERE pizza_name = 'greek pizza') AS menu_id, '2022-02-25' AS order_date
    FROM person
    INNER JOIN generate_series(1, 
    (SELECT count (*)
    FROM person)) AS g ON g = person.id;

--Напишите 2 оператора SQL (DML), которые удаляют все новые заказы из упражнения № 12 на основе даты заказа. Затем удалите «греческую пиццу» из меню.
--Предупреждение: это упражнение, скорее всего, заставит вас изменить данные неправильным образом. 
--На самом деле, вы можете перестроить исходную модель базы данных с данными из ссылки в разделе «Правила дня» и воспроизвести сценарий из упражнений 07, 08, 09, 10, 11, 12 и 13.
DELETE FROM person_order
WHERE order_date = '2022-02-25';

DELETE FROM menu
WHERE pizza_name = 'greek pizza';
