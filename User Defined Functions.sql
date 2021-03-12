--USER DEFINED FUNCTIONS


---Create a function to calculate employee age --Scalar Function

Create function Employee_age(@Emp_Id as int)
returns int
as
begin     
         declare @yy as date
		 select @yy = DateOfBirth from Employee where Emp_Id = @Emp_Id
         declare @age as int
		 set @age = datediff(YEAR,@yy,getdate())
return(
         @age
	  )
end
go

select  *,dbo.Employee_age(123) as age from Employee
where Emp_Id = 123

select  *,dbo.Employee_age(Emp_id) as age from Employee


----Create a function for EmployeeTransaction --Inline Table

Alter function Emp_Tran(@Emp_Id as int)
returns table
as
return(
    select * from EmpTransaction where Emp_Id = @Emp_Id
	
   )

select distinct e.* from Employee as e
where exists(select * from dbo.Emp_Tran(Emp_Id) as t where e.Emp_id = t.Emp_Id )


---Create a function for Employee Total Attendance --Multi-statment Table valued function
go
Alter function Employee_TotalAttendance(@Emp_id as int)
returns @Attendance table(Emp_id  int,FirstName  varchar(50),LastName  varchar(50),NumberOfAttendance  smallint)
as
begin
 
 
    insert into @Attendance
	select e.Emp_id,e.EmpFirstName,e.EmpLastName,SUM(a.NumberOfAttendance) as TotalAttendance
	from Employee as e
	inner join EmpAttendance as a
	on e.Emp_id = a.Emp_Id
	where a.Emp_id = @Emp_id
	group by e.Emp_id,e.EmpFirstName,e.EmpLastName
 
    
	if @@ROWCOUNT = 0
	begin
	insert into @Attendance
	values(0,'No Employee with this Id','N/A',0)
	end
	 	
	
return
end


select * from dbo.Employee_TotalAttendance(1)