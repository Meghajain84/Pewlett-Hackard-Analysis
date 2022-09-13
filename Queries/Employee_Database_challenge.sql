/*
Deliverable 1: The Number of Retiring Employees by Title
*********************************************************
1) Retrieve the emp_no, first_name, and last_name columns from the Employees table.
2) Retrieve the title, from_date, and to_date columns from the Titles table.
3) Create a new table using the INTO clause.
4) Join both tables on the primary key.
5) Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
6) Export the Retirement Titles table from the previous step as retirement_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
7) Before you export your table, confirm that it looks like given image
*/
SELECT e.emp_no,
   e.first_name,
   e.last_name,
   t.title, 
   t.from_date,
   t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     --AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
     --AND (de.to_date = '9999-01-01')
order by e.emp_no;

/*
8) Copy the query from the Employee_Challenge_starter_code.sql and add it to your Employee_Database_challenge.sql file.
9) Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
These columns will be in the new table that will hold the most recent title of each employee.
10) Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
11) Exclude those employees that have already left the company by filtering on to_date to keep only those dates that are equal to '9999-01-01'.
12) Create a Unique Titles table using the INTO clause.
13) Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e., to_date) of the most recent title.
14) Export the Unique Titles table as unique_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
15) Before you export your table, confirm that it looks like given image 
*/
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no,to_date DESC;

/*
16) Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.
17) First, retrieve the number of titles from the Unique Titles table.
18) Then, create a Retiring Titles table to hold the required information.
19) Group the table by title, then sort the count column in descending order.
20) Export the Retiring Titles table as retiring_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
21) Before you export your table, confirm that it looks like given image
22) Save your Employee_Database_challenge.sql file in your Queries folder in the Pewlett-Hackard folder
*/
SELECT count(emp_no),
title
into retiring_titles
FROM unique_titles
group by title
ORDER BY count(emp_no) DESC;

/*
Deliverable 2: The Employees Eligible for the Mentorship Program
******************************************************************
1) Retrieve the emp_no, first_name, last_name, and birth_date columns from the Employees table.
2) Retrieve the from_date and to_date columns from the Department Employee table.
3) Retrieve the title column from the Titles table.
4) Use a DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
5) Create a new table using the INTO clause.
6) Join the Employees and the Department Employee tables on the primary key.
7) Join the Employees and the Titles tables on the primary key.
8) Filter the data on the to_date column to all the current employees, then filter the data on the birth_date columns to get all the employees whose birth dates are between January 1, 1965 and December 31, 1965.
9) Order the table by the employee number.
10) Export the Mentorship Eligibility table as mentorship_eligibilty.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
11) Before you export your table, confirm that it looks like given image
*/
select distinct on (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
into mentorship_eligibilty
from employees as e 
inner join dept_emp de
on (e.emp_no = de.emp_no)
inner join titles as t
on (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
and (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
order by e.emp_no, t.from_date desc;

/*
Deliverable 3 - Analysis
*************************
Provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami"
*/

/*
(1)	Table of employees eligible for retirement with their days of service in the company
*/
SELECT E.EMP_NO,
	E.FIRST_NAME,
	E.LAST_NAME,
	E.BIRTH_DATE,
	E.GENDER,
	(CURRENT_DATE - E.HIRE_DATE) AS DAYS_OF_SERVICE INTO EMPLOYEE_SERVICE
FROM EMPLOYEES E
WHERE (E.BIRTH_DATE BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY E.EMP_NO;

/*
(2)	Table with count of total employees and max salary per department and various titles under those departments
*/
SELECT DISTINCT de.dept_no, d.dept_name, emp_title.title, count(de.emp_no), max(s.salary)
INTO Dept_Title_MaxSal
FROM 
	(select * from dept_emp 
	where to_date = '9999-01-01') de
INNER JOIN (select distinct on (e.emp_no) e.emp_no, t.title
			from employees e
		    inner join titles as t
			on (e.emp_no = t.emp_no)
		   	order by e.emp_no, t.from_date desc) emp_title
ON (de.emp_no = emp_title.emp_no)
INNER JOIN salaries as s
ON (de.emp_no = s.emp_no)
INNER JOIN departments d 
ON (de.dept_no = d.dept_no)
group by 
	de.dept_no, d.dept_name, emp_title.title ;

--select * from Dept_Title_MaxSal;
	

	
