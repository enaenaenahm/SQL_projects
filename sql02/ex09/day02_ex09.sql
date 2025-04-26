SELECT person.name AS name
FROM person
JOIN person_order ON
  person_order.person_id = person.id AND
  person.gender = 'female'
JOIN menu ON 
  person_order.menu_id = menu.id AND
  menu.pizza_name IN ('pepperoni pizza', 'cheese pizza')
GROUP BY name
HAVING COUNT (DISTINCT menu.pizza_name) = 2
ORDER BY name;
