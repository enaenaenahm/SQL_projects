SELECT pizza_name, price, p.name AS pizzeria_name, pv.visit_date
FROM menu
INNER JOIN pizzeria p ON p.id = menu.pizzeria_id
INNER JOIN person_visits pv ON p.id = pv.pizzeria_id
INNER JOIN person p2 ON p2.id = pv.person_id
WHERE price BETWEEN 800 AND 1000 AND p2.name = 'Kate'
ORDER BY 1,2,3