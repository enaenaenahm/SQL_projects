# SQL_00

В каждой директории (ex00, ex01, ex02, ex03, ex04, ex05, ex06, ex07, ex08,ex09) находятся задания и выводы SQL-запросов из базы данных.

### Ex 00.

Let’s make our first task. Please make a select statement which returns all person's names and person's ages from the city ‘Kazan’.

| 1 | name   | age |
| - | ------ | --- |
| 2 | Kate   | 33  |
| 3 | Denis  | 13  |
| 4 | Elvira | 45  |

### Ex 01.

Please make a select statement which returns names , ages for all women from the city ‘Kazan’. Yep, and please sort result by name.

| 1 | name   | age |
| - | ------ | --- |
| 2 | Elvira | 45  |
| 3 | Kate   | 33  |

### Ex 02.

Please make 2 syntax different select statements which return a list of pizzerias (pizzeria name and rating) with rating between 3.5 and 5 points (including limit points) and ordered by pizzeria rating.

* the 1st select statement must contain comparison signs (<=, >=);
* the 2nd select statement must contain** **`BETWEEN` keyword.

| 1 | name       | rating |
| - | ---------- | ------ |
| 2 | DinoPizza  | 4.2    |
| 3 | Dominos    | 4.3    |
| 4 | Pizza Hut  | 4.6    |
| 5 | Papa Johns | 4.9    |

### Ex 03.

Please make a select statement that returns the person identifiers (without duplicates) who visited pizzerias in a period from January 6, 2022 to January 9, 2022 (including all days) or visited pizzerias with identifier 2. Also include ordering clause by person identifier in descending mode.

| person_id |
| --------- |
| 9         |
| 8         |
| 7         |
| 6         |
| 5         |
| 4         |
| 2         |

### Ex 04.

Please make a select statement which returns one calculated field with name ‘person_information’ in one string like described in the next sample:

`Anna (age:16,gender:'female',address:'Moscow')`

Finally, please add the ordering clause by calculated column in ascending mode. Please pay attention to the quotation marks in your formula!

> Andrey (age:21, gender:male, address:Moscow)
>
> Anna (age:16, gender:female, address:Moscow)
>
> Denis (age:13, gender:male, address:Kazan)
>
> Dmitriy (age:18, gender:male, address:Samara)
>
> Elvira (age:45, gender:female, address:Kazan)
>
> Irina (age:21, gender:female, address:Saint-Petersburg)
>
> Kate (age:33, gender:female, address:Kazan)
>
> Nataly (age:30, gender:female, address:Novosibirsk)
>
> Peter (age:24, gender:male, address:Saint-Petersburg)

### Ex 05.

Write a select statement that returns the names of people (based on an internal query in the** **`SELECT` clause) who placed orders for the menu with identifiers 13, 14, and 18, and the date of the orders should be January 7, 2022. Be careful with "Denied Section" before your work.

Please take a look at the pattern of internal query.

```plaintext
SELECT 
    (SELECT ... ) AS NAME  -- this is an internal query in a main SELECT clause
FROM ...
WHERE ...
```

| 1 | name   |
| - | ------ |
| 2 | Denis  |
| 3 | Nataly |

### Ex 06.

Use the SQL construction from Exercise 05 and add a new calculated column (use column name ‘check_name’) with a check statement a pseudocode for this check is given below) in the** **`SELECT` clause.

```plaintext
if (person_name == 'Denis') then return true
    else return false
```

| 1 | name   | isdenis |
| - | ------ | ------- |
| 2 | Denis  | TRUE    |
| 3 | Nataly | FALSE   |

### Ex 07.

Let's apply data intervals to the** **`person` table. Please make an SQL statement that returns the identifiers of a person, the person's names, and the interval of the person's ages (set a name of a new calculated column as 'interval_info') based on the pseudo code below.

```plaintext
if (age >= 10 and age <= 20) then return 'interval #1'
else if (age > 20 and age < 24) then return 'interval #2'
else return 'interval #3'
```

And yes... please sort a result by ‘interval_info’ column in ascending mode.

| 1  | id | name    | interval_info |
| -- | -- | ------- | ------------- |
| 2  | 1  | Anna    | interval #1   |
| 3  | 4  | Denis   | interval #1   |
| 4  | 9  | Dmitriy | interval #1   |
| 5  | 6  | Irina   | interval #2   |
| 6  | 2  | Andrey  | interval #2   |
| 7  | 8  | Nataly  | interval #3   |
| 8  | 5  | Elvira  | interval #3   |
| 9  | 7  | Peter   | interval #3   |
| 10 | 3  | Kate    | interval #3   |

### Ex 08.

Create an SQL statement that returns all columns from the** **`person_order` table with rows whose identifier is an even number. The result must be ordered by the returned identifier.

| 1  | id | person_id | menu_id | order_date |
| -- | -- | --------- | ------- | ---------- |
| 2  | 2  | 1         | 2       | 2022-01-01 |
| 3  | 4  | 2         | 9       | 2022-01-01 |
| 4  | 6  | 4         | 16      | 2022-01-07 |
| 5  | 8  | 4         | 18      | 2022-01-07 |
| 6  | 10 | 4         | 7       | 2022-01-08 |
| 7  | 12 | 5         | 7       | 2022-01-09 |
| 8  | 14 | 7         | 3       | 2022-01-03 |
| 9  | 16 | 7         | 4       | 2022-01-05 |
| 10 | 18 | 8         | 14      | 2022-01-07 |
| 11 | 20 | 9         | 6       | 2022-01-10 |

### Ex 09.

Please make a select statement that returns person names and pizzeria names based on the** **`person_visits` table with a visit date in a period from January 07 to January 09, 2022 (including all days) (based on an internal query in the `FROM' clause).

Please take a look at the pattern of the final query.

```plaintext
SELECT (...) AS person_name ,  -- this is an internal query in a main SELECT clause
        (...) AS pizzeria_name  -- this is an internal query in a main SELECT clause
FROM (SELECT … FROM person_visits WHERE …) AS pv -- this is an internal query in a main FROM clause
ORDER BY ...
```

Please add a ordering clause by person name in ascending mode and by pizzeria name in descending mode.

| 1 | person_name | pizzeria_name |
| - | ----------- | ------------- |
| 2 | Denis       | DinoPizza     |
| 3 | Denis       | Best Pizza    |
| 4 | Dmitriy     | Papa Johns    |
| 5 | Dmitriy     | Best Pizza    |
| 6 | Elvira      | Dominos       |
| 7 | Elvira      | DinoPizza     |
| 8 | Irina       | Dominos       |
| 9 | Nataly      | Papa Johns    |
