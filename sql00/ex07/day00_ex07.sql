--Давайте применим интервалы данных к таблице **person`. Создайте SQL-оператор, который возвращает 
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