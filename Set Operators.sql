---Set operators

---just assuming i am given 2 different data set and given instruction to find the out 
---1)The employee who had done transaction on 30th of november and december = union
---2)The employee who had done transaction on both the months on the 30th day. = intersect
---3)The employee who had done transaction on 30th but not in the month of november and december = except

select e.Emp_id,e.EmpFirstName,e.EmpLastname,d.Dept_Name,t.DateOfTransaction 
from Employee as e
left join Department as d
on d.Dept_Name = e.Department
left join EmpTransaction as t
on e.Emp_id = t.Emp_id
where t.DateOfTransaction  in (select DateOfTransaction  from EmpTransaction where datepart(DAY,DateOfTransaction) = 30) 

except--/union all/intersect/union


select e.Emp_id,e.EmpFirstName,e.EmpLastname,d.Dept_Name,t.DateOfTransaction 
from Employee as e
left join Department as d
on d.Dept_Name = e.Department
left join EmpTransaction as t
on e.Emp_id = t.Emp_id
where t.DateOfTransaction  in(select DateOfTransaction  from EmpTransaction where datepart(month,DateOfTransaction) in (11,12)) 
