--After Trigger

Alter TRIGGER Trigger_Transactions
    ON dbo.EmpTransaction
    after DELETE, INSERT, UPDATE
    AS
   BEGIN
          
		 --select* from inserted
		 --select * from deleted

		 --print 'Something has happened to the EmpTransaction Table'
   -- END

      declare @EmpId as int
	  declare @delete as int

	  select @EmpId = Emp_id from inserted
	  
	  select * into #temp1
	  from inserted

	   while(exists(select Emp_Id from #temp1))
	   begin

	    select top(1) @EmpId = Emp_Id from #temp1

		insert into Audit_Section_After values(' Inserted record in employee table of Emp_Id ' +convert(varchar(10),@EmpId) +' by ' + SUSER_NAME()+' at '+  convert(nvarchar(30),GETDATE(),113));

		delete from #temp1
		where Emp_id = @EmpId

	   end

	   select @delete = Emp_id from deleted
	   select * into #temp2
	   from deleted

	    while(exists(select Emp_Id from #temp2))
	   begin

	    select top(1) @EmpId = Emp_Id from #temp2

		insert into Audit_Section_After values(' deleted record in employee table of Emp_Id ' +convert(varchar(10),@EmpId) +' by ' + SUSER_NAME()+' at '+  convert(nvarchar(30),GETDATE(),113));

		delete from #temp2
		where Emp_id = @EmpId

	   end


end


create table Audit_Section_After(
	ID int primary key identity(1,1),
	Audit_Message varchar(max)
	)
	
	begin tran

	insert into EmpTransaction values(1111111,'2020-09-20',123),(222222,'2021-09-20',124)

	delete from EmpTransaction
	where Emp_id in (131,132)

	select * from Audit_Section_After

	rollback tran
	begin tran

	
	
	update EmpTransaction
	set Emp_id =123
	from EmpTransaction
	where Emp_id = 132

	rollback tran



--INSTEAD OF TRIGGER FOR UPDATE
---The same way we can create on delete,insert but make sure we can create only one instead of trigger to a table

	

  Create trigger trigger_Employee
	on dbo.Employee
	--with encryption
	instead of update
	as 
	begin
	    
		insert into Audit_Section values('Someone tried to update record in employee table at: ' + convert(nvarchar(30),GETDATE(),113));

	end
	
	
    update employee
	set EmpFirstName = 'Jack'
	where Emp_id =123
	
	select * from employee
	select * from Audit_Section

---This Audit table is created to keep record of instead of trigger
--If someone tries to update anything in the employee table ,so that table will keep record of it

	create table Audit_Section(
	ID int primary key identity(1,1),
	Audit_Message varchar(max)
	)
