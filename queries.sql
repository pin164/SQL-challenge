--Strategy
-- Data Engineering  
-- Data Clensing
-- Data Viewing
---------------------------------------------------------------------------------------
-- Data Engineering  
---------------------------------------------------------------------------------------
--Create 6 tables 
-- Drop tables in reverse order of dependencies

---------------------------------------------------------------------------------------
-- Data Clensing  
---------------------------------------------------------------------------------------
-- CLEAN DATE DATA
--ALTER TABLE employees-
--two new columns
--convert from  hire date & birth date =  datatype text
--        to    hire date & birth date =  datatype Date
-- Step 1: Add a new column to hold the converted dates
ALTER TABLE employees
ADD COLUMN birth_date_true DATE;
ALTER TABLE employees
ADD COLUMN hire_date_true DATE;
-- Step 2: Update the new column with the converted birth_date values
UPDATE employees
SET birth_date_true = TO_DATE(birth_date, 'MM/DD/YYYY'),
    hire_date_true = TO_DATE(hire_date, 'MM/DD/YYYY');

-- confirm all the tables have imported - check all the tables 
SELECT *
	FROM employees
	LIMIT 50
SELECT *
	FROM titles
	LIMIT 6
SELECT *
	FROM salaries
	LIMIT 6
SELECT *
	FROM dept_emp
	LIMIT 6
SELECT *
	FROM dept_manager
	LIMIT 6
--------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Data viewing - list data
------------------------------------------------------------------------------------
--1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, 
	   e.last_name, 
	   e.first_name, 
	   e.sex,
	   s.salary
FROM 
	employees e
JOIN 
	salaries s ON e.emp_no = s.emp_no;
--2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date_true
FROM employees
WHERE EXTRACT(YEAR FROM hire_date_true) = 1986;
--3. List the manager of each department along with 
--   their department number, department name, employee number, last name, and first name.
SELECT
    d.dept_no,
    d.dept_name,
    dm.emp_no,
    e.last_name,
    e.first_name
FROM
    departments d
JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
JOIN
    employees e ON dm.emp_no = e.emp_no;
--4 List the department number for each employee 
--along with that employee’s employee number, last name, first name, and department name 
SELECT 
	  dm.emp_no,
	  d.dept_no,
	  d.dept_name,
	  e.last_name,
      e.first_name
FROM 
	 departments d
JOIN 
     dept_manager dm ON d.dept_no = dm.dept_no
JOIN
    employees e ON dm.emp_no = e.emp_no;
--5. List first name, last name, and sex 
--of each employee whose first name is Hercules and whose last name begins with the letter B.
Select 
	   e.last_name,
       e.first_name,
	   e.sex
FROM 
	employees e
WHERE   
     e.first_name = 'Hercules'
AND	
	 e.last_name LIKE 'B%';
--6. List each employee in the
--Sales department, including their employee number, last name, and first name.
SELECT 
   	e.emp_no,
    e.last_name,
    e.first_name
FROM 
    employees e
JOIN
    dept_emp de ON e.emp_no = de.emp_no
WHERE de.dept_no IN (
    SELECT
        d.dept_no
    FROM
        departments d
    WHERE
        d.dept_name = 'Sales'
);
--7. List each employee in the Sales and Development departments,
--including their employee number, last name, first name, and department name.
SELECT 
      e.emp_no, 
      e.last_name, 
      e.first_name, 
      d.dept_name
FROM 
	employees e
JOIN 
	dept_emp de 
	ON e.emp_no = de.emp_no
JOIN (
         SELECT 
		       dept_no, dept_name
         FROM 
	           departments
         WHERE 
	           dept_name IN ('Sales', 'Development')
) 
	d ON de.dept_no = d.dept_no;

--8. List the frequency counts, in descending order,
--of all the employee last names (that is, how many employees share each last name).
SELECT 
	  last_name, 
      COUNT(last_name) AS frequency    
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;



