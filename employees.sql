-- Create Tables

CREATE TABLE "titles" (
    "title_id" varchar(255)   NOT NULL,
    "Title" varchar(255)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "employees" (
    "Emp_no" int   NOT NULL,
    "Emp_title_id" varchar(255)   NOT NULL,
    "Birth_date" varchar(255)   NOT NULL,
    "First_name" varchar(255)   NOT NULL,
    "Last_name" varchar(255)   NOT NULL,
    "Sex" varchar(255)   NOT NULL,
    "Hire_date" varchar(255)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "Emp_no"
     )
);

CREATE TABLE "departments" (
    "Dept_no" varchar(255)   NOT NULL,
    "Dept_name" varchar(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "Dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "Emp_no" int   NOT NULL,
    "Dept_no" varchar(255)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "Emp_no", "Dept_no"
     )
);

CREATE TABLE "salaries" (
    "Emp_no" int   NOT NULL,
    "Salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "Emp_no"
     )
);

CREATE TABLE "dept_manager" (
    "Dept_no" varchar(255)   NOT NULL,
    "Emp_no" int   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "Dept_no", "Emp_no"
     )
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_Emp_title_id" FOREIGN KEY("Emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_Emp_no" FOREIGN KEY("Emp_no")
REFERENCES "employees" ("Emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_Dept_no" FOREIGN KEY("Dept_no")
REFERENCES "departments" ("Dept_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_Emp_no" FOREIGN KEY("Emp_no")
REFERENCES "employees" ("Emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_Dept_no" FOREIGN KEY("Dept_no")
REFERENCES "departments" ("Dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_Emp_no" FOREIGN KEY("Emp_no")
REFERENCES "employees" ("Emp_no");

-- List the employee number, last name, first name, sex, and salary of each employee.

SELECT employees."Emp_no", employees."Last_name", employees."First_name", employees."Sex", salaries."Salary"
FROM employees 
INNER JOIN salaries
ON employees."Emp_no" = salaries."Emp_no"

-- List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT "First_name", "Last_name", "Hire_date"
FROM employees
WHERE "Hire_date" LIKE '%1986'

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT employees."Emp_no", employees."Last_name", employees."First_name", dept_manager."Dept_no", departments."Dept_name"
FROM employees
INNER JOIN dept_manager
ON employees."Emp_no" = dept_manager."Emp_no"
INNER JOIN departments 
ON departments."Dept_no" = dept_manager."Dept_no"

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT employees."Emp_no", employees."Last_name", employees."First_name", dept_emp."Dept_no", departments."Dept_name"
FROM employees
INNER JOIN dept_emp
ON employees."Emp_no" = dept_emp."Emp_no"
INNER JOIN departments
ON departments."Dept_no" = dept_emp."Dept_no"

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT "First_name", "Last_name", "Sex"
FROM employees
WHERE "First_name" = 'Hercules'
AND "Last_name" LIKE 'B%'

-- List each employee in the Sales department, including their employee number, last name, and first name.

SELECT employees."Emp_no", employees."Last_name", employees."First_name", dept_emp."Dept_no", departments."Dept_name"
FROM employees
INNER JOIN dept_emp
ON employees."Emp_no" = dept_emp."Emp_no"
INNER JOIN departments
ON departments."Dept_no" = dept_emp."Dept_no"
WHERE "Dept_name" = 'Sales'

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT employees."Emp_no", employees."Last_name", employees."First_name", dept_emp."Dept_no", departments."Dept_name"
FROM employees
INNER JOIN dept_emp
ON employees."Emp_no" = dept_emp."Emp_no"
INNER JOIN departments
ON departments."Dept_no" = dept_emp."Dept_no"
WHERE "Dept_name" = 'Sales'
OR "Dept_name" = 'Development'

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT "Last_name", COUNT("Last_name")
FROM employees
GROUP BY "Last_name"
ORDER BY COUNT("Last_name") DESC
