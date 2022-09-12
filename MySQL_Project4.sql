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