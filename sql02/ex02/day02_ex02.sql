SELECT 
	COALESCE(person.name, '-') AS person_name,
	visit_date,
	COALESCE(pizzeria.name, '-') AS pizzeria_name
FROM (SELECT visit_date,
	  		 person_id,
	  		 pizzeria_id
	  FROM person_visits
	  WHERE visit_date = '2022-01-01' OR 
	 		visit_date = '2022-01-02' OR
	 		visit_date = '2022-01-03') AS person_ordered
FULL JOIN person ON person.id = person_id
FULL JOIN pizzeria ON pizzeria.id = pizzeria_id
ORDER BY person_name, visit_date, pizzeria_name;