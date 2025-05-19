--Напишите SQL-оператор, который возвращает список пиццерий с соответствующим 
--значением рейтинга, которые не были посещены людьми.
SELECT pizzeria.name,
	   rating
FROM person_visits
RIGHT JOIN pizzeria ON
	pizzeria.id = person_visits.pizzeria_id
WHERE pizzeria_id IS NULL;

--Напишите SQL-выражение, которое возвращает пропущенные дни с 1 по 10 января 2022 года 
--(включая все дни) для посещений людьми с идентификаторами 1 или 2 (т. е. пропущенные дни обоими). 
--​​Пожалуйста, упорядочите по дням посещений в порядке возрастания.
SELECT missing_date::date
FROM generate_series(
	'2022-01-01'::date, 
	'2022-01-10'::date, 
	'1 day'::interval) AS missing_date
LEFT JOIN (SELECT visit_date
    	   FROM person_visits
           WHERE person_id = 1 OR person_id = 2) AS visited_date 
ON  missing_date = visit_date
WHERE visit_date IS NULL
ORDER BY visit_date;

--Напишите SQL-выражение, которое вернет полный список имен людей, 
--которые посетили (или не посетили) пиццерии в период с 1 по 3 января 2022 года 
--с одной стороны и полный список названий пиццерий, которые были посещены (или не посетили) с другой стороны. 
--Обратите внимание на заменяющее значение '-' для** NULL значений в столбцах** person_name и pizzeria_name. 
--Также добавьте порядок для всех 3 столбцов.
SELECT 
	COALESCE(person.name, '-') AS person_name,
	visit_date,
	COALESCE(pizzeria.name, '-') AS pizzeria_name
FROM (SELECT visit_date,
	  		 person_id,
	  		 pizzeria_id
	  FROM person_visits
	  WHERE visit_date = '2022-01-01' OR 
	 		visit_date = '2022-01-02' OR
	 		visit_date = '2022-01-03') AS person_ordered
FULL JOIN person ON person.id = person_id
FULL JOIN pizzeria ON pizzeria.id = pizzeria_id
ORDER BY person_name, visit_date, pizzeria_name;

--Давайте вернемся к упражнению № 01, пожалуйста, перепишите ваш SQL, 
--используя шаблон CTE (Common Table Expression). 
--Пожалуйста, перейдите к части CTE вашего "генератора дней". 
--Результат должен быть похож на Упражнение № 01.
WITH date_range AS (
  SELECT missing_date::date
  FROM generate_series(
      '2022-01-01'::date, 
      '2022-01-10'::date, 
      '1 day'::interval
  ) AS missing_date),
visited_date AS (
  SELECT visit_date
    FROM person_visits
    WHERE person_id = 1 OR person_id = 2
)
SELECT missing_date
FROM date_range
LEFT JOIN visited_date
ON missing_date = visit_date
WHERE visit_date IS NULL
ORDER BY visit_date;

--Найдите полную информацию о всех возможных названиях пиццерий и ценах, 
--чтобы получить пиццу с грибами или пепперони. Затем отсортируйте 
--результат по названию пиццы и названию пиццерии. 
--Результат выборочных данных показан ниже (используйте те же названия столбцов в вашем операторе SQL).
SELECT
	menu.pizza_name,
	table_pizzeria.name AS pizzeria_name,
	menu.price
FROM menu
JOIN pizzeria AS table_pizzeria
ON table_pizzeria.id = menu.pizzeria_id
WHERE pizza_name = 'mushroom pizza' OR pizza_name = 'pepperoni pizza'
ORDER BY menu.pizza_name, pizzeria_name;

--Найдите имена всех женщин старше 25 лет и отсортируйте результат 
--по имени. Пример вывода показан ниже.
SELECT name FROM person
WHERE gender='female' AND 
	  age > 25
ORDER BY name;

--Найти все названия пицц (и соответствующие названия пиццерий с использованием таблицы **`menu`), 
--упорядоченные Денисом или Анной. Сортировать результат по обоим столбцам. 
SELECT 
	menu.pizza_name AS pizza_name,
	pizzeria.name AS pizzeria_name
FROM person_order 
JOIN menu
	ON person_order.menu_id = menu.id
JOIN pizzeria
	ON pizzeria.id = menu.pizzeria_id
JOIN (SELECT id, name 
	  FROM person WHERE name = 'Denis' OR 
	 					name = 'Anna') AS person_table
	ON person_table.id = person_order.person_id
ORDER BY pizza_name, pizzeria_name;

--Найдите, пожалуйста, название пиццерии, которую Дмитрий посетил 
--8 января 2022 года и смог съесть пиццу менее чем за 800 рублей.
SELECT pizzeria.name AS pizzeria_name
FROM pizzeria
JOIN menu ON
	menu.pizzeria_id = pizzeria.id AND
	price < 800
JOIN person_visits ON
	person_visits.pizzeria_id = menu.pizzeria_id AND
	visit_date = '2022-01-08'
JOIN person ON
	person.id = person_visits.person_id AND
	person.name = 'Dmitriy';

--Найдите имена всех мужчин из Москвы или Самары, которые заказывают либо пепперони, 
--либо грибную пиццу (или обе). Отсортируйте результат по именам людей в порядке убывания.
--Конструкция AL JOIN. Результат должен быть таким же, как и для упражнения № 07.
SELECT 
	person_table.name AS name
FROM (SELECT * 
	  FROM person 
	  WHERE address IN ('Moscow', 'Samara') AND
	 		gender = 'male') AS person_table
JOIN person_order ON 
	person_order.person_id = person_table.id
JOIN (SELECT * 
	  FROM menu 
	  WHERE menu.pizza_name = 'pepperoni pizza' OR
	 		menu.pizza_name = 'mushroom pizza') AS menu_table
	ON menu_table.id = person_order.menu_id
ORDER BY name DESC;

--Найдите имена всех женщин, которые заказали пиццу пепперони и сыр (в любое время и в любых пиццериях). 
--Убедитесь, что результат упорядочен по имени человека.
SELECT person.name AS name
FROM person
JOIN person_order ON
  person_order.person_id = person.id AND
  person.gender = 'female'
JOIN menu ON 
  person_order.menu_id = menu.id AND
  menu.pizza_name IN ('pepperoni pizza', 'cheese pizza')
GROUP BY name
HAVING COUNT (DISTINCT menu.pizza_name) = 2
ORDER BY name;

--Найдите имена людей, которые живут по одному адресу. 
--Убедитесь, что результат отсортирован по имени 1-го лица, имени 2-го лица и общему адресу. 
--Убедитесь, что имена ваших столбцов совпадают с именами столбцов ниже.
SELECT 
	person1.name AS person_name1, 
	person2.name AS person_name2, 
	person1.address AS common_address
FROM person AS person1 
JOIN person AS person2 
  ON person1.address = person2.address 
  AND person1.id > person2.id
ORDER BY person_name1, person_name2, common_address
