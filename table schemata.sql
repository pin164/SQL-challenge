--Strategy
-- Data Engineering  
-- Data Clensing
-- Data Viewing
---------------------------------------------------------------------------------------
-- Data Engineering  
---------------------------------------------------------------------------------------
--Create 6 tables 
-- Drop tables in reverse order of dependencies
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS titles;
-- Table Schema 1 for 'employees' table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(7) NOT NULL,
    birth_date VARCHAR(12) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date VARCHAR(12) NOT NULL
);
-- Table Schema 2 for 'titles' table
CREATE TABLE titles (
    title_id VARCHAR(7) PRIMARY KEY,
    title VARCHAR(30) NOT NULL
);
-- Table Schema 3 for 'salaries' table
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary NUMERIC(15, 2) NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no) ON DELETE CASCADE
);
-- Table Schema 4 for 'departments' table
CREATE TABLE departments (
    dept_no VARCHAR(10) PRIMARY KEY,
    dept_name VARCHAR(30) NOT NULL
);
-- Table Schema 5 for 'dept_emp' table
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(10) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no) ON DELETE CASCADE,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no) ON DELETE CASCADE
);
-- Table Schema 6 for 'dept_manager' table
CREATE TABLE dept_manager (
    dept_no  VARCHAR(10) NOT NULL,
    emp_no INT NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no) ON DELETE CASCADE,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no) ON DELETE CASCADE
);
