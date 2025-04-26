CREATE VIEW find_pizza AS
	SELECT pizzeria.id pizzeria_id, menu.id menu_id
	FROM pizzeria
	JOIN menu ON menu.pizzeria_id = pizzeria.id
	WHERE menu.price < 800 AND pizzeria.name != 'Papa Johns'
	ORDER BY 1
	LIMIT 1;

INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
SELECT
		(SELECT MAX(id) + 1 FROM person_visits),
		(SELECT id FROM person WHERE name = 'Dmitriy'),
		(SELECT pizzeria_id FROM find_pizza),
		'2022-01-08';

INSERT INTO person_order (id, person_id, menu_id, order_date)
SELECT
		(SELECT MAX(id) + 1 FROM person_order),
		(SELECT id FROM person WHERE name = 'Dmitriy'),
		(SELECT menu_id FROM find_pizza),
		'2022-01-08';

DROP VIEW find_pizza;

REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;