# SQL_02

В каждой директории (ex00, ex01, ex02, ex03, ex04, ex05, ex06, ex07, ex08, ex09, ex10) находятся задания и выводы SQL-запросов из базы данных.

### Ex 00.

Write a SQL statement that returns a list of pizzerias with the corresponding rating value that have not been visited by people.

"DoDo Pizza"

### Ex 01.

Please write a SQL statement that returns the missing days from January 1 through January 10, 2022 (including all days) for visits by people with identifiers 1 or 2 (i.e., days missed by both). Please order by visit days in ascending mode. The sample data with column names is shown below.

"2022-01-03"

"2022-01-04"

"2022-01-05"

"2022-01-06"

"2022-01-07"

"2022-01-08"

"2022-01-09"

"2022-01-10"

### Ex 02.

Please write an SQL statement that will return the entire list of names of people who visited (or did not visit) pizzerias during the period from January 1 to January 3, 2022 on one side and the entire list of names of pizzerias that were visited (or did not visit) on the other side. The data sample with the required column names is shown below. Please note the replacement value '-' for** **`NULL` values in the columns** **`person_name` and** **`pizzeria_name`. Please also add the order for all 3 columns.

| 1  | person_name | visit_date | pizzeria_name |
| -- | ----------- | ---------- | ------------- |
| 2  | -           |            | DinoPizza     |
| 3  | -           |            | DoDo Pizza    |
| 4  | Andrey      | 2022-01-01 | Dominos       |
| 5  | Andrey      | 2022-01-02 | Pizza Hut     |
| 6  | Anna        | 2022-01-01 | Pizza Hut     |
| 7  | Denis       |            | -             |
| 8  | Dmitriy     |            | -             |
| 9  | Elvira      |            | -             |
| 10 | Irina       | 2022-01-01 | Papa Johns    |
| 11 | Kate        | 2022-01-03 | Best Pizza    |
| 12 | Nataly      |            | -             |
| 13 | Peter       | 2022-01-03 | Pizza Hut     |

### Ex 03.

Let's go back to Exercise #01, please rewrite your SQL using the CTE (Common Table Expression) pattern. Please go to the CTE part of your "day generator". The result should look similar to Exercise #01.

"2022-01-03"

"2022-01-04"

"2022-01-05"

"2022-01-06"

"2022-01-07"

"2022-01-08"

"2022-01-09"

"2022-01-10"

### Ex 04.

Find complete information about all possible pizzeria names and prices to get mushroom or pepperoni pizza. Then sort the result by pizza name and pizzeria name. The result of the sample data is shown below (please use the same column names in your SQL statement).

| 1 | pizza_name      | pizzeria_name | price |
| - | --------------- | ------------- | ----- |
| 2 | mushroom pizza  | Dominos       | 1100  |
| 3 | mushroom pizza  | Papa Johns    | 950   |
| 4 | pepperoni pizza | Best Pizza    | 800   |
| 5 | pepperoni pizza | DinoPizza     | 800   |
| 6 | pepperoni pizza | Papa Johns    | 1000  |
| 7 | pepperoni pizza | Pizza Hut     | 1200  |

### Ex 05.

Find the names of all females over the age of 25 and sort the result by name. The sample output is shown below.

"Elvira"

"Kate"

"Nataly"

### Ex 06.

Find all pizza names (and corresponding pizzeria names using the** **`menu` table) ordered by Denis or Anna. Sort a result by both columns. The sample output is shown below.

| 1 | pizza_name      | pizzeria_name |
| - | --------------- | ------------- |
| 2 | cheese pizza    | Best Pizza    |
| 3 | cheese pizza    | Pizza Hut     |
| 4 | pepperoni pizza | Best Pizza    |
| 5 | pepperoni pizza | DinoPizza     |
| 6 | pepperoni pizza | Pizza Hut     |
| 7 | sausage pizza   | DinoPizza     |
| 8 | supreme pizza   | Best Pizza    |

### Ex 07.

Please find the name of the pizzeria Dmitriy visited on January 8, 2022 and could eat pizza for less than 800 rubles.

"Papa Johns"

### Ex 08.

Please find the names of all men from Moscow or Samara who order either pepperoni or mushroom pizza (or both). Please sort the result by person names in descending order. The sample output is shown below.AL JOIN construction. The result must be the same like for Exercise #07.

"Dmitriy"

"Andrey"

### Ex 09.

Find the names of all women who ordered both pepperoni and cheese pizzas (at any time and in any pizzerias). Make sure that the result is ordered by person's name. The sample data is shown below.

"Anna"

"Nataly"

### Ex 10.

Find the names of people who live at the same address. Make sure the result is sorted by 1st person's name, 2nd person's name, and shared address. The data sample is shown below. Make sure your column names match the column names below.

| 1 | person_name1 | person_name2 | common_address   |
| - | ------------ | ------------ | ---------------- |
| 2 | Andrey       | Anna         | Moscow           |
| 3 | Denis        | Kate         | Kazan            |
| 4 | Elvira       | Denis        | Kazan            |
| 5 | Elvira       | Kate         | Kazan            |
| 6 | Peter        | Irina        | Saint-Petersburg |
