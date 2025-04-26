--Создайте 2 различных по синтаксису оператора select, которые возвращают список пиццерий (название пиццерии и рейтинг) 
--с рейтингом от 3,5 до 5 баллов (включая предельные баллы) и упорядоченных по рейтингу пиццерии.

--* первый оператор select должен содержать знаки сравнения (<=, >=);
--* второй оператор select должен содержать** ключевое слово **`BETWEEN`.

--1 запрос
SELECT name, rating FROM pizzeria 
WHERE 
    (rating >= 3.5) AND (rating <= 5) 
ORDER BY 
    rating;

--2 запрос
SELECT name, rating FROM pizzeria 
WHERE 
    (rating BETWEEN 3.5 AND 5) 
ORDER BY 
    rating;