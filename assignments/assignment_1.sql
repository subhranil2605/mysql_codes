/* 
---------------------------- Assignment 1 ----------------------------
---------------------------- Subhranil Sarkar ----------------------------
---------------------------- M.Sc. Data Science ----------------------------
---------------------------- 1st Semester ----------------------------
---------------------------- 25th March, 2022 ----------------------------
*/


SHOW DATABASES;

/* Creating database */
CREATE DATABASE assignment_1;

USE assignment_1;

/* Createing table for employee */
CREATE TABLE employee(
    eid CHAR (6) PRIMARY KEY,
    name CHAR (30) NOT NULL,
    dep_id INT NOT NULL,
    qualification CHAR (30) NOT NULL,
    age INT CHECK (age > 18 AND age < 60) NOT NULL
);

/* description of employee table */
DESC employee;


/* creating table for salary */
CREATE TABLE salary (
    eid CHAR (6) PRIMARY KEY,
    basic DECIMAL (8,2) NOT NULL,
    da DECIMAL (8, 2) AS (basic * 0.25),
    hra DECIMAL (8, 2) AS (basic * 0.08),
    bonus DECIMAL (8, 2) AS (basic * 0.05)
);

/* description of salary table */
DESC salary;


/* Inserting 10 rows into salary table*/
INSERT INTO salary (eid, basic) VALUES 
    ('EMP101', 50000),
    ('EMP102', 150000),
    ('EMP103', 70000),
    ('EMP104', 58000),
    ('EMP105', 9000),
    ('EMP106', 10000),
    ('EMP107', 65000),
    ('EMP108', 78000),
    ('EMP109', 45600),
    ('EMP110', 42810)
;

/* Showing salary table */
SELECT * FROM salary;


/* Inserting 10 rows into employee table*/
INSERT INTO employee VALUES 
    ('EMP101', "Subhranil Sarkar", 901, "BSC", 22),
    ('EMP102', "Anish Naskar", 901, "BSC", 21),
    ('EMP103', "Chinmoy Biswas", 903, "MSC", 23),
    ('EMP104', "Ashik Mamun", 904, "MBA", 24),
    ('EMP105', "Arpan Manna", 901, "BSC", 22),
    ('EMP106', "Suprity Pal", 906, "BA", 20),
    ('EMP107', "Pritam Sarkar", 903, "MA", 30),
    ('EMP108', "Hritam Nath", 910, "HS", 40),
    ('EMP109', "Arup Biswas", 909, "HS", 27),
    ('EMP110', "Suchandra Mondal", 909, "BSC", 22)
;

/* Showing salary table */
SELECT * FROM employee;


/* ------------------------ Queries ------------------------------ */

/* To display the frequency of employees in each department */
SELECT dep_id AS 'DEPARTMENT ID', COUNT(*) AS 'FREQUENCY' FROM employee GROUP BY dep_id ORDER BY COUNT(*) DESC;


/* To list the names of those employees only whose name starts with 'H' */
SELECT * FROM employee WHERE name LIKE 'H%';


/* Adding a new column in the salary table, total_sal */
/* 
ALTER TABLE salary ADD total_sal DECIMAL(8, 2) AS NOT NULL;
 */

/* Add and store value in total_sal as of the sum of basic, da, hra and bonus */
ALTER TABLE salary ADD total_sal DECIMAL(8, 2) AS (basic + da + hra + bonus);


/* showing the salary table */
SELECT * FROM salary;
