SELECT e.emp_no                                                                   AS ID,
       concat(e.first_name, ' ', e.last_name)                                     AS Name,
       t.title                                                                    AS Position,
       t.from_date                                                                AS "From",
       t.to_date                                                                  AS "To",
       CASE WHEN e.gender = 'f' THEN 'Female' WHEN e.gender = 'm' THEN 'Male' END AS Gender,
       e.hire_date                                                                AS Hired,
       d.dept_name                                                                AS Department,
       d.dept_no                                                                  as 'Department no',
       de.from_date                                                               AS "Assigned from",
       de.to_date                                                                 AS "Assigned to",
       concat(em.first_name, ' ', em.last_name)                                   AS 'Manager',
       s.salary                                                                   AS Salary
FROM employees e

         JOIN (SELECT emp_no,
                      MAX(titles.to_date) AS titles_max_to_date
               FROM titles
               GROUP BY emp_no) last_title ON last_title.emp_no = e.emp_no
         JOIN titles t ON t.emp_no = e.emp_no AND t.to_date = last_title.titles_max_to_date

         JOIN dept_emp de ON e.emp_no = de.emp_no AND de.to_date = last_title.titles_max_to_date
         JOIN departments d ON de.dept_no = d.dept_no

         JOIN (SELECT dept_no,
                      MAX(dept_manager.to_date) AS dept_manager_max_to_date
               FROM dept_manager
               GROUP BY dept_no) last_manager ON last_manager.dept_no = d.dept_no
         JOIN dept_manager dm ON dm.dept_no = d.dept_no AND dm.to_date = last_manager.dept_manager_max_to_date
         JOIN employees em ON em.emp_no = dm.emp_no

         JOIN(SELECT emp_no,
                     max(salaries.to_date) AS salaries_max_to_date
              FROM salaries
              GROUP BY emp_no) last_salary ON last_salary.emp_no = e.emp_no
         JOIN salaries s ON e.emp_no = s.emp_no AND s.to_date = last_salary.salaries_max_to_date;