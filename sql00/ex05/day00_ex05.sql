--Напишите оператор select, который возвращает имена людей (на основе внутреннего запроса в **предложении SELECT`), которые 
--оформили заказы на меню с идентификаторами 13, 14 и 18, а дата заказов должна быть 7 января 2022 года. 
--Будьте осторожны с «Отклоненным разделом» перед началом работы.

SELECT 
    (SELECT name from person WHERE id = person_order.person_id) AS name  -- this is an internal query in a main SELECT clause
FROM person_order
WHERE
    (
        (menu_id = 13)
        OR
        (menu_id = 14)
        OR
        (menu_id = 18)
    )
    AND
    (
        (order_date = '2022-01-07')
    )
    