DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

CREATE TABLE departments (
	dept_no VARCHAR NOT NULL,
	dept_name VARCHAR NOT NULL,
	PRIMARY KEY (dept_no)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE dept_manager (
	dept_no INT NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (dept_no, emp_no)
)

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
)

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
)

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM titles;

-- List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
ORDER BY emp_no;

-- List employees who were hired in 1986.
SELECT * 
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY emp_no;

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name,
--and start and end employment dates.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, e.from_date, e.to_date
FROM department AS d
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
JOIN employees as e ON dm.emp_no = e.emp_no
ORDER BY e.emp_no;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments as d ON dm.dept_no = d.dept_no
ORDER BY e.emp_no;

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * 
FROM employees AS e
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
ORDER BY emp_no;

--List all employees in the Sales department, including their 
--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales'
ORDER BY e.emp_no;

--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY e.emp_no;

--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
-- The frequency of employee last names
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;
