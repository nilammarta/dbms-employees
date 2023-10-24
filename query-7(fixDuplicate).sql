select
    e.emp_no as ID,
    concat(e.first_name,' ', e.last_name) as Name,
    t.title as Position,
    t.from_date as 'From',
    t.to_date as 'To',
    case when e.gender ='f' then 'Female' when e.gender = 'm' then 'Male' end as Gender,
    e.hire_date as Hired,
    d.dept_name as Department,
    de.from_date as 'Assigned from',
    de.to_date as 'Assigned to',
    concat(em.first_name,' ', em.last_name) as Manager
from employees e
    join titles t on e.emp_no = t.emp_no
    join dept_emp de on e.emp_no = de.emp_no
    join departments d on de.dept_no = d.dept_no
    join dept_manager dm on d.dept_no = dm.dept_no
    join employees em on dm.emp_no = em.emp_no
where t.to_date >= curdate()
    and de.to_date >= curdate()
    and dm.to_date >= curdate()
order by e.emp_no asc;