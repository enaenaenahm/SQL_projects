--Взгляните на график.
--Есть 4 города (a, b, c и d) и дуги между ними с расходами (или налогами). Фактически, расход равен (a, b) = (b, a).
--Пожалуйста, создайте таблицу с именованными узлами, используя структуру {point1, point2, cost}, и заполните данные на основе рисунка (помните, что между 2 узлами есть прямые и обратные пути).
--Пожалуйста, напишите SQL-выражение, которое возвращает все туры (т. е. пути) с минимальной стоимостью поездки, если мы начнем с города «a».
--Помните, вам нужно найти самый дешевый способ посетить все города и вернуться в исходную точку. Например, тур выглядит как a -> b -> c -> d -> a.
--Ниже приведен пример выходных данных. Пожалуйста, отсортируйте данные по total_cost, а затем по tour.-
DROP TABLE IF EXISTS nodes;

CREATE TABLE nodes (
    point1 TEXT,
    point2 TEXT,
    cost INT
);

INSERT INTO nodes (point1, point2, cost)
VALUES
    ('a', 'b', 10),
    ('b', 'a', 10),
    ('a', 'c', 15),
    ('c', 'a', 15),
    ('a', 'd', 20),
    ('d', 'a', 20),
    ('b', 'c', 35),
    ('c', 'b', 35),
    ('b', 'd', 25),
    ('d', 'b', 25),
    ('c', 'd', 30),
    ('d', 'c', 30);


WITH RECURSIVE tours AS (
    SELECT 
        point1 AS tour_start,
        point2 AS next_city,
        cost AS total_cost,
        ARRAY[point1::TEXT, point2::TEXT] AS path,
        FALSE AS cycle
    FROM nodes
    WHERE point1 = 'a'

    UNION ALL

    SELECT 
        t.tour_start,
        n.point2 AS next_city,
        t.total_cost + n.cost AS total_cost,
        t.path || n.point2::TEXT AS path,
        n.point2 = ANY(t.path) AS cycle
    FROM tours t
    JOIN nodes n ON t.next_city = n.point1
    WHERE NOT t.cycle
)
SELECT 
    total_cost,
    ARRAY_TO_STRING(path, ',') AS tour
FROM tours
WHERE 
    array_length(path, 1) = 5
    AND path[1] = 'a'
    AND path[array_length(path, 1)] = 'a' 
    AND total_cost = (SELECT MIN(total_cost) FROM tours WHERE array_length(path, 1) = 5)
ORDER BY 
    total_cost, 
    tour;