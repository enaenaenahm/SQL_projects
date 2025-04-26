INSERT INTO menu values 
((SELECT max(id)+1 FROM menu ),
(SELECT id FROM pizzeria WHERE name = 'Dominos'),
'sicilian pizza',
900)