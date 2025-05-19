--Напишите SQL-оператор, который возвращает идентификатор меню и названия пиццы из таблицы menu, а также идентификатор 
--и имя человека из таблицы person в одном глобальном списке (с именами столбцов, как показано в примере ниже), 
--упорядоченном по столбцам object_id, а затем по столбцам object_name.
SELECT id AS object_id, pizza_name AS object_name
FROM menu
UNION
SELECT id, name
FROM person
ORDER BY 1, 2

--Измените SQL-выражение из "Exercise 00", удалив столбец object_id. 
--Затем измените порядок по object_name для части данных из таблицы person`, а затем из таблицы menu (как показано в примере ниже). 
--Сохранить дубликаты!
SELECT pizza_name AS object_name
FROM menu
UNION ALL
SELECT name 
FROM person
ORDER BY 1;

--Напишите SQL-выражение, которое возвращает уникальные названия пиццы из таблицы menu и 
--сортирует их по столбцу pizza_name в порядке убывания. Обратите внимание на раздел Denied.
SELECT pizza_name AS object_name
FROM menu
INTERSECT
SELECT pizza_name AS object_name
FROM menu
ORDER BY 1 DESC;

--Напишите SQL-выражение, которое возвращает общие строки для атрибутов order_date, person_id из таблицы person_order 
--с одной стороны и visit_date, person_id из таблицы person_visits с другой стороны (см. пример ниже). 
--Другими словами, давайте найдем идентификаторы лиц, которые посетили и заказали пиццу в один и тот же день. 
--На самом деле, пожалуйста, добавьте заказ по action_date в порядке возрастания, а затем по person_id в порядке убывания.
SELECT order_date, person_id
FROM person_order
INTERSECT
SELECT visit_date, person_id
FROM person_visits
ORDER BY 1, 2 DESC;

--Напишите оператор SQL, который возвращает разницу (минус) значений столбца person_id, 
--сохраняя дубликаты между таблицами person_order и person_visits для order_date и visit_date на 7 января 2022 г.
SELECT person_id
FROM person_order
WHERE order_date = '2022-01-07'
EXCEPT ALL
SELECT person_id
From person_visits
WHERE visit_date = '2022-01-07';

--Пожалуйста, напишите SQL-выражение, которое возвращает все возможные комбинации 
--между таблицами ** **`person` и ** **`pizzeria`, и, пожалуйста, 
--установите порядок столбцов идентификаторов людей, а затем столбцов 
--идентификаторов пиццерий. Пожалуйста, взгляните на пример результата ниже. 
--Пожалуйста, обратите внимание, что названия столбцов могут отличаться для вас. 
SELECT * FROM person
CROSS JOIN pizzeria
ORDER BY person.id, pizzeria.id;

--Давайте вернемся к упражнению № 03 и изменим наш оператор SQL, чтобы он возвращал имена людей вместо идентификаторов людей и изменил 
--порядок по action_date в восходящем режиме, а затем по person_name в 
--нисходящем режиме. Взгляните на пример данных ниже.
SELECT ACTION_DATE,
	PERSON.NAME
FROM
	(SELECT ORDER_DATE AS ACTION_DATE,
			PERSON_ID
		FROM PERSON_ORDER 
    INTERSECT 
    SELECT VISIT_DATE AS ACTION_DATE,
			PERSON_ID
		FROM PERSON_VISITS) AS INTER
INNER JOIN PERSON ON PERSON.ID = PERSON_ID
ORDER BY 1 ASC,
	2 DESC;

--Напишите SQL-выражение, которое возвращает дату заказа из таблицы **person_order` и 
--соответствующее имя человека (имя и возраст отформатированы как в примере данных ниже), 
--который сделал заказ из таблицы **person`. 
--Добавьте сортировку по обоим столбцам в порядке возрастания.
SELECT ORDER_DATE,
	PERSON_INFORMATION
FROM
	(SELECT NAME || ' (age:' || AGE || ')' AS PERSON_INFORMATION,
			ID
		FROM PERSON) AS TABLE1
INNER JOIN PERSON_ORDER ON PERSON_ORDER.PERSON_ID = TABLE1.ID
ORDER BY 1 ASC,
	2 ASC;

--Пожалуйста, перепишите SQL-выражение из упражнения № 07, используя конструкцию NATURAL JOIN. 
--Результат должен быть таким же, как для упражнения № 07.
SELECT ORDER_DATE,
	PERSON_INFORMATION
FROM
	(SELECT NAME || ' (age:' || AGE || ')' AS PERSON_INFORMATION,
			ID
		FROM PERSON) AS TABLE1
NATURAL JOIN (SELECT order_date, person_id AS ID FROM PERSON_ORDER) AS nj
ORDER BY 1 ASC,
	2 ASC;

--Напишите два оператора SQL, которые возвращают список пиццерий, которые не посещались людьми, 
--используя IN для первого и EXISTS для второго.
SELECT name 
FROM pizzeria
WHERE id NOT IN (SELECT pizzeria_id AS id FROM person_visits);

SELECT NAME
FROM PIZZERIA
WHERE NOT EXISTS
		(SELECT PIZZERIA_ID
			FROM PERSON_VISITS
			WHERE PIZZERIA.ID = PIZZERIA_ID);

--Пожалуйста, напишите SQL-выражение, которое возвращает список имен 
--людей, заказавших пиццу в соответствующей пиццерии. 
--Сделайте заказ по 3 столбцам (person_name, pizza_name, pizzeria_name`) 
--в возрастающем режиме.
SELECT PERSON.NAME AS PERSON_NAME,
	PIZZA_NAME,
	PIZZERIA.NAME AS PIZZERIA_NAME
FROM PERSON
INNER JOIN PERSON_ORDER ON PERSON_ID = PERSON.ID
INNER JOIN MENU ON MENU_ID = MENU.ID
INNER JOIN PIZZERIA ON MENU.PIZZERIA_ID = PIZZERIA.ID
ORDER BY 1 ASC,
	2 ASC,
	3 ASC;

