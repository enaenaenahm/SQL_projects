CREATE VIEW v_price_with_discount AS
SELECT p.name,
		m.pizza_name, 
		m.price, 
		(SELECT (m2.price *0.9)::INT discount_price FROM menu m2 WHERE m2.id = m.id)
FROM person_order po
LEFT JOIN person p ON p.id = po.person_id
LEFT JOIN menu m ON m.id = po.menu_id
ORDER BY 1, 2;