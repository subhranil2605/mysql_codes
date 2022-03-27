/* ------------------------- Assignment 3 ------------------------- */
/* ------------------------- Subhranil Sarkar ------------------------- */
/* ------------------------- M.Sc. Data Science ------------------------- */
/* ------------------------- 1st Semester ------------------------- */
/* ------------------------- 26th March, 2022 ------------------------- */


/* Creating database */
CREATE DATABASE assignment_3;

/* Use the created assignment */
USE assignment_3;


/*Creating employee table*/
CREATE TABLE employee (
    eid CHAR (6) PRIMARY KEY CHECK (eid LIKE 'EMP___'),
    name CHAR (30) NOT NULL,
    dep_id CHAR (6) NOT NULL CHECK (dep_id LIKE 'Dep___'),
    qualification CHAR (30) NOT NULL,
    age INT CHECK (age > 18 and age < 60) NOT NULL
);

/*Creating salary table*/
CREATE TABLE salary (
    eid CHAR (6) PRIMARY KEY CHECK (eid LIKE 'EMP___'),
    basic DECIMAL (8, 2) NOT NULL,
    da DECIMAL (8, 2) AS (basic * 0.25),
    hra DECIMAL (8, 2) AS (basic * 0.08),
    bonus DECIMAL (8, 2) AS (basic * 0.05),
    total_sal DECIMAL (8, 2) AS (basic + da + hra + bonus)
);


/*Creating department table*/
CREATE TABLE department (
    dep_id CHAR (6) PRIMARY KEY CHECK (dep_id LIKE 'Dep___'),
    descr CHAR (30) NOT NULL,
    hod CHAR (6),
    location CHAR (30) NOT NULL
);

/* Inserting into salary table*/
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
    ('EMP110', 42810),
    ('EMP201', 30000),
    ('EMP202', 40000),
    ('EMP203', 20000),
    ('EMP204', 6000),
    ('EMP205', 15000)
;


/* Inserting into employee table*/
INSERT INTO employee VALUES 
    ('EMP101', "Subhranil Sarkar", 'Dep101', "BSC", 22),
    ('EMP102', "Anish Naskar", 'Dep101', "BSC", 21),
    ('EMP103', "Chinmoy Biswas", 'Dep103', "MSC", 23),
    ('EMP104', "Ashik Mamun", 'Dep104', "MBA", 24),
    ('EMP105', "Arpan Manna", 'Dep101', "BSC", 22),
    ('EMP106', "Suprity Pal", 'Dep109', "BA", 20),
    ('EMP107', "Pritam Sarkar", 'Dep108', "MA", 30),
    ('EMP108', "Hritam Nath", 'Dep107', "HS", 40),
    ('EMP109', "Arup Biswas", 'Dep103', "HS", 27),
    ('EMP110', "Suchandra Mondal", 'Dep108', "BSC", 22),
    ('EMP201', 'Souvik Shil', 'Dep103', 'HS', 20),
    ('EMP202', 'Niloy Dey', 'Dep104', 'BA', 25),
    ('EMP203', 'Aryan Sarkar', 'Dep108', 'BA', 30),
    ('EMP204', 'Bijay Halder', 'Dep103', 'BSC', 29),
    ('EMP205', 'Rahul Roy', 'Dep101', 'HS', 20)
;


/* Inserting into department table*/
INSERT INTO department VALUES 
    ('Dep101', 'Data Science', 'EMP101', 'Kolkata'),
    ('Dep103', 'Botany', 'EMP204', 'Kalyani'),
    ('Dep104', 'Agriculture', 'EMP104', 'Dehradun'),
    ('Dep109', 'Mathematics', 'EMP106', 'Krishnagar'),
    ('Dep108', 'IT', 'EMP203', 'Kolkata'),
    ('Dep107', 'Physics', 'EMP108', 'Kharagpur')
; 


/*Adding a new field noe into the department table, it represents the number of employees in each department*/
ALTER TABLE department ADD noe INT;

/* Inserting derived values into the noe filed for each department */
UPDATE department SET noe = (SELECT COUNT(*) FROM employee WHERE dep_id = 'Dep101' ) WHERE dep_id = 'Dep101';
UPDATE department SET noe = (SELECT COUNT(*) FROM employee WHERE dep_id = 'Dep103' ) WHERE dep_id = 'Dep103';
UPDATE department SET noe = (SELECT COUNT(*) FROM employee WHERE dep_id = 'Dep104' ) WHERE dep_id = 'Dep104';
UPDATE department SET noe = (SELECT COUNT(*) FROM employee WHERE dep_id = 'Dep107' ) WHERE dep_id = 'Dep107';
UPDATE department SET noe = (SELECT COUNT(*) FROM employee WHERE dep_id = 'Dep108' ) WHERE dep_id = 'Dep108';
UPDATE department SET noe = (SELECT COUNT(*) FROM employee WHERE dep_id = 'Dep109' ) WHERE dep_id = 'Dep109';


/* Display the name and qualification of all the HoDs whose department is located in Kolkata. */ 

SELECT 
    name, qualification
FROM
    employee E,
    department D
WHERE
    E.eid = D.hod AND D.location = 'Kolkata'; 


/* Display the name, department, and salary of all the employees that are HoD of some department */

SELECT 
    E.name, D.descr AS 'Department', S.basic AS 'Salary'
FROM 
    employee E,
    department D,
    salary S
WHERE 
    (E.eid = D.hod AND E.eid = S.eid); 

/* Display the details of all the employees who are younger than average employee age. */
SELECT * FROM employee WHERE age < (SELECT AVG(age) FROM employee);


/* Display the details of the highest-paid HoD. */
SELECT 
    E.name, E.dep_id, E.qualification, E.age, S.basic, D.descr, D.location 
FROM 
    employee E, 
    salary S, 
    department D 
WHERE 
    E.eid = S.eid 
    AND E.eid = D.hod 
    AND basic = (SELECT MAX(basic) FROM salary, department WHERE salary.eid = department.hod);


/* Change the HoD of Dep103 to Emp109. */
UPDATE department SET hod = 'EMP109' WHERE dep_id = 'Dep103';


/* Display the department details and average salary received by each Department. */
SELECT 
    E.dep_id,
    D.descr,
    D.hod,
    D.location,
    AVG(S.basic) AS 'Avg Salary'
FROM
    employee E,
    salary S,
    department D
WHERE
    E.eid = S.eid AND E.dep_id = D.dep_id
GROUP BY dep_id;
    
