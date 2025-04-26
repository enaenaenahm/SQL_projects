SELECT pizza_name, price, p.name
FROM
 (SELECT id AS menu_id
 FROM menu
 EXCEPT SELECT menu_id
 FROM person_order) AS t1
INNER JOIN menu ON t1.menu_id = menu.id
INNER JOIN pizzeria p ON p.id = menu.pizzeria_id
ORDER BY 1,2