--Пожалуйста, добавьте способ просмотра дополнительных строк с самой дорогой стоимостью 
--в SQL из предыдущего упражнения. Взгляните на образец данных ниже. 
--Пожалуйста, отсортируйте данные по total_cost, а затем по trip.
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
),
filtered_tours AS (
    SELECT 
        total_cost,
        ARRAY_TO_STRING(path, ',') AS tour
    FROM tours
    WHERE 
        array_length(path, 1) = 5 
        AND path[1] = 'a'
        AND path[array_length(path, 1)] = 'a'
)

SELECT *
FROM filtered_tours
WHERE total_cost = (SELECT MIN(total_cost) FROM filtered_tours)

UNION ALL

SELECT *
FROM filtered_tours
WHERE total_cost = (SELECT MAX(total_cost) FROM filtered_tours)

ORDER BY 
    total_cost, 
    tour;