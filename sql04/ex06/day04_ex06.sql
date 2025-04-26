CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
SELECT pz.name
FROM person_visits pv
FULL JOIN menu ON menu.pizzeria_id = pv.pizzeria_id
FULL JOIN pizzeria pz ON pz.id = menu.pizzeria_id
FULL JOIN person p ON p.id = pv.person_id
WHERE p.name = 'Dmitriy' AND pv.visit_date = '2022-01-08' AND menu.price < 800
WITH DATA;