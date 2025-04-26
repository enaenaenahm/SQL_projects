SELECT 
	person_table.name AS name
FROM (SELECT * 
	  FROM person 
	  WHERE address IN ('Moscow', 'Samara') AND
	 		gender = 'male') AS person_table
JOIN person_order ON 
	person_order.person_id = person_table.id
JOIN (SELECT * 
	  FROM menu 
	  WHERE menu.pizza_name = 'pepperoni pizza' OR
	 		menu.pizza_name = 'mushroom pizza') AS menu_table
	ON menu_table.id = person_order.menu_id
ORDER BY name DESC;
