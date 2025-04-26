SELECT p2.name 
 FROM person_visits
 INNER JOIN person p ON p.id = person_visits.person_id
 INNER JOIN pizzeria p2 ON p2.id = person_visits.pizzeria_id
 WHERE p.name = 'Andrey'
 EXCEPT 
 SELECT p2.name
 FROM person_order
 INNER JOIN person p ON p.id = person_order.person_id
 INNER JOIN menu m ON m.id = person_order.menu_id
 INNER JOIN pizzeria p2 ON p2.id = m.pizzeria_id
 WHERE p.name = 'Andrey'
ORDER BY 1;