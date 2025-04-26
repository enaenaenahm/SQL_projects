SELECT 
	menu.pizza_name AS pizza_name,
	pizzeria.name AS pizzeria_name
FROM person_order 
JOIN menu
	ON person_order.menu_id = menu.id
JOIN pizzeria
	ON pizzeria.id = menu.pizzeria_id
JOIN (SELECT id, name 
	  FROM person WHERE name = 'Denis' OR 
	 					name = 'Anna') AS person_table
	ON person_table.id = person_order.person_id
ORDER BY pizza_name, pizzeria_name;
	
