--TYPES OF LOCKS AND INDEXES


--shared lock =used to read only select
--Exclusive lock = used for insert,delete,update at that time no other can get access to it like inserting ,no other get access
--update lock = shared+exclusive first we select to find data that get shared lock n then update get exclusive lock
--Note=update can get row level lock

--Types of isolation

--1) set transaction isolation level committed(default) like upper lock
--2) set transaction isolation level uncommitted = read dirty data with this command used with select
--3) set transaction isolation level repeatable read = in this command no one else can delete data but it can be inserted.
--4) set transaction isolation level serialization = it is very strict, no one can modify during that time when command use with this




--INDEX

--Clustered index can be created only one on a particular table and it can be non-unqiue and it is default in asc
--NonClustered index can be created more than one column on a particular table and it can be non-unqiue
--drop index [index_Emp_id_DateOfBirth] on Employee
--sp_helpindex Employee
--I did not create clustered index because i have already created primary key on emp_id on employee table.

create nonclustered index index_Emp_id_DateOfBirth on dbo.Employee(Emp_id,DateOfBirth)

select Emp_id,DateOfBirth from  Employee
where Emp_id in(123,144,156,198,1125)

select * from Employee


drop index [index_Emp_id_DateOfBirth] on Employee

sp_helpindex Employee