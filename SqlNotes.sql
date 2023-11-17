-------------------CRUD------------------------------
-----------------------------------------------------
// select database to query
USE <databaseName>
    
-- CRUD = CREATE READ UPDATE DELETE

-- Creates new database
CREATE DATABASE <name>; 
-----------------------------------------------------
-- Delete database
DROP <name>;
-----------------------------------------------------
-- Show tables in a database
SHOW TABLES;
-----------------------------------------------------
-- Creates new table for a database
CREATE TABLE <tableName>
(                                                                   
    <var> <TYPE>         <OPTIONAL PARAMS>
    id INT               PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)     NOT NULL DEFAULT 'something', 
    breed VARCHAR(20),
    age INT

    --PRIMARY KEY(id) -- alternate way of defining the primary key
);

-----------------------------------------------------
-- Delete table
DROP TABLE <tableName>
-----------------------------------------------------
-- Show table and containing vars
DESC <name>
-----------------------------------------------------

-- Insert data to table
INSERT INTO <tableName>(<var>, <var>...)

INSERT INTO cats(name, age)
VALUES  ('Sam', 6),
        ('Henry' 4),
        ('Bubbles', 5);

-----------------------------------------------------
-- SELECT / get info from tables
SELECT * FROM <tableName>; -- Show all info in table

SELECT <var> <optionalParams>, <var>... FROM <tableName>; -- Get info only from a specific variable in table
SELECT age FROM cats; 
SELECT age, breed AS kittyBreed FROM cats;-- examples (AS renames the variable ONLY temporarily for this specific query)

SELECT * FROM <tableName> WHERE <query> -- Get info based on query with WHERE
SELECT * FROM cats WHERE age = 4; -- example: LIMIT limits to first 5 results.



-------------------------------------------------------
--Refined Selections

SELECT DISTINCT <var/s> FROM <tableName>; -- will not print duplicates

--ORDER BY
SELECT <var/s> FROM <tableName> ORDER BY <var/s/varNum> <optionalParams>; -- order prints by specific var
SELECT author_fname, author_lname FROM books ORDER BY author_lname DESC; -- example: will order in descending order due to DESC, ie: reverse alphabetically

--LIMIT
-- orders by descending, limits results to first 5 from after first result
SELECT author_fname, author_lname FROM books ORDER BY author_lname DESC LIMIT 1,5;

--LIKE
-- selects all instances where author_fname includes the passed string. note: must use % signs
SELECT author_fname, author_lname FROM books WHERE author_fname LIKE '%da%'; -- note: can omit first or last % based on starts with or ends with.
-- selects all instances where author_fname is exactly 4 chars(equal to amount of underscores)
SELECT author_fname FROM books WHERE author_fname LIKE '____';



-----------------------------------------------------
-- UPDATE
UPDATE <tableName> SET <var>=<newValue> -- will update ALL cats breed in table to Sphynx
UPDATE cats SET breed = 'Sphynx' -- example

UPDATE <tableName> SET <var>=<newValue>, <var>=<newValue>... WHERE <query> -- selective update
UPDATE cats SET age = 6 WHERE name = Bubbles; -- example: Updates only the cat/s with name Bubbles

-----------------------------------------------------
-- DELETE
DELETE FROM <tableName> -- deletes EVERYTHING from table!
DELETE FROM <tableName> WHERE <query> -- selective deletion
DELETE FROM cats WHERE name='Egg'; -- example





-------------------STRING FUNCTIONS------------------
-----------------------------------------------------
--  mysql documentation => https://dev.mysql.com/doc/refman/8.0/en/string-functions.html
SELECT CONCAT('h', 'e', 'l'); -- concatinates the strings(duh)
SELECT CONCAT_WS('-', 'spider', 'man'); -- concatinates with seperator, first value is smooshed in between all other values

SELECT SUBSTRING('Hello World', 1, 4); -- cuts out string from first char to fourth. Or just from position to end if third param is not given.
SELECT SUBSTRING(breed, -2) FROM cats; -- negative numbers count from the end. So this would go from the second to last char. 

SELECT REPLACE('HELLO WORLD', 'HELL', '21#¤'); -- replaces 2nd param from string with 3rd param. note: does not actually replace the values in the database. Just the print.
SELECT INSERT('Hello Bobby', 6, 0, ' There'); -- Inserts string at char in position of 2nd param. Replaces chars as far as 3rd param commands.

SELECT REVERSE('Good Day'); -- reverses string, pretty self explanitory.
SELECT CHAR_LENGTH('This is a text'); -- gets length of string

SELECT UPPER('Hello World'); -- all chars become uppercase
SELECT LOWER('Hello World'); -- all chars become lowercase

SELECT LEFT('Walter White', 4); -- gets 4 leftmost chars
SELECT RIGHT('Walter White', 4); -- gets 4 rightmost chars
SELECT REPEAT('ha', 4); -- repeats ha 4 times

SELECT TRIM('   Budapest  '); -- removes white spaces on sides
SELECT TRIM(LEADING '.' FROM '.......Budapest...'); -- removes specified leading chars
SELECT TRIM(TRAILING '.' FROM '.......Budapest...'); -- removes specified trailing chars
SELECT TRIM(BOTH '.' FROM '.......Budapest...'); -- removes chars on both sides





-------------------AGGREGATE FUNCTIONS---------------
-----------------------------------------------------
-- docs => https://dev.mysql.com/doc/refman/8.0/en/aggregate-functions.html
-- note: aggregate functions are typiccally used with GROUP BY
SELECT COUNT(<*/var>) FROM <tableName>; --counts amount of values in table or total rows if *
SELECT <var/s> FROM <tableName> GROUP BY <var>; --groups values by selected variable behind the scenes

-- using aggregate function with group by
SELECT released_year, COUNT(*) FROM books GROUP BY released_year; -- example: count how many books adhere to each year

SELECT MAX/MIN(<var>) -- get the min or max in table
SELECT SUM(<var>) -- sums up all values in var
SELECT AVG(<var>) -- finds avarage of all values in var

-- subquery : good for printing out other info that arent aggregate functions
SELECT title, pages FROM books
    WHERE pages = (SELECT MAX(pages) FROM books); -- get the title of the book with the most pages






-------------------DATA TYPES------------------------
-----------------------------------------------------
--docs => https://dev.mysql.com/doc/refman/8.0/en/data-types.html

--strings and numbers
VARCHAR(<number>) -- string variable in max length
CHAR(<number>) -- string that is fixed in size
INT -- stores whole numbers
INT UNSIGNED -- will disallow negative numbers
DECIMAL(<MaxTotalDigits>,<DigitsAfterDecimal>) -- stores decimal numbers
DECIMAL(5,2) -- example: valid values 555.55 / 23.22
FLOAT / DOUBLE -- less accurate, take up less bytes when displaying decimals

-- date time
<T>  <getCurrentTimeFunc>
DATE CURDATE() -- stores date in YYYY-MM-DD format
TIME CURTIME() -- stores time in HH:MM:SS format mostly?
DATETIME NOW()-- stores date in YYYY-MM-DD HH:MM:SS format

-- date time functions
-- docs => https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html
DAYOFWEEK(<date>) -- gets weekday in number, starting at 1 with sunday
DAYNAME(<date>) -- gets weekday as string
DAYOFMONTH(), DAYOFYEAR(), MONTHNAME() -- other
HOUR(<time>) -- get hour
MINUTE(), SECOND() -- other

-- date_format
-- docs for formats => https://www.w3schools.com/sql/func_mysql_date_format.asp
DATE_FORMAT(<date>,<formats>)
DATE_FORMAT(birthdate, '%b') --example

-- date math
DATEDIFF(<date>,<date>); -- gets difference between two dates
DATEDIFF(CURDATE(), birthdate); --example
TIMEDIFF(CURTIME(), '07:00:00') -- same but wit time

DATE_ADD(<date>, INTERVAL <num> <YEAR/MONTH/DAY>) -- add specified amount of date type to date
DATE_ADD(CURDATE(), INTERVAL 1 YEAR) -- adds one year
DATE_SUB() -- same but subtracts instead of adds

<date> + INTERVAL <num> -- can also use interval with normal operators
(DEFAULT/ON UPDATE) (CURRENT_DATETIME/CURRENT_TIMESTAMP) -- automatically set date values in tables with this.







------------COMPARISON AND LOGICAL OPERATORS---------
-----------------------------------------------------

NOT <command> -- not inverts command, similar to !=
NOT LIKE -- example: gets all that are not like 
AND -- same as &&
OR -- same as ||
BETWEEN <value1> AND <value2> -- gets values in between the 2 passed values
IS NULL -- checks if value is null

CAST(<T> AS <newT>) -- turn one type into another
CAST("5" AS INT) -- example
<value> IN (<value>,<value>,<value>) -- IN checks if first value is included in list

-- Case is basically an if statement/s, can have multiple before END
CASE
    WHEN <query>
    THEN <doSomething>
    ELSE <doSomethingElse>
    END <doSomethingAtEnd>

IFNULL(<statement>, <replacementIfNull>)







------------Constraints and ALTER TABLE--------------
-----------------------------------------------------
-- constraints are things you put after types when creating tables example: NOT NULL

NOT NULL --cannot be null
UNIQUE --each value must be unique
PRIMARY KEY -- sets to primary key auto NOT NULL and UNIQUE
FOREIGN KEY (column) REFERENCES <foreignTable>(foreignColumn) -- reference a foreign table 
DEFAULT <value> --sets default value when not specified
AUTO_INCREMENT -- auto increments with each new value when not specified
CHECK (<query>) -- Only adds if query is true, else it returns an error
age INT CHECK (age > 18) -- example: will only add if age is over 18
CONSTRAINT <constraintName> CHECK <query> --custom name for constraint check

-- constraint for multiple columns(columns must adhere to constraint as a combination, not individually)
CONSTRAINT <constraintName> <constraint> (<columns>) 
CONSTRAINT name_adress UNIQUE (name, adress) -- example


--alter table
--docs => https://dev.mysql.com/doc/refman/8.0/en/alter-table.html
ALTER TABLE <tableName> <command>
-- alter table commands
    ADD COLUMN <newColumnName> <T>; -- add a new column to table
    DROP COLUMN <column> -- drops/deletes column
    RENAME TO <newTableName> -- rename table
    RENAME COLUMN <columnName> TO <newColumnName> -- rename column
    MODIFY <column> <newT>; -- change type/modify column
    ADD CONSTRAINT <constraintName?> <constraint> --add constraint to table
    DROP CONSTRAINT <constraint> -- delete constraint from table







-----------------One to many & joins-----------------
-----------------------------------------------------
FOREIGN KEY (column) REFERENCES <foreignTable>(foreignColumn) -- reference a foreign table 
FOREIGN KEY (customer_id) REFERENCES customers(id) -- example

-- inner join
SELECT * FROM <table1> 
    JOIN <table2> ON <table1>.<column> = <table2.column> -- join two tables together based on shared values

SELECT * FROM customers
    JOIN orders ON orders.customer_id = customers.id; -- example

-- left and right join
LEFT JOIN -- same as an inner join but will print out all rows on left column
RIGHT JOIN -- same as right join but vice versa

-- put after foreign key constraint to auto delete row when corresponding reference is deleted
ON DELETE CASCADE








------------------Views Modes and More---------------
-----------------------------------------------------
CREATE VIEW <viewName> AS <sqlQuery> -- create new view
CREATE OR REPLACE -- update view
ALTER VIEW AS -- update view #2
DROP VIEW <viewName> -- delete view

HAVING: GROUP BY <column/s> HAVING <query> -- filters group bys based on query
GROUP BY title HAVING COUNT(rating) > 1; -- example

-- complicated, rolls up aggregate functions used with group bys
GROUP BY <column/s> WITH ROLLUP 

--modes
SET SESSION sql_mode = <modeString> -- change mode(temporary)
SELECT @@SESSION.sql_mode; -- display current mode settings









------------------Window functions-------------------
-----------------------------------------------------

SELECT <aggregateFunc> OVER() FROM <table>; -- works similar to group by but prints all rows in table
SELECT AVG(salary) OVER() FROM employees; -- example

OVER(PARTITION BY <column>) -- will group by specified column
OVER(ORDER BY <column>) -- returns rolling results after each row

-- exammple, prints will keep adding sums one by one instead of the sum of all because of ORDER BY in OVER
SELECT SUM(salary) OVER(PARTITION BY department, ORDER BY salary) FROM employees;

RANK() OVER(ORDER BY <column> <desc?>) --ranking function
DENSE_RANK()  -- does not skip ahead numbers when there is a tie
ROW_NUMBER OVER(ORDER BY <column>?) -- prints row numbers

NTILE() OVER(ORDER BY <column>) -- breaks up values into buckets and assigns a num to each row / department etc
FIRST_VALUE(<column>) OVER...-- returns first value of expr form first row of the window frame

LAG(<column>, <num?>) -- prints out previous value in prev row/department etc..
LEAD(<column>, <num?>) -- gets next rows value
-- num specifies how many rows forward or back















