(SELECT p2.name AS pizzeria_name
 FROM person p
 INNER JOIN person_visits pv ON p.id = pv.person_id
 INNER JOIN pizzeria p2 ON p2.id = pv.pizzeria_id
 WHERE p.gender = 'female'
 EXCEPT ALL SELECT p2.name
 FROM person p
 INNER JOIN person_visits pv ON p.id = pv.person_id
 INNER JOIN pizzeria p2 ON p2.id = pv.pizzeria_id
 WHERE p.gender = 'male')
UNION
(SELECT p2.name
 FROM person p
 INNER JOIN person_visits pv ON p.id = pv.person_id
 INNER JOIN pizzeria p2 ON p2.id = pv.pizzeria_id
 WHERE p.gender = 'male'
 EXCEPT ALL SELECT p2.name
 FROM person p
 INNER JOIN person_visits pv ON p.id = pv.person_id
 INNER JOIN pizzeria p2 ON p2.id = pv.pizzeria_id
 WHERE p.gender = 'female')
ORDER BY 1
