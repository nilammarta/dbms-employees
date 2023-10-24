select
    e.emp_no as ID,
    concat(first_name,' ', last_name) as Name,
    t.title as Position,
    t.from_date as 'From',
    t.to_date as 'To',
    case when gender ='f' then 'Female' when gender = 'm' then 'Male' end as Gender,
    hire_date as Hired,
    d.dept_name as Department,
    de.from_date as 'Assigned from',
    de.to_date as 'Assigned to'
from employees e
    join titles t on e.emp_no = t.emp_no
    join dept_emp de on e.emp_no = de.emp_no
    join departments d on de.dept_no = d.dept_no
    where t.to_date >= curdate()
    and de.to_date >= curdate()
order by e.emp_no asc;
