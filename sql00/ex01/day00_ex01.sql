--Сделайте запрос select, который возвращает имена, возрасты всех женщин из города «Казань». 
--Отсортируйте результат по имени.

SELECT name, age FROM person
WHERE
    gender = 'female' 
    AND 
    address = 'Kazan'
ORDER BY
    name    
;