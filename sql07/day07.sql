-- Давайте сделаем простую агрегацию, пожалуйста, напишите SQL-запрос, которая возвращает идентификаторы 
-- лиц и соответствующее количество посещений в любых пиццериях и сортирует по количеству посещений в 
-- -- нисходящем режиме и сортирует по person_id в восходящем режиме. 
-- person_id	count_of_visits
-- 9	        4
-- 4	        3
SELECT DISTINCT person_id, count(visit_date) AS count_of_visits 
FROM person_visits
GROUP BY person_id
ORDER BY count_of_visits DESC,person_id;

-- Измените SQL-запрос из упражнения 00 и верните имя человека (не идентификатор). 
-- Дополнительное положение заключается в том, что нам нужно видеть только 4 лучших человека с 
-- максимальным количеством посещений в каждой пиццерии и отсортировать по имени человека.
-- name	    count_of_visits

-- Dmitriy	4
-- Denis	3
SELECT DISTINCT p.name, count(visit_date) AS count_of_visits 
FROM person_visits pv
LEFT JOIN person p ON p.id = pv.person_id
GROUP BY p.name
ORDER BY count_of_visits 
DESC,p.name
LIMIT 4;

-- Пожалуйста, напишите SQL-запрос, чтобы увидеть 3 любимых ресторана по посещениям и заказам в списке (пожалуйста, 
-- добавьте столбец action_type со значениями 'order' или 'visit', это зависит от данных из соответствующей таблицы). 
-- Пожалуйста, ознакомьтесь с приведенными ниже примерами данных. Результат должен быть отсортирован в порядке возрастания 
-- по столбцу action_type и в порядке убывания по столбцу count.
-- name	 count	action_type
-- Dominos  6	    order
-- ...	     ...    ...
-- Dominos	 7	    visit
(SELECT  p.name, count(visit_date) AS count , 'visit' AS action_type FROM person_visits pv
LEft JOIN pizzeria p ON p.id=pv.pizzeria_id
GROUP BY p.name
ORDER BY count DESC, action_type
LIMIT 3)
UNION 
(SELECT  p.name, count(order_date), 'order' AS action_type FROM person_order po
LEFT JOIN menu m ON m.id=po.menu_id
LEFT JOIN pizzeria p ON p.id=m.pizzeria_id
GROUP BY p.name
ORDER BY count DESC, action_type
LIMIT 3)
ORDER BY  action_type,count DESC;

-- Напишите SQL-запрос, чтобы увидеть, как рестораны сгруппированы по посещениям и заказам и объединены по названию ресторана.
-- Вы можете использовать внутренний SQL из Упражнения 02 (Рестораны по посещениям и заказам) без каких-либо ограничений на количество строк.
-- Рассчитайте сумму заказов и посещений соответствующей пиццерии (обратите внимание, что не все ключи пиццерии представлены в обеих таблицах).
-- Отсортируйте результаты по столбцу total_count в порядке убывания и по столбцу имени в порядке возрастания. Взгляните на примеры данных ниже.
-- name    	total_count
-- Dominos	    13
-- DinoPizza	9
SELECT name, sum(total_count) AS total_count FROM
(SELECT  p.name, count(visit_date) AS total_count FROM person_visits pv
LEFT JOIN pizzeria p on p.id=pv.pizzeria_id
GROUP BY p.name
UNION ALL
SELECT  p.name, count(order_date) AS total_count FROM person_order po
LEFT JOIN menu m ON m.id=po.menu_id
LEFT JOIN pizzeria p ON p.id=m.pizzeria_id
GROUP BY p.name) AS combined_counts
GROUP BY NAME
ORDER BY  total_count DESC,name;

-- Пожалуйста, напишите SQL-запрос, которая возвращает имя человека и соответствующее количество посещений любых пиццерий, 
-- если человек посетил более 3 раз (> 3). Пожалуйста, ознакомьтесь с приведенными ниже примерами данных.
-- name	count_of_visits
-- Dmitriy	4
SELECT p.name, count(visit_date) AS count_of_visits
    FROM person_visits
    LEFT JOIN person p ON p.id=person_visits.person_id
    GROUP BY p.name
    HAVING count(visit_date)>3;

-- Пожалуйста, напишите простой SQL-запрос, который возвращает список уникальных имен людей, 
-- которые разместили заказы в любой пиццерии. Результат должен быть отсортирован по имени человека. 
-- name
-- Andrey
-- Anna
-- ...
SELECT DISTINCT p.name FROM person_order po
    LEFT JOIN person p ON p.id=po.person_id
    ORDER BY name;

-- Напишите SQL-запрос, которое возвращает количество заказов, среднюю цену, максимальную цену и 
-- минимальную цену на пиццу, продаваемую каждым пиццерией. Результат должен быть отсортирован по названию пиццерии. 
-- Округлите среднюю цену до 2 плавающих чисел.

-- name	     count_of_orders	average_price	max_price	min_price
-- Best Pizza	 5	                780	            850	        700
-- DinoPizza	 5	                880	            1000	    800
SELECT p.name, 
       count(po.order_date) AS count_of_orders,
       ROUND(AVG(m.price),2) AS average_price,
       ROUND(MAX(m.price),0) AS max_price,
       ROUND(MIN(m.price),0) AS min_price
    FROM person_order po
    LEFT JOIN menu m ON m.id=po.menu_id
    LEFT JOIN pizzeria p ON m.pizzeria_id=p.id
    GROUP BY p.name
    ORDER BY p.name;

--Напишите SQL-запрос, которая возвращает общий средний рейтинг (имя атрибута вывода global_rating) для всех ресторанов. 
--Округлите свой средний рейтинг до 4 чисел с плавающей точкой.
SELECT ROUND(AVG(rating),4) AS global_rating FROM pizzeria;

-- Мы знаем личные адреса из наших данных. Предположим, что этот человек посещает пиццерии только в своем городе. 
-- Напишите SQL-запрос, которая возвращает адрес, название пиццерии и количество заказов человека. 
-- Результат должен быть отсортирован по адресу, а затем по названию ресторана. 
-- address	name	    count_of_orders
-- Kazan	Best Pizza	4
-- Kazan	DinoPizza	4
SELECT p.address, pz.name, count(po.order_date) AS count_of_orders FROM person_order po
    LEFT JOIN person p ON p.id=person_id
    LEFT JOIN menu m ON m.id=menu_id
    LEFT JOIN pizzeria pz ON pz.id=pizzeria_id
    GROUP BY pz.name,p.address
    ORDER BY p.address, name;

--  Возвращает агрегированную информацию по адресу человека, результат "Maximum Age - (Minimum Age / Maximum Age)", 
--  представленный в виде столбца формулы, далее - средний возраст на адрес и результат сравнения между формулой и 
--  средними столбцами (другими словами, если формула больше среднего, то True, в противном случае False значение).
-- Результат должен быть отсортирован по адресной колонке. 
-- address	formula	average	comparison
-- Kazan	44.71	30.33	true
-- Moscow	20.24	18.5	true
SELECT address, 
       ROUND((MAX(age)-(CAST(MIN(age) AS DECIMAL) / (Max(age)))),2) AS formula,
       ROUND(AVG(age),2) as average,
        CASE
        WHEN (MAX(age) - (CAST(MIN(age) AS DECIMAL) / (MAX(age)))) > AVG(age) THEN 'true'
            ELSE 'false'
            END AS comparison
       FROM person
GROUP BY address
ORDER BY address;



