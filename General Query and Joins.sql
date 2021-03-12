--Query 1 : Find employees whose firstname start with A

   select * 
   from Employee_Record.dbo.Employee
   where EmpFirstName like 'A%'

--Query 2 : Give Fullname,DOB of employees who work in Commercial and HR department

   select EmpFirstName+' '+ iif(EmpMiddleName is Null,'',EmpLastName)+' '+ EmpLastName as FullName, DateOfBirth,Department
   from Employee_Record.dbo.Employee
   where Department in ('Commercial','HR')
   order by Department

--Query  4: Find out whose birthday fall in month of November and December

    select Emp_id,EmpFirstName,EmpLastName,DateOfBirth 
	from Employee_Record.dbo.Employee
	where DateOfBirth in 
    (select DateOfBirth  from Employee_Record.dbo.Employee where datepart(month,DateOfBirth) in (11,12))

--Query 5 : Find out employees whose emp_id not in between 200 and 350

    select * 
	from Employee_Record.dbo.Employee
	where Emp_id not between 200 and 350

--Query 6: Find out employees whose emp_id is greater than 200 and less than 240

     select * 
	 from Employee_Record.dbo.Employee
	 where Emp_id > 200 and Emp_id<240

--Query 7: Find out  5 latest and oldest record from the employee table

   select top(5) * 
   from Employee_Record.dbo.Employee   --latest

   select top(5) * 
   from Employee_Record.dbo.Employee 
   order by Emp_id desc --oldest

--Query 8: Give count of employees DOB fall  by each year 

   select year(DateOfBirth) as YearOfBirth,count(*) as NumberOfBorn
   from Employee_Record.dbo.Employee 
   group by year(DateOfBirth)
   having count(*)>=40
   order by count(*) desc

--Query 9: modify blank values in EmpMiddleName with Null

    update Employee_Record.dbo.Employee
	set EmpMiddleName = NULl
	where EmpMiddleName =''

	select * from employee

--Query 10: Get Count of No. of intitals of employees whose initial greater than 40 and fall in year between 1970 to 1988

   select left(EmpLastName,1) as Initial,count(*) as NumberOfInitial
   from Employee_Record.dbo.Employee 
   where year(DateOfBirth) between 1970 and 1988
   group by left(EmpLastName,1)
   having count(*) >40
   order by NumberOfInitial desc


 --Joins Query


--Query 11: Find top 5 employees by total transaction

select top(5) e.EmpFirstName,e.EmpMiddleName,e.EmpLastName, concat('$ ',sum(t.Amount)) as TotalAmount 
from Employee_Record.dbo.Employee as e
right join EmpTransaction as t
on e.Emp_id = t.Emp_id
where e.Emp_id is not null
group by e.EmpFirstName,e.EmpMiddleName,e.EmpLastName
order by sum(t.Amount) desc


--Query 12: Find out how many employees are working in each department

select Department 
from
(
select Department,count(*) as NoOfEmployees from Employee_Record.dbo.Employee
group by Department
) as Total



--Query:13 Find out which department employees have done the highest total amount of transaction

select top(1) d.Dept_Name,sum(t.Amount) as SumOfAmount  
from Employee_Record.dbo.Department as d
inner join Employee_Record.dbo.Employee as e
on d.Dept_Name = e.Department
inner join EmpTransaction as t
on e.Emp_id = t.Emp_id
group by d.Dept_Name
order by sum(t.Amount) desc

--Query:14 Find all those employees who have got no transaction

select e.Emp_id,EmpFirstName,t.Emp_id,e.EmpLastName ,sum(t.Amount) as SumOfAmount  
from Employee_Record.dbo.Employee as e
left join Employee_Record.dbo.EmpTransaction as t
on e.Emp_id = t.Emp_id
where t.Emp_id is null
group by e.Emp_id,EmpFirstName,t.Emp_id,e.EmpLastName
order by e.Emp_id

--Query:15 Find all those transaction who have no record 

select e.Emp_id,EmpFirstName,e.EmpLastName ,t.Amount as SumOfAmount  
from Employee_Record.dbo.Employee as e
right join Employee_Record.dbo.EmpTransaction as t
on e.Emp_id = t.Emp_id
where e.Emp_id is null
order by e.Emp_id

--Query:16 Remove all those records from transaction which is created by unknown

begin tran
delete Employee_Record.dbo.EmpTransaction
from  Employee_Record.dbo.EmpTransaction as t
left join Employee as e
on t.Emp_id = e.Emp_id
where e.Emp_id is null
rollback tran

---Query :17 modify employee id 4 all transactions to employee 205
begin tran

select * from Employee_Record.dbo.EmpTransaction
where Emp_id = 205

select * from Employee_Record.dbo.EmpTransaction
where Emp_id = 4

update Employee_Record.dbo.EmpTransaction
set Emp_id = 205
output inserted.*,deleted.*
from Employee_Record.dbo.EmpTransaction
where Emp_id = 4

rollback tran

--Query :18 Find out the employees who have done transaction on 5th and 6th month of year 2014.Which department they belong to?

select e.EmpFirstName,e.EmpLastname,d.Dept_Name,t.DateOfTransaction 
from Employee as e
left join Department as d
on d.Dept_Name = e.Department
left join EmpTransaction as t
on e.Emp_id = t.Emp_id
where t.DateOfTransaction  in(select DateOfTransaction  from EmpTransaction where datepart(year,DateOfTransaction) in (2014)) 
and t.DateOfTransaction  in(select DateOfTransaction  from EmpTransaction where datepart(month,DateOfTransaction) in (5,6))


--Query :19 Find out an employee with their respective department who had attendance more than 1000 in year 2014 with their total Transaction

select  d.Dept_Name, e.EmpFirstName,e.EmpLastName,sum(a.NumberOfAttendance) as TotalAttendes,sum(t.Amount) as TotalTransaction from 
Department as d
left join Employee as e
on d.Dept_Name = e.Department
left join EmpTransaction as t
on e.Emp_id = t.Emp_id
left join EmpAttendance as a
on e.Emp_id = a.Emp_Id
where DATEPART(year,a.AttendanceMonth) = 2014
group by d.Dept_Name,e.EmpFirstName,e.EmpLastName
having sum(a.NumberOfAttendance)>1000
order by sum(a.NumberOfAttendance) desc

--Query :20 Find out total attendance of an employee Emp_ID of 123 and 196.

select  e.Emp_id,a.AttendanceMonth,a.NumberOfAttendance,sum(a.NumberOfAttendance) over(partition by e.Emp_Id,year(a.AttendanceMonth) ) as TotalAttendes 
from Employee as e
inner join EmpAttendance as a
on e.Emp_id = a.Emp_Id
where  e.Emp_id in (123,196)
order by e.Emp_id 




