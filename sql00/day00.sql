--Создайте оператор select, который возвращает все имена и возрасты людей из города «Казань».
SELECT name, age FROM person 
    WHERE 
        address = 'Kazan';

--Сделайте запрос select, который возвращает имена, возрасты всех женщин из города «Казань». 
--Отсортируйте результат по имени.
SELECT name, age FROM person
WHERE
    gender = 'female' 
    AND 
    address = 'Kazan'
ORDER BY
    name;

--Создайте 2 различных по синтаксису оператора select, которые возвращают список пиццерий (название пиццерии и рейтинг) 
--с рейтингом от 3,5 до 5 баллов (включая предельные баллы) и упорядоченных по рейтингу пиццерии.
--1 запрос
SELECT name, rating FROM pizzeria 
WHERE 
    (rating >= 3.5) AND (rating <= 5) 
ORDER BY 
    rating;
--* первый оператор select должен содержать знаки сравнения (<=, >=);
--* второй оператор select должен содержать** ключевое слово **`BETWEEN`.
--2 запрос
SELECT name, rating FROM pizzeria 
WHERE 
    (rating BETWEEN 3.5 AND 5) 
ORDER BY 
    rating;

--Создайте оператор select, который возвращает идентификаторы лиц (без дубликатов), которые посетили пиццерии 
--в период с 6 января 2022 г. по 9 января 2022 г. (включая все дни) или посетили пиццерии с идентификатором 2. 
--Также включите условие упорядочивания по идентификатору лица в убывающем порядке.
SELECT DISTINCT person_id FROM person_visits 
WHERE 
    (visit_date BETWEEN '2022-01-06' AND '2022-01-09') 
    OR 
    (pizzeria_id = 2)
ORDER BY 
    person_id DESC;

--Пожалуйста, сделайте оператор select, который возвращает одно вычисляемое поле с именем «person_information» 
--в одной строке, как описано в следующем примере:
`Анна (возраст:16, пол: 'женский', адрес: 'Москва')`
--Добавьте предложение упорядочивания по вычисляемому столбцу в порядке возрастания. 
--Обратите внимание на кавычки в вашей формуле!
SELECT 
    name 
    || ' (age:' || age
    || ', gender:' || gender
    || ', address:' || address
    || ')'
    AS person_information
FROM 
    person
ORDER BY person_information ASC;

--Напишите оператор select, который возвращает имена людей (на основе внутреннего запроса в **предложении SELECT`), которые 
--оформили заказы на меню с идентификаторами 13, 14 и 18, а дата заказов должна быть 7 января 2022 года. 
--Будьте осторожны с «Отклоненным разделом» перед началом работы.
SELECT 
    (SELECT name from person WHERE id = person_order.person_id) AS name  -- this is an internal query in a main SELECT clause
FROM person_order
WHERE
    (
        (menu_id = 13)
        OR
        (menu_id = 14)
        OR
        (menu_id = 18))
    AND
    (
        (order_date = '2022-01-07'))

--Используйте конструкцию SQL из упражнения 05 и добавьте новый вычисляемый столбец 
--(используйте имя столбца «check_name») с оператором проверки (псевдокод для этой 
--проверки приведен ниже)в предложении SELECT.
SELECT 
    ( 
        SELECT name 
        
        FROM person WHERE id = person_order.person_id
    )
    ,
    (
        SELECT 
            CASE 
                WHEN name = 'Denis' THEN TRUE
                ELSE FALSE
            END
        AS isDenis

        FROM person WHERE id = person_order.person_id
    )
FROM person_order
WHERE
    (
        (menu_id = 13)
        OR
        (menu_id = 14)
        OR
        (menu_id = 18)
)
    AND
    ((order_date = '2022-01-07'))
    
--Давайте применим интервалы данных к таблице person. Создайте SQL-оператор, который возвращает 
--идентификаторы человека, его имена и интервал возраста человека (задайте имя нового вычисляемого 
--столбца как 'interval_info') на основе приведенного ниже псевдокода.
SELECT 
    id,
    name,
    (
        SELECT 
            CASE 
                WHEN (age BETWEEN 10 AND 20) THEN 'interval #1'
                WHEN (age > 20 AND age < 24) THEN 'interval #2'
                ELSE 'interval #3'
            END
        AS interval_info
    )
FROM person
ORDER BY interval_info ASC;

--Создайте SQL-оператор, который возвращает все столбцы из таблицы **person_order** со строками, 
--идентификатор которых является четным числом. Результат должен быть упорядочен 
--по возвращаемому идентификатору.
SELECT 
    id,
    person_id,
    menu_id,
    order_date
FROM person_order
WHERE (id % 2 = 0)
ORDER BY id ASC;

--Создайте оператор select, который возвращает имена людей и названия пиццерий на основе 
--таблицы **person_visits` с датой посещения в период с 7 по 9 января 2022 г. (включая все дни) 
--(на основе внутреннего запроса в предложении `FROM').
SELECT 
    (
        SELECT name 
        FROM person 
        WHERE id = pv.person_id 
    ) AS person_name,  -- this is an internal query in a main SELECT clause
    (   
        SELECT name
        FROM pizzeria 
        WHERE id = pv.pizzeria_id
    ) AS pizzeria_name  -- this is an internal query in a main SELECT clause
FROM 
(
    SELECT person_id, pizzeria_id 
    FROM person_visits 
    WHERE visit_date BETWEEN '2022-01-07' AND '2022-01-09'
) AS pv -- this is an internal query in a main FROM clause
ORDER BY 
    person_name ASC,
    pizzeria_name DESC;
