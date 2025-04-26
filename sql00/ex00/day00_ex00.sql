--Создайте оператор select, который возвращает все имена и возрасты людей из города «Казань».

SELECT name, age FROM person 
    WHERE 
        address = 'Kazan';