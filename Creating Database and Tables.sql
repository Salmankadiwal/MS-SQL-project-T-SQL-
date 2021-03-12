--Create a database

create database Employee_Record

use Employee_Record

--Creating 4 tables Name Employee,EmpTransaction,Department

create table Employee(

Emp_id int not null,
EmpFirstName varchar(50) not null,
EmpMiddleName varchar(50) null,
EmpLastName varchar(50) not null,
EmpGovernmentID char(10) null,
DateOfBirth date not null,

)


--Adding department column to the employee table

Alter table Employee
Add Department varchar(10);


--Altering the table to modify the department datatype

Alter table Employee
Alter column Department varchar(20);


create table EmpTransaction(

Amount int not null,
DateOfTransaction smalldatetime null,
Emp_id int not null

)



create table Department(

Dept_Name varchar(20) not null,
DepartmentHead varchar(25)  null
)

insert into Department (Dept_Name)
select distinct Department from Employee


create table EmpAttendance
(
 Emp_Id int,
 AttendanceMonth date,
 NumberOfAttendance smallint,
 CONSTRAINT FK_Attendance_EmployeeNumber FOREIGN KEY(Emp_Id)
 REFERENCES Employee(Emp_Id)

) 