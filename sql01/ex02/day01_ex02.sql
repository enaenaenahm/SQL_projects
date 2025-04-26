SELECT pizza_name AS object_name
FROM menu
INTERSECT
SELECT pizza_name AS object_name
FROM menu
ORDER BY 1 DESC