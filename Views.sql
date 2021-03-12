---Creating Views

if exists(select * 
          from information_schema.views 
          where [TABLE_NAME] = 'viewByDepartment' and [TABLE_SCHEMA] ='dbo')
		  drop view [dbo].[viewByDepartment]

--(with encryption) can be used for security purpose following as and with decryption to avoid security

create view viewByDepartment 
as  
select d.Dept_Name,e.Emp_id,t.DateOfTransaction,t.Amount 
from department as d
left join Employee_Record.dbo.Employee as e
on d.Dept_Name = e.Department
left join Employee_Record.dbo.EmpTransaction as t
on e.Emp_id = t.Emp_id

select * from viewByDepartment where Emp_id = 998