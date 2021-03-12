---Creating another table Manager in employee table

begin tran

 Alter table Employee
 add Manager int

 update Employee
 set Manager = ((Emp_id - 123)/10)+123
 WHERE Emp_id > 123

 rollback tran

  select * from Employee

 --Find out the manager of each employee

 select e.Emp_id,e.EmpFirstName,e.EmpLastName,e.Manager,
        m.Emp_Id,m.EmpFirstName,m.EmpLastName,m.Manager 		  
		from Employee as e
 left join Employee as m
 on e.Manager = m.Emp_id

