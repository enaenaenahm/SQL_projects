SELECT
	menu.pizza_name,
	table_pizzeria.name AS pizzeria_name,
	menu.price
FROM menu
JOIN pizzeria AS table_pizzeria
ON table_pizzeria.id = menu.pizzeria_id
WHERE pizza_name = 'mushroom pizza' OR pizza_name = 'pepperoni pizza'
ORDER BY menu.pizza_name, pizzeria_name;