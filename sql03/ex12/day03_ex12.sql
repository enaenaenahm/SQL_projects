INSERT INTO person_order
SELECT g+
    (SELECT max(id)
    FROM person_order) AS id, id AS person_id,

    (SELECT id
    FROM menu
    WHERE pizza_name = 'greek pizza') AS menu_id, '2022-02-25' AS order_date
    FROM person
    INNER JOIN generate_series(1, 
    (SELECT count (*)
    FROM person)) AS g ON g = person.id