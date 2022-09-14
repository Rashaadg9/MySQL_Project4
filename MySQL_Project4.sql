DROP DATABASE IF EXISTS MySQL_Project4;
CREATE DATABASE MySQL_Project4;
USE MySQL_Project4;

CREATE TABLE DepartmentData
(
	department_id INT,
    department_name VARCHAR(30) NOT NULL,
	location_id INT NOT NULL,
    PRIMARY KEY (department_id)
);

CREATE TABLE EmployeeData
(
	employee_id INT AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(25) NOT NULL,
    email VARCHAR(25) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    hire_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    salary INT NOT NULL,
    commission_pct INT,
    manager_id INT,
    department_id INT NOT NULL,
    PRIMARY KEY (employee_id),
    FOREIGN KEY (department_id) REFERENCES DepartmentData(department_id)
		ON UPDATE CASCADE
);

INSERT INTO DepartmentData VALUES(20, "Marketing", 180);
INSERT INTO DepartmentData VALUES(30, "Purchasing", 1700);
INSERT INTO DepartmentData VALUES(40, "Human Resources", 2400);
INSERT INTO DepartmentData VALUES(50, "Shipping", 1500);
INSERT INTO DepartmentData VALUES(60, "IT", 1400);
INSERT INTO DepartmentData VALUES(70, "Public Relations", 2700);
INSERT INTO DepartmentData VALUES(80, "Sales", 2500);
INSERT INTO DepartmentData VALUES(90, "Executive", 1700);
INSERT INTO DepartmentData VALUES(100, "Finance", 1700);
INSERT INTO DepartmentData VALUES(110, "Accounting", 1700);
INSERT INTO DepartmentData VALUES(120, "Treasury", 1700);
INSERT INTO DepartmentData VALUES(130, "Corporate Tax", 1700);
INSERT INTO DepartmentData VALUES(140, "Control And Credit", 1700);
INSERT INTO DepartmentData VALUES(150, "Shareholder Services", 1700);
INSERT INTO DepartmentData VALUES(160, "Benefits", 1700);
INSERT INTO DepartmentData VALUES(170, "Payroll", 1700);

ALTER TABLE EmployeeData AUTO_INCREMENT = 100;
INSERT INTO EmployeeData VALUES(NULL, "Steven", "King", "SKING", "515.123.4567", "1987-06-17", "AD_PRES", 24000, NULL, NULL, 20);
INSERT INTO EmployeeData VALUES(NULL, "Neena", "Kochhar", "NKOCHHAR", "515.123.4568", "1989-11-21", "AD_VP", 17000, NULL, 100, 20);
INSERT INTO EmployeeData VALUES(NULL, "Lex", "DeHaan", "LDEHAAN", "515.123.4569", "1993-09-12", "AD_VP", 17000, NULL, 100, 30);
INSERT INTO EmployeeData VALUES(NULL, "Alexander", "Hunold", "AHUNOLD", "590.423.4567", "1990-09-30", "IT_PROG", 9000, NULL, 102, 60);
INSERT INTO EmployeeData VALUES(NULL, "Bruce", "Ernst", "BERNST", "590.423.4568", "1991-05-21", "IT_PROG", 6000, NULL, 103, 60);
INSERT INTO EmployeeData VALUES(NULL, "David", "Austin", "DAUSTIN", "590.423.4569", "1997-06-25", "IT_PROG", 4800, NULL, 103, 60);
INSERT INTO EmployeeData VALUES(NULL, "Valli", "Pataballa", "VPATABAL", "590.423.4560", "1998-02-05", "IT_PROG", 4800, NULL, 103, 40);
INSERT INTO EmployeeData VALUES(NULL, "Diana", "Lorentz", "DLORENTZ", "590.423.5567", "1999-02-09", "IT_PROG", 4200, NULL, 103, 40);
INSERT INTO EmployeeData VALUES(NULL, "Nancy", "Greenberg", "NGREENBE", "515.124.4569", "1994-08-17", "FI_MGR", 12000, NULL, 101, 100);
INSERT INTO EmployeeData VALUES(NULL, "Daniel", "Faviet", "DFAVIET", "515.124.4169", "1994-08-12", "FI_ACCOUNT", 9000, NULL, 108, 170);
INSERT INTO EmployeeData VALUES(NULL, "John", "Chen", "JCHEN", "515.124.4269", "1997-04-09", "FI_ACCOUNT", 8200, NULL, 108, 170);

/* 1. Select employees first name, last name, job_id and salary whose first name starts with alphabet S.*/

SELECT first_name, last_name, job_id FROM EmployeeData WHERE first_name REGEXP "^S.*$";

/* 2. Write a query to select employee with the highest salary. */

SELECT * FROM EmployeeData ORDER BY salary DESC LIMIT 1;
/* ALTERNATE ANS --> SELECT * FROM (SELECT *, DENSE_RANK() OVER( ORDER BY Salary DESC) Salary_Rank FROM EmployeeData) TEMP WHERE Salary_Rank = 1; */

/* 3. Select employee with the second highest salary. */

SELECT * FROM (SELECT *, DENSE_RANK() OVER( ORDER BY Salary DESC) Salary_Rank FROM EmployeeData) Salary_Rank WHERE Salary_Rank = 2;

/* 4. Fetch employees with 2nd or 3rd highest salary. */

SELECT * FROM (SELECT *, DENSE_RANK() OVER( ORDER BY Salary DESC) Salary_Rank FROM EmployeeData) Salary_Rank WHERE Salary_Rank = 2 OR Salary_Rank = 3;

/* 5. Write a query to select employees and their corresponding managers and their salaries (use Self join in this case) */

SELECT
CONCAT(e.first_name, ' ', e.last_name) AS Employee,
e.Salary AS Employee_Salary,
CONCAT(m.first_name, ' ', m.last_name) AS Manager
FROM EmployeeData e
INNER JOIN EmployeeData m ON e.manager_id = m.employee_id
ORDER BY Manager;

/* 6. Write a query to show count of employees under each manager in descending order. */

SELECT
CONCAT(m.first_name, ' ', m.last_name) AS Manager,
COUNT(*) AS EmployeeCount
FROM EmployeeData e
INNER JOIN EmployeeData m ON e.manager_id = m.employee_id
GROUP BY Manager
ORDER BY EmployeeCount DESC;

/* 7. Find the count of employees in each department.*/

SELECT
d.department_name AS Department,
COUNT(e.department_id) AS EmployeeCount
FROM DepartmentData d
LEFT JOIN EmployeeData e ON d.department_id = e.department_id
GROUP BY Department
ORDER BY EmployeeCount DESC;

/* 8. Get the count of employees hired year wise. */
SET @year = 1994;
SELECT YEAR(hire_date) AS Year, COUNT(*) AS EmployeeCount FROM EmployeeData WHERE YEAR(hire_date) = @year;

/* 9. Find the salary range of employees. */

SELECT MIN(Salary) AS min, MAX(Salary) AS max FROM EmployeeData;

/* 10. Write a query to divide people into three groups based on their salaries. */

SELECT
CONCAT(first_name, ' ', last_name) AS Employee,
Salary,
IF(Salary < 5000, "LOW", IF(Salary BETWEEN 5000 AND 10000, "MID", "HIGH")) AS Level
FROM EmployeeData
ORDER BY Salary DESC;

/* 11. Select the employees whose first_name contains “an”. */

SELECT * FROM EmployeeData WHERE first_name LIKE "%an%";

/* 12. Select employee first name and the corresponding phone number in the format (_ _ _)-(_ _ _)-(_ _ _ _). */
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //
CREATE FUNCTION FormatPhoneNumber(PhoneNumber VARCHAR(255))
RETURNS VARCHAR(255)
BEGIN
DECLARE NUM VARCHAR(255);
SET NUM = CONCAT('(', SUBSTR(PhoneNumber, 1, 3), ')', SUBSTR(PhoneNumber, 4, 1), '(', SUBSTR(PhoneNumber, 5, 3), ')', SUBSTR(PhoneNumber, 8, 1), '(', SUBSTR(PhoneNumber, 9, 4), ')');
SET NUM = REPLACE(NUM, '.', '-');
RETURN NUM;
END //
DELIMITER ;

SELECT first_name, FormatPhoneNumber(phone_number) FROM EmployeeData;

/* 13. Find the employees who joined in August, 1994. */

SELECT * FROM EmployeeData WHERE YEAR(hire_date) = "1994" and MONTH(hire_date) = "8";

/* 14. Write an SQL query to display employees who earn more than the average salary in that company. */

SELECT * FROM EmployeeData WHERE salary > (SELECT FLOOR(AVG(salary)) FROM EmployeeData);

/* 15. Find the maximum salary from each department. */

SELECT D.department_name, IFNULL(MAX(E.salary), 0) AS MaximumSalary
FROM DepartmentData D
LEFT JOIN EmployeeData E ON D.department_id = E.department_id
GROUP BY D.department_name
ORDER BY MaximumSalary DESC;

/* 16. Write a SQL query to display the 5 least earning employees. */

SELECT * FROM EmployeeData ORDER BY Salary ASC LIMIT 5;

/* 17. Find the employees hired in the 80s. */

SELECT * FROM EmployeeData WHERE YEAR(hire_date) BETWEEN "1980" AND "1989";

/* 18. Display the employees first name and the name in reverse order. */

SELECT CONCAT(first_name, ' ', last_name) AS FullName FROM EmployeeData ORDER BY FullName DESC;
SELECT CONCAT(first_name, ' ', last_name) AS FullName, CONCAT(REVERSE(last_name), ' ', REVERSE(first_name)) AS ReverseName FROM EmployeeData ORDER BY FullName DESC;

/* 19. Find the employees who joined the company after 15th of the month. */

SELECT * FROM EmployeeData WHERE DAY(hire_date) > "15";

/* 20. Display the managers and the reporting employees who work in different departments. */

SELECT
CONCAT(m.first_name, ' ', m.last_name) AS Manager,
md.department_name AS ManagerDepartment,
CONCAT(e.first_name, ' ', e.last_name) AS Employee,
ed.department_name AS EmployeeDepartment
FROM EmployeeData e
INNER JOIN EmployeeData m ON e.manager_id = m.employee_id
INNER JOIN Departmentdata md ON m.department_id = md.department_id
INNER JOIN Departmentdata ed ON e.department_id = ed.department_id
WHERE md.department_id != ed.department_id
ORDER BY Manager;

/*Bonus Questions*/

/*--------------------------------------------------------------------------------------------------------------------------------------------*/
DELIMITER //
CREATE TRIGGER EmailFormat BEFORE INSERT ON EmployeeData FOR EACH ROW
BEGIN
SET NEW.email = CONCAT(NEW.email, "@collabera.com");
END //
DELIMITER ;

INSERT INTO EmployeeData VALUES(NULL, "Test", "Row", "TROW", "000.000.0000", "1987-06-17", "IT_PROG", 15000, NULL, 101, 60);


/*--------------------------------------------------------------------------------------------------------------------------------------------*/


TRUNCATE TABLE EmployeeData;
ALTER TABLE EmployeeData AUTO_INCREMENT = 100;

LOAD DATA INFILE "C:\\Java_WorkSpace\\mysqlprojects\\MySQL_Project4\\EmployeeData.csv"
INTO TABLE EmployeeData
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

