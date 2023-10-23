select
    emp_no as ID,
    concat(first_name,' ', last_name) as Name,
    case when gender ='f' then 'Female' when gender = 'm' then 'Male' end as Gender,
    hire_date as Hired

from employees
order by hire_date asc;
