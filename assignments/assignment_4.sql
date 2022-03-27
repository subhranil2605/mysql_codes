/* ------------------------- Assignment 4 ------------------------- */
/* ------------------------- Subhranil Sarkar ------------------------- */
/* ------------------------- M.Sc. Data Science ------------------------- */
/* ------------------------- 1st Semester ------------------------- */
/* ------------------------- 27th March, 2022 ------------------------- */



/*Creating the database*/
CREATE DATABASE assignment_4;

USE assignment_4;


/*Creating the department table*/
CREATE TABLE department (
    dep_id CHAR (6) PRIMARY KEY,
    ddesc CHAR (20) NOT NULL,
    area CHAR (20) NOT NULL,
    estd_date DATE NOT NULL
);

/*Creating the personal table*/
CREATE TABLE personal (
    emp_no CHAR (6) PRIMARY KEY,
    name CHAR (30) NOT NULL,
    dob DATE NOT NULL,
    native_place CHAR (30),
    hobby CHAR (20)
);

/*Creating the job table*/
CREATE TABLE job (
    emp_no CHAR (6) PRIMARY KEY,
    app_date DATE NOT NULL,
    salary DECIMAL (8, 2) NOT NULL,
    retd_date DATE NOT NULL,
    dept CHAR (6),
    CONSTRAINT FOREIGN KEY (dept) REFERENCES department(dep_id)
);

/*Creating the hod table*/
CREATE TABLE hod (
    dep_id CHAR (6), 
    head CHAR (6), 
    CONSTRAINT FOREIGN KEY (dep_id) REFERENCES department(dep_id),
    CONSTRAINT FOREIGN KEY (head) REFERENCES personal(emp_no)
);


/*Inserting into the department table*/
INSERT INTO department VALUES 
    ('Dep701', 'Data Science', 'Kalyani', '1987-05-02'),
    ('Dep702', 'Physics', 'Kharagpur', '2000-01-02'),
    ('Dep703', 'Mathematics', 'Kolkata', '1992-07-09'),
    ('Dep704', 'Computer Science', 'Mumbai', '2005-10-05' ),
    ('Dep705', 'Agriculture', 'Kolkata', '1988-11-25' )
;

/*Inserting into the personal table*/
INSERT INTO personal VALUES 
    ('EMP101', 'Subhranil Sarkar', '1989-05-26', 'Krishnagar', 'sports' ),
    ('EMP102', 'Arghya Sarkar', '1987-06-18', 'Kalyani', 'painting' ),
    ('EMP103', 'Arpan Manna', '1990-12-29', 'Kolkata', 'cooking'),
    ('EMP104', 'Kalidas Das', '1991-11-12', 'Kolkata', 'music' ),
    ('EMP105', 'Archisman Biswas', '1985-06-21 ', 'Siliguri', 'sports' ),
    ('EMP106', 'Tridib Biswas', '1988-06-02 ', 'Santipur', 'gardening' ),
    ('EMP107', 'Sumit Saha', '1985-12-18 ', 'Kharagpur', 'music' ),
    ('EMP108', 'Suchandra Mondal', '1975-02-13', 'Suri', 'cooking' ),
    ('EMP109', 'Aryan Sarkar', '1992-03-05', 'Krishnagar', 'fishing' ),
    ('EMP110', 'Sayan Sharma', '1987-05-26', 'Kolkata', 'sports' ),
    ('EMP111', 'Anish Naskar', '1986-01-01 ', 'Kolkata', 'ghost hunting' ),
    ('EMP112', 'Sabuj Biswas', '1988-06-28 ', 'Kalyani', 'farming'),
    ('EMP113', 'Chinmoy Biswas', '1989-08-14 ', 'Taherpur', 'sports'),
    ('EMP114', 'Ashik Mamun', '1989-09-13 ', 'Badkulla', 'farming' ),
    ('EMP115', 'Suprity Pal', '1990-03-11 ', 'Majdia', 'music' )
;

/*Inserting into the job table*/
INSERT INTO job VALUES 
    ('EMP101', '2008-09-22', 72805, '2049-05-11', 'Dep701'),
    ('EMP102', '2010-09-13', 39920, '2047-06-03', 'Dep702'),
    ('EMP103', '2013-06-07', 56298, '2050-12-14', 'Dep701'),
    ('EMP104', '2018-12-13', 36708, '2051-10-28', 'Dep703'),
    ('EMP105', '2008-07-03', 47631, '2045-06-06', 'Dep702'),
    ('EMP106', '2009-08-18', 33671, '2048-05-18', 'Dep702'),
    ('EMP107', '2012-10-16', 69022, '2045-12-03', 'Dep701'),
    ('EMP108', '2013-06-11', 75651, '2035-01-29', 'Dep704'),
    ('EMP109', '2015-08-25', 77372, '2052-02-19', 'Dep704'),
    ('EMP110', '2016-01-19', 74701, '2047-05-11', 'Dep701'),
    ('EMP111', '2016-07-19', 22284, '2045-12-17', 'Dep701'),
    ('EMP112', '2019-07-01', 49144, '2048-06-13', 'Dep705'),
    ('EMP113', '2020-01-13', 55948, '2049-07-30', 'Dep702'),
    ('EMP114', '2020-09-08', 51577, '2049-08-29', 'Dep705'),
    ('EMP115', '2021-03-15', 39241, '2050-02-24', 'Dep703')
;


/*Inserting into the hod table*/
INSERT INTO hod VALUES 
    ('Dep701', 'EMP103'),
    ('Dep702', 'EMP102'),
    ('Dep703', 'EMP104'),
    ('Dep704', 'EMP109'),
    ('Dep705', 'EMP114')
;


/*----------------- Queries -----------------*/

/*To Show Empno, name and salary of those who have Sports as a hobby*/
SELECT P.emp_no, P.name, J.salary FROM personal P, job J WHERE  P.emp_no = J.emp_no AND hobby = 'sports';


/*To show the youngest employee from each Native place.*/
SELECT emp_no, name, native_place, FLOOR(DATEDIFF(NOW(), dob)/365) AS 'Age' FROM personal WHERE dob IN (SELECT MAX(dob) FROM personal GROUP BY native_place);


/*Show the number of employees area-wise.*/
SELECT D.area, COUNT(*) AS 'No. of Employees' FROM JOB J, DEPARTMENT D WHERE J.DEPT=D.DEP_ID GROUP BY D.area;


/*Increase salary by 5% of their present salary of the employees having a hobby as Music or who have completed at least 3 years of service*/
UPDATE job, personal SET salary = (salary + salary * 0.05) WHERE personal.emp_no = job.emp_no AND (hobby = 'music' OR (floor((datediff(NOW(), app_date))/365)) >= 3 );

/*Show the salary expense with the suitable column heading of those who shall retire after 20-Jan-2026.*/
SELECT SUM(salary) AS 'Salary Expense of employees retire after 20-Jan-2026' FROM job WHERE retd_date > '2026-01-26';

/*Show the hobby of which there are 2 or more employees.*/
SELECT hobby, COUNT(*) AS 'Number of Employees' FROM personal GROUP BY hobby HAVING COUNT(*) >= 2;
