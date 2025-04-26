--Используйте конструкцию SQL из упражнения 05 и добавьте новый вычисляемый столбец 
--(используйте имя столбца «check_name») с оператором проверки (псевдокод для этой 
--проверки приведен ниже)в предложении **SELECT`.

SELECT 
    ( 
        SELECT name 
        
        FROM person WHERE id = person_order.person_id
    )
    ,
    (
        SELECT 
            CASE 
                WHEN name = 'Denis' THEN TRUE
                ELSE FALSE
            END
        AS isDenis

        FROM person WHERE id = person_order.person_id
    )
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
    