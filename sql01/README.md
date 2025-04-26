# SQL_01

В каждой директории (ex00, ex01, ex02, ex03, ex04, ex05, ex06, ex07, ex08, ex09, ex10) находятся задания и выводы SQL-запросов из базы данных.

### Ex 00.

Please write a SQL statement that returns the menu identifier and pizza names from the** **`menu` table and the person identifier and person name from the** **`person` table in one global list (with column names as shown in the example below) ordered by object_id and then by object_name columns.

| 1  | object_id | object_name     |
| -- | --------- | --------------- |
| 2  | 1         | Anna            |
| 3  | 1         | cheese pizza    |
| 4  | 2         | Andrey          |
| 5  | 2         | pepperoni pizza |
| 6  | 3         | Kate            |
| 7  | 3         | sausage pizza   |
| 8  | 4         | Denis           |
| 9  | 4         | supreme pizza   |
| 10 | 5         | Elvira          |
| 11 | 5         | cheese pizza    |
| 12 | 6         | Irina           |
| 13 | 6         | pepperoni pizza |
| 14 | 7         | Peter           |
| 15 | 7         | sausage pizza   |
| 16 | 8         | Nataly          |
| 17 | 8         | cheese pizza    |
| 18 | 9         | Dmitriy         |
| 19 | 9         | mushroom pizza  |
| 20 | 10        | cheese pizza    |
| 21 | 11        | supreme pizza   |
| 22 | 12        | cheese pizza    |
| 23 | 13        | mushroom pizza  |
| 24 | 14        | pepperoni pizza |
| 25 | 15        | sausage pizza   |
| 26 | 16        | cheese pizza    |
| 27 | 17        | pepperoni pizza |
| 28 | 18        | supreme pizza   |
| 29 | 19        | greek pizza     |

### Ex 01.

Please modify an SQL statement from "Exercise 00" by removing the object_id column. Then change the order by object_name for part of the data from the** **`person` table and then from the** **`menu` table (as shown in an example below). Please save duplicates!

"Andrey"

"Anna"

"Denis"

"Dmitriy"

 "Elvira"

"Irina"

"Kate"

"Nataly"

 "Peter"

"cheese pizza"

"cheese pizza"

 "cheese pizza"

"cheese pizza"

"cheese pizza"

"cheese pizza"

 "greek pizza"

 "mushroom pizza"

"mushroom pizza"

"pepperoni pizza"

  "pepperoni pizza"

"pepperoni pizza"

"pepperoni pizza"

"sausage pizza"

 "sausage pizza"

"sausage pizza"

"supreme pizza"

 "supreme pizza"

 "supreme pizza"

### Ex 02.

Write an SQL statement that returns unique pizza names from the** **`menu` table and sorts them by the pizza_name column in descending order. Please note the Denied section.

"supreme pizza"

"sausage pizza"

 "pepperoni pizza"

 "mushroom pizza"

"greek pizza"

"cheese pizza"

### Ex 03.

Write an SQL statement that returns common rows for attributes order_date, person_id from the** **`person_order` table on one side and visit_date, person_id from the** **`person_visits` table on the other side (see an example below). In other words, let's find the identifiers of persons who visited and ordered a pizza on the same day. Actually, please add the order by action_date in ascending mode and then by person_id in descending mode.

| 1  | order_date | person_id |
| -- | ---------- | --------- |
| 2  | 2022-01-01 | 6         |
| 3  | 2022-01-01 | 2         |
| 4  | 2022-01-01 | 1         |
| 5  | 2022-01-03 | 7         |
| 6  | 2022-01-04 | 3         |
| 7  | 2022-01-05 | 7         |
| 8  | 2022-01-06 | 8         |
| 9  | 2022-01-07 | 8         |
| 10 | 2022-01-07 | 4         |
| 11 | 2022-01-08 | 4         |
| 12 | 2022-01-09 | 9         |
| 13 | 2022-01-09 | 5         |
| 14 | 2022-01-10 | 9         |

### Ex 04.

Please write a SQL statement that returns a difference (minus) of person_id column values while saving duplicates between** **`person_order` table and** **`person_visits` table for order_date and visit_date are for January 7, 2022.

"4"

"4"

### Ex 05.

Please write a SQL statement that returns all possible combinations between** **`person` and** **`pizzeria` tables, and please set the order of the person identifier columns and then the pizzeria identifier columns. Please take a look at the sample result below. Please note that the column names may be different for you.Please take a look at the pattern of internal query.

| 1  | id | name    | age | gender | address          | id (1) | name (1)   | rating |
| -- | -- | ------- | --- | ------ | ---------------- | ------ | ---------- | ------ |
| 2  | 1  | Anna    | 16  | female | Moscow           | 1      | Pizza Hut  | 4.6    |
| 3  | 1  | Anna    | 16  | female | Moscow           | 2      | Dominos    | 4.3    |
| 4  | 1  | Anna    | 16  | female | Moscow           | 3      | DoDo Pizza | 3.2    |
| 5  | 1  | Anna    | 16  | female | Moscow           | 4      | Papa Johns | 4.9    |
| 6  | 1  | Anna    | 16  | female | Moscow           | 5      | Best Pizza | 2.3    |
| 7  | 1  | Anna    | 16  | female | Moscow           | 6      | DinoPizza  | 4.2    |
| 8  | 2  | Andrey  | 21  | male   | Moscow           | 1      | Pizza Hut  | 4.6    |
| 9  | 2  | Andrey  | 21  | male   | Moscow           | 2      | Dominos    | 4.3    |
| 10 | 2  | Andrey  | 21  | male   | Moscow           | 3      | DoDo Pizza | 3.2    |
| 11 | 2  | Andrey  | 21  | male   | Moscow           | 4      | Papa Johns | 4.9    |
| 12 | 2  | Andrey  | 21  | male   | Moscow           | 5      | Best Pizza | 2.3    |
| 13 | 2  | Andrey  | 21  | male   | Moscow           | 6      | DinoPizza  | 4.2    |
| 14 | 3  | Kate    | 33  | female | Kazan            | 1      | Pizza Hut  | 4.6    |
| 15 | 3  | Kate    | 33  | female | Kazan            | 2      | Dominos    | 4.3    |
| 16 | 3  | Kate    | 33  | female | Kazan            | 3      | DoDo Pizza | 3.2    |
| 17 | 3  | Kate    | 33  | female | Kazan            | 4      | Papa Johns | 4.9    |
| 18 | 3  | Kate    | 33  | female | Kazan            | 5      | Best Pizza | 2.3    |
| 19 | 3  | Kate    | 33  | female | Kazan            | 6      | DinoPizza  | 4.2    |
| 20 | 4  | Denis   | 13  | male   | Kazan            | 1      | Pizza Hut  | 4.6    |
| 21 | 4  | Denis   | 13  | male   | Kazan            | 2      | Dominos    | 4.3    |
| 22 | 4  | Denis   | 13  | male   | Kazan            | 3      | DoDo Pizza | 3.2    |
| 23 | 4  | Denis   | 13  | male   | Kazan            | 4      | Papa Johns | 4.9    |
| 24 | 4  | Denis   | 13  | male   | Kazan            | 5      | Best Pizza | 2.3    |
| 25 | 4  | Denis   | 13  | male   | Kazan            | 6      | DinoPizza  | 4.2    |
| 26 | 5  | Elvira  | 45  | female | Kazan            | 1      | Pizza Hut  | 4.6    |
| 27 | 5  | Elvira  | 45  | female | Kazan            | 2      | Dominos    | 4.3    |
| 28 | 5  | Elvira  | 45  | female | Kazan            | 3      | DoDo Pizza | 3.2    |
| 29 | 5  | Elvira  | 45  | female | Kazan            | 4      | Papa Johns | 4.9    |
| 30 | 5  | Elvira  | 45  | female | Kazan            | 5      | Best Pizza | 2.3    |
| 31 | 5  | Elvira  | 45  | female | Kazan            | 6      | DinoPizza  | 4.2    |
| 32 | 6  | Irina   | 21  | female | Saint-Petersburg | 1      | Pizza Hut  | 4.6    |
| 33 | 6  | Irina   | 21  | female | Saint-Petersburg | 2      | Dominos    | 4.3    |
| 34 | 6  | Irina   | 21  | female | Saint-Petersburg | 3      | DoDo Pizza | 3.2    |
| 35 | 6  | Irina   | 21  | female | Saint-Petersburg | 4      | Papa Johns | 4.9    |
| 36 | 6  | Irina   | 21  | female | Saint-Petersburg | 5      | Best Pizza | 2.3    |
| 37 | 6  | Irina   | 21  | female | Saint-Petersburg | 6      | DinoPizza  | 4.2    |
| 38 | 7  | Peter   | 24  | male   | Saint-Petersburg | 1      | Pizza Hut  | 4.6    |
| 39 | 7  | Peter   | 24  | male   | Saint-Petersburg | 2      | Dominos    | 4.3    |
| 40 | 7  | Peter   | 24  | male   | Saint-Petersburg | 3      | DoDo Pizza | 3.2    |
| 41 | 7  | Peter   | 24  | male   | Saint-Petersburg | 4      | Papa Johns | 4.9    |
| 42 | 7  | Peter   | 24  | male   | Saint-Petersburg | 5      | Best Pizza | 2.3    |
| 43 | 7  | Peter   | 24  | male   | Saint-Petersburg | 6      | DinoPizza  | 4.2    |
| 44 | 8  | Nataly  | 30  | female | Novosibirsk      | 1      | Pizza Hut  | 4.6    |
| 45 | 8  | Nataly  | 30  | female | Novosibirsk      | 2      | Dominos    | 4.3    |
| 46 | 8  | Nataly  | 30  | female | Novosibirsk      | 3      | DoDo Pizza | 3.2    |
| 47 | 8  | Nataly  | 30  | female | Novosibirsk      | 4      | Papa Johns | 4.9    |
| 48 | 8  | Nataly  | 30  | female | Novosibirsk      | 5      | Best Pizza | 2.3    |
| 49 | 8  | Nataly  | 30  | female | Novosibirsk      | 6      | DinoPizza  | 4.2    |
| 50 | 9  | Dmitriy | 18  | male   | Samara           | 1      | Pizza Hut  | 4.6    |
| 51 | 9  | Dmitriy | 18  | male   | Samara           | 2      | Dominos    | 4.3    |
| 52 | 9  | Dmitriy | 18  | male   | Samara           | 3      | DoDo Pizza | 3.2    |
| 53 | 9  | Dmitriy | 18  | male   | Samara           | 4      | Papa Johns | 4.9    |
| 54 | 9  | Dmitriy | 18  | male   | Samara           | 5      | Best Pizza | 2.3    |
| 55 | 9  | Dmitriy | 18  | male   | Samara           | 6      | DinoPizza  | 4.2    |

### Ex 06.

Let's go back to Exercise #03 and modify our SQL statement to return person names instead of person identifiers and change the order by action_date in ascending mode and then by person_name in descending mode. Take a look at the sample data below.

| 1  | action_date | name    |
| -- | ----------- | ------- |
| 2  | 2022-01-01  | Irina   |
| 3  | 2022-01-01  | Anna    |
| 4  | 2022-01-01  | Andrey  |
| 5  | 2022-01-03  | Peter   |
| 6  | 2022-01-04  | Kate    |
| 7  | 2022-01-05  | Peter   |
| 8  | 2022-01-06  | Nataly  |
| 9  | 2022-01-07  | Nataly  |
| 10 | 2022-01-07  | Denis   |
| 11 | 2022-01-08  | Denis   |
| 12 | 2022-01-09  | Elvira  |
| 13 | 2022-01-09  | Dmitriy |
| 14 | 2022-01-10  | Dmitriy |

### Ex 07.

Write an SQL statement that returns the order date from the** `person_order` table and the corresponding person name (name and age are formatted as in the data sample below) who made an order from the **`person` table. Add a sort by both columns in ascending order.

| 1  | order_date | person_information |
| -- | ---------- | ------------------ |
| 2  | 2022-01-01 | Andrey (age:21)    |
| 3  | 2022-01-01 | Andrey (age:21)    |
| 4  | 2022-01-01 | Anna (age:16)      |
| 5  | 2022-01-01 | Anna (age:16)      |
| 6  | 2022-01-01 | Irina (age:21)     |
| 7  | 2022-01-03 | Peter (age:24)     |
| 8  | 2022-01-04 | Kate (age:33)      |
| 9  | 2022-01-05 | Peter (age:24)     |
| 10 | 2022-01-05 | Peter (age:24)     |
| 11 | 2022-01-06 | Nataly (age:30)    |
| 12 | 2022-01-07 | Denis (age:13)     |
| 13 | 2022-01-07 | Denis (age:13)     |
| 14 | 2022-01-07 | Denis (age:13)     |
| 15 | 2022-01-07 | Nataly (age:30)    |
| 16 | 2022-01-08 | Denis (age:13)     |
| 17 | 2022-01-08 | Denis (age:13)     |
| 18 | 2022-01-09 | Dmitriy (age:18)   |
| 19 | 2022-01-09 | Elvira (age:45)    |
| 20 | 2022-01-09 | Elvira (age:45)    |
| 21 | 2022-01-10 | Dmitriy (age:18)   |

### Ex 08.

Please rewrite a SQL statement from Exercise #07 by using NATURAL JOIN construction. The result must be the same like for Exercise #07.


| 1  | order_date | person_information |
| -- | ---------- | ------------------ |
| 2  | 2022-01-01 | Andrey (age:21)    |
| 3  | 2022-01-01 | Andrey (age:21)    |
| 4  | 2022-01-01 | Anna (age:16)      |
| 5  | 2022-01-01 | Anna (age:16)      |
| 6  | 2022-01-01 | Irina (age:21)     |
| 7  | 2022-01-03 | Peter (age:24)     |
| 8  | 2022-01-04 | Kate (age:33)      |
| 9  | 2022-01-05 | Peter (age:24)     |
| 10 | 2022-01-05 | Peter (age:24)     |
| 11 | 2022-01-06 | Nataly (age:30)    |
| 12 | 2022-01-07 | Denis (age:13)     |
| 13 | 2022-01-07 | Denis (age:13)     |
| 14 | 2022-01-07 | Denis (age:13)     |
| 15 | 2022-01-07 | Nataly (age:30)    |
| 16 | 2022-01-08 | Denis (age:13)     |
| 17 | 2022-01-08 | Denis (age:13)     |
| 18 | 2022-01-09 | Dmitriy (age:18)   |
| 19 | 2022-01-09 | Elvira (age:45)    |
| 20 | 2022-01-09 | Elvira (age:45)    |
| 21 | 2022-01-10 | Dmitriy (age:18)   |

### Ex 09.

Write 2 SQL statements that return a list of pizzerias that have not been visited by people using IN for the first and EXISTS for the second.

"DoDo Pizza"

### Ex 10.

Please write an SQL statement that returns a list of the names of the people who ordered pizza from the corresponding pizzeria. The sample result (with named columns) is provided below and yes ... please make the ordering by 3 columns (`person_name`,** **`pizza_name`,** **`pizzeria_name`) in ascending mode.


| 1  | person_name | pizza_name      | pizzeria_name |
| -- | ----------- | --------------- | ------------- |
| 2  | Andrey      | cheese pizza    | Dominos       |
| 3  | Andrey      | mushroom pizza  | Dominos       |
| 4  | Anna        | cheese pizza    | Pizza Hut     |
| 5  | Anna        | pepperoni pizza | Pizza Hut     |
| 6  | Denis       | cheese pizza    | Best Pizza    |
| 7  | Denis       | pepperoni pizza | Best Pizza    |
| 8  | Denis       | pepperoni pizza | DinoPizza     |
| 9  | Denis       | sausage pizza   | DinoPizza     |
| 10 | Denis       | supreme pizza   | Best Pizza    |
| 11 | Dmitriy     | pepperoni pizza | DinoPizza     |
| 12 | Dmitriy     | supreme pizza   | Best Pizza    |
| 13 | Elvira      | pepperoni pizza | DinoPizza     |
| 14 | Elvira      | sausage pizza   | DinoPizza     |
| 15 | Irina       | mushroom pizza  | Papa Johns    |
| 16 | Kate        | cheese pizza    | Best Pizza    |
| 17 | Nataly      | cheese pizza    | Dominos       |
| 18 | Nataly      | pepperoni pizza | Papa Johns    |
| 19 | Peter       | mushroom pizza  | Dominos       |
| 20 | Peter       | sausage pizza   | Pizza Hut     |
| 21 | Peter       | supreme pizza   | Pizza Hut     |
