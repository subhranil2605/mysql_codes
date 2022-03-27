/* ------------------------- Assignment 2 ------------------------- */
/* ------------------------- Subhranil Sarkar ------------------------- */
/* ------------------------- M.Sc. Data Science ------------------------- */
/* ------------------------- 1st Semester ------------------------- */
/* ------------------------- 25th March, 2022 ------------------------- */

SHOW DATABASES;

/* Previously created database for assignment 1 */
USE assignment_1;

SHOW TABLES;

/* Updating the dep_id field of employee table */
ALTER TABLE employee MODIFY dep_id CHAR(6) NOT NULL;

/*Inserting 5 new rows in the salary table*/
INSERT INTO salary (eid, basic) VALUES 
    ('EMP201', 30000),
    ('EMP202', 40000),
    ('EMP203', 20000),
    ('EMP204', 6000),
    ('EMP205', 15000)
;


/*Inserting 5 new rows in the employee table */
INSERT INTO employee VALUES 
    ('EMP201', 'Souvik Shil', 'Dep101', 'HS', 20),
    ('EMP202', 'Niloy Dey', 'Dep102', 'BA', 25),
    ('EMP203', 'Aryan Sarkar', 'Dep103', 'BA', 30),
    ('EMP204', 'Bijay Halder', 'Dep103', 'BSC', 29),
    ('EMP205', 'Rahul Roy', 'Dep101', 'HS', 20)
;

/* --------------------- Queries --------------------- */

/* The oldest employee */
SELECT * FROM employee WHERE age = (SELECT MAX(age) FROM EMPLOYEE); 

/* The name, age and qualification of the employees in Dep103 */
SELECT name, age, qualification FROM employee WHERE dep_id = 'Dep103';

/* The average salary of the employees */
SELECT AVG(basic) AS 'Average Salary' FROM salary;

/* Employees getting more salary than average salary */
SELECT E.eid, E.name, E.dep_id, E.qualification, E.age, S.basic FROM employee E, salary S WHERE E.eid = S.eid and basic > (SELECT AVG(basic) FROM salary) ORDER BY S.basic;

/* The average salary of the employees in Dep101 */
SELECT 
	dep_id,
	COUNT(*) AS 'Number of employees', 
	AVG(basic) AS 'Avg Salary' 
FROM 
	employee E, 
	salary S 
WHERE 
	E.eid = S.eid 
GROUP BY 
	dep_id HAVING dep_id = 'Dep101';
