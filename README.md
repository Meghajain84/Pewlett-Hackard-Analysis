# Pewlett-Hackard-Analysis

## Overview of the analysis
Pewlett Hackard is preparing for it's upcoming "silver tsumnami" where many baby boomers will retire. This analysis is to determine the number of employees that will be retiring under different categories so as to prepare for filling those positions accordingly. Also, this analysis will help the company plan retirement packages and mentorship strategy for new hires.

## Results
(1) The query results in table "retirement_titles" gives us employees names that are eligible for retirement. In addition, the query returns different roles they played in the company. This data can be interpreted to know the general trend in the growth of employees from one role to another in the company. For example(in below image), we see from and to dates of Chirstian, Kyoichi and Sumant under different titles(roles). This type of data can be extracted and plotted to see the trend in the company. 

![retirement_titles](https://github.com/Meghajain84/Pewlett-Hackard-Analysis/blob/main/retirement_titles.PNG)

(2) The number of retiring employees by title in table "retiring_titles" - This count conveys the open positions that need to be filled per title, where each title comes with the distinct set of responsibilities. These responsibilities would need to be included in job postings. Below image shows 7 titles and the number of potential job openings.

![retiring_titles](https://github.com/Meghajain84/Pewlett-Hackard-Analysis/blob/main/retiring_titles.PNG)

(2) The table "retiring_titles" (as seen in above image) also conveys that retirement-eligible employees in senior positions are huge in number as compared to non-senior positions. People with most experience are in senior roles. 

(4) The below query with highlighted conditions help in identifying employees that can mentor new hires. 1965 born resources fit this bill as they have atleast 10 years of service left to mentor the people before they become eligible for retirement.

![mentorship](https://github.com/Meghajain84/Pewlett-Hackard-Analysis/blob/main/mentorship.PNG)

## Summary
### Provide high-level responses to the following questions
    (Ques) How many roles will need to be filled as the "silver tsunami" begins to make an impact? 
    (Ans) Table "retiring_titles" gives the 7 roles and the corresponding number of retirement-eligible employees. Sum of 25916, 24926, 9285, 7636, 3603, 1090, 2 is 72,458.

    (Ques) Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
    (Ans) Table "mentorship_eligibilty" provides answer to this question. Total 1549 employees with their respective title(role) fit the mentorship criteria and can mentor new people before they become eligible for retirement.

### Provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami"

(1)

(2)

