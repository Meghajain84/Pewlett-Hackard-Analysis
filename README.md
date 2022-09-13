# Pewlett-Hackard-Analysis

## Overview of the analysis
Pewlett Hackard is preparing for it's upcoming "silver tsumnami" where many baby boomers will retire. This analysis is to determine the number of employees that will be retiring under different categories so as to prepare for filling those positions accordingly. Also, this analysis will help the company plan retirement packages and mentorship strategy for new hires.

## Results
(1) The query results in table "retirement_titles" gives us employees names that are eligible for retirement. In addition, the query returns different roles they played in the company. This data can be interpreted to know the general trend in the growth of employees from one role to another in the company. For example(in below image), we see from and to dates of Chirstian, Kyoichi and Sumant under different titles(roles). This type of data can be extracted and plotted to see the trend in the company. 

![retirement_titles](https://github.com/Meghajain84/Pewlett-Hackard-Analysis/blob/main/retirement_titles.PNG)

(2) The number of retiring employees by title in table "retiring_titles" - This count conveys the open positions that need to be filled per title, where each title comes with the distinct set of responsibilities. These responsibilities would need to be included in job postings. Below image shows 7 titles and the number of potential job openings.

![retiring_titles](https://github.com/Meghajain84/Pewlett-Hackard-Analysis/blob/main/retiring_titles.PNG)

(3) The table "retiring_titles" (as seen in above image) also conveys that retirement-eligible employees in senior positions are huge in number as compared to non-senior positions. In other words about 70% of employees that are eligible for retirement are in senior positions. The company can decide how they want to allocate this percentage in hiring employees between new hires, promoting in-house employees to senior positions, or to get rid of certain positions as automations have reduced manual labor.

(4) The below query with highlighted conditions help in identifying employees that can mentor new hires. 1965 born resources fit this bill as they have atleast 10 years of service left to mentor the people before they become eligible for retirement.

![mentorship](https://github.com/Meghajain84/Pewlett-Hackard-Analysis/blob/main/mentorship.PNG)

## Summary
### Provide high-level responses to the following questions
    (Ques) How many roles will need to be filled as the "silver tsunami" begins to make an impact? 
    (Ans) Table "retiring_titles" gives the 7 roles and the corresponding number of retirement-eligible employees. Sum of 25916, 24926, 9285, 7636, 3603, 1090, 2 is 72,458.

    (Ques) Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
    (Ans) Table "mentorship_eligibilty" provides answer to this question. Total 1549 employees with their respective title(role) fit the mentorship criteria and can mentor new people before they become eligible for retirement.

### Provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami"

(1) Table of employees eligible for retirement with their days of service in the company

Purpose:
That can determine the retirement benefits or severence package for employees


Query:

    SELECT E.EMP_NO,
        E.FIRST_NAME,
        E.LAST_NAME,
        E.BIRTH_DATE,
        E.GENDER,
        (CURRENT_DATE - E.HIRE_DATE) AS DAYS_OF_SERVICE INTO EMPLOYEE_SERVICE
    FROM EMPLOYEES E
    INNER JOIN DEPT_EMP DE ON DE.EMP_NO = E.EMP_NO
    WHERE (E.BIRTH_DATE BETWEEN '1952-01-01' AND '1955-12-31')
        AND (DE.TO_DATE = '9999-01-01')
    ORDER BY E.EMP_NO;


(2)	Table with count of total employees and max salary per department and various titles under those departments

Purpose: 
This gives count of total current employees and max salary per department and title under those departments. This information shows the current size of department and big picture in regards to titles available in department. The company can determine the new composition before posting new openings using this as base. This data can be used when looking at count of potential retiring employees in comparison to overall current state of department.We can also use same query to find employees retiring by adding additional clause of retirement criteria. 

Query:

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

